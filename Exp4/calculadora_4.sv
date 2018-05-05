`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2018 15:37:37
// Design Name: 
// Module Name: calculadora_4
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


module calculadora_4(
    input logic [15:0] SW,
    input logic [3:0] BTN,
    input logic CLK100MHZ,
    output logic [7:0] D7S,
    output logic [7:0] AN
    );
    
    logic [7:0] output_an;
    logic [7:0] output_7s;
    logic [8:0] resultado;
    logic [31:0] dsp_num;
    logic [31:0] def_output = {8'b0, SW[7:0], 8'b0, SW[15:8]};
    
    alu4 ALU(
    .button(BTN),
    .numeroA(SW[7:0]),
    .numeroB(SW[15:8]),
    .resultado(resultado)
    );
    
    drv_7seg DRV7SEG(
    .in_num(dsp_num),
    .clk(CLK100MHZ),
    .D7S(D7S),
    .AN(AN)
    );
    
    always_comb
    begin
        if (BTN == 4'b0001 || BTN == 4'b0010 || BTN == 4'b0100 || BTN == 4'b1000)
            dsp_num = {23'b0, resultado};
        else
            dsp_num = def_output;
    end
endmodule
