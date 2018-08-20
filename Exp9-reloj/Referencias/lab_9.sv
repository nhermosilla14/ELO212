module lab_9(
	input CLK100MHZ,
	input [2:0]SW,
	input CPU_RESETN,
	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);

        logic [11:0] hc_visible, vc_visible;
        logic [11:0] vga_data, uart_data_12;
        logic [18:0] cont_uart, cont_vga;
        logic clk_uart, clk_vga;

	clk_wiz_0 inst(
		.clk_out1(CLK82MHZ),
		.reset(1'b0), 
		.clk_in1(CLK100MHZ)
		);
        blk_mem_gen_0 memoria(
                .clka(clk_uart),
                .addra(cont_uart),
                .dina(uart_data_12),
                .douta(),
                .wea(uart_rx_ready_12),
                .clkb(clk_vga),
                .addrb(cont_vga),
                .dinb(),
                .doutb(vga_data),
                .web(),
                .enb(clk_vga)
            );

        driver_vga_1024x768(
            .clk_vga(CLK82MHZ),
            .hs(VGA_HS),
            .vs(VGA_VS),
            .hc_visible(hc_visible),
            .vc_visible(vc_visible)
        );



	/************************* VGA ********************/
endmodule
