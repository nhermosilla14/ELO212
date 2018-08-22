`timescale 1ns / 1ps


module counter_nbit #(parameter n = 1)
(
    input logic  clk,reset,enable,
    output logic [n-1:0] P
    );
    logic [n-1:0] count = 0;
    logic [n-1:0] count_next;

    assign P = count;

    always_comb
    begin
        if (enable)
            count_next = count + 1;
        else
            count_next = count;
    end

    always_ff @(posedge clk or negedge reset) begin
        if (reset)
            count <= 'b0;
            
        else
            count <= count_next;
    end

endmodule
