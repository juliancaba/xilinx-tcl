package provide sdk 1.0



proc ::sdk::create_sw_project {os_type src_files} {
    sdk setws $::sdk::workspace
    
    file delete -force $::sdk::workspace/.metadata
    file delete -force $::sdk::workspace/.Xil

    sdk createhw -name hw_platform_0 -hwspec $::sdk::workspace/system_top.hdf
    
    source /opt/xilinx-tcl/oss/$os_type.tcl
    
    # switch $os_type {
    # 	standalone {
    # 	    createbsp -name standalone_bsp_0 -hwproject hw_platform_0 -proc ps7_cortexa9_0 -os standalone
    # 	    createapp -name app -app {Empty Application} -bsp standalone_bsp_0 -hwproject hw_platform_0 -proc ps7_cortexa9_0
    # 	}
    # }

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
