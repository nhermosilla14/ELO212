`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2018 00:34:21
// Design Name: 
// Module Name: modopm
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

module modpm(
        input logic [5:0]in_num,
        input logic mode12,
        output logic [5:0] out_num,
        output logic pm
        );
   
   
        localparam hrs24 =   2'b00;
        localparam doce =   6'd12;
   
   
        always_comb
        begin
                if(mode12 == 1'b1)
                    if (in_num > doce) begin
                        out_num= in_num - doce;
                    end else  begin
                        out_num = in_num ;
                    end else begin
                        out_num = in_num ;
                end
       pm = (mode12 & (in_num >= doce)) ? 1'b1 : 1'b0;
       end
endmodule
