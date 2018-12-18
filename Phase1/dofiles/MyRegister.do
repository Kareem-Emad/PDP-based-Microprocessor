restart -f
add wave -position end  sim:/myregister/n
add wave -position end  sim:/myregister/d
add wave -position end  sim:/myregister/q
add wave -position end  sim:/myregister/ld
add wave -position end  sim:/myregister/clk
add wave -position end  sim:/myregister/rst

force -freeze sim:/myregister/clk 1 0, 0 {50 ns} -r 100

force myregister/ld 1
force d 16#1234
run
force myregister/ld 0

force d 16#4234
run
force myregister/ld 1
run

force myregister/rst 1
run

force myregister/rst 0
run
run


