`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2018 18:08:26
// Design Name: 
// Module Name: Exp9-reloj
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


module Exp9reloj(
        input logic             CLK100MHZ,
        input logic             BTNC, BTNR, BTNL, CPU_RESETN,
        input logic     [0:0]   SW,
        output logic    [7:0]   D7S, AN,
        output logic    [0:0]   LED
);
//Botones
        logic btn_reset = ~CPU_RESETN;
        logic btn_reset_db, btnl_db, btnr_db, btnc_db, btnl_turbo, btnr_turbo;
        logic reset_seconds, reset_minutes, reset_hours;
        logic btnl_real, btnr_real, btnr_db_posedge, btnl_db_posedge;
        assign btnr_real = (btnr_db_posedge | btnr_turbo);
        assign btnl_real = (btnl_db_posedge | btnl_turbo);
////////////////////////////////////////////////////////////
//Clocks
        logic seconds_clk, minutes_clk, hours_clk, signal_clk, points_clk;
// Valores de salida para los contadores
        logic [5:0] cur_seconds, cur_minutes, cur_hours, cur_hours_post_pm;
        logic [31:0] cur_seconds_bcd, cur_minutes_bcd, cur_hours_bcd;
//Debouncers para todo
        pb_debouncer btn_reset_db_(
                .clk(CLK100MHZ),
                .rst(0),
                .PB(btn_reset),
                .PB_state(btn_reset_db),
                .PB_negedge(),
                .PB_posedge()
        );
        
        pb_debouncer btn_r(
                .clk(CLK100MHZ),
                .rst(0),
                .PB(BTNR),
                .PB_state(btnr_db),
                .PB_negedge(),
                .PB_posedge(btnr_db_posedge)
        );
        
        pb_debouncer btn_l(
                .clk(CLK100MHZ),
                .rst(0),
                .PB(BTNL),
                .PB_state(btnl_db),
                .PB_negedge(),
                .PB_posedge(btnl_db_posedge)
        );
        pb_debouncer btn_c(
                .clk(CLK100MHZ),
                .rst(0),
                .PB(BTNC),
                .PB_state(btnc_db),
                .PB_negedge(),
                .PB_posedge()
        );
////////////////////////////////////////////
        //Counters
        counter_nbit #(6) seconds(
                .clk(seconds_clk),
                .reset(reset_seconds),
                .P(cur_seconds)
        );

        counter_nbit #(6) minutes(
                .clk(minutes_clk),
                .reset(reset_minutes),
                .P(cur_minutes)
        );
        
        counter_nbit #(6) hours(
                .clk(hours_clk),
                .reset(reset_hours),
                .P(cur_hours)
        );
////////////////////////////////////////////////////
//Modo PM/AM
        modpm(
            .in_num(cur_hours),
            .mode12(SW[0]),
            .out_num(cur_hours_post_pm),
            .pm(LED[0])
        );
////////////////////////////////////////////////////        
//Clock principal del segundero        
        clk_divider #(49999999) clkdiv_seconds(
                .clk_in(CLK100MHZ),
                .reset(btn_reset_db),
                .clk_out(seconds_clk)
        );

        clk_divider #(24999999) clk_div_puntitos(
                .clk_in(CLK100MHZ),
                .reset(btn_reset_db),
                .clk_out(points_clk)
        );
        
        clk_divider #(2499999) clk_div_converter(
                .clk_in(CLK100MHZ),
                .reset(btn_reset_db),
                .clk_out(signal_clk)
        );

///////////////////////////////////////////////////
// Lógica para cálculo de horas, minutos y segundos
        always_comb
        begin
                hours_clk = (btnr_real | (cur_minutes == 6'd60)) ? 1'b1 : 1'b0;
                minutes_clk = (btnl_real | (cur_seconds == 6'd60)) ? 1'b1 : 1'b0;
                reset_minutes = ((cur_minutes == 6'd60) | btn_reset_db) ? 1'b1 : 1'b0;
                reset_seconds = ((cur_seconds == 6'd60) | btnc_db | btn_reset_db) ? 1'b1 : 1'b0;
                reset_hours = ((cur_hours == 6'd24) | btn_reset_db) ? 1'b1 : 1'b0;
        end
///////////////////////////////////////////////////////////
// Turbo buttons
// Botones con función de repeticion
        btn_repeater left_repeater(
            .btn(btnl_db),
            .clk_1(seconds_clk),
            .clk_2(points_clk),
            .btn_output(btnl_turbo)
        );
        
        btn_repeater right_repeater(
            .btn(btnr_db),
            .clk_1(seconds_clk),
            .clk_2(points_clk),
            .btn_output(btnr_turbo)
        );


///////////////////////////////////////////////////////////
// Convertidor a decimal
        unsigned_to_bcd conv_bcd_seconds(
                .clk(CLK100MHZ),
                .trigger(signal_clk),
                .in({26'b0, cur_seconds}),
                .idle(),
                .bcd(cur_seconds_bcd)
        );
        unsigned_to_bcd conv_bcd_minutes(
                .clk(CLK100MHZ),
                .trigger(signal_clk),
                .in({26'b0, cur_minutes}),
                .idle(),
                .bcd(cur_minutes_bcd)
        );
        unsigned_to_bcd conv_bcd_hours(
                .clk(CLK100MHZ),
                .trigger(signal_clk),
                .in({26'b0, cur_hours_post_pm}),
                .idle(),
                .bcd(cur_hours_bcd)
        );
///////////////////////////////////////////////////////////
// Display driver
        drv_7seg _7segdrv(
            .in_num({cur_hours_bcd[7:0], 4'b0, cur_minutes_bcd[7:0], 4'b0, cur_seconds_bcd[7:0]}),
            .clk(CLK100MHZ),
            .turn_on(1'b1),
            .D7S(D7S),
            .AN(AN),
            .clock_mode(1'b1),
            .dot_clk(points_clk)
        );

endmodule
