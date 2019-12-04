package provide project 1.0

source /opt/xilinx-tcl/build/project-utils.tcl


namespace eval ::project {
    variable project_name "none"
    variable device_part "none"
    variable board_part "none"

    namespace eval ::bd {
	variable bd_name "none"
    }
    
    namespace eval ::sdk {
	variable workspace "none"
    }
    
    namespace eval ::deploy {
    }
}



proc ::project::setProjectName {project_name} {
    set ::project::project_name $project_name
    set ::sdk::workspace [pwd]/$project_name.sdk
}


proc ::project::setBoard {board} {
    set filename /opt/xilinx-tcl/boards/$board.tcl
    if ![file exist $filename] {
	puts "ERROR: Board specification could not be found in $filename"
	exit 1
    }
    source $filename
     set ::project::device_part [::board::getDevicePart]
    set ::project::board_part [::board::getBoardPart [getToolchainVersion]]
}


proc ::project::setBlockDesignName {bd_name} {    
    set ::project::bd::bd_name $bd_name
}


proc ::project::setProperties {project_name board} {
    set filename /opt/xilinx-tcl/boards/$board.tcl
    if ![file exist $filename] {
	puts "ERROR: Board specification could not be found in $filename"
	exit 1
    }
    source $filename
    set ::project::device_part [::board::getDevicePart]
    set ::project::board_part [::board::getBoardPart [getToolchainVersion]]
    set ::project::project_name $project_name
    set ::sdk::workspace [pwd]/$project_name.sdk
}


proc ::project::setWorkspace {workspace} {
    set ::sdk::workspace $workspace
}



source /opt/xilinx-tcl/build/project-hw.tcl
source /opt/xilinx-tcl/build/project-bd.tcl
source /opt/xilinx-tcl/build/project-sdk.tcl
source /opt/xilinx-tcl/build/project-deploy.tcl
