`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2018 03:27:11
// Design Name: 
// Module Name: matrix_index
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


module matrix_index(
    input clk,
    input draw,             // dentro de la imagen?
    output [1:0] Mx, My
    );
    
    logic [1:0] x, y, x_next, y_next;
    logic countdelay;
    
    assign {Mx, My} = {x, y};
    
    initial begin
        x = 'd0;
        x_next = 'd0;
        y = 'd0;
        y_next = 'd0;
    end
    
    always_ff @(posedge clk)
    begin
        countdelay = 'd0;
        if (draw == 1'b1)
            countdelay <= 'd1; 
    end
    
    always_ff @(posedge clk) begin
        if (x == 'd3) begin
            x_next = 'd0;
        end else if (y == 'd3) begin
             y_next = 'd0;
        end else if (countdelay) begin
            x_next = x + 'd1;
        end else begin
            x_next = x;
            y_next = y;
        end
    end
        
    always_ff @(negedge draw) begin
        y_next = y + 'd1;
        x_next = 'd0;
    end        
        
    always_ff @(posedge clk) begin
        x <= x_next;
        y <= y_next;
    end
    
    
    
    
endmodule

