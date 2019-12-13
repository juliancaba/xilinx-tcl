package provide axi_dma 1.0


source /opt/xilinx-tcl/ips/ip-utils.tcl


namespace eval ::axi_dma {
    variable ip_core_generator "xilinx.com:ip:axi_dma"

    array set options {
	sg {CONFIG.c_include_sg "none" CONFIG.c_sg_include_stscntrl_strm "none"}
    }
}



proc ::axi_dma::create_ip {ip_name options} {
    set ref  [create_bd_cell -type ip -vlnv $::axi_dma::ip_core_generator $ip_name]
    setProperties $ip_name [arrray get ::axi_dma::options] $options
    return $ref
}

