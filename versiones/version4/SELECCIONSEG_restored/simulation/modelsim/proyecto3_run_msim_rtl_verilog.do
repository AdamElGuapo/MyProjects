transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cycloneive_ver
vmap cycloneive_ver ./verilog_libs/cycloneive_ver
vlog -vlog01compat -work cycloneive_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/cycloneive_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/registro_ex_mem.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/registro_mem_wb.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/registro_if_id.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/pc.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/Banco_registros.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/ALU.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/fase1.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/Control.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/mux1.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/mux2.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/sumador1.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/sumador2.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/ALU_CONTROL.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/PUERTA_AND.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/ImmGen.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/micro.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/registro_id_ex.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/ROM.sv}
vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/RAM.sv}

vlog -sv -work work +incdir+C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored {C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/tb_micro.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_micro

add wave *
view structure
view signals
run -all
