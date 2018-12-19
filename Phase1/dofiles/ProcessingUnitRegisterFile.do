restart -f
# set clock
force -freeze sim:/ProcessingUnit/clk 1 0, 0 {50 ns} -r 100

# show all variables
add wave -position end  sim:/ProcessingUnit/clk
add wave -position end  sim:/ProcessingUnit/reg_rst
add wave -position end  sim:/ProcessingUnit/busA
add wave -position end  sim:/ProcessingUnit/busB
add wave -position end  sim:/ProcessingUnit/reg_in_select_B
add wave -position end  sim:/ProcessingUnit/reg_out_select_A
add wave -position end  sim:/ProcessingUnit/reg_out_select_B
add wave -position end  sim:/processingunit/register_file_define/q_arr

run 50
# test reading from bus
force ProcessingUnit/reg_in_select_B 10#1
force ProcessingUnit/busB 16#1
run
force ProcessingUnit/reg_in_select_B 0

# test reading from bus
force ProcessingUnit/reg_in_select_B 10#2
force ProcessingUnit/busB 16#2
run
force ProcessingUnit/reg_in_select_B 0

# test reading from bus
force ProcessingUnit/reg_in_select_B 10#4
force ProcessingUnit/busB 16#4
run
force ProcessingUnit/reg_in_select_B 0

# test reading from bus
force ProcessingUnit/reg_in_select_B 10#8
force ProcessingUnit/busB 16#8
run
force ProcessingUnit/reg_in_select_B 0

# test reading from bus
force ProcessingUnit/reg_in_select_B 10#16
force ProcessingUnit/busB 16#16
run
force ProcessingUnit/reg_in_select_B 0

# test reading from bus
force ProcessingUnit/reg_in_select_B 10#32
force ProcessingUnit/busB 16#32
run
force ProcessingUnit/reg_in_select_B 0
noforce ProcessingUnit/busA
noforce ProcessingUnit/busB
#############################################################
# test writing to bus A and B
force ProcessingUnit/reg_out_select_B 10#1
force ProcessingUnit/reg_out_select_A 10#1
run
force ProcessingUnit/reg_out_select_B 10#0
force ProcessingUnit/reg_out_select_A 10#0

force ProcessingUnit/reg_out_select_B 10#2
force ProcessingUnit/reg_out_select_A 10#2
run
force ProcessingUnit/reg_out_select_B 10#0
force ProcessingUnit/reg_out_select_A 10#0

force ProcessingUnit/reg_out_select_B 10#4
force ProcessingUnit/reg_out_select_A 10#4
run
force ProcessingUnit/reg_out_select_B 10#0
force ProcessingUnit/reg_out_select_A 10#0

force ProcessingUnit/reg_out_select_B 10#8
force ProcessingUnit/reg_out_select_A 10#8
run
force ProcessingUnit/reg_out_select_B 10#0
force ProcessingUnit/reg_out_select_A 10#0

force ProcessingUnit/reg_out_select_B 10#16
force ProcessingUnit/reg_out_select_A 10#16
run
force ProcessingUnit/reg_out_select_B 10#0
force ProcessingUnit/reg_out_select_A 10#0

force ProcessingUnit/reg_out_select_B 10#32
force ProcessingUnit/reg_out_select_A 10#32
run
force ProcessingUnit/reg_out_select_B 10#0
force ProcessingUnit/reg_out_select_A 10#0
################################################
# test sending info
force ProcessingUnit/reg_out_select_B 10#8
force ProcessingUnit/reg_in_select_B 10#1
run
force ProcessingUnit/reg_out_select_B 10#0
force ProcessingUnit/reg_in_select_B 10#0

