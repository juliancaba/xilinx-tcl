source /opt/xilinx-tcl/build/project.tcl

set workspace [pwd]/[lindex $argv 1].sdk
project::setWorkspace $workspace

set board [lindex $argv 0]

deploy::upload_binaries $board
deploy::run $board

exit
