package provide project-utils 1.0

source INSTALL_PATH/build/project-defines.tcl


proc getToolchainVersion {} {
    if {[catch {set vtmp [version -short]}]} {
	set vtmp [version]
	set vtoolchain [string range $vtmp 5 10]
    } else {    
	set vtoolchain [string range $vtmp 0 5]
    } 
    return $vtoolchain
}


proc loadTCL {filename} {
    if ![file exist $filename] {
	puts "ERROR: Board specification could not be found in $filename"
	exit 1
    }
    source $filename
}


# 1: XSDK
# 2: VITIS
proc getSW_IDE {} {
    variable VITIS
    variable XSDK
    
    if [expr {double([getToolchainVersion]) > 2019.1}] {
	return $VITIS 
    }
    return $XSDK
}


proc get_init_file {ps workspace hw_project} {
    variable VITIS
    
    set init_file $ps\_init.tcl

    if { [getSW_IDE] == $VITIS } {
	return $workspace/system_top/hw/$init_file
    } else {
	return $workspace/$hw_project/$init_file
    }
}
