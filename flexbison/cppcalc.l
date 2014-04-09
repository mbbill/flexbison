/* recognize tokens for the C++ calculator and print them out */
/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/cppcalc.l,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

%option noyywrap
%{
# include <cstdlib>

# include "cppcalc-ctx.hh"
# include "cppcalc.tab.hh"

#define YY_DECL int yylex(yy::cppcalc::semantic_type *yylval, \
    yy::cppcalc::location_type *yylloc, cppcalc_ctx &ctx)

// make location include the current token
# define YY_USER_ACTION  yylloc->columns (yyleng);

typedef yy::cppcalc::token token;
extern int myatoi(int radix, char *s);

%}

%%

%{
     // start where previous token ended
     yylloc->step ();
%}

"+"	{ return token::ADD; }
"-"	{ return token::SUB; }
"*"	{ return token::MUL; }
"/"	{ return token::DIV; }
"|"     { return token::ABS; }
"("     { return token::OP; }
")"     { return token::CP; }
[0-9]+	{ yylval->ival = myatoi(ctx.getradix(), yytext); return token::NUMBER; }

\n      { yylloc->lines(1); return token::EOL; }

  /* skip over comments and white space */
"//".*  |
[ \t]   {  yylloc->step (); }

.	{ printf("Mystery character %c\n", *yytext); }
%%
