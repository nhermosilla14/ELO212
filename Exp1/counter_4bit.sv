`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2018 16:37:12
// Design Name: 
// Module Name: counter_4bit
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


module counter_4bit(
    input logic         clk,reset,
    output logic [3:0] P
    );
    logic [3:0] count;
    
    assign P = count;
    always_ff @(posedge clk) begin
        if (reset)
            count <= 4'b0;
            
        else
            count <= count+1;
    end        
endmodule
