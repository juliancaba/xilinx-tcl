package provide zynqberry 1.0

set device_part "xc7z010clg225"


###############################################################
### Get Version
###############################################################
set vtmp [version -short]
set vtoolchain [string range $vtmp 0 5]
###############################################################


switch $vtoolchain {
    2018.3 {
	set board_part "trenz.biz:te0726_m:part0:3.1"
    }
    2017.4 {
	set board_part "trenz.biz:te0726_m:part0:3.1"
    }
    default {
	error "ERROR: Toolchain version not supported"
    }
}
