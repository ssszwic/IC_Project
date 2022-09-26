# step 1 Read & elaborate the RTL file list & check
#==========================================================
set TOP_MODULE Top
analyze -library ANALYZE -format verilog [list Project.v]
elaborate -library ANALYZE $TOP_MODULE
current_design $TOP_MODULE
if {[link] == 0} {
    echo link with error!;
    exit;
}
if {[check_design] == 0} {
    echo check design with error!;
    exit;
}
#==========================================================
# step 2 reset the design first
#==========================================================
reset_design
#==========================================================
# step 3 write the unmapped ddc file 
#==========================================================
uniquify
set uniquify_naming_style %s_%d
write -f ddc -hierarchy -output ${UNMAPPED_PATH}/${TOP_MODULE}.ddc
#==========================================================
# step 4 define clock
#==========================================================
set         CLK_NAME            sys_clk
set         CLK_PERIOD          20
set         CLK_SKEW            [expr $CLK_PERIOD * 0.05]
set         CLK_JITTER          [expr $CLK_PERIOD * 0.01]
set         CLK_TRANS           [expr $CLK_PERIOD * 0.01]
set         CLK_SRC_LATENCY     [expr $CLK_PERIOD * 0.1]
set         CLK_LATENCY         [expr $CLK_PERIOD * 0.1]

create_clock -period $CLK_PERIOD [get_ports $CLK_NAME]

set_ideal_network      [get_ports $CLK_NAME]
set_dont_touch_network [get_ports $CLK_NAME]
set_drive  0           [get_ports $CLK_NAME]

set_clock_uncertainty -setup [expr $CLK_SKEW + $CLK_JITTER] [get_ports $CLK_NAME]
set_clock_uncertainty -hold $CLK_SKEW [get_ports $CLK_NAME]

set_clock_latency -source -max $CLK_SRC_LATENCY [get_ports $CLK_NAME]
set_clock_latency -max $CLK_LATENCY [get_ports $CLK_NAME]

set_clock_transition -max $CLK_TRANS [get_ports $CLK_NAME]
#==========================================================
# step 5 define reset
#==========================================================
set         RST_NAME            sys_rst_n

set_ideal_network [get_ports $RST_NAME]
set_dont_touch_network [get_ports $RST_NAME]
set_drive  0           [get_ports $RST_NAME]
#==========================================================
# step 6 set input delay
#==========================================================
set         ALL_IN_EXCEPT_CLK   [remove_from_collection [all_inputs] [get_ports $CLK_NAME]]
set         INPUT_DELAY         [expr $CLK_PERIOD * 0.5]

set_input_delay $INPUT_DELAY -clock $CLK_NAME $ALL_IN_EXCEPT_CLK
#==========================================================
# step 7 set output delay
#==========================================================
set         ALL_OUT             [all_outputs]
set         OUTPUT_DELAY         [expr $CLK_PERIOD * 0.4]

# set_output_delay $OUTPUT_DELAY -clock $CLK_NAME $ALL_OUT
#==========================================================
# step 8 compile
#==========================================================
compile
#==========================================================
# step 10 generate report files
#==========================================================
redirect -tee -file $REPORT_PATH/check_design.txt {check_design}
redirect -tee -file $REPORT_PATH/check_timing.txt {check_timing}
redirect -tee -file $REPORT_PATH/report_constraint.txt {report_constraint -all_violators}
redirect -tee -file $REPORT_PATH/report_setup.txt {report_timing -delay_type max}
redirect -tee -file $REPORT_PATH/report_hold.txt {report_timing -delay_type min}
redirect -tee -file $REPORT_PATH/report_area.txt {report_area}
