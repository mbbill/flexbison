/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb2-1.l,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* fb2-1 even more like unix wc with explicit input */

%{
int chars = 0;
int words = 0;
int lines = 0;
%}

%%

[a-zA-Z]+	{ words++; chars += strlen(yytext); }
\n		{ chars++; lines++; }
.		{ chars++; }

%%

main(argc, argv)
int argc;
char **argv;
{
  // 这个地方的逻辑是: yyin 是定义的输入流
  // 这里定义了 yyin
  if(argc > 1) {
    if(!(yyin = fopen(argv[1], "r"))) {
      perror(argv[1]);
      return (1);
    }
  }

  yylex();
  printf("lines: %8d; words: %8d; chars: %8d\n", lines, words, chars);
}

yywrap() { return 1; }
