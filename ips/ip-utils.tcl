package provide ip-utils 1.0


proc checkSizeOptions {ip_name options} {
    if {[expr {[llength $options] % 2}] == 1} {
	puts "ERROR: Bad options for IP $ip_name"
	exit 1
    }
}


proc checkSizeValues {ip_name option values} {
    if {[llength $values] != [llength [lsearch -all $option "none"]]} {
	puts "ERROR: Option's size wrong for $ip_name"
	exit 1
    }
}


proc replaceNoneValues {option values} {
    set option_tmp {}
    set j 0
    
    for {set i 0} {$i < [llength $option]} {incr i 1} {
	if {[regexp [lindex $option  $i] "none" ]} {
	    lappend option_tmp [lindex $values $j]
	    incr j 1
	} else {
	    lappend option_tmp [lindex $option $i]
	}
    }
    return $option_tmp
}


proc setProperties {ip_name ip_options cfg_options} {
    array set ip_options_cpy $ip_options
    checkSizeOptions $ip_name $cfg_options

    for {set i 0} {$i < [llength $cfg_options]} {incr i 2} {
	set option $ip_options_cpy([lindex $cfg_options $i])
	set values [lindex $cfg_options [expr {$i+1}]]
	checkSizeValues $ip_name $option $values
	set config_option [replaceNoneValues $option  $values]
	puts $config_option
	set_property -dict $config_option [get_bd_cell $ip_name]
    }
}
