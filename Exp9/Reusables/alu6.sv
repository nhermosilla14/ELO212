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


module alu6 #(parameter n = 8) 
(
input logic [3:0]   button,
input logic [n-1:0] numeroA,
input logic [n-1:0] numeroB,
output logic [n-1:0] resultado,
output logic        overflow,
output logic        underflow,
output logic        valid_result
 );
   
   logic [n:0] resultado_previo;
   
   always_comb 
   begin
        overflow = 1'b0;
        underflow = 1'b0;
        valid_result = 1'b1;
        case(button)
            4'b0001:
                begin
                resultado_previo = {1'b0, numeroA} + {1'b0, numeroB};  //suma
                if (resultado_previo[n])
                    begin
                    overflow = 1'b1;
                    valid_result = 1'b0;
                    end
                resultado = resultado_previo[n-1:0];
                end
            4'b0010:
                begin
                resultado_previo = {1'b0, numeroA} - {1'b0, numeroB};   // resta
                if (resultado_previo[n])
                    begin
                    underflow = 1'b1;
                    valid_result = 1'b0;
                    end
                resultado = resultado_previo[n-1:0];
                end 
            4'b0100:
                resultado = numeroA & numeroB;  // and
            4'b1000:
                resultado = numeroA | numeroB;  //or
            default:
                resultado = 'b0;
        endcase
    end
 
endmodule
