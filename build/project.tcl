package provide project 1.0



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
}



proc ::project::setProjectName {project_name} {
    set ::project::project_name $project_name
    set ::sdk::workspace [pwd]/$project_name.sdk
}


proc ::project::setBoard {board_name} {
    source ../boards/$board_name.tcl
    set ::project::device_part $device_part    
    set ::project::board_part $board_part
}


proc ::project::setBlockDesignName {bd_name} {    
    set ::project::bd::bd_name $bd_name
}


proc ::project::setProperties {project_name board} {
    source /opt/xilinx-tcl/boards/$board.tcl
    set ::project::device_part $device_part    
    set ::project::board_part $board_part
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
