package provide project 1.0

source INSTALL_PATH/build/project-utils.tcl


namespace eval ::project {
    variable project_name "none"
    variable device_part "none"
    variable board_part "none"

    namespace eval ::bd {
	variable bd_name "none"
    }
    
    namespace eval ::sdk {
	variable workspace "none"
	variable sw_project_name "app"
	variable os_type "standalone"
	variable hw_project "hw_platform_0"
	variable bsp_suffix "bsp_0"
    }
    
    namespace eval ::deploy {
    }
}



proc ::project::setProjectName {project_name} {
    set ::project::project_name $project_name
    set ::sdk::workspace [pwd]/$project_name.sdk
}


proc ::project::setBoard {board} {
    loadTCL INSTALL_PATH/boards/$board.tcl
    set ::project::device_part [::board::getDevicePart]
    set ::project::board_part [::board::getBoardPart [getToolchainVersion]]
}


proc ::project::setBlockDesignName {bd_name} {    
    set ::project::bd::bd_name $bd_name
}


proc ::project::setProperties {project_name board} {
    loadTCL INSTALL_PATH/boards/$board.tcl
    set ::project::device_part [::board::getDevicePart]
    set ::project::board_part [::board::getBoardPart [getToolchainVersion]]
    set ::project::project_name $project_name
    set ::sdk::workspace [pwd]/$project_name.sdk
}


proc ::project::setWorkspace {workspace} {
    set ::sdk::workspace $workspace
}


proc ::project::setSWProjectName {name} {
    set ::sdk::sw_project_name $name
}


proc ::project::addIPRepoPath {path} {
    set_property ip_repo_paths $path [current_project]
    update_ip_catalog
}




source INSTALL_PATH/build/project-hw.tcl
source INSTALL_PATH/build/project-bd.tcl
source INSTALL_PATH/build/project-sdk.tcl
source INSTALL_PATH/build/project-deploy.tcl

source INSTALL_PATH/ips/ips.tcl
