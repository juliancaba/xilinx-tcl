package provide decompress 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::decompress {
    variable ip_core_generator "arco_group:user:decompress:1.0"

    array set properties {
	in_endianess {CONFIG.C_IN_LITTLE_ENDIAN "none"}
    }
}



proc ::decompress::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::decompress::ip_core_generator $ip_name]    
    setProperties $ip_name [array get ::bram_ctrl::properties] $ip_properties
    return $ref
}

