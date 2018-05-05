`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2018 12:58:52
// Design Name: 
// Module Name: drv_7seg
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


module drv_7seg
(
    input logic [31:0] in_num,
    input logic clk,
    output logic [7:0] D7S,
    output logic [7:0] AN
    );
    
    logic clk_mux;
    logic [2:0] cur_an;
    logic [3:0] cur_num;
    logic [6:0] cur_output;

    assign D7S = {1'b1,cur_output};


    clk_divider divider(
    	.clk_in(clk),
    	.clk_out(clk_mux),
    	.reset(0)
    	);
    
    counter_nbit #(3) counter_an(
    	.clk(clk_mux),
    	.reset(0),
    	.P(cur_an)
    	);

    bch_7seg bch_conv(
    	.in_hex(cur_num),
	    .out_7seg(cur_output)
	);
	
    always_comb
    begin
	 case (cur_an)
               3'b000:
                    cur_num = in_num[3:0];
               3'b001:
                    cur_num = in_num[7:4];
               3'b010:
                    cur_num = in_num[11:8];
               3'b011:
                    cur_num = in_num[15:12];
               3'b100:
                    cur_num = in_num[19:16];
               3'b101:
                    cur_num = in_num[23:20];
               3'b110:
                    cur_num = in_num[27:24];
               3'b111:
                    cur_num = in_num[31:28];
         endcase          
         case (cur_an)
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
