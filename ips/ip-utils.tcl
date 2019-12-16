package provide ip-utils 1.0


proc checkSizeProperties {ip_name properties} {
    if {[expr {[llength $properties] % 2}] == 1} {
	puts "ERROR: Bad properties for IP $ip_name"
	exit 1
    }
}


proc checkSizeValues {ip_name property values} {
    if {[llength $values] != [llength [lsearch -all $property "none"]]} {
	puts "ERROR: Property's size wrong for $ip_name"
	exit 1
    }
}


proc replaceNoneValues {property values} {
    set property_tmp {}
    set j 0
    
    for {set i 0} {$i < [llength $property]} {incr i 1} {
	if {[regexp [lindex $property  $i] "none" ]} {
	    lappend property_tmp [lindex $values $j]
	    incr j 1
	} else {
	    lappend property_tmp [lindex $property $i]
	}
    }
    return $property_tmp
}


proc setProperties {ip_name ip_properties ip_values} {
    array set ip_properties_cpy $ip_properties
    checkSizeProperties $ip_name $ip_values

    for {set i 0} {$i < [llength $ip_values]} {incr i 2} {
	set property $ip_properties_cpy([lindex $ip_values $i])
	set values [lindex $ip_values [expr {$i+1}]]
	checkSizeValues $ip_name $property $values
	set config_property [replaceNoneValues $property $values]
	puts $config_property
	set_property -dict $config_property [get_bd_cell $ip_name]
    }
}
