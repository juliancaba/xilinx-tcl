package provide axis_data_fifo 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::axis_data_fifo {
    variable ip_core_generator "xilinx.com:ip:axis_data_fifo"

    array set properties {
	depth {CONFIG.FIFO_DEPTH "none"}
	tdata_bytes {CONFIG.TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.TDATA_NUM_BYTES "none"}
    }
}



proc ::axis_data_fifo::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::axis_data_fifo::ip_core_generator $ip_name]
    setProperties $ip_name [array get ::axis_data_fifo::properties] $ip_properties
    return $ref
}


