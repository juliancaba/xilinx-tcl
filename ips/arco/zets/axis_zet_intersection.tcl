package provide axis_zet_intersection 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::axis_zet_intersection {
    variable ip_core_generator "arco_group:user:axis_zet_intersection"

    array set properties {
	tdata_width {CONFIG.C_S_AXIS_DWIDTH "none" CONFIG.C_M_AXIS_DWIDTH "none"}
    }
}



proc ::axis_zet_intersection::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::axis_zet_intersection::ip_core_generator $ip_name]    
    setProperties $ip_name [array get ::axis_zet_intersection::properties] $ip_properties
    return $ref
}

