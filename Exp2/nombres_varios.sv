`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2018 14:37:40
// Design Name: 
// Module Name: nombres_varios
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


module nombres_varios(
    input CLK100MHZ, 
    input logic [15:0] SW,
    output logic [7:0] AN, 
    output logic [6:0] D7S);
    
    logic [3:0] in_hex;
    logic [3:0] n; //salida contador
    logic clk_out_mux;
    
     clk_divider clk_div(
       .reset(1'b0),
       .COUNTER_MAX(32'd100000),
       .clk_in(CLK100MHZ),
       .clk_out(clk_out_mux));
       
     counter4_bit CNT(
       .clk(clk_out_mux),
       .reset(1'b0),
       .P(n));
     
     always_comb
           begin
              case (n[2:0])
                   3'b000:
                   begin
                        if (SW[1:0] == 2'b00) begin
                            D7S = 7'b1111111;
                        end else if (SW[1:0] == 2'b01) begin
                            D7S = 7'b1111111;
                        end else if (SW[1:0] == 2'b10) begin
                            D7S = 7'b0101011;
                        end else if (SW[1:0] == 2'b11) begin
                            D7S = 7'b1111111;
                        end
                   end        
                   3'b001://segundo display d
                   begin
                            if (SW[1:0] == 2'b00) begin
                                D7S = 7'b1111111;
                            end else if (SW[1:0] == 2'b01) begin
                                D7S = 7'b1111111;
                            end else if (SW[1:0] == 2'b10) begin
                                D7S = 7'b1111001;
                            end else if (SW[1:0] == 2'b11) begin
                                D7S = 7'b1111111;
                            end
                   end
                   3'b010:// vacio
                   begin
                        if (SW[1:0] == 2'b00) begin
                            D7S = 7'b0100100;
                        end else if (SW[1:0] == 2'b01) begin
                            D7S = 7'b1111111;
                        end else if (SW[1:0] == 2'b10) begin
                            D7S = 7'b1001000;
                        end else if (SW[1:0] == 2'b11) begin
                            D7S = 7'b1111111;
                        end
                   end        
                   3'b011://4todisplay  H
                   begin
                        if (SW[1:0] == 2'b00) begin
                          D7S = 7'b1111001;
                        end else if (SW[1:0] == 2'b01) begin
                          D7S = 7'b1000000;
                        end else if (SW[1:0] == 2'b10) begin
                          D7S = 7'b0001000;
                        end else if (SW[1:0] == 2'b11) begin
                          D7S = 7'b1111111;
                        end            
                   end
                   3'b100://5to display n
                   begin
                        if (SW[1:0] == 2'b00) begin
                            D7S = 7'b0100100;
                        end else if (SW[1:0] == 2'b01) begin
                            D7S = 7'b0010000;
                        end else if (SW[1:0] == 2'b10) begin
                            D7S = 7'b1110001;
                        end else if (SW[1:0] == 2'b11) begin
                            D7S = 7'b1000000;
                        end 
                  end
                  3'b101://vacio
                  begin
                        if (SW[1:0] == 2'b00) begin
                            D7S = 7'b1000000;
                        end else if (SW[1:0] == 2'b01) begin
                            D7S = 7'b0000110;
                        end else if (SW[1:0] == 2'b10) begin
                            D7S = 7'b0101011;
                        end else if (SW[1:0] == 2'b11) begin
                            D7S = 7'b1000110;
                        end 
                  end        
                  3'b110://7mo display H
                  begin
                        if (SW[1:0] == 2'b00) begin
                            D7S = 7'b1000111;
                        end else if (SW[1:0] == 2'b01) begin
                            D7S = 7'b1111001;
                        end else if (SW[1:0] == 2'b10) begin
                            D7S = 7'b0000110;
                        end else if (SW[1:0] == 2'b11) begin
                            D7S = 7'b1111001;
                        end 
                  end
                  3'b111://8vo display b
                  begin
                        if (SW[1:0] == 2'b00) begin
                            D7S = 7'b0000110;
                        end else if (SW[1:0] == 2'b01) begin
                            D7S = 7'b0100001;
                        end else if (SW[1:0] == 2'b10) begin
                            D7S = 7'b0000011;
                        end else if (SW[1:0] == 2'b11) begin
                            D7S = 7'b0101011;
                        end 
                        
                  end
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