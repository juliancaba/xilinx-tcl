package provide standalone 1.0

namespace eval ::os {
    variable hard_processor "none"
    variable bsp_name "none"
    variable hw_project "none"
}


proc ::os::setProperties {processor bsp_name hw_project} {
    set ::os::hard_processor $processor
    set ::os::bsp_name standalone_$bsp_name
    set ::os::hw_project $hw_project
}


proc ::os::setHardProcessor {processor} {
    set ::os::hard_processor $processor
}


proc ::os::setBSPname {bsp_name} {
    set ::os::bsp_name standalone_$bsp_name
}


proc ::os::setHardProcessor {hw_project} {
    set ::os::hw_project $hw_project
}


proc ::os::create_bsp {} {
    createbsp -name $::os::bsp_name -hwproject $::os::hw_project -proc $::os::hard_processor -os standalone
}


proc ::os::create_empty_app {name} {
    createapp -name $name -app {Empty Application} -bsp $::os::bsp_name -hwproject $::os::hw_project -proc  $::os::hard_processor
}
