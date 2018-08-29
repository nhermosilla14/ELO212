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
    output [11:0] VGA_DIT
    );
   
    logic [5:0][7:0]M_1;
    logic [5:0][7:0]M_2;
    logic [5:0][7:0]M_3;
    logic [5:0][7:0]M_4;
   
   
    logic [n-1:0] red, blue, green;
    logic [3:0] out_red, out_blue, out_green;
   
    logic [3:0] m_value;
   
    assign red = colour_data[23:16];
    assign green = colour_data[15:8];
    assign blue = colour_data[7:0];
    assign VGA_DIT = {out_red, out_blue, out_green};
   
    initial begin            // cambiar a always_ff si no funciona
        M_1 = '{'d0, 'd8, 'd2, 'd10};
        M_2 = '{'d12, 'd4, 'd14, 'd6};
        M_3 = '{'d3, 'd11, 'd1, 'd9};
        M_4 = '{'d15, 'd13, 'd7, 'd5};
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
            if (red == 'd256)
                out_red = red[n-1:n-4];
            if (blue == 'd256)
                out_blue = blue[n-1:n-4];
            if (green == 'd256)
                out_green = green[n-1:n-4];
            else begin
            out_red = (red[n-5:n-8] > m_value)?(red[n-1:n-4]+'d1):red[n-1:n-4];    //canales redondeados a 4 bits por color
            out_blue = (blue[n-5:n-8] > m_value)?(blue[n-1:n-4]+'d1):blue[n-1:n-4];
            out_green = (green[n-5:n-8] > m_value)?(green[n-1:n-4]+'d1):green[n-1:n-4];
            end
        end else begin
            out_red = red[n-1:n-4];
            out_blue = blue[n-1:n-4];
            out_green = green[n-1:n-4];
        end
    end
   
endmodule
