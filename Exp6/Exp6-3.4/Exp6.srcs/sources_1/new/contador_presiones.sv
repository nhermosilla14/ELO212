`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2018 22:53:38
// Design Name: 
// Module Name: contador_presiones
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


module contador_presiones(
    input logic         CLK100MHZ,
    input logic         BTNC,
    input logic         BTN_reset_n,
    output logic [7:0]  AN,
    output logic [7:0]  D7S,
    output logic [15:0] LED
    );
    
    logic pulso, estado;
    logic [31:0] conteo;
    
    logic pulso_reset, estado_reset;
    
    pb_debouncer debouncer(
        .clk(CLK100MHZ),
        .rst(0),
        .PB(BTNC),
        .PB_state(estado),
        .PB_negedge(),
        .PB_posedge(pulso)); 
    
    pb_debouncer debouncer1(
        .clk(CLK100MHZ),
        .rst(0),
        .PB(~BTN_reset_n),
        .PB_state(estado_reset),
        .PB_negedge(),
        .PB_posedge(pulso_reset));
    
    counter_nbit #(32) contador_pulsos(
        .clk(pulso),
        .reset(0),
        .P(conteo));
        
    drv_7seg driver(
        .in_num(conteo),
        .clk(CLK100MHZ),
        .D7S(D7S),
        .AN(AN));
        
    always_comb
    begin
        LED = {14'b11111111111111, estado, estado_reset};
    end
endmodule