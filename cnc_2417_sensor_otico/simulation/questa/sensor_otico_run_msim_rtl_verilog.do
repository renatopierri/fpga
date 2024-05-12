transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/antenor/OneDrive/Documentos/GitHub/fpga/cnc_2417_sensor_otico {C:/Users/antenor/OneDrive/Documentos/GitHub/fpga/cnc_2417_sensor_otico/sensor_otico.v}

