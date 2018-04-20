`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2018 04:42:44
// Design Name: 
// Module Name: hex_counter_display
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


module hex_counter_display(
    input CLK100MHZ, 
    input logic [15:0] SW,
    output logic [7:0] AN, 
    output logic [6:0] D7S);
    
    logic [3:0] in_hex;
    logic [3:0] n; //salida contador
    logic clk_out_mux;
    logic clk_out_count;
    logic reset = SW[0];
    logic [31:0] counter;
    
     clk_divider clk_div(
       .reset(1'b0),
       .COUNTER_MAX(32'd200000),
       .clk_in(CLK100MHZ),
       .clk_out(clk_out_mux));
       
     clk_divider clk_div2(
        .reset(1'b0),
        .COUNTER_MAX(32'd25000000),
       .clk_in(CLK100MHZ),
       .clk_out(clk_out_count));
       
     counter4_bit CNT(
       .clk(clk_out_mux),
       .reset(1'b0),
       .P(n));
       
    counter32_bit CNT2(
              .clk(clk_out_count),
              .reset(reset),
              .P(counter));
        
     bch_7seg SEG(
       .in_hex(in_hex),
       .out_7seg(D7S));
     
     always_comb
           begin
              case (n[2:0])
                   3'b000:
                   begin
                       in_hex = counter[3:0]; 
                   end
                   3'b001:
                   begin
                       in_hex = counter[7:4]; 
                   end
                   3'b010:
                   begin
                       in_hex = counter[11:8]; 
                   end
                   3'b011:
                   begin
                       in_hex = counter[15:12];
                   end 
                   3'b100:
                   begin
                       in_hex = counter[19:16]; 
                   end
                   3'b101:
                   begin
                        in_hex = counter[23:20]; 
                   end
                   3'b110:
                   begin
                        in_hex = counter[27:24]; 
                   end
                   3'b111:
                   begin
                        in_hex = counter[31:28]; 
                   end
                   default:
                       in_hex = counter[3:0];
               endcase
               case (n[2:0])
                   3'b000:
                        AN = 8'b11111110;
                   3'b001:
                        AN = 8'b11111101;
                   3'b010:
                        AN = 8'b11111011;
                   3'b011:
                        AN = 8'b11110111;
                   3'b100:
                        AN = 8'b11101111;
                   3'b101:
                        AN = 8'b11011111;
                   3'b110:
                        AN = 8'b10111111;
                   3'b111:
                        AN = 8'b01111111;  
               endcase            
               
           end
endmodule
