package provide axis_broadcaster 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::axis_broadcaster {
    variable ip_core_generator "xilinx.com:ip:axis_broadcaster"

    array set properties {
	nmasters {CONFIG.NUM_MI "none"}
    }
}



proc ::axis_broadcaster::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::axis_broadcaster::ip_core_generator $ip_name]
    setProperties $ip_name [array get ::axis_broadcaster::properties] $ip_properties
    return $ref
}


