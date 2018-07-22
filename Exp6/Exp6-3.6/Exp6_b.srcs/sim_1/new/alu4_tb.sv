`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2018 17:11:31
// Design Name: 
// Module Name: alu4_tb
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


module alu4_tb();

logic [3:0] button;
logic [3:0] numeroA, numeroB, resultado;
logic underflow, overflow, valid_result;

alu4 #(4) DUT(
    .button(button),
    .numeroA(numeroA),
    .numeroB(numeroB),
    .resultado(resultado),
    .overflow(overflow),
    .underflow(underflow),
    .valid_result(valid_result));

initial #0
    begin
    numeroA = 4'd6;
    numeroB = 4'd10;
    #10
    button = 4'b0001;
    #50
    button = 4'b0010;
    #50
    button = 4'b0100;
    #50
    button = 4'b1000;
    #50
    numeroB = 4'd5;
    button = 4'b0001;
    #50
    button = 4'b0010;
    end
endmodule
