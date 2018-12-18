restart -f
add wave -position end  sim:/tristate/q
add wave -position end  sim:/tristate/d
add wave -position end  sim:/tristate/ld

force tristate/ld 1
force d 16#1234
run

force tristate/ld 0
force d 16#4234
run

force tristate/ld 1
run

force tristate/ld 0
run

