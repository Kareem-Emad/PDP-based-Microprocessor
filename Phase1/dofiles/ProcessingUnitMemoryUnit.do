restart -f
# set clock
force -freeze sim:/ProcessingUnit/clk 1 0, 0 {50 ns} -r 100

# show all variables
add wave -position end  sim:/ProcessingUnit/clk
add wave -position end  sim:/ProcessingUnit/reg_in_select_B
add wave -position end  sim:/ProcessingUnit/reg_out_select_A
add wave -position end  sim:/ProcessingUnit/reg_out_select_B
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
force ProcessingUnit/busB 16#1
force ProcessingUnit/reg_in_select_B 1
run
noforce ProcessingUnit/busB
force ProcessingUnit/reg_in_select_B 0

force ProcessingUnit/mar_in_select_A 1
force ProcessingUnit/reg_out_select_A 1
force ProcessingUnit/mem_read 1
run
force ProcessingUnit/mar_in_select_A 0
force ProcessingUnit/reg_out_select_A 0
force ProcessingUnit/mem_read 0

force ProcessingUnit/mdr_out_select 1
force ProcessingUnit/mar_in_select_A 1
force ProcessingUnit/mem_read 1
run
force ProcessingUnit/mdr_out_select 0
force ProcessingUnit/mar_in_select_A 0
force ProcessingUnit/mem_read 0

force ProcessingUnit/reg_out_select_B 1
force ProcessingUnit/mdr_in_select 1
force mem_write 1
run
force ProcessingUnit/reg_out_select_B 0
force ProcessingUnit/mdr_in_select 0
force mem_write 0