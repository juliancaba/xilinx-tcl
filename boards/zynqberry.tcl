package provide zynqberry 1.0


namespace eval ::board {
    variable device_part "xc7z010clg225"
    variable hard_processor "ps7_cortexa9_0"
    variable board_part [dict create 2018.3 "trenz.biz:te0726_m:part0:3.1" 2017.4 "trenz.biz:te0726_m:part0:3.1"]
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

