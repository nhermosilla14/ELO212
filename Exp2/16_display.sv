`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2018 15:39:43
// Design Name: 
// Module Name: 16_display
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


module _16_display(
    input CLK100MHZ, 
    input logic [15:0] SW,
    output logic [3:0] AN, 
    output logic [6:0] DS7);
    
    logic [3:0] in_hex;
    logic [6:0] output_7seg;
    logic [1:0] n; //salida contador
    logic clk_out;
    logic reset = 0;
    
    clk_divider clk_div(
    .reset(reset),
    .clk_in(CLK100MHZ),
    .clk_out(clk_out));
    
    counter4_bit CNT(
    .clk(clk_out),
    .reset(reset),
    .P(n));
     
    bch_7seg SEG(
    .in_hex(in_hex),
    .out_7seg(output_7seg));
    
    
    always_comb
    begin
        case (n)
            4'b0000:
            begin
                reset = 0;
                AN = 4'b0001;
                in_hex = SW[3:0]; 
                DS7 = output_7seg;
            end
            4'b0001:
            begin
                AN = 4'b0010;
                in_hex = SW[7:4]; 
                DS7 = output_7seg;
            end
            4'b0010:
            begin
                AN = 4'b0100;
                in_hex = SW[11:8]; 
                DS7 = output_7seg;
            end
            4'b0011:
            begin
                AN = 4'b1000;
                in_hex = SW[15:12]; 
                DS7 = output_7seg;
            end
            default:
                reset = 1; 
        endcase
    end
endmodule
