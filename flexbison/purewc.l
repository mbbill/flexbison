/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/purewc.l,v 2.2 2009/11/08 02:53:18 johnl Exp $
 */

/* word count, pure version */

%option noyywrap nodefault reentrant
%{
struct pwc {
    int chars;
    int words;
    int lines;
};
%}
%option extra-type="struct pwc *"

%%
%{
  struct pwc *pp = yyextra;
%}

[a-zA-Z]+	{ pp->words++; pp->chars += strlen(yytext); }
\n		{ pp->chars++; pp->lines++; }
.		{ pp->chars++; }

%%

main(argc, argv)
int argc;
char **argv;
{
  struct pwc mypwc = { 0, 0, 0 }; /* my instance data */
  yyscan_t lexer;		  /* flex instance data */

  if(yylex_init_extra(&mypwc, &lexer)) {
    perror("init alloc failed");
    return 1;
  }

  if(argc > 1) {
    FILE *f;

    if(!(f = fopen(argv[1], "r"))) {
      perror(argv[1]);
      return (1);
    }
    yyset_in(f, lexer);
  } else
    yyset_in(stdin, lexer);

  yylex(lexer);
  printf("%8d%8d%8d\n", mypwc.lines, mypwc.words, mypwc.chars);

  if(argc > 1)
    fclose(yyget_in(lexer));

  yylex_destroy( lexer );

}

