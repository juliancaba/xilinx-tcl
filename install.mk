# -*- mode: makefile-gmake; coding: utf-8 -*-
DESTDIR ?= /opt

TCL_ROOT  = /xilinx-tcl


install:
	install -vd $(DESTDIR)$(TCL_ROOT)/boards
	install -v -m 444 boards/* $(DESTDIR)$(TCL_ROOT)/boards
	install -vd $(DESTDIR)$(TCL_ROOT)/os
	install -v -m 444 os/* $(DESTDIR)$(TCL_ROOT)/os
	install -vd $(DESTDIR)$(TCL_ROOT)/ips
	install -v -m 444 ips/* $(DESTDIR)$(TCL_ROOT)/ips
	install -vd $(DESTDIR)$(TCL_ROOT)/build
	install -v -m 444 build/* $(DESTDIR)$(TCL_ROOT)/build



