package provide axi_data_fifo 1.0


source /opt/xilinx-tcl/ips/ip-utils.tcl


namespace eval ::axi_data_fifo {
    variable ip_core_generator "xilinx.com:ip:axi_data_fifo"

    array set options {
	depth {CONFIG.FIFO_DEPTH "none"}
    }
}



proc ::axi_data_fifo::create_ip {ip_name options} {
    set ref  [create_bd_cell -type ip -vlnv $::axi_data_fifo::ip_core_generator $ip_name]
    setProperties $ip_name [array get ::axi_data_fifo::options] $options
    return $ref
}


