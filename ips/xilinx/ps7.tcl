package provide ps7 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::ps7 {
    variable ip_core_generator "xilinx.com:ip:processing_system7"

    array set properties {
	hp0 {CONFIG.PCW_USE_S_AXI_HP0 "none"}
	freq0 {CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ "none"}
	intren {CONFIG.PCW_USE_FABRIC_INTERRUPT "none" CONFIG.PCW_IRQ_F2P_INTR "none"}
    }
}



proc ::ps7::setPresets {ref} {
    apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 \
	-config {make_external "FIXED_IO, DDR" apply_board_preset "1" \
		     Master "Disable" Slave "Disable" }  $ref
}


proc ::ps7::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::ps7::ip_core_generator $ip_name]
    ps7::setPresets $ref
    setProperties $ip_name [array get ::ps7::properties] $ip_properties
    return $ref
}

