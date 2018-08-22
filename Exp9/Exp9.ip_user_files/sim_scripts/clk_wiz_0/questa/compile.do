vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv -L xil_defaultlib "+incdir+../../../ipstatic" "+incdir+/home/nicolas/.local/opt/Xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/home/nicolas/.local/opt/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"/home/nicolas/.local/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/nicolas/.local/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" "+incdir+/home/nicolas/.local/opt/Xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/home/nicolas/.local/opt/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../Exp9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v" \
"../../../../Exp9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.v" \

vlog -work xil_defaultlib \
"glbl.v"
