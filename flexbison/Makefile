# $Header: /home/johnl/flnb/code/RCS/Makefile,v 2.1 2009/11/08 02:53:18 johnl Exp $
# Companion source code for "flex & bison", published by O'Reilly
# Media, ISBN 978-0-596-15597-1
# Copyright (c) 2009, Taughannock Networks. All rights reserved.
# See the README file for license conditions and contact info.

# Make all the examples

SOURCES=README \
	fb1-1.l fb1-2.l fb1-3.l fb1-4.l fb1-5.l fb1-5.y \
	fb2-1.l fb2-2.l fb2-3.l fb2-4.l fb2-5.l \
	fb3-1.l fb3-1.y fb3-1.h fb3-1funcs.c \
	fb3-2.l fb3-2.y fb3-2.h fb3-2funcs.c \
	purewc.l purecalc.h purecalc.l purecalc.y purecalcfuncs.c \
	cppcalc.l cppcalc.yy cppcalc-ctx.hh \
	Makefile Makefile.ch1 Makefile.ch2 Makefile.ch3 Makefile.ch9 \
	${SQLFILES}

SQLFILES=sql/Makefile sql/glrmysql.y sql/lpmysql.y sql/pmysql.y \
	sql/glrmysql.l sql/lpmysql.l sql/pmysql.l

All:
	$(MAKE) -f Makefile.ch1
	$(MAKE) -f Makefile.ch2
	$(MAKE) -f Makefile.ch3
	$(MAKE) -f Makefile.ch9
	cd sql; $(MAKE)

clean:
	$(MAKE) -f Makefile.ch1 clean
	$(MAKE) -f Makefile.ch2 clean
	$(MAKE) -f Makefile.ch3 clean
	$(MAKE) -f Makefile.ch9 clean
	cd sql; $(MAKE) clean

zip::	flexbison.zip

flexbison.zip:	${SOURCES}
	rm -f $@
	zip -FS $@ ${SOURCES}
