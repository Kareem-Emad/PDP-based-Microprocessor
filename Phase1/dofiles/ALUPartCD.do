restart -f
add wave -position end  sim:/ALU/a
add wave -position end  sim:/ALU/b
add wave -position end  sim:/ALU/f
add wave -position end  sim:/ALU/s
add wave -position end  sim:/ALU/cin
add wave -position end  sim:/ALU/cout

force alu/a 16#0f0f
force alu/b 16#000a
force alu/s 4
run 100

force alu/a 16#0f0f
force alu/b 16#000a
force alu/cin 0
force alu/s 5
run 100

force alu/a 16#0f0f
force alu/b 16#000a
force alu/cin 0
force alu/s 6
run 100

force alu/a 16#0f0f
force alu/cin 0
force alu/s 7
run 100

force alu/a 16#0f0f
force alu/cin 0
force alu/s 8
run 100

force alu/a 16#0f0f
force alu/cin 0
force alu/s 9
run 100

force alu/a 16#ffff
force alu/b 16#0001
force alu/cin 0
force alu/s 2#1111
run 100




force alu/a 16#0f0f
force alu/cin 0
force alu/s 10#10
run 100

force alu/a 16#0f0f
force alu/cin 1
force alu/s 10#10
run 100

force alu/a 16#0f0f
force alu/cin 0
force alu/s 10#12
run 100

force alu/a 16#f0f0
force alu/b 16#0001
force alu/cin 0
force alu/s 10#13
run 100

force alu/a 16#f0f0
force alu/b 16#0001
force alu/cin 0
force alu/s 10#14
run 100

force alu/a 16#f0f0
force alu/b 16#0001
force alu/cin 1
force alu/s 10#14
run 100

force alu/a 16#f0f0
force alu/b 16#0001
force alu/cin 1
force alu/s 10#11
run 100