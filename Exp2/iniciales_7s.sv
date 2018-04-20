`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2018 06:30:14
// Design Name: 
// Module Name: iniciales_7s
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


module iniciales_7s(
    input CLK100MHZ, 
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
                   3'b000://primer display g
                   begin
                        D7S[0]=1'b0;
                        D7S[1]=1'b0;
                        D7S[2]=1'b0;
                        D7S[3]=1'b0;
                        D7S[4]=1'b1;
                        D7S[5]=1'b0;
                        D7S[6]=1'b0;
                   end        
                   3'b001://segundo display d
                   begin
                        D7S[0]=1'b1;
                        D7S[1]=1'b0;
                        D7S[2]=1'b0;
                        D7S[3]=1'b0;
                        D7S[4]=1'b0;
                        D7S[5]=1'b1;
                        D7S[6]=1'b0;
                   end
                   3'b010:// vacio
                   begin
                        D7S[0]=1'b1;
                        D7S[1]=1'b1;
                        D7S[2]=1'b1;
                        D7S[3]=1'b1;
                        D7S[4]=1'b1;
                        D7S[5]=1'b1;
                        D7S[6]=1'b1;
                   end        
                   3'b011://4todisplay  H
                   begin
                        D7S[0]=1'b1;
                        D7S[1]=1'b0;
                        D7S[2]=1'b0;
                        D7S[3]=1'b1;
                        D7S[4]=1'b0;
                        D7S[5]=1'b0;
                        D7S[6]=1'b0;             
                   end
                   3'b100://5to display n
                   begin
                        D7S[0]=1'b0;
                        D7S[1]=1'b0;
                        D7S[2]=1'b0;
                        D7S[3]=1'b1;
                        D7S[4]=1'b0;
                        D7S[5]=1'b0;
                        D7S[6]=1'b1;
                  end
                  3'b101://vacio
                  begin
                        D7S[0]=1'b1;
                        D7S[1]=1'b1;
                        D7S[2]=1'b1;
                        D7S[3]=1'b1;
                        D7S[4]=1'b1;
                        D7S[5]=1'b1;
                        D7S[6]=1'b1;
                  end        
                  3'b110://7mo display H
                  begin
                        D7S[0]=1'b1;
                        D7S[1]=1'b0;
                        D7S[2]=1'b0;
                        D7S[3]=1'b1;
                        D7S[4]=1'b0;
                        D7S[5]=1'b0;
                        D7S[6]=1'b0;
                  end
                  3'b111://8vo display b
                  begin
                        D7S[0]=1'b1;
                        D7S[1]=1'b1;
                        D7S[2]=1'b0;
                        D7S[3]=1'b0;
                        D7S[4]=1'b0;
                        D7S[5]=1'b0;
                        D7S[6]=1'b0;
                        
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