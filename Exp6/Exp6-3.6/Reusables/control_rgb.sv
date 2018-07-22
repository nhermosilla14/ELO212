`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2018 05:28:27
// Design Name: 
// Module Name: control_rgb
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


module control_rgb(
    input logic CLK100MHZ,
    input logic [15:0] SW,
    output logic [2:0] LED16
    );
    
    logic active_0;
    
    driver_pwm drv_0(
        .clk(CLK100MHZ),
        .pwm(active_0),
        .in_value(SW[15:13]));
    
    always_comb
        begin
            case (SW[0])
                1'b0:
                    LED16[0] = 1'b0;
                1'b1:
                    LED16[0] = active_0;
            endcase
            case (SW[1])
                1'b0:
                    LED16[1] = 1'b0;
                1'b1:
                    LED16[1] = active_0;
            endcase
            case (SW[2])
                1'b0:
                    LED16[2] = 1'b0;
                1'b1:
                    LED16[2] = active_0;
            endcase
        end
endmodule
