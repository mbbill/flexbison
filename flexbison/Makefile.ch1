# $Header: /home/johnl/flnb/code/RCS/Makefile.ch1,v 2.2 2009/11/08 02:52:21 johnl Exp $
# Companion source code for "flex & bison", published by O'Reilly
# Media, ISBN 978-0-596-15597-1
# Copyright (c) 2009, Taughannock Networks. All rights reserved.
# See the README file for license conditions and contact info.

# programs in chapter 1

all:	  fb1-1 fb1-2 fb1-3 fb1-4 fb1-5


fb1-1:	fb1-1.l
	flex $<
	cc -o $@ lex.yy.c -lfl

fb1-2:	fb1-2.l
	flex $<
	cc -o $@ lex.yy.c -lfl

fb1-3:	fb1-3.l
	flex $<
	cc -o $@ lex.yy.c -lfl

fb1-4:	fb1-4.l
	flex $<
	cc -o $@ lex.yy.c -lfl

fb1-5:	fb1-5.l fb1-5.y
	bison -d fb1-5.y
	flex fb1-5.l
	cc -o $@ fb1-5.tab.c lex.yy.c -lfl

clean:
	rm -f fb1-1 fb1-2 fb1-3 fb1-4 fb1-5 \
	lex.yy.c fb1-5.tab.c fb1-5.tab.h

