`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2018 11:03:43
// Design Name: 
// Module Name: FDCE
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


module FDCE7 #(parameter N=8)
(	input  logic           clk,
	input  logic           reset,
	input  logic   [N-1:0] valor_entrada,
	input  logic           retain,
	output logic   [N-1:0] valor_salida
);

    logic [N-1:0] Q, Q_next;
    assign valor_salida = Q;

	always_ff @(posedge clk) begin
	   if (reset) begin
	       Q <= 2'd0;
	   end else begin
	       Q <= Q_next;
	   end
	end

	always_comb begin
        Q_next = Q;
 
		case (retain)
		  1'b1: 	  Q_next = valor_entrada;
		  1'b0: 	  ;
        endcase
	end

endmodule
    