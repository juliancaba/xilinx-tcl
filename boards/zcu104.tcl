package provide zcu104 1.0


namespace eval ::board {
    variable device_part "xczu7ev-ffvc1156-2-e"
    variable hard_processor "psu_cortexa53_0"

    array set board_part_versions {
	2019.2 "xilinx.com:zcu104:part0:1.1"
	2018.3 "xilinx.com:zcu104:part0:1.1"
    }
}


proc ::board::getDevicePart {} {
    return $::board::device_part
}


proc ::board::getProcessor {} {
    return $::board::hard_processor
}


proc ::board::getBoardPart {vtoolchain} {
    set board_part [array get ::board::board_part_versions $vtoolchain]
    if {[llength $board_part] == 2} {
	return [lindex $board_part 1]
    }
    puts $vtoolchain
    puts "ERROR: Toolchain version not supported"
    exit 1
}


proc ::board::upload_binaries {} {
    connect    
    targets -set -filter {name =~ "PSU"}
    fpga $::sdk::workspace/fpga.bit
    puts "PL configured"

    configparams force-mem-access 1
    targets -set -filter {name =~"APU*"}
    loadhw $::sdk::workspace/system_top.hdf
    source $::sdk::workspace/$::sdk::hw_project/psu_init.tcl
    puts $::sdk::workspace/$::sdk::hw_project/psu_init.tcl
    psu_init

    after 1000
    psu_ps_pl_isolation_removal
    after 1000
    psu_ps_pl_reset_config

    targets -set -filter {name =~ "*A53*0"}
    rst -processor
    
    dow $::sdk::workspace/$::sdk::sw_project_name/Debug/$::sdk::sw_project_name.elf
    configparams force-mem-access 0
    puts "PS configured"
}


proc ::board::run {} {
    connect
    targets -set -filter {name =~ "Cortex-A*#0"}
    con
    after 1000
    exit	
}


