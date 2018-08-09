module UART_RX_CTRL
(
        input  logic           clock,
        input  logic           reset,
        input  logic           rx_ready,
        input  logic  [7:0]    rx_data,
        output logic  [15:0]   OP1,
        output logic  [15:0]   OP2,
        output logic  [1:0]    CMD,
        output logic           trigger_tx_result,
        output logic  [3:0]    stateID
    );
    
    logic [15:0] result16;
    assign OP1 = result16;
    assign OP2 = 'b0;
    assign trigger_tx_result = 'b0;

    always_ff @(posedge clock) begin
        if(reset)
            result16 <= 16'd0;
        else 
        if (rx_ready)
            result16 <= {rx_data, result16[15:8]};
    end
 
	
endmodule
