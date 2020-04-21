package provide axis_fifo 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::axis_fifo {
    variable ip_core_generator "xilinx.com:ip:axi_fifo_mm_s"

    array set properties {
	rx_depth {CONFIG.C_RX_FIFO_DEPTH "none"}
	tx_depth {CONFIG.C_TX_FIFO_DEPTH "none"}
    }
}




proc ::axis_fifo::RX {ip_name} {
    set_property -dict [list CONFIG.C_USE_TX_DATA {0} CONFIG.C_USE_TX_CTRL {0}]  [get_bd_cells $ip_name]
}

proc ::axis_fifo::TX {ip_name} {
    set_property -dict [list CONFIG.C_USE_RX_DATA {0}]  [get_bd_cells $ip_name]
}

proc ::axis_fifo::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::axis_fifo::ip_core_generator $ip_name]
    setProperties $ip_name [array get ::axis_fifo::properties] $ip_properties
    return $ref
}


