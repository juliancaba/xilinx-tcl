package provide mysdk 1.0



proc ::sdk::create_sw_project {os_type src_files} {
    set $::sdk::os_type $os_type
    sdk setws $::sdk::workspace
    
    file delete -force $::sdk::workspace/.metadata
    file delete -force $::sdk::workspace/.Xil

    sdk createhw -name $::sdk::hw_project -hwspec $::sdk::workspace/system_top.hdf
    
    loadTCL INSTALL_PATH/os/$os_type.tcl

    ::os::setProperties $::board::hard_processor $::sdk::bsp_suffix $::sdk::hw_project
    ::os::create_bsp
    ::os::create_empty_app  $::sdk::sw_project_name 

    foreach f $src_files {
	file copy -force $f $::sdk::workspace/$::sdk::sw_project_name/src
    }

}


proc ::sdk::add_files_from_folder {folder} {
    set files [glob -tails -dir $folder *{.c,.cc,.cpp,.h,.hh,.hpp}]
    foreach f $files {
	file copy -force $f $::sdk::workspace/$::sdk::sw_project_name/src
    }    
}


proc ::sdk::setBSPLibs {bsp_libs} {
    foreach it $bsp_libs {	
	setlib -bsp $::sdk::os_type\_$::sdk::bsp_suffix -lib $it
	configapp -app $::sdk::sw_project_name libraries $it
    }
    updatemss -mss $::sdk::workspace/$::sdk::os_type\_$::sdk::bsp_suffix/system.mss
    regenbsp -bsp $::sdk::os_type\_$::sdk::bsp_suffix
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
