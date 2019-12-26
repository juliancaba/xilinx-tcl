package provide psu_e 1.0


source INSTALL_PATH/ips/ip-utils.tcl


namespace eval ::psu_e {
    variable ip_core_generator "xilinx.com:ip:zynq_ultra_ps_e"

    array set properties {
	irq0 {CONFIG.PSU__USE__IRQ0 "none"}
	irq1 {CONFIG.PSU__USE__IRQ1 "none"}
    }
}



# proc ::psu_e::setPresets {ref} {
#     apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 \
# 	-config {make_external "FIXED_IO, DDR" apply_board_preset "1" \
# 		     Master "Disable" Slave "Disable" }  $ref
# }


proc ::psu_e::create_ip {ip_name ip_properties} {
    set ref  [create_bd_cell -type ip -vlnv $::psu_e::ip_core_generator $ip_name]
    #psu_e::setPresets $ref
    setProperties $ip_name [array get ::psu_e::properties] $ip_properties
    return $ref
}

