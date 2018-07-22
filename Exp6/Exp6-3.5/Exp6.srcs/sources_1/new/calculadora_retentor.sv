`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2018 13:12:45
// Design Name: 
// Module Name: calculadora_retentor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module calculadora_retentor(
    input logic         CLK100MHZ,
    input logic         BTNC,
    input logic [3:0]   BTN, //De 0 a 3: UDLR
    input logic         BTN_reset_n,
    input logic [15:0] SW,
    output logic [7:0]  AN,
    output logic [7:0]  D7S,
    output logic [15:0] LED,
    output logic [2:0] LED16
    );
    logic pulso_btnc, estado_reset;   //Botones limpios
    logic ret_a, ret_b, ret_bin; //Retain de los ff
    logic [15:0] D_a, D_b, sw_a, sw_b, in_res_bin, D_res_bin; //Entradas y salidas de los ff
                                                  // de las entradas numericas
    logic [3:0] alu_btn; //Entrada que le indica a la alu la operacion
    
    logic [31:0] in_dec, out_dec;
    logic trigger_dec, show_dec;
    logic [31:0] disp_num; //Numero a mostrar en el d7s
    logic estado_panel; //Estado de los d7s, verdadero si esta encendido
    
    // Leds usados para indicar el estado actual de la FSM
    logic [15:0] estado_led;
    assign LED = estado_led;    
   
    // Led que indica la validez del resultado
    logic on_tricolor, resultado_correcto; //senales para el led tricolor      
    
    //////////////////////////////////////////////////////////
    // Debouncers para todos los botones
    
    pb_debouncer debouncer(
        .clk(CLK100MHZ),
        .rst(0),
        .PB(BTNC),
        .PB_state(),
        .PB_negedge(),
        .PB_posedge(pulso_btnc)); 
      
    pb_debouncer debouncer_reset(
        .clk(CLK100MHZ),
        .rst(0),
        .PB(~BTN_reset_n),
        .PB_state(estado_reset),
        .PB_negedge(),
        .PB_posedge());
    
    pb_debouncer debouncer_up(
        .clk(CLK100MHZ),
        .rst(0),
        .PB(BTN[0]),
        .PB_state(show_dec),
        .PB_negedge(),
        .PB_posedge(trigger_dec));
        
   ////////////////////////////////////////////    
   // Flip flops para almacenar los datos de variables, operacion actual y resultados     
          
    FDCE #(16) FDCE_a(
        .clk(CLK100MHZ),
        .reset(),
        .valor_entrada(sw_a),
        .retain(ret_a),
        .valor_salida(D_a)
        );
        
    FDCE #(16) FDCE_b(      
        .clk(CLK100MHZ),
        .reset(),
        .valor_entrada(sw_b),
        .retain(ret_b),
        .valor_salida(D_b)
        );
        
    FDCE #(16) FDCE_op(      
        .clk(CLK100MHZ),
        .reset(),
        .valor_entrada(in_res_bin),
        .retain(ret_bin),
        .valor_salida(D_res_bin)
        );
        
  //////////////////////////////////////////////////   
    // alu mejorada con soporte para deteccion de overflow, underflow y validacion
    // del resultado (que es basicamente verificar si existe cualquiera de las dos
    // condiciones anteriores.     
    alu6 #(16) calc(
        .button(alu_btn),
        .numeroA(D_a),
        .numeroB(D_b),
        .resultado(in_res_bin),
        .overflow(),
        .underflow(),
        .valid_result(resultado_correcto)
        );
        

    //////////////////////////////////////////////////////
     
     driver_pwm pwm_3bit(
         .clk(CLK100MHZ),
         .in_value(2'b001), //la senal sube en 0 y baja en t igual a in_value
         .pwm(on_tricolor)  //el periodo total depende de la resolucion en bits
         );                 // (por defecto es 3) 
        
     drv_7seg driver(
         .in_num(disp_num),
         .clk(CLK100MHZ),
         .D7S(D7S),
         .AN(AN),
         .turn_on(estado_panel)
         );   
            
    ////////////////////////////////////////
    
    
   
    unsigned_to_bcd u32_to_bcd_inst (
         .clk(CLK100MHZ),
         .trigger(trigger_dec),
         .in(in_dec),
         .idle(),
         .bcd(out_dec)
    );
    /////////////////////////////////////////
    
    enum logic [1:0] {WaitOP1, WaitOP2, WaitOperation, ShowResult} state, next_state;
    
    always_ff @(posedge CLK100MHZ)
        begin
            if (estado_reset)
                state <= WaitOP1;
            else
                state <= next_state;
        end
        
   ////////////////////////////////////////////
   always_comb
        begin
        LED16 = 3'b000;
        ret_a = 0;
        ret_b = 0;
        ret_bin = 'b0;
        sw_a = 'b0;
        sw_b = 'b0;
        case (state)
            WaitOP1:
                begin
                    sw_a = SW;
                    if (show_dec)
                    begin
                        in_dec = {16'b0, sw_a};
                        disp_num = out_dec;
                    end else
                        disp_num = { 16'b0, SW};
                    estado_led = {14'b0, WaitOP1};
                    estado_panel = 'b1;
                    if (pulso_btnc)
                    begin
                        next_state = WaitOP2;
                        ret_a = 'b1;
                    end else
                        next_state = state;
                end
            WaitOP2:
                begin
                    sw_b = SW;
                    if (show_dec)
                    begin
                        in_dec = {16'b0, sw_b};
                        disp_num = out_dec;
                    end else
                        disp_num = { 16'b0, SW};
                    estado_led = {14'b0, WaitOP2};
                    estado_panel = 'b1;
                    if (pulso_btnc)
                    begin
                        next_state = WaitOperation;
                        ret_b = 'b1;
                    end
                    else
                        next_state = state;
                end
            WaitOperation:
                begin
                    disp_num = 32'b0; //solo para debugging
                    estado_led = {14'b0, WaitOperation};
                    estado_panel = 'b0;
                    if (pulso_btnc)
                    begin
                        case (SW[1:0])
                            2'b00:
                                alu_btn = 4'b0001;
                            2'b01:
                                alu_btn = 4'b0010;
                            2'b10:
                                alu_btn = 4'b0100;
                            2'b11:
                                alu_btn = 4'b1000;
                            default:
                                alu_btn = 4'b0000;
                        endcase
                       ret_bin = 1'b1;
                       next_state = ShowResult;
                    end 
                    else
                        next_state = state;
                end
            ShowResult:
                begin  
                    if (show_dec)
                    begin
                        in_dec = {16'b0, D_res_bin};
                        disp_num = out_dec;
                    end else    
                        disp_num = {16'b0, D_res_bin};
                    estado_led = {14'b0, ShowResult};
                    estado_panel = 'b1;
                    if (resultado_correcto)
                        LED16[1] = on_tricolor;
                    else
                        LED16[0] = on_tricolor;
                    if (pulso_btnc)
                        next_state = WaitOP1;
                    else
                        next_state = state;
                end
            default:
                begin
                    disp_num = 32'b0;
                    next_state = state;
                end
        endcase
    end
    //////////////////////////////////////////////////////////       
endmodule
