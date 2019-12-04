package provide zed 1.0


namespace eval ::board {
    variable device_part "xc7z020clg484-1"
    variable hard_processor "ps7_cortexa9_0"
    variable board_part [dict create 2018.3 "em.avnet.com:zed:part0:1.4" 2017.4 "em.avnet.com:zed:part0:1.3" 2016.4 "em.avnet.com:zed:part0:1.3" 2015.4 "xilinx.com:zc702:part0:0.9"]
}


proc ::board::getDevicePart {} {
    return $::board::device_part
}


proc ::board::getProcessor {} {
    return $::board::hard_processor
}


proc ::board::getBoardPart {vtoolchain} {
    if [dict exists $::board::board_part $vtoolchain] {
	return [dict get $::board::board_part $vtoolchain]
    }
    puts $vtoolchain
    puts "ERROR: Toolcahin version not supported"
    exit 1
}

