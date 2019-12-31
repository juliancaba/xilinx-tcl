package provide deploy 1.0


proc ::deploy::upload_binaries {board} {
    loadTCL INSTALL_PATH/boards/$board.tcl
    board::upload_binaries
}


proc ::deploy::run {board} {
    puts "Running ..."
    loadTCL INSTALL_PATH/boards/$board.tcl
    board::run
}


proc ::deploy::upload_bitstream {board} {
    loadTCL INSTALL_PATH/boards/$board.tcl
    board::upload_bitstream
}
