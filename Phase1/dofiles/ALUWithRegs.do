restart -f
# set clock
force -freeze sim:/ALUWithRegs/clk 1 0, 0 {50 ns} -r 100

# show all variables
add wave -position end  sim:/ALUWithRegs/clk
add wave -position end  sim:/ALUWithRegs/b
add wave -position end  sim:/ALUWithRegs/s
add wave -position end  sim:/ALUWithRegs/x_in_bus
add wave -position end  sim:/ALUWithRegs/x_in_select
add wave -position end  sim:/ALUWithRegs/z_out_bus
add wave -position end  sim:/ALUWithRegs/z_in_select
add wave -position end  sim:/ALUWithRegs/z_out_select
add wave -position end  sim:/ALUWithRegs/alu_out_select
add wave -position end  sim:/ALUWithRegs/alu_out_bus
add wave -position end  sim:/ALUWithRegs/c_flag
add wave -position end  sim:/ALUWithRegs/n_flag
add wave -position end  sim:/ALUWithRegs/z_flag
add wave -position end  sim:/ALUWithRegs/p_flag
add wave -position end  sim:/ALUWithRegs/o_flag
add wave -position end  sim:/ALUWithRegs/update_flag
add wave -position end  sim:/ALUWithRegs/x_d
add wave -position end  sim:/ALUWithRegs/x_q
add wave -position end  sim:/ALUWithRegs/z_q
add wave -position end  sim:/ALUWithRegs/alu_f
add wave -position end  sim:/aluwithregs/flag_reg_define/is_add_sub
add wave -position end  sim:/aluwithregs/flag_reg_define/is_add
add wave -position end  sim:/aluwithregs/flag_reg_define/is_sub
add wave -position end  sim:/aluwithregs/flag_reg_define/reg_q
add wave -position end  sim:/aluwithregs/flag_reg_define/a_msb
add wave -position end  sim:/aluwithregs/flag_reg_define/b_msb

run 50
# test x_in
force ALUWithRegs/x_in_select 1
force ALUWithRegs/x_in_bus 16#FFFF
run
force ALUWithRegs/x_in_select 0

# test ALU & z_in
force ALUWithRegs/b 16#EEEE
force ALUWithRegs/s 1
force ALUWithRegs/z_in_select 1
run
force ALUWithRegs/z_in_select 0

# test z_out
force ALUWithRegs/z_out_select 1
run
force ALUWithRegs/z_out_select 0

# test alu_out
force ALUWithRegs/alu_out_select 1
run
force ALUWithRegs/alu_out_select 0

# test flag regs
force ALUWithRegs/update_flag 1

# test overflow flag
force ALUWithRegs/b 2#0111111111111111
force ALUWithRegs/x_in_select 1
force ALUWithRegs/x_in_bus 2#0111111111111111
run
force ALUWithRegs/x_in_select 0

force ALUWithRegs/s 1
force ALUWithRegs/z_in_select 1
run