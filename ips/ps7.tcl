package provide ps7 1.0


source /opt/xilinx-tcl/ips/ip-utils.tcl


namespace eval ::ps7 {
    variable ip_core_generator "xilinx.com:ip:processing_system7"

    array set options {
	hp0 {CONFIG.PCW_USE_S_AXI_HP0 "none"}
    }
}



proc ::ps7::setPresets {ref} {
    apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 \
	-config {make_external "FIXED_IO, DDR" apply_board_preset "1" \
		     Master "Disable" Slave "Disable" }  $ref
}


proc ::ps7::create_ip {ip_name options} {
    set ref  [create_bd_cell -type ip -vlnv $::ps7::ip_core_generator $ip_name]
    ps7::setPresets $ref
    setProperties $ip_name [array get ::ps7::options] $options
    return $ref
}

