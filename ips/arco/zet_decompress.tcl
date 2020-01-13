package provide zet_decompress 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::zet_decompress {
    variable ip_core_generator "arco_group:user:zet_decompress"

    array set properties {
	in_endianess {CONFIG.C_IN_LITTLE_ENDIAN "none"}
    }
}



proc ::zet_decompress::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::zet_decompress::ip_core_generator $ip_name]    
    setProperties $ip_name [array get ::zet_decompress::properties] $ip_properties
    return $ref
}

