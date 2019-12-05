package provide mysdk 1.0



proc ::sdk::create_sw_project {os_type src_files} {
    set hw_project "hw_platform_0"
    set bsp_name "bsp_0"
    
    sdk setws $::sdk::workspace
    
    file delete -force $::sdk::workspace/.metadata
    file delete -force $::sdk::workspace/.Xil

    sdk createhw -name $hw_project -hwspec $::sdk::workspace/system_top.hdf
    
    loadTCL /opt/xilinx-tcl/os/$os_type.tcl

    ::os::setProperties $::board::hard_processor $bsp_name $hw_project
    ::os::create_bsp
    ::os::create_empty_app "app" 
    
    foreach f $src_files {
	file copy -force $f $::sdk::workspace/app/src 
    }

}


proc ::sdk::build {} {
    projects -build
}

proc ::sdk::patch_ps7_init {} {	
    set init_file $::sdk::workspace/hw_platform_0/ps7_init.tcl
	
    exec sed -i -e "s/variable PCW_SILICON/global PCW_SILICON/g"  $init_file
    exec sed -i -e "s/variable APU/global APU/g"  $init_file	
    exec sed -i -e "s/set APU/variable APU/g" $init_file
    exec sed -i -e "s/set PCW_SILICON/variable PCW_SILICON/g" $init_file
}
