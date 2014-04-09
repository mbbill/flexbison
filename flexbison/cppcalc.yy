/* C++ version of calculator */
/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/cppcalc.yy,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

%language "C++"
%defines
%locations

%define parser_class_name "cppcalc"

%{
#include <iostream>
using namespace std;

#include "cppcalc-ctx.hh"
%}

%parse-param { cppcalc_ctx &ctx }
%lex-param   { cppcalc_ctx &ctx }

%union {
       int ival;
};

/* declare tokens */
%token <ival> NUMBER
%token ADD SUB MUL DIV ABS
%token OP CP
%token EOL

%type <ival> exp factor term

%{
  extern int yylex(yy::cppcalc::semantic_type *yylval,
       yy::cppcalc::location_type* yylloc,
       cppcalc_ctx &ctx);

void myout(int val, int radix);
%}

%initial-action {
 // Filename for locations here
 @$.begin.filename = @$.end.filename = new std::string("stdin");
}
%%

calclist: /* nothing */
| calclist exp EOL { cout << "= "; myout(ctx.getradix(), $2); cout << "\n> "; }
 | calclist EOL { cout <<  "> "; } /* blank line or a comment */
 ;

exp: factor
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 | exp ABS factor { $$ = $1 | $3; }
 ;

factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { if($3 == 0) {
                         error(@3, "zero divide");
			 YYABORT;
                     }
                     $$ = $1 / $3; }
 ;

term: NUMBER
 | ABS term { $$ = $2 >= 0? $2 : - $2; }
 | OP exp CP { $$ = $2; }
 ;
%%
main()
{
  cppcalc_ctx ctx(8);      // work in octal today

  cout << "> "; 

  yy::cppcalc parser(ctx); // make a cppcalc parser

  int v = parser.parse();  // and run it

  return v;
}

// print an integer in given radix
void
myout(int radix, int val)
{
  if(val < 0) {
    cout << "-";
    val = -val;
  }
  if(val > radix) {
    myout(radix, val/radix);
    val %= radix;
  }
  cout << val;
}

int
myatoi(int radix, char *s)
{
  int v = 0;

  while(*s) {
    v = v*radix + *s++ - '0';
  }
  return v;
}
namespace yy {
void
cppcalc::error(location const &loc, const std::string& s)
{
  std::cerr << "error at " << loc << ": " << s << std::endl;
}
}

