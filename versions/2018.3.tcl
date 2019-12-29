package provide aliases-commands 1.0


proc alias_write_hw_tool {} {
    write_hwdef -force  -file [pwd]/$::project::project_name.sdk/system_top.hdf
    file copy -force [pwd]/$::project::project_name.runs/impl_1/$::bd::bd_name\_wrapper.sysdef [pwd]/$::project::project_name.sdk/system_top.hdf
}


proc alias_set_extra_property {} {
    return
}


proc alias_sdk_create_app {} {
    sdk createhw -name $::sdk::hw_project -hwspec $::sdk::workspace/system_top.hdf
    ::os::create_bsp
    ::os::create_empty_app  $::sdk::sw_project_name
}


proc alias_os_create_app {name os_type} {
    createapp -name $name -app {Empty Application} -bsp $::os::bsp_name -hwproject $::os::hw_project -proc  $::os::hard_processor -os $os_type
}


proc alias_sdk_build {name} {
    projects -build
}


proc alias_get_init_file {filename} {
    return $::sdk::workspace/$::sdk::hw_project/$filename
}

