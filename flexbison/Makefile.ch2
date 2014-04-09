# $Header: /home/johnl/flnb/code/RCS/Makefile.ch2,v 2.1 2009/11/08 02:53:18 johnl Exp $
# Companion source code for "flex & bison", published by O'Reilly
# Media, ISBN 978-0-596-15597-1
# Copyright (c) 2009, Taughannock Networks. All rights reserved.
# See the README file for license conditions and contact info.

# programs in chapter 2

CFLAGS=-g

all:	  fb2-1 fb2-2 fb2-3 fb2-4 fb2-5

fb2-1:	fb2-1.l
	flex -o $@.c $<
	${CC} ${CFLAGS} -o $@ $@.c

fb2-2:	fb2-2.l
	flex -o $@.c $<
	${CC} ${CFLAGS}  -o $@ $@.c

fb2-3:	fb2-3.l
	flex -o $@.c $<
	${CC} ${CFLAGS}  -o $@ $@.c

fb2-4:	fb2-4.l
	flex -o $@.c $<
	${CC} ${CFLAGS}  -o $@ $@.c

fb2-5:	fb2-5.l
	flex -o $@.c $<
	${CC} ${CFLAGS}  -o $@ $@.c

clean:
	rm -f fb2-1 fb2-2 fb2-3 fb2-4 fb2-5 \
	fb2-1.c fb2-2.c fb2-3.c fb2-4.c fb2-5.c

