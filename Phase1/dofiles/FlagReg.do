restart -f
# set clock
force -freeze sim:/flagreg/clk 1 0, 0 {100 ns} -r 100

# show all variables
add wave -position end  sim:/FlagReg/clk
add wave -position end  sim:/FlagReg/a_msb
add wave -position end  sim:/FlagReg/a_msb
add wave -position end  sim:/FlagReg/cout
add wave -position end  sim:/FlagReg/f
add wave -position end  sim:/FlagReg/s
add wave -position end  sim:/FlagReg/c_flag
add wave -position end  sim:/FlagReg/n_flag
add wave -position end  sim:/FlagReg/z_flag
add wave -position end  sim:/FlagReg/p_flag
add wave -position end  sim:/FlagReg/o_flag
add wave -position end  sim:/FlagReg/update_flag
add wave -position end  sim:/FlagReg/is_add_sub
add wave -position end  sim:/FlagReg/is_add
add wave -position end  sim:/FlagReg/is_sub

# test carry flag
run 50
force FlagReg/cout 1
force FlagReg/update_flag 1
run

# test negative flag
force FlagReg/f 2#1010010101001010
run

# test zero flag
force FlagReg/f 0
run

# test parity flag
force FlagReg/f 2#1010010101001010
run
force FlagReg/f 2#0010010101001011
run

# test is_add_sub, is_add and is_sub
force FlagReg/s 2#0000
run
force FlagReg/s 2#0001
run
force FlagReg/s 2#0010
run
force FlagReg/s 2#0011
run
force FlagReg/s 2#0100
run
force FlagReg/s 2#0101
run
force FlagReg/s 2#0110
run
force FlagReg/s 2#0111
run
force FlagReg/s 2#1000
run

# test overflow flag
force FlagReg/a_msb 0
force FlagReg/b_msb 0
force FlagReg/f 2#1010010101001010
run
force FlagReg/s 2#0000
run 
force FlagReg/a_msb 1
force FlagReg/b_msb 1
force FlagReg/f 2#0010010101001010
run
force FlagReg/a_msb 0
force FlagReg/b_msb 1
force FlagReg/f 2#1010010101001010
run
force FlagReg/s 2#0011
run
force FlagReg/a_msb 1
force FlagReg/b_msb 1
force FlagReg/f 2#0010010101001010
run
force FlagReg/a_msb 1
force FlagReg/b_msb 0
force FlagReg/f 2#0010010101001010
run
