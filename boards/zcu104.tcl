package provide zcu104 1.0


namespace eval ::board {
    variable device_part "xczu7ev-ffvc1156-2-e"
    variable hard_processor "psu_cortexa53_0"
    variable platform_name "ZCU104"

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
    source /opt/Xilinx/SDK/2018.3/scripts/sdk/util/zynqmp_utils.tcl

    targets -set -filter {name =~ "PSU"}
    fpga $::sdk::workspace/fpga.bit
    puts "INFO: PL configured"

    targets -set -filter {name =~"APU*"}
    loadhw $::sdk::workspace/system_top.hdf
    configparams force-mem-access 1
    targets -set -filter {name =~"APU*"}
    
    source [alias_get_init_file psu_init.tcl]
    psu_init
    after 1000
    psu_ps_pl_isolation_removal
    after 1000
    psu_ps_pl_reset_config
    catch {psu_protection}

    targets -set -filter {name =~ "*A53*0"}
    rst -processor    
    dow $::sdk::workspace/$::sdk::sw_project_name/Debug/$::sdk::sw_project_name.elf
    configparams force-mem-access 0
    puts "INFO: PS configured"
}


proc ::board::run {} {
    connect
    targets -set -filter {name =~ "Cortex-A*#0"}
    con
    after 1000
    exit	
}


