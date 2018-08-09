`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2018 00:50:42
// Design Name: 
// Module Name: SE_top
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


module SE_top(
        input logic CLK100MHZ,
        input logic uart_rx_usb,
        output logic uart_tx_usb,
        input logic BTN_reset_n,
        output logic [7:0] AN,
        output logic [7:0] D7S,
        output logic [3:0] LED,
        output logic JA[3:1]
    );

    logic [7:0] rx_data, tx_data;
    logic rx_ready, tx_line, rx_line;
    logic [15:0] OP1, OP2, result16;
    logic [1:0] CMD;
    logic [3:0] stateID;
    logic [31:0] number_to_show;


    assign LED = stateID;
    assign rx_line = uart_rx_usb;
    assign uart_tx_usb = tx_line;
    assign tx_data = result16;
    
    assign JA[3] = rx_line;
    assign JA[2] = tx_line;
    assign JA[1] = rx_ready;
    
    
    pb_debouncer rst_db(
        .clk(CLK100MHZ),
        .rst(0),
        .PB(~BTN_reset_n),
        .PB_state(rst_n_db),
        .PB_negedge(),
        .PB_posedge()
    );


    UART_RX_CTRL RX_CTRL_inst(
        .clock(CLK100MHZ),
        .reset(rst_n_db),
        .rx_ready(rx_ready),
        .rx_data(rx_data),
        .OP1(OP1),
        .OP2(OP2),
        .CMD(CMD),
        .trigger_tx_result(tx_start),
        .stateID(stateID)
    );
   
    uart_basic uart_inst(
        .clk(CLK100MHZ),
        .reset(rst_n_db),
        .rx(rx_line),
        .rx_data(rx_data),
        .rx_ready(rx_ready),
        .tx(tx_line),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx_busy()
    );

    drv_7seg pantalla(
        .in_num(number_to_show),
        .clk(CLK100MHZ),
        .turn_on(1),
        .D7S(D7S),
        .AN(AN)
    );

    always_comb
    begin
        case (stateID)
            4'd5:
                number_to_show = {16'b0, OP1};
            4'd9:
                number_to_show = {16'b0, OP2};
            4'd1:
                number_to_show = {16'b0, result16};
            default:
                number_to_show = {32'b0};
        endcase
    end
endmodule
