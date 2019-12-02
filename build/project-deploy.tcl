package provide deploy 1.0


proc ::deploy::upload_binaries {} {
    #global workspace
	
    connect
    fpga $::sdk::workspace/fpga.bit	
    targets -set -filter {name =~ "ARM*#0"}
    rst
	
    source $::sdk::workspace/hw_platform_0/ps7_init.tcl
    ps7_init
    ps7_post_config
    #	catch {stop}
    loadhw $::sdk::workspace/system_top.hdf
    dow $::sdk::workspace/app/Debug/app.elf
}


proc ::deploy::run {} {
    connect
    targets -set -filter {name =~ "ARM*#0"}
    con
    after 1000
    exit	
}
