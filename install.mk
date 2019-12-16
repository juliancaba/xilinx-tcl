# -*- mode: makefile-gmake; coding: utf-8 -*-
DESTDIR ?= /opt

TCL_ROOT  = /xilinx-tcl

DESTDIR_SED=$(subst /,\/,$(DESTDIR)$(TCL_ROOT))
REPLACE_SED = "s/INSTALL_PATH/${DESTDIR_SED}/g"


all: install patch

install:
	install -vd $(DESTDIR)$(TCL_ROOT)/boards
	install -v -m 444 boards/* $(DESTDIR)$(TCL_ROOT)/boards
	install -vd $(DESTDIR)$(TCL_ROOT)/os
	install -v -m 444 os/* $(DESTDIR)$(TCL_ROOT)/os
	install -vd $(DESTDIR)$(TCL_ROOT)/ips
	install -v -m 444 ips/*.tcl $(DESTDIR)$(TCL_ROOT)/ips
	install -vd $(DESTDIR)$(TCL_ROOT)/ips/xilinx
	install -v -m 444 ips/xilinx/* $(DESTDIR)$(TCL_ROOT)/ips/xilinx
	install -vd $(DESTDIR)$(TCL_ROOT)/build
	install -v -m 444 build/* $(DESTDIR)$(TCL_ROOT)/build


patch:
	@for i in $(shell find  $(DESTDIR)$(TCL_ROOT) -type f -iname "*.tcl"); do \
	  sed -i -e $(REPLACE_SED) $$i; \
	done

