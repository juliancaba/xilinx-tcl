package provide axi_dma 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::axi_dma {
    variable ip_core_generator "xilinx.com:ip:axi_dma"

    array set properties {
	sg {CONFIG.c_include_sg "none" CONFIG.c_sg_include_stscntrl_strm "none"}
	data_width {CONFIG.c_m_axi_mm2s_data_width "none"}
	tdata_width {CONFIG.c_m_axis_mm2s_tdata_width "none"}
	burst_size {CONFIG.c_mm2s_burst_size "none"}
    }
}


proc ::axi_dma::read_only {ip_name} {
    set_property -dict [list CONFIG.c_include_s2mm {0}] [get_bd_cells $ip_name]
}


proc ::axi_dma::write_only {ip_name} {
    set_property -dict [list CONFIG.c_include_mm2s {0}] [get_bd_cells $ip_name]
}


proc ::axi_dma::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::axi_dma::ip_core_generator $ip_name]
    setProperties $ip_name [array get ::axi_dma::properties] $ip_properties
    return $ref
}

