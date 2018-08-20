`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2018 23:32:37
// Design Name: 
// Module Name: btn_repeater
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


module btn_repeater #(parameter COUNTERMAX=3)(
    input logic btn,
    input logic clk_1,
    input logic clk_2,
    output logic btn_output
    );
    
    logic [1:0] count;
    logic reset, clk_counter, btn_turbo, btn_1, clk_counter_2;
    
    counter_nbit #(2) main_counter(
        .clk(clk_counter),
        .reset(reset),
        .P(count)
    );

    always_comb
    begin
        if (~btn)
        begin
            reset = 1'b1;
            btn_output = 1'b0;
        end else begin
            reset = 1'b0;
            btn_output = btn_turbo;
        end
    end
    
    always_comb
    begin
        if (count >= COUNTERMAX)
        begin
            btn_turbo = clk_2; 
            clk_counter = 1'b0;
        end else begin
            btn_turbo = 1'b0;
            clk_counter = clk_1;
        end
    end

endmodule
