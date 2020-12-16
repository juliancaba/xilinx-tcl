source /opt/xilinx-tcl/build/project.tcl


set board [lindex $argv 0]

set workspace [pwd]/[lindex $argv 1].sdk
project::setWorkspace $workspace


deploy::upload_binaries $board
deploy::run $board

exit
