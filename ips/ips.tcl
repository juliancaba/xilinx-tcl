package provide ips 1.0

########
# Xilinx
############
source INSTALL_PATH/ips/xilinx/axis_data_fifo.tcl
source INSTALL_PATH/ips/xilinx/axis_fifo.tcl
source INSTALL_PATH/ips/xilinx/axis_dwidth_converter.tcl
source INSTALL_PATH/ips/xilinx/axis_register_slice.tcl
source INSTALL_PATH/ips/xilinx/axis_broadcaster.tcl
source INSTALL_PATH/ips/xilinx/axi_dma.tcl
source INSTALL_PATH/ips/xilinx/bram_ctrl.tcl
source INSTALL_PATH/ips/xilinx/ps7.tcl
source INSTALL_PATH/ips/xilinx/psu_e.tcl
source INSTALL_PATH/ips/xilinx/axi_gpio.tcl
############



######
# ARCO
############

#Zets prj
source INSTALL_PATH/ips/arco/zets/axis_zet_intersection.tcl
source INSTALL_PATH/ips/arco/zets/axis_zet_merge.tcl
source INSTALL_PATH/ips/arco/zets/axis_zet_union.tcl
source INSTALL_PATH/ips/arco/zets/zet_compress.tcl
source INSTALL_PATH/ips/arco/zets/zet_decompress.tcl
############
