restart -f
# set clock
force -freeze sim:/ProcessingUnit/clk 1 0, 0 {50 ns} -r 100

# show all variables
add wave -position end  sim:/ProcessingUnit/clk
add wave -position end  sim:/ProcessingUnit/alu_define/x_q
add wave -position end  sim:/ProcessingUnit/alu_define/z_q
add wave -position end  sim:/ProcessingUnit/alu_define/alu_f
add wave -position end  sim:/ProcessingUnit/x_in_select
add wave -position end  sim:/ProcessingUnit/z_in_select
add wave -position end  sim:/ProcessingUnit/busA
add wave -position end  sim:/ProcessingUnit/busB
add wave -position end  sim:/ProcessingUnit/c_flag
add wave -position end  sim:/ProcessingUnit/n_flag
add wave -position end  sim:/ProcessingUnit/z_flag
add wave -position end  sim:/ProcessingUnit/p_flag
add wave -position end  sim:/ProcessingUnit/o_flag
add wave -position end  sim:/ProcessingUnit/alu_define/flag_reg_define/reg_d
add wave -position end  sim:/ProcessingUnit/alu_update_flag


run 50
# test x_in
force ProcessingUnit/x_in_select 1
force ProcessingUnit/busB 16#FFFF
run
force ProcessingUnit/x_in_select 0
noforce ProcessingUnit/busB


# test ALU & z_in
force ProcessingUnit/busA 16#EEEE
force ProcessingUnit/alu_select 1
force ProcessingUnit/z_in_select 1
force ProcessingUnit/alu_out_select 1
run
force ProcessingUnit/z_in_select 0
force ProcessingUnit/alu_out_select 0
noforce ProcessingUnit/busA


# test z_out
force ProcessingUnit/z_out_select 1
run
force ProcessingUnit/z_out_select 0
noforce ProcessingUnit/busB

# test alu_out
force ProcessingUnit/busA 1
noforce ProcessingUnit/busB
force ProcessingUnit/alu_out_select 1
run
force ProcessingUnit/alu_out_select 0

# test flag regs
force ProcessingUnit/alu_update_flag 1

# test overflow flag
force ProcessingUnit/busA 2#0111111111111111
force ProcessingUnit/x_in_select 1
force ProcessingUnit/busB 2#0111111111111111
run
force ProcessingUnit/x_in_select 0

force ProcessingUnit/alu_select 1
force ProcessingUnit/z_in_select 1
run

noforce ProcessingUnit/busA
noforce ProcessingUnit/busB
do ProcessingUnitRegisterFile.do
noforce ProcessingUnit/busA
noforce ProcessingUnit/busB
#################################################
force ProcessingUnit/reg_out_select_B 10#1
force ProcessingUnit/x_in_select 1
force ProcessingUnit/reg_out_select_A 10#2
force ProcessingUnit/alu_select 1
force ProcessingUnit/z_in_select 1
run
force ProcessingUnit/alu_select 0
force ProcessingUnit/z_in_select 0
force ProcessingUnit/x_in_select 0
force ProcessingUnit/reg_out_select_A 0
force ProcessingUnit/reg_out_select_B 0

force ProcessingUnit/reg_in_select_B 4
force ProcessingUnit/z_out_select 1
run
