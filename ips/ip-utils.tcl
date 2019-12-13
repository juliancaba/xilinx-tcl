package provide ip-utils 1.0


proc checkSizeOptions {ip_name options} {
    if {[expr {[llength $options] % 2}] == 1} {
	puts "ERROR: Bad options for IP $ip_name"
	exit 1
    }
}


proc replaceNoneValues {listA value} {
    set list_tmp {}
    for {set i 0} {$i < [llength $listA]} {incr i 1} {
	if {[regexp [expr $i] "none" ]} {
	    lappend list_tmp $value
	} else {
	    lappend list_tmp [expr {$i}]
	}
    }
    return $list_tmp
}


proc setProperties {ip_name ip_options cfg_options} {
    array set ip_options_cpy $ip_options
    checkSizeOptions $ip_name $cfg_options

    for {set i 0} {$i < [llength $cfg_options]} {incr i 2} {
	set option $ip_options_cpy([lindex $cfg_options $i])
	set value [lindex $cfg_options [expr {$i+1}]]
	set config_option [replaceNoneValues $option  $value]
	puts $config_option
	set_property -dict $config_option [get_bd_cell $ip_name]
    }
}
