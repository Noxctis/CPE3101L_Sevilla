transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Chrys\ Sean\ Sevilla/Desktop/School\ Stuff/CPE3101L_Sevilla/LabExers/FinalsPractice/CustomSeqCounter {C:/Users/Chrys Sean Sevilla/Desktop/School Stuff/CPE3101L_Sevilla/LabExers/FinalsPractice/CustomSeqCounter/CustomSeqCounter.v}

vlog -vlog01compat -work work +incdir+C:/Users/Chrys\ Sean\ Sevilla/Desktop/School\ Stuff/CPE3101L_Sevilla/LabExers/FinalsPractice/CustomSeqCounter {C:/Users/Chrys Sean Sevilla/Desktop/School Stuff/CPE3101L_Sevilla/LabExers/FinalsPractice/CustomSeqCounter/tb_CustomSeqCounter.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  tb_CustomSeqCounter

add wave *
view structure
view signals
run -all
