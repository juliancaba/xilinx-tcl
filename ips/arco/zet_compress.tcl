package provide zet_compress 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::zet_compress {
    variable ip_core_generator "arco_group:user:zet_compress"

    array set properties {
	out_endianess {CONFIG.C_OUT_LITTLE_ENDIAN "none"}
    }
}



proc ::zet_compress::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::zet_compress::ip_core_generator $ip_name]    
    setProperties $ip_name [array get ::zet_compress::properties] $ip_properties
    return $ref
}

