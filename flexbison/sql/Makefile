# $Header: /home/johnl/flnb/code/sql/RCS/Makefile,v 2.1 2009/11/08 02:53:39 johnl Exp $
# Companion source code for "flex & bison", published by O'Reilly
# Media, ISBN 978-0-596-15597-1
# Copyright (c) 2009, Taughannock Networks. All rights reserved.
# See the README file for license conditions and contact info.

CC = cc -g
LEX = flex
YACC = bison
CFLAGS = -DYYDEBUG=1

PROGRAMS4 = pmysql
PROGRAMS8 = lpmysql
PROGRAMS9 = glrmysql

all:	${PROGRAMS4} ${PROGRAMS8} ${PROGRAMS9}

# chapter 4

pmysql:	pmysql.tab.o pmysql.o
	${CC} -o $@ pmysql.tab.o pmysql.o

pmysql.tab.c pmysql.tab.h:	pmysql.y
	${YACC} -vd pmysql.y

pmysql.c:	pmysql.l
	${LEX} -o $@ $<

pmysql.o:	pmysql.c pmysql.tab.h

# chapter 8

lpmysql:	lpmysql.tab.o lpmysql.o
	${CC} -o $@ lpmysql.tab.o lpmysql.o

lpmysql.tab.c lpmysql.tab.h:	lpmysql.y
	${YACC} -vd lpmysql.y

lpmysql.c:	lpmysql.l
	${LEX} -o $@ $<

lpmysql.o:	lpmysql.c lpmysql.tab.h

# chapter 9

glrmysql:	glrmysql.tab.o glrmysql.o
	${CC} -o $@ glrmysql.tab.o glrmysql.o

glrmysql.tab.c glrmysql.tab.h:	glrmysql.y
	${YACC} -v glrmysql.y

glrmysql.c:	glrmysql.l
	${LEX} -o $@ $<

glrmysql.o:	glrmysql.c glrmysql.tab.h

clean:
	rm -f pmysql pmysql.tab.c pmysql.tab.h pmysql.c pmysql.tab.o pmysql.o \
	lpmysql	lpmysql.tab.o lpmysql.o lpmysql.tab.c lpmysql.tab.h lpmysql.c \
	glrmysql glrmysql.tab.o glrmysql.o glrmysql.tab.c glrmysql.tab.h \
	glrmysql.c glrmysql.output lpmysql.output pmysql.output

.SUFFIXES:	.l .y .c

