package provide zynqberry 1.0


namespace eval ::board {
    variable device_part "xc7z010clg225"
    variable hard_processor "ps7_cortexa9_0"
    variable platform_name "te0726_m"
    
    array set board_part_versions {
	2018.3 "trenz.biz:te0726_m:part0:3.1"
	2017.4 "trenz.biz:te0726_m:part0:3.1"
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


proc ::board::upload_bitstream {} {
    connect	
    targets -set -filter {name =~ "ARM*#0"}
    rst
    fpga $::sdk::workspace/fpga.bit
    puts "INFO: PL configured"
}


proc ::board::upload_sw {} {
    source [get_init_file ps7 $::sdk::workspace $::sdk::hw_project]
    ps7_init
    ps7_post_config
    loadhw $::sdk::workspace/system_top.hdf
    dow $::sdk::workspace/app/Debug/app.elf
    puts "INFO: PS configured"
}


proc ::board::upload_binaries {} {
    board::upload_bitstream
    board::upload_sw
}


proc ::board::run {} {
    connect
    targets -set -filter {name =~ "ARM*#0"}
    con
    after 1000
    exit	
}
