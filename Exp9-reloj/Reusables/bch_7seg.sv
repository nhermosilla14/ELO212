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
    input logic [4:0] in_hex,
    output logic [6:0] out_7seg 
    );
    always_comb
    begin
    case (in_hex)
    5'b00000 :          //Hexadecimal 0
        out_7seg = 7'b1000000;
    5'b00001 :            //Hexadecimal 1
        out_7seg = 7'b1111001;
    5'b00010 :          // Hexadecimal 2
        out_7seg = 7'b0100100; 
    5'b00011 :         // Hexadecimal 3
        out_7seg = 7'b0110000 ;
    5'b00100 :        // Hexadecimal 4
        out_7seg = 7'b0011001 ;
    5'b00101 :        // Hexadecimal 5
        out_7seg = 7'b0010010 ;  
    5'b00110 :        // Hexadecimal 6
        out_7seg = 7'b0000010 ;
    5'b00111 :        // Hexadecimal 7
        out_7seg = 7'b1111000;
    5'b01000 :              //Hexadecimal 8
        out_7seg = 7'b0000000;
    5'b01001 :            //Hexadecimal 9
        out_7seg = 7'b0010000 ;
    5'b01010 :          // Hexadecimal A
        out_7seg = 7'b0001000 ; 
    5'b01011 :         // Hexadecimal B
        out_7seg = 7'b0000011;
    5'b01100 :        // Hexadecimal C
        out_7seg = 7'b1000110 ;
    5'b01101 :        // Hexadecimal D
        out_7seg = 7'b0100001 ;
    5'b01110 :        // Hexadecimal E
        out_7seg = 7'b0000110 ;
    5'b01111 :        // Hexadecimal F
        out_7seg = 7'b0001110 ;
    
 // Simbolos   
    5'b10000 :          //-
        out_7seg = 7'b0111111;
    5'b10001 :            //:
        out_7seg = 7'b1110110;
    5'b10010 :          // Hexadecimal 2
        out_7seg = 7'b0100100; 
    5'b10011 :         // Hexadecimal 3
        out_7seg = 7'b0110000 ;
    5'b10100 :        // Hexadecimal 4
        out_7seg = 7'b0011001 ;
    5'b10101 :        // Hexadecimal 5
        out_7seg = 7'b0010010 ;  
    5'b10110 :        // Hexadecimal 6
        out_7seg = 7'b0000010 ;
    5'b10111 :        // Hexadecimal 7
        out_7seg = 7'b1111000;
    5'b11000 :              //Hexadecimal 8
        out_7seg = 7'b0000000;
    5'b11001 :            //Hexadecimal 9
        out_7seg = 7'b0010000 ;
    5'b11010 :          // Hexadecimal A
        out_7seg = 7'b0001000 ; 
    5'b11011 :         // Hexadecimal B
        out_7seg = 7'b0000011;
    5'b11100 :        // Hexadecimal C
        out_7seg = 7'b1000110 ;
    5'b11101 :        // Hexadecimal D
        out_7seg = 7'b0100001 ;
    5'b11110 :        // Hexadecimal E
        out_7seg = 7'b0000110 ;
    5'b11111 :        // Hexadecimal F
        out_7seg = 7'b0001110 ;
    endcase
    end
endmodule
