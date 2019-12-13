package provide project-utils 1.0


proc getToolchainVersion {} {
    if {[catch {set vtmp [version -short]}]} {
	set vtmp [version]
	set vtoolchain [string range $vtmp 5 10]
    } else {    
	set vtoolchain [string range $vtmp 0 5]
    } 
    return $vtoolchain
}

proc loadTCL {filename} {
    if ![file exist $filename] {
	puts "ERROR: Board specification could not be found in $filename"
	exit 1
    }
    source $filename
}
