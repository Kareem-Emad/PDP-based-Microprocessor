restart -f
add wave -position end  sim:/ALU/a
add wave -position end  sim:/ALU/b
add wave -position end  sim:/ALU/f
add wave -position end  sim:/ALU/s
add wave -position end  sim:/ALU/cin
add wave -position end  sim:/ALU/cout

force ALU/a 16#0f0f
force ALU/cin 0
force ALU/s 0
run 100

force ALU/a 16#0f0f
force ALU/b 16#0001
force ALU/cin 0
force ALU/s 1
run 100

force ALU/a 16#ffff
force ALU/b 16#0001
force ALU/cin 0
force ALU/s 1
run 100

force ALU/a 16#ffff
force ALU/b 16#0001
force ALU/cin 0
force ALU/s 2
run 100

force ALU/a 16#ffff
force ALU/cin 0
force ALU/s 3
run 100

force ALU/a 16#0f0e
force ALU/cin 1
force ALU/s 0
run 100

force ALU/a 16#ffff
force ALU/b 16#0001
force ALU/cin 1
force ALU/s 1
run 100

force ALU/a 16#0f0f
force ALU/b 16#0001
force ALU/cin 1
force ALU/s 2
run 100

force ALU/cin 1
force ALU/s 3
run 100