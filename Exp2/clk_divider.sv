`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2018 17:23:42
// Design Name: 
// Module Name: clk_divider
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


module clk_divider #(parameter COUNTER_MAX = 32'd100000) 
    (input logic clk_in,
    input logic reset,
    output logic clk_out = 0
    );
       
    logic [31:0] counter = 'd0;
        
    always @(posedge clk_in) begin
        if (reset == 1'b1) begin
            counter <= 'd0;
            clk_out <= 0;
        end else if (counter == COUNTER_MAX) begin
            counter <= 'd0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 'd1;
            clk_out <= clk_out;
        end
    end
endmodule

