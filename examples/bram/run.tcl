source /opt/xilinx-tcl/build/project.tcl

set workspace [pwd]/[lindex $argv 0].sdk
project::setWorkspace $workspace

deploy::upload_binaries
deploy::run

exit
