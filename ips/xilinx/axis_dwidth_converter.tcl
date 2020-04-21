package provide axis_dwidth_converter 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::axis_dwidth_converter {
    variable ip_core_generator "xilinx.com:ip:axis_dwidth_converter"

    array set properties {
	NtoM {CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER CONFIG.S_TDATA_NUM_BYTES "none" CONFIG.M_TDATA_NUM_BYTES "none"}
    }
}



proc ::axis_dwidth_converter::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::axis_dwidth_converter::ip_core_generator $ip_name]
    setProperties $ip_name [array get ::axis_dwidth_converter::properties] $ip_properties
    return $ref
}
