onerror {quit -f}
vlib work
vlog -work work CEG3156_Lab1_FPAdder.vo
vlog -work work CEG3156_Lab1_FPAdder.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.sevenBitUpCounter_vlg_vec_tst
vcd file -direction CEG3156_Lab1_FPAdder.msim.vcd
vcd add -internal sevenBitUpCounter_vlg_vec_tst/*
vcd add -internal sevenBitUpCounter_vlg_vec_tst/i1/*
add wave /*
run -all
