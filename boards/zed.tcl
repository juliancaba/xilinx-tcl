package provide zed 1.0

set device_part "xc7z020clg484-1"


###############################################################
### Get Version
###############################################################
set vtmp [version -short]
set vtoolchain [string range $vtmp 0 5]
###############################################################

switch $vtoolchain {
    2018.3 {
	set board_part "em.avnet.com:zed:part0:1.4"
    }
    2017.4 {
	set board_part "em.avnet.com:zed:part0:1.3"
    }
    2016.4{
	set board_part "em.avnet.com:zed:part0:1.3"
    }
    2015.4{
	set board_part "xilinx.com:zc702:part0:0.9"
    }
    default {
	error "ERROR: Toolchain version not supported"
    }
}
