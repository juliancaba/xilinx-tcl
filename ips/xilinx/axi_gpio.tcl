package provide axi_gpio 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::axi_gpio {
    variable ip_core_generator "xilinx.com:ip:axi_gpio"

    array set properties {
	width {CONFIG.C_GPIO_WIDTH "none"}
	iface {CONFIG.GPIO_BOARD_INTERFACE "none"}
	outputs {CONFIG.C_ALL_OUTPUTS "none"}
    }
}



proc ::axi_gpio::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::axi_gpio::ip_core_generator $ip_name]
    setProperties $ip_name [array get ::axi_gpio::properties] $ip_properties
    return $ref
}


