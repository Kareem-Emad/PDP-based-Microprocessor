restart -f
# set clock
force -freeze sim:/RegisterFile/clk 1 0, 0 {50 ns} -r 100

# show all variables
add wave -position end  sim:/RegisterFile/clk
add wave -position end  sim:/RegisterFile/rst
add wave -position end  sim:/RegisterFile/busA
add wave -position end  sim:/RegisterFile/busB
add wave -position end  sim:/RegisterFile/reg_in_select_B
add wave -position end  sim:/RegisterFile/reg_out_select_A
add wave -position end  sim:/RegisterFile/reg_out_select_B
add wave -position end  sim:/RegisterFile/q_arr

run 50
# test reading from bus
force RegisterFile/reg_in_select_B 10#1
force RegisterFile/busB 16#1
run
force RegisterFile/reg_in_select_B 0

# test reading from bus
force RegisterFile/reg_in_select_B 10#2
force RegisterFile/busB 16#2
run
force RegisterFile/reg_in_select_B 0

# test reading from bus
force RegisterFile/reg_in_select_B 10#4
force RegisterFile/busB 16#4
run
force RegisterFile/reg_in_select_B 0

# test reading from bus
force RegisterFile/reg_in_select_B 10#8
force RegisterFile/busB 16#8
run
force RegisterFile/reg_in_select_B 0

# test reading from bus
force RegisterFile/reg_in_select_B 10#16
force RegisterFile/busB 16#16
run
force RegisterFile/reg_in_select_B 0

# test reading from bus
force RegisterFile/reg_in_select_B 10#32
force RegisterFile/busB 16#32
run
force RegisterFile/reg_in_select_B 0
noforce RegisterFile/busA
noforce RegisterFile/busB
#############################################################
# test writing to bus A and B
force RegisterFile/reg_out_select_B 10#1
force RegisterFile/reg_out_select_A 10#1
run
force RegisterFile/reg_out_select_B 10#0
force RegisterFile/reg_out_select_A 10#0

force RegisterFile/reg_out_select_B 10#2
force RegisterFile/reg_out_select_A 10#2
run
force RegisterFile/reg_out_select_B 10#0
force RegisterFile/reg_out_select_A 10#0

force RegisterFile/reg_out_select_B 10#4
force RegisterFile/reg_out_select_A 10#4
run
force RegisterFile/reg_out_select_B 10#0
force RegisterFile/reg_out_select_A 10#0

force RegisterFile/reg_out_select_B 10#8
force RegisterFile/reg_out_select_A 10#8
run
force RegisterFile/reg_out_select_B 10#0
force RegisterFile/reg_out_select_A 10#0

force RegisterFile/reg_out_select_B 10#16
force RegisterFile/reg_out_select_A 10#16
run
force RegisterFile/reg_out_select_B 10#0
force RegisterFile/reg_out_select_A 10#0

force RegisterFile/reg_out_select_B 10#32
force RegisterFile/reg_out_select_A 10#32
run
force RegisterFile/reg_out_select_B 10#0
force RegisterFile/reg_out_select_A 10#0
################################################
# test sending info
force RegisterFile/reg_out_select_B 10#8
force RegisterFile/reg_in_select_B 10#1
run
force RegisterFile/reg_out_select_B 10#0
force RegisterFile/reg_in_select_B 10#0

