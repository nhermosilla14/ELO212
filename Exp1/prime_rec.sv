`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2018 14:52:34
// Design Name: 
// Module Name: prime_rec
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


module prime_rec(
    input logic [3:0] P,
    output logic     DP
    );
    
    always_comb begin
        if (P==4'd3 || P==4'd5 || P==4'd7 || P==4'd11 || P==4'd13)
            DP = 1;
        else
            DP = 0;
    end
endmodule
