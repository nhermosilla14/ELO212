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
    output logic [15:0] LED
    );
    logic pulso_btnc, estado_reset;   //Botones limpios
    // Leds usados para indicar el estado actual de la FSM
    logic [15:0] estado_led;
    assign LED = estado_led;    
   
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
    

    //////////////////////////////////////////////////////
    
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
        case (state)
            WaitOP1:
                begin
                    estado_led = {14'b0, WaitOP1};
                    if (pulso_btnc)
                        next_state = WaitOP2;
                    else
                        next_state = state;
                end
            WaitOP2:
                begin
                    estado_led = {14'b0, WaitOP2};
                    if (pulso_btnc)
                        next_state = WaitOperation;
                    else
                        next_state = state;
                end
            WaitOperation:
                begin
                    estado_led = {14'b0, WaitOperation};
                    if (pulso_btnc)
                       next_state = ShowResult;
                    else
                        next_state = state;
                end
            ShowResult:
                begin  
                    estado_led = {14'b0, ShowResult};
                    if (pulso_btnc)
                        next_state = WaitOP1;
                    else
                        next_state = state;
                end
            default:
                    next_state = state;
        endcase
    end
    //////////////////////////////////////////////////////////       
endmodule
