package provide aliases-commands 1.0


proc alias_write_hw_tool {} {
    write_hw_platform -fixed -force -file [pwd]/$::project::project_name.sdk/system_top.xsa
    file copy -force [pwd]/$::project::project_name.runs/impl_1/$::bd::bd_name\_wrapper.hwdef [pwd]/$::project::project_name.sdk/system_top.hdf
}


proc alias_set_extra_property {} {
    set_property platform.name $::board::platform_name [current_project]
}


proc alias_sdk_create_app {} {
    ::os::create_empty_app  $::sdk::sw_project_name
}


proc alias_os_create_app {name os_type} {
    app create -name $name -template {Empty Application} -hw [pwd]/$::project::project_name.sdk/system_top.xsa -proc  $::os::hard_processor -os $os_type
}


proc alias_sdk_build {name} {
    app build -name $name
}


proc alias_get_init_file {filename} {
    return $::sdk::workspace/$filename
}
