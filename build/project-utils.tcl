package provide utils 1.0

proc getToolchainVersion {} {
    set vtmp [version -short]
    set vtoolchain [string range $vtmp 0 5]
    return $vtoolchain
}

