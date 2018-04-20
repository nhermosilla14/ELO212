`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2018 15:56:08
// Design Name: 
// Module Name: hex_7seg
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


module bch_7seg(
    input logic [3:0] in_hex,
    output logic [6:0] out_7seg 
    );
    always_comb
    begin
    case (in_hex)
    4'b0000 :          //Hexadecimal 0
        out_7seg = 7'b1000000;
    4'b0001 :            //Hexadecimal 1
        out_7seg = 7'b1111001;
    4'b0010 :          // Hexadecimal 2
        out_7seg = 7'b0100100; 
    4'b0011 :         // Hexadecimal 3
        out_7seg = 7'b0110000 ;
    4'b0100 :        // Hexadecimal 4
        out_7seg = 7'b0011001 ;
    4'b0101 :        // Hexadecimal 5
        out_7seg = 7'b0010010 ;  
    4'b0110 :        // Hexadecimal 6
        out_7seg = 7'b0000010 ;
    4'b0111 :        // Hexadecimal 7
        out_7seg = 7'b1111000;
    4'b1000 :              //Hexadecimal 8
        out_7seg = 7'b0000000;
    4'b1001 :            //Hexadecimal 9
        out_7seg = 7'b0010000 ;
    4'b1010 :          // Hexadecimal A
        out_7seg = 7'b0001000 ; 
    4'b1011 :         // Hexadecimal B
        out_7seg = 7'b0000011;
    4'b1100 :        // Hexadecimal C
        out_7seg = 7'b1000110 ;
    4'b1101 :        // Hexadecimal D
        out_7seg = 7'b0100001 ;
    4'b1110 :        // Hexadecimal E
        out_7seg = 7'b0000110 ;
    4'b1111 :        // Hexadecimal F
        out_7seg = 7'b0001110 ;
    endcase
    end
endmodule
