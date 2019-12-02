# -*- mode: makefile-gmake; coding: utf-8 -*-
DESTDIR ?= /opt

TCL_ROOT  = /xilinx-tcl


install:
	install -vd $(DESTDIR)$(TCL_ROOT)/boards
	install -v -m 444 boards/* $(DESTDIR)$(TCL_ROOT)/boards
	install -vd $(DESTDIR)$(TCL_ROOT)/build
	install -v -m 444 build/* $(DESTDIR)$(TCL_ROOT)/build



