`timescale 1ns / 1ps


module counter_nbit #(parameter n = 1)
(
    input logic  clk,reset,
    output logic [n-1:0] P
    );
    logic [n-1:0] count = 0;
    
    assign P = count;
    always_ff @(posedge clk) begin
        if (reset)
            count <= 'b0;
            
        else
            count <= count+1;
    end        
endmodule