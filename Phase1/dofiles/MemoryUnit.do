restart -f
# set clock
force -freeze sim:/MemoryUnit/clk 1 0, 0 {50 ns} -r 100

# show all variables
add wave -position end  sim:/MemoryUnit/clk
add wave -position end  sim:/MemoryUnit/ram_clk
add wave -position end  sim:/MemoryUnit/rst
add wave -position end  sim:/MemoryUnit/mem_read
add wave -position end  sim:/MemoryUnit/mem_write
add wave -position end  sim:/MemoryUnit/bus_a
add wave -position end  sim:/MemoryUnit/bus_b
add wave -position end  sim:/MemoryUnit/mar_in_select_a
add wave -position end  sim:/MemoryUnit/mar_in_select_b
add wave -position end  sim:/MemoryUnit/mdr_out_select_a
add wave -position end  sim:/MemoryUnit/mdr_in_select_b
add wave -position end  sim:/MemoryUnit/mdr_q
add wave -position end  sim:/MemoryUnit/mdr_d
add wave -position end  sim:/MemoryUnit/mar_q
add wave -position end  sim:/MemoryUnit/mar_d
add wave -position end  sim:/MemoryUnit/ram_out
add wave -position end  sim:/MemoryUnit/mdr_in_select
add wave -position end  sim:/MemoryUnit/mar_in_select
add wave -position end  sim:/MemoryUnit/ram_word_to_write

run 50
# test reading from memory and filling mar from a same clock
force MemoryUnit/bus_a 1
force MemoryUnit/mar_in_select_a 1
force MemoryUnit/mem_read 1
run
force MemoryUnit/mar_in_select_a 0
force MemoryUnit/mem_read 0

# test reading from memory and filling mar from b same clock
force MemoryUnit/bus_b 3
force MemoryUnit/mar_in_select_b 1
force MemoryUnit/mem_read 1
run
force MemoryUnit/mar_in_select_b 0
force MemoryUnit/mem_read 0

# test writing to memory same clock
force MemoryUnit/bus_b 16#2124
force MemoryUnit/mdr_in_select_b 1
force MemoryUnit/bus_a 10#125
force MemoryUnit/mar_in_select_a 1
force MemoryUnit/mem_write 1
run
force MemoryUnit/mdr_in_select_b 0
force MemoryUnit/mar_in_select_a 0
force MemoryUnit/mem_write 0

##############################################

# test reading from memory and filling mar from a different clock
force MemoryUnit/bus_a 0
force MemoryUnit/mar_in_select_a 1
run
force MemoryUnit/mar_in_select_a 0

force MemoryUnit/mem_read 1
run
force MemoryUnit/mem_read 0

# test reading from memory and filling mar from b different clock
force MemoryUnit/bus_b 16#38
force MemoryUnit/mar_in_select_b 1
run
force MemoryUnit/mar_in_select_b 0

force MemoryUnit/mem_read 1
run
force MemoryUnit/mem_read 0

# test writing to memory different clock
force MemoryUnit/bus_b 16#2125
force MemoryUnit/mdr_in_select_b 1
force MemoryUnit/bus_a 10#126
force MemoryUnit/mar_in_select_a 1
run
force MemoryUnit/mdr_in_select_b 0
force MemoryUnit/mar_in_select_a 0

force MemoryUnit/mem_write 1
run
force MemoryUnit/mem_write 0


