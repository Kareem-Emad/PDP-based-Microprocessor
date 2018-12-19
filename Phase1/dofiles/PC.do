restart -f
# set clock
force -freeze sim:/PCReg/clk 1 0, 0 {50 ns} -r 100

# show all variables
add wave -position end  sim:/PCReg/clk
add wave -position end  sim:/PCReg/rst
add wave -position end  sim:/PCReg/pc_in_bus_select
add wave -position end  sim:/PCReg/pc_out_bus_select
add wave -position end  sim:/PCReg/pc_in_bus
add wave -position end  sim:/PCReg/pc_out_bus
add wave -position end  sim:/PCReg/pc_inc
add wave -position end  sim:/PCReg/ir_q
add wave -position end  sim:/PCReg/c_flag
add wave -position end  sim:/PCReg/n_flag
add wave -position end  sim:/PCReg/z_flag
add wave -position end  sim:/PCReg/p_flag
add wave -position end  sim:/PCReg/o_flag
add wave -position end  sim:/PCReg/pc_q
add wave -position end  sim:/PCReg/pc_d
add wave -position end  sim:/PCReg/pc_incremented


run 50
# test reading from bus
force PCReg/pc_in_bus_select 1
force PCReg/pc_in_bus 16#ABBA
run
force PCReg/pc_in_bus_select 0

# test writing to bus
force PCReg/pc_out_bus_select 1
run
force PCReg/pc_out_bus_select 0

# test incrementing correctly
force rst 1
run
force rst 0
force pc_inc 1

run
run
run
run
run

# test BEQ
force PCReg/z_flag 1
force PCReg/ir_q 2#1111001000000010
run
run
# test BNEQ
force PCReg/ir_q 2#1111010000000010
run
force PCReg/z_flag 0
run