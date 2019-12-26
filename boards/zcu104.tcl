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

