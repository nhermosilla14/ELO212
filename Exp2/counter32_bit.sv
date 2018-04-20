`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2018 04:52:18
// Design Name: 
// Module Name: counter16_bit
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


module counter32_bit(
    input logic  clk,reset,
    output logic [31:0] P
    );
    logic [31:0] count = 0;
    
    assign P = count;
    always_ff @(posedge clk) begin
        if (reset)
            count <= 31'b0;
            
        else
            count <= count+1;
    end        
endmodule