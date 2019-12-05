package provide mysdk 1.0



proc ::sdk::create_sw_project {os_type src_files} {    
    sdk setws $::sdk::workspace
    
    file delete -force $::sdk::workspace/.metadata
    file delete -force $::sdk::workspace/.Xil

    sdk createhw -name $::sdk::hw_project -hwspec $::sdk::workspace/system_top.hdf
    
    loadTCL /opt/xilinx-tcl/os/$os_type.tcl

    ::os::setProperties $::board::hard_processor $::sdk::bsp_suffix $::sdk::hw_project
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
    set init_file $::sdk::workspace/$::sdk::hw_project/ps7_init.tcl
	
    #exec sed -i -e "s/variable PCW_SILICON/global PCW_SILICON/g"  $init_file
    #exec sed -i -e "s/variable APU/global APU/g"  $init_file	
    exec sed -i -e "s/set APU/variable APU/g" $init_file
    exec sed -i -e "s/set PCW_SILICON/variable PCW_SILICON/g" $init_file

    puts "Patch ps7_init file ($init_file)" 
}
