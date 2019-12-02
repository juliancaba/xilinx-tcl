source /opt/xilinx-tcl/build/project.tcl


set workspace [pwd]/[lindex $argv 0].sdk
project::setWorkspace $workspace

sdk::create_sw_project standalone {"main.c"}

sdk:build
sdk::patch_ps7_init

exit
