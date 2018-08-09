`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2018 04:41:37
// Design Name: 
// Module Name: driver_rgb
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


module driver_rgb(
    input logic [23:0] color_hex,
    input logic         clk,
    output logic [2:0] rgb
    );
    
    logic color_r_high = color_hex[23:16];
    logic color_g_high = color_hex[15:8];
    logic color_b_high = color_hex[7:0];
    
    
    driver_pwm #(8) r_pwm(
        .clk(clk),
        .pwm(rgb[0]));
    driver_pwm #(8) g_pwm(
                .clk(clk),
                .pwm(rgb[1]));    
    driver_pwm #(8) b_pwm(
                 .clk(clk),
                 .pwm(rgb[2]));   
    
endmodule
