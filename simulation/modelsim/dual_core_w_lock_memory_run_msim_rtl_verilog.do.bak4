transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory {C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory/tiny_risc_v.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory {C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory/register_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory {C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory/instruction_parser.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory {C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory {C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory/core_0_mem.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory {C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory/core_1_mem.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory {C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory/two_port_lock_mem.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory {C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory/dual_core_w_lock_memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory {C:/Users/haln/Desktop/ECE289/dual_core_w_lock_memory/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run -all
