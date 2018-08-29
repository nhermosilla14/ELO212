# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_msg_config -id {Common 17-41} -limit 10000000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.cache/wt [current_project]
set_property parent.project_path /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_property ip_output_repo /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/clk_divider.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/counter_nbit.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/UART_RX_CTRL.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/FDCE7.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/pb_debouncer.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Referencias/driver_vga_1024x768.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Referencias/lab_9.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/new/filtro1.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/new/matrix_index.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/new/dith_simple.sv
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/new/filtrogris.sv
}
read_verilog -library xil_defaultlib {
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/uart_baud_tick_gen.v
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/uart_basic.v
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/uart_tx.v
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/uart_rx.v
  /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Reusables/data_sync.v
}
read_ip -quiet /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]

read_ip -quiet /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci
set_property used_in_implementation false [get_files -all /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/constrs_1/imports/Reusables/Nexys4DDR.xdc
set_property used_in_implementation false [get_files /home/benjamin/remoto/Documentos/ELO/Digitales/LAB/Verilog/Exp9/Exp9.srcs/constrs_1/imports/Reusables/Nexys4DDR.xdc]


synth_design -top lab_9 -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef lab_9.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file lab_9_utilization_synth.rpt -pb lab_9_utilization_synth.pb"
