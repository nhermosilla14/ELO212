`timescale 1ns / 1ps

module lab_9(
	input logic CLK100MHZ,
	input logic [15:0]SW,
	input logic CPU_RESETN,
        input logic uart_rx_usb,
	output logic VGA_HS,
	output logic VGA_VS,
	output logic [3:0] VGA_R,
	output logic [3:0] VGA_G,
	output logic [3:0] VGA_B,
        output logic [15:0] LED
	);

      
        logic clk100mhz_clkwiz;
        logic clk_vga;    
        logic [11:0] VGA_COLOR;  
        logic [10:0] vc_visible,hc_visible;
 
        logic rx_ready, rx_ready_12, rx_line;
        assign rx_line = uart_rx_usb;

        logic [7:0] rx_data;
        logic [23:0] video_data, image_cur_pix, image_cur_pix_1, image_cur_pix_2;
        logic [11:0] image_cur_pix_12;
        logic [17:0] addra, addrb;
        logic reset_addra, addra_count_en;
        assign addra_count_en = 1'b1;
        assign LED = addra[15:0];
////////////////////////////////////////////////
//Reloj de la salida VGA
//Debe usarse igualmente en la BRAM, puerto B
        clk_wiz_0 ins(
                .clk_out2(clk_vga),
                .clk_out1(clk100mhz_clkwiz),
                .locked(),
                .clk_in1(CLK100MHZ),
                .reset(1'b0));
/////////////////////////////////////////////////
//Lógica para recibir la imagen. Consiste en un
//módulo uart_tx_ctrl que reporta cuando llegan
//los 12 bits de un pixel, y le avisa así a la
//ram habilitando la entrada wea (write enable a).
//

        uart_basic uart_(
                .clk(clk100mhz_clkwiz),
                .reset(1'b0),
                .rx(rx_line),
                .rx_data(rx_data),
                .rx_ready(rx_ready),
                .tx(),
                .tx_busy(),
                .tx_start(1'b0),
                .tx_data(8'b0)
        );

        UART_RX_CTRL video_input_port(
                .clock(clk100mhz_clkwiz),
                .reset(1'b0),
                .rx_ready(rx_ready),
                .rx_data(rx_data),
                .video_data(video_data),
                .stateID(),
                .rx_ready_12(rx_ready_12)
        );


/////////////////////////////////////////////////////
//Lógica para guardar la imagen
//Acá se instancia el bloque de bram para almacenar los
//datos y leerlos. Se usa el modo True Dual Port, con
//reloj A sincronizado con la UART y reloj B sincronizado
//con la salida VGA.
        
        blk_mem_gen_0 blkmem(
                .clka(clk100mhz_clkwiz),
                .addra(addra),
                .dina(video_data),
                .wea(rx_ready_12),
                .clkb(clk_vga),
                .addrb(addrb),
                .doutb(image_cur_pix)
        );


        counter_nbit #(18) addra_counter(
                .clk(rx_ready_12),
                .reset(reset_addra),
                .enable(addra_count_en),
                .P(addra)
        );

//        counter_nbit #(18) addrb_counter(
//                .clk(clk_vga),
//                .reset(reset_addrb),
//                .enable(addrb_count_en),
//                .P()
//        );
/////////////////////////////////////////////////////
// Driver de la pantalla
// Aquí se mandan las señales de color a la pantalla
        driver_vga_1024x768(
                .clk_vga(clk_vga),                    
                .hs(VGA_HS),
                .vs(VGA_VS),
                .hc_visible(hc_visible),
                .vc_visible(vc_visible)
        );

/////////////////////////////////////////////////////


//Constantes de configuración
        localparam CUADRILLA_XI     = 0;
        localparam CUADRILLA_XF     = CUADRILLA_XI + 512;
         
        localparam CUADRILLA_YI     = 0;
        localparam CUADRILLA_YF     = CUADRILLA_YI + 392;
        localparam COLOR_BLUE       = 12'h00F;
        localparam COLOR_YELLOW     = 12'hFF0;
        localparam COLOR_RED        = 12'hF00;
        localparam COLOR_BLACK      = 12'h000;
        localparam COLOR_WHITE      = 12'hFFF;
        localparam COLOR_CYAN       = 12'h0FF;
        localparam COLOR_GREY       = 12'h444;
        
// Algunas abstracciones para legibilidad
        logic DENTRO_DE_LA_PANTALLA;
        logic DENTRO_DE_LA_CUADRILLA;
        logic CERCA_DE_LA_CUADRILLA;
        assign DENTRO_DE_LA_PANTALLA = (( hc_visible != 0) && ( vc_visible != 0));
        assign DENTRO_DE_LA_CUADRILLA = ((hc_visible > CUADRILLA_XI) && (hc_visible <= CUADRILLA_XF) && (vc_visible > CUADRILLA_YI) && (vc_visible <= CUADRILLA_YF));
//        assign CERCA_DE_LA_CUADRILLA = (((hc_visible + 11'd2) > CUADRILLA_XI) && (hc_visible-2 <= CUADRILLA_XF) && (vc_visible > CUADRILLA_YI) && (vc_visible <= CUADRILLA_YF));
///////////////////////////////////////////////////////////
        always @(posedge clk_vga )
        begin
                if(DENTRO_DE_LA_PANTALLA)
                        if(DENTRO_DE_LA_CUADRILLA)
                        begin
                            if (SW[0])
                                VGA_COLOR <= {image_cur_pix_12};
                            else
                                VGA_COLOR <= COLOR_YELLOW;
                        end else
                             VGA_COLOR  <= COLOR_GREY;
                else
                       VGA_COLOR  <= COLOR_BLACK;// Seguridad
        end
        
        assign addrb = (vc_visible - 11'd1)*512 + (hc_visible - 11'd1);

        always @(posedge clk100mhz_clkwiz)
            reset_addra = (addra == 18'd200701) ? 1'b1 : 1'b0;





filtro1 color_Scr(
    .color_in(image_cur_pix),
    .SW(SW[15:10]),
    .color_out(image_cur_pix_1)
);


filtrogris filtgr(
    .color_in(image_cur_pix_1),
    .SW(SW[2]),
    .color_out(image_cur_pix_2)
);

        assign image_cur_pix_12 = {image_cur_pix_2[23:20], image_cur_pix_2[15:12], image_cur_pix_2[7:4]};


        assign {VGA_R, VGA_G, VGA_B} = VGA_COLOR;  
endmodule
