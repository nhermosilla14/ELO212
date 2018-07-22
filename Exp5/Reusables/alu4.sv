`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2018 14:41:42
// Design Name: 
// Module Name: alu4
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


module alu4 #(parameter n = 8) 
(
input logic [3:0] button,
input logic [n-1:0] numeroA,
input logic [n-1:0] numeroB,
output logic [n-1:0] resultado
 );
    
   always_comb 
   begin
        case(button)
            4'b0001:
                resultado = numeroA + numeroB;  //suma
            4'b0010: 
                resultado = numeroA - numeroB;   // resta 
            4'b0100:
                resultado = numeroA & numeroB;  // and
            4'b1000:
                resultado = numeroA | numeroB;  //or
            default:
                resultado = 'b0;
        endcase
    end
endmodule
