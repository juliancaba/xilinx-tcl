PRJ = test
BOARD = zcu104
SRC_FILES =

TCL_FILE = system.tcl

VIVADO = vivado -mode batch -source

TMP_FILES += *~ *.log *.jou
PRJ_FILES += *.cache *.hw *.ip_user_files *.srcs *.runs *.sdk *.sim *.xpr *.xsa    

all: $(PRJ).xpr $(PRJ).sdk/app/Debug/app.elf run


$(PRJ).xpr: $(SRC_FILES) clean-all
	$(VIVADO) $(TCL_FILE)

$(PRJ).sdk/app/Debug/app.elf:
	xsct sw.tcl $(BOARD) $(PRJ)

run:
	xsct run.tcl $(BOARD) $(PRJ)


clean-sw:
	$(RM) -rf $(PRJ).sdk/*_init* $(PRJ).sdk/app $(PRJ).sdk/standalone_bsp_0 $(PRJ).sdk/hw_platform_0

clean:clean-all

clean-all:
	$(RM) -rf $(TMP_FILES) $(PRJ_FILES)
