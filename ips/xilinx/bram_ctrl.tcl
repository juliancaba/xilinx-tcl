package provide bram_ctrl 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::bram_ctrl {
    variable ip_core_generator "xilinx.com:ip:axi_bram_ctrl"

    array set properties {
	protocol {CONFIG.PROTOCOL "none"}
	ports {CONFIG.SINGLE_PORT_BRAM "none"}
    }
}



proc ::bram_ctrl::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::bram_ctrl::ip_core_generator $ip_name]    
    setProperties $ip_name [array get ::bram_ctrl::properties] $ip_properties
    return $ref
}


proc ::bram_ctrl::build_bram {port} {
    apply_bd_automation -rule xilinx.com:bd_rule:bram_cntlr -config {BRAM "Auto" } [get_bd_intf_pins $port]	
}
