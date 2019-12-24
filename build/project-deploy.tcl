package provide deploy 1.0


proc ::deploy::upload_binaries {} {
    #global workspace
	
    connect	
    targets -set -filter {name =~ "ARM*#0"}
    rst
    fpga $::sdk::workspace/fpga.bit
	
    source $::sdk::workspace/$::sdk::hw_project/ps7_init.tcl
    ps7_init
    ps7_post_config
    #	catch {stop}
    loadhw $::sdk::workspace/system_top.hdf
    dow $::sdk::workspace/app/Debug/app.elf
    #con -timeout 5
}


proc ::deploy::run {} {
    puts "Running ..."
    connect
    targets -set -filter {name =~ "ARM*#0"}
    con
    after 1000
    exit	
}
