restart -f
# set clock
force -freeze sim:/ProcessingUnit/clk 1 0, 0 {50 ns} -r 100

# show all variables
add wave -position end  sim:/ProcessingUnit/clk
add wave -position end  sim:/ProcessingUnit/pc_inc
add wave -position end  sim:/ProcessingUnit/pc_out
add wave -position end  sim:/ProcessingUnit/pc_define/pc_q
add wave -position end  sim:/ProcessingUnit/ir_q
add wave -position end  sim:/ProcessingUnit/mem_rst
add wave -position end  sim:/ProcessingUnit/mem_read
add wave -position end  sim:/ProcessingUnit/mem_write
add wave -position end  sim:/ProcessingUnit/mar_in_select_A
add wave -position end  sim:/ProcessingUnit/mar_in_select_B
add wave -position end  sim:/ProcessingUnit/mdr_out_select
add wave -position end  sim:/ProcessingUnit/mdr_in_select
add wave -position end  sim:/ProcessingUnit/ram_define/mdr_q
add wave -position end  sim:/ProcessingUnit/ram_define/mar_q
add wave -position end  sim:/ProcessingUnit/register_file_define/q_arr
add wave -position end  sim:/ProcessingUnit/busA
add wave -position end  sim:/ProcessingUnit/busB

run 50
force ProcessingUnit/pc_inc 1
run 
run
run
force ProcessingUnit/ir_in_select 1
force ProcessingUnit/busA 2#1111001000000010
run
force ProcessingUnit/ir_in_select 0
noforce ProcessingUnit/busA

run
run
# test x_in
force ProcessingUnit/x_in_select 1
force ProcessingUnit/busB 16#FFFF
run
force ProcessingUnit/x_in_select 0
noforce ProcessingUnit/busB


# test ALU & z_in
force ProcessingUnit/busA 1
force ProcessingUnit/alu_select 1
force ProcessingUnit/alu_update_flag 1
force ProcessingUnit/z_in_select 1
force ProcessingUnit/alu_out_select 1
run
noforce ProcessingUnit/busA
force ProcessingUnit/alu_select 0
force ProcessingUnit/z_in_select 0
force ProcessingUnit/alu_out_select 0
force ProcessingUnit/alu_update_flag 0
run

