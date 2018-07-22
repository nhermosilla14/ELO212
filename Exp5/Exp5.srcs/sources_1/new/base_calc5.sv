`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2018 19:38:10
// Design Name: 
// Module Name: base_calc5
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


module base_calc5(
    input logic         CLK100MHZ,
    input logic         BTNC,
    input logic [3:0]   BTN, //UDLR
    input logic [15:0]  SW,
    output logic [7:0]  AN,
    output logic [7:0]  D7S
    );
    
    logic pulso_up, pos_l, pos_r, pos_c;
    
    logic [31:0] pantalla;
    logic [15:0] D_a, D_b;
    logic [15:0] suma, resultado;    
    
    pb_debouncer debouncer_btn_c(
            .clk(CLK100MHZ),
            .rst(0),
            .PB(BTNC),
            .PB_state(),
            .PB_negedge(),
            .PB_posedge(pos_c));

    pb_debouncer debouncer_btn_up(
            .clk(CLK100MHZ),
            .rst(0),
            .PB(BTN[0]),
            .PB_state(pulso_up),
            .PB_negedge(),
            .PB_posedge());

    pb_debouncer debouncer_btn_left(
            .clk(CLK100MHZ),
            .rst(0),
            .PB(BTN[2]),
            .PB_state(),
            .PB_negedge(),
            .PB_posedge(pos_l));
    
    pb_debouncer debouncer_btn_right(
            .clk(CLK100MHZ),
            .rst(0),
            .PB(BTN[3]),
            .PB_state(),
            .PB_negedge(),
            .PB_posedge(pos_r));
	
    
    drv_7seg driver(
            .in_num(pantalla),
            .clk(CLK100MHZ),
            .D7S(D7S),
            .AN(AN),
            .turn_on(1)
            );
                      
   FDCE #(16) FDCE_a(
            .clk(CLK100MHZ),
            .reset(),
            .valor_entrada(SW),
            .retain(pos_l),
            .valor_salida(D_a));
                 
   FDCE #(16) FDCE_b(
            .clk(CLK100MHZ),
            .reset(),
            .valor_entrada(SW),
            .retain(pos_r),
            .valor_salida(D_b));
   
   FDCE #(16) FDCE_resultado(
            .clk(CLK100MHZ),
            .reset(),
            .valor_entrada(suma),
            .retain(pos_c),
            .valor_salida(resultado));
            
    alu4 #(16) alu(
            .button('b0001),
            .numeroA(D_a),
            .numeroB(D_b),
            .resultado(suma));
    

    enum logic {muestra_resultado, muestra_operandos} state, next_state;

    always_ff @(posedge CLK100MHZ)
    begin
        state <= next_state;
    end
    
    always_comb    
    begin    
    	case (state)
            muestra_resultado:
            begin
                if (pulso_up)
                    pantalla = {D_a, D_b};
                else
                    pantalla = {16'b0, resultado};
                if (pos_l || pos_r || pos_c)
                begin
                    next_state = muestra_operandos;
                end else begin
                    next_state = state;
                end
            end
            muestra_operandos:
            begin
                pantalla = {D_a, D_b};
                if (pos_c)
                    next_state = muestra_resultado;
                else
                    next_state = state;
            end

        endcase
    end
    endmodule
