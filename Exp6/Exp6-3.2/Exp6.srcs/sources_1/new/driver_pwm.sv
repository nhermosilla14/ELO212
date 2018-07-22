`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2018 04:14:17
// Design Name: 
// Module Name: driver_pwm
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


module driver_pwm 
(   input logic clk,
    input logic [3:0] in_value,
    output logic pwm
    );
       
    logic slow_clock;
    logic [2:0] counter_value;
       
    clk_divider #(83333) slow_clock_(
        .clk_in(clk),
        .reset(0),
        .clk_out(slow_clock)
       );
       
    counter_nbit #(3) cntr(
        .clk(slow_clock),
        .reset(0),
        .P(counter_value));
    
    always_comb
    begin
    pwm = 0;
        case (counter_value)
            3'b000:
                pwm = ~pwm;    
            in_value:
                pwm = ~pwm;
            default:
                ;
         endcase
    end      
endmodule
