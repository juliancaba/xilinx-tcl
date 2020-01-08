package provide axis_union 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::axis_union {
    variable ip_core_generator "arco_group:user:axis_union"

    array set properties {
	tdata_width {CONFIG.C_S_AXIS_DWIDTH "none" CONFIG.C_M_AXIS_DWIDTH "none"}
    }
}



proc ::axis_union::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::axis_union::ip_core_generator $ip_name]    
    setProperties $ip_name [array get ::axis_union::properties] $ip_properties
    return $ref
}

