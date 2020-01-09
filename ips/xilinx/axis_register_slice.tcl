package provide axis_register_slice 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::axis_register_slice {
    variable ip_core_generator "xilinx.com:ip:axis_register_slice"

    array set pipeline_options {
	light_weight 7
	full 8
	bypass 0
	dflt 1
    }
    
    array set properties {
	pipeline {CONFIG.REG_CONFIG "none"}
    }
}



proc ::axis_register_slice::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::axis_register_slice::ip_core_generator $ip_name]
    setProperties $ip_name [array get ::axis_register_slice::properties] $ip_properties
    return $ref
}


