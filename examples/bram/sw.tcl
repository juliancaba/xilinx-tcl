source /opt/xilinx-tcl/build/project.tcl

set board [lindex $argv 0]
project::setBoard $board

set workspace [pwd]/[lindex $argv 1].sdk
project::setWorkspace $workspace
project::setProjectName test



sdk::create_sw_project standalone {"main.c"}

sdk::build
sdk::patch_ps7_init

exit
