package provide bd 1.0

proc ::bd::create_bd {bd_name} {
    set ::bd::bd_name $bd_name
    create_bd_design $::bd::bd_name
}
	

proc ::bd::regenerate_bd {} {
    regenerate_bd_layout
}


proc ::bd::wrap_bd {} {
    set bd_design_dir [file join [pwd]/$::project::project_name.srcs/sources_1/bd/$::bd::bd_name]
    puts $bd_design_dir
    make_wrapper -files [get_files [file join $bd_design_dir/$::bd::bd_name.bd]] -top
    add_files -norecurse [file join $bd_design_dir/hdl/$::bd::bd_name\_wrapper.vhd]
}


proc ::bd::create_ip {ip_type ip_name options} {

    set ip "none"
	
    # create IP
    switch $ip_type {		
	axi_dma { set ip "xilinx.com:ip:axi_dma" }
	ps7 {set ip "xilinx.com:ip:processing_system7"}
	axis_data_fifo {set ip "xilinx.com:ip:axis_data_fifo"}
	bram_ctrl {set ip "xilinx.com:ip:axi_bram_ctrl"}
    }

    set ref [create_bd_cell -type ip -vlnv $ip $ip_name]

    # apply presets for PS7
    if [regexp "ps7" $ip_type] {
	apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 \
	    -config {make_external "FIXED_IO, DDR" apply_board_preset "1" \
			 Master "Disable" Slave "Disable" }  $ref
    }
	
    # apply options for core
    if {[llength $options] != 0}  {
	for {set i 0} {$i < [llength $options]} {incr i 2} {
	    set config_option [get_config_options $ip_type [lindex $options $i] [lindex $options  [expr {$i+1}]]]
	    puts $config_option
	    set_property -dict $config_option [get_bd_cell $ip_name]
	}
		
	#foreach option $options {
	#	set config_option [get_config_option $ip_type $option]
	#	puts $config_option
	#	set_property -dict $config_option $ref
	#}
    }
    
    return $ref
}


proc ::bd::get_config_options {ip_type option value} {
    switch $ip_type {
	ps7 {
	    switch $option {
		hp0 { return [list CONFIG.PCW_USE_S_AXI_HP0 [expr {$value}]]  }
	    }
	}

	axi_dma {
	    switch $option {
		sg { return [list CONFIG.c_include_sg [expr {$value}] \
				 CONFIG.c_sg_include_stscntrl_strm [expr {$value}]]}				
	    }
	}

	axis_data_fifo {
	    switch $option {
		depth { return [list CONFIG.FIFO_DEPTH [expr {$value}]] }
	    }
	}

	bram_ctrl {
	    switch $option {
		protocol { return [list CONFIG.PROTOCOL [expr {$value}]] }
		ports {return [list CONFIG.SINGLE_PORT_BRAM [expr {$value}]] }
	    }
	}
    }
}


# bus_type:
#   - axi4
# connect_ip: ip to be used for the bus interconnection
#   - Auto (leave the wizard)
#   - path to ip (to reuse an existing one)
# returns: reference to the interconnect bus in case one is detected
proc ::bd::automate_bus {bus_type connect_ip master slave} {
    set previous_cells [get_bd_cells]
    apply_bd_automation -rule xilinx.com:bd_rule:$bus_type \
	-config " Clk_master {Auto} \
		  Clk_slave {Auto} \
	    	  Clk_xbar {Auto} \
      	  	  Master $master Slave $slave \
		  intc_ip $connect_ip master_apm {0}" \
	[get_bd_intf_pins $slave]
    set current_cells [get_bd_cells]

    foreach elem $current_cells {
	if {$elem ni $previous_cells} {
	    return $elem
	}
    }	
}


proc ::bd::build_bram {port} {
    apply_bd_automation -rule xilinx.com:bd_rule:bram_cntlr -config {BRAM "Auto" } [get_bd_intf_pins $port]	
}





# proc automate_clock {ip} {
#     apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/ps_0/FCLK_CLK0 (100 MHz)" }  [get_bd_pins fifo_0/s_axis_aclk]
# }


# proc connect_ports {port1 port2} {
#     connect_bd_intf_net [get_bd_intf_pins $port1] [get_bd_intf_pins $port2]
# }
