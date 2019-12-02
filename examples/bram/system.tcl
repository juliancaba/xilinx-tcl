source /opt/xilinx-tcl/build/project.tcl

set prj_name test
set bd sch


#######
## Create Project
####################
project::setProperties $prj_name zed
project::create_hw_project
########



#######
## Create Block Design
####################
bd::create_bd $bd

set ps [bd::create_ip ps7 ps_0 []]
set bram_ctrl [bd::create_ip bram_ctrl bram_ctrl0  [list protocol {AXI4LITE} ports {1}]]

set axiconnect_ip [bd::automate_bus axi4 Auto $ps/M_AXI_GP0 $bram_ctrl/S_AXI]
set bram_ip [bd::build_bram $bram_ctrl/BRAM_PORTA]

bd::regenerate_bd
bd::wrap_bd
########



#######
## Synth Project and Export
####################
project::synth
project::export_hardware
########


