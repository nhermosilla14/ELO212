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
    output logic [7:0] AN, 
    output logic [6:0] D7S);
    
    logic [3:0] in_hex;
    logic [3:0] n; //salida contador
    logic clk_out;
    logic reset = 0;
    
    clk_divider clk_div(
    .reset(1'b0),
    .COUNTER_MAX(32'd208334),
    .clk_in(CLK100MHZ),
    .clk_out(clk_out));
    
    counter4_bit CNT(
    .clk(clk_out),
    .reset(reset),
    .P(n));
     
    bch_7seg SEG(
    .in_hex(in_hex),
    .out_7seg(D7S));
    
    always_comb
    begin
       case (n[1:0])
            2'b00:
            begin
                //AN = 8'b11111110;
                in_hex = SW[3:0]; 
            end
            2'b01:
            begin
                //AN = 8'b11111101;
                in_hex = SW[7:4]; 
            end
            2'b10:
            begin
                //AN = 8'b11111011;
                in_hex = SW[11:8]; 
            end
            2'b11:
            begin
                //AN = 8'b11110111;
                in_hex = SW[15:12]; 
            end
            default:
                in_hex= SW[3:0];
        endcase
        case (n[1:0])
            2'b00:
                AN = 8'b11111110;
            2'b01:
                AN = 8'b11111101;
            2'b10:
                AN = 8'b11111011;
            2'b11:
                AN = 8'b11110111;
        endcase            
        
    end
endmodule
