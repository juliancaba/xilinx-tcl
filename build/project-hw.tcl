package provide hw 1.0



proc ::project::create_hw_project {} {	
    set current_dir [pwd]
    create_project -force $::project::project_name $current_dir -part $::project::device_part

    set_property board_part $::project::board_part [current_project]
    set_property target_language VHDL [current_project]
    set_property simulator_language VHDL [current_project]	
}
	


proc ::project::synth {} {
    generate_target all [get_files  [pwd]/$::project::project_name.srcs/sources_1/bd/$::bd::bd_name/$::bd::bd_name.bd]

    set_property strategy Flow_RuntimeOptimized [get_runs synth_1]
    set_property strategy Flow_RuntimeOptimized [get_runs impl_1]
    launch_runs impl_1 -to_step write_bitstream -jobs 4
    wait_on_run impl_1
}


proc ::project::export_hardware {} {
    file mkdir [pwd]/$::project::project_name.sdk
    write_hwdef -force  -file [pwd]/$::project::project_name.sdk/system_top.hdf
    # 2019 version >> write_hw_platform -force  -file [pwd]/$::project::project_name.sdk/system_top.hdf
    file copy -force [pwd]/$::project::project_name.runs/impl_1/sch_wrapper.sysdef [pwd]/$::project::project_name.sdk/sch_wrapper.hdf
    file copy -force [pwd]/$::project::project_name.runs/impl_1/sch_wrapper.bit [pwd]/$::project::project_name.sdk/fpga.bit	
}



# add any type of source files
proc ::project::add_src {files} {
    add_files -norecurse $files
    update_compile_order -fileset sources_1
}

proc ::project::add_tb {files} {
    set_property SOURCE_SET sources_1 [get_filesets sim_1]
    add_files -fileset sim_1 -norecurse $files
    update_compile_order -fileset sources_1
}


proc ::project::project_to_ip {} {
    ipx::package_project -root_dir . -vendor ARCo -library user -taxonomy /UserIP
    set_property core_revision 2 [ipx::current_core]
    ipx::create_xgui_files [ipx::current_core]
    ipx::update_checksums [ipx::current_core]
    ipx::save_core [ipx::current_core]
    set_property  ip_repo_paths . [current_project]
    update_ip_catalog
}



