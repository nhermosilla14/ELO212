`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2018 16:25:38
// Design Name: 
// Module Name: dith_simple
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


module dith_simple #(parameter n=8)(
    input [3*n-1:0] colour_data,
    input [1:0] countx,     //  posicion x en la matriz
    input [1:0] county,     //  posicion y en la matriz
    input SW,
    output [23:0] VGA_DIT
    );
    
    bit [5:0][7:0]M_1;
    bit [5:0][7:0]M_2;
    bit [5:0][7:0]M_3;
    bit [5:0][7:0]M_4;
    
    
    logic [n-1:0] red, blue, green;
    logic [3:0] out_red, out_blue, out_green; 
    
    logic [3:0] m_value;
    
    assign red = colour_data[3*n-1:3*n-8];
    assign green = colour_data[2*n-1:2*n-8];
    assign blue = colour_data[n-1:n-8];
    assign VGA_DIT = {out_red, red[n-5:n-8], out_green, green[n-5:n-8], out_blue, blue[n-5:n-8]};
    
    initial begin         // cambiar a always_ff si no funciona
        M_1[0] = 'd0;
        M_1[1] = 'd8;
        M_1[2] = 'd2;
        M_1[3] = 'd10;
        M_2[0] = 'd12;
        M_2[1] = 'd4;
        M_2[2] = 'd14;
        M_2[3] = 'd6;
        M_3[0] = 'd3;
        M_3[1] = 'd11;
        M_3[2] = 'd1;
        M_3[3] = 'd7;
        M_4[0] = 'd15;
        M_4[1] = 'd13;
        M_4[2] = 'd7;
        M_4[3] = 'd5;
    
//        M_1 = '{'d0, 'd8, 'd2, 'd10};
//        M_2 = '{'d12, 'd4, 'd14, 'd6};
//        M_3 = '{'d3, 'd11, 'd1, 'd9};
//        M_4 = '{'d15, 'd13, 'd7, 'd5};
    end
    
    

    always_comb begin
        case (county)                       //rescata el valor del mapa de threshold
            'd0:
                m_value = M_1[countx];
            'd1:
                m_value = M_2[countx];
            'd2:
                m_value = M_3[countx];
            'd3:
                m_value = M_4[countx];
         endcase     
            
        if (SW) begin
            out_red = (red[n-5:n-8] > m_value)?(red[n-1:n-4]+'d1):red[n-1:n-4];    //canales redondeados a 4 bits por color
            out_blue = (blue[n-5:n-8] > m_value)?(blue[n-1:n-4]+'d1):blue[n-1:n-4];
            out_green = (green[n-5:n-8] > m_value)?(green[n-1:n-4]+'d1):green[n-1:n-4];
            case (red[n-1:n-4])
                'd15:
                    out_red = red[n-1:n-4];
            endcase
            case (blue[n-1:n-4])
                'd15:
                out_blue = blue[n-1:n-4];
            endcase
            case (green[n-1:n-4])
                'd15:
                out_green = green[n-1:n-4];
            endcase
        end else begin
            out_red = red[n-1:n-4];
            out_blue = blue[n-1:n-4];
            out_green = green[n-1:n-4];
        end
    end
    
endmodule


