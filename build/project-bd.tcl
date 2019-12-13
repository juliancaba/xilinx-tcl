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




# proc automate_clock {ip} {
#     apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/ps_0/FCLK_CLK0 (100 MHz)" }  [get_bd_pins fifo_0/s_axis_aclk]
# }


# proc connect_ports {port1 port2} {
#     connect_bd_intf_net [get_bd_intf_pins $port1] [get_bd_intf_pins $port2]
# }
