package provide compress 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::compress {
    variable ip_core_generator "arco_group:user:compress"

    array set properties {
	out_endianess {CONFIG.C_OUT_LITTLE_ENDIAN "none"}
    }
}



proc ::compress::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::compress::ip_core_generator $ip_name]    
    setProperties $ip_name [array get ::bram_ctrl::properties] $ip_properties
    return $ref
}

