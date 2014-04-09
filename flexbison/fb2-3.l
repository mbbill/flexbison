/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb2-3.l,v 2.3 2010/01/04 02:43:58 johnl Exp $
 */

/* fb2-3 skeleton for include files */

%option noyywrap warn nodefault
%x IFILE
  struct bufstack {
    struct bufstack *prev;	/* previous entry */
    YY_BUFFER_STATE bs;		/* saved buffer */
    int lineno;			/* saved line number */
    char *filename;		/* name of this file */
    FILE *f;			/* current file */
  } *curbs = 0;

  char *curfilename;		/* name of current input file */

  int newfile(char *fn);
  int popfile(void);

%%
^"#"[ \t]*include[ \t]*[\"<] { BEGIN IFILE; }

<IFILE>[^ \t\n\">]+          { 
                             { int c;
			       while((c = input()) && c != '\n') ;
			     }
			     yylineno++;
			     if(!newfile(yytext))
                                yyterminate(); /* no such file */
			     BEGIN INITIAL;
                           }

<IFILE>.|\n                { fprintf(stderr, "%4d bad include line\n", yylineno);
				     yyterminate();
			   }
^.                         { fprintf(yyout, "%4d %s", yylineno, yytext); }
^\n                        { fprintf(yyout, "%4d %s", yylineno++, yytext); }
\n                         { ECHO; yylineno++; }
.                          { ECHO; }
<<EOF>>                    { if(!popfile()) yyterminate(); }
%%

main(int argc, char **argv)
{
  if(argc < 2) {
    fprintf(stderr, "need filename\n");
    return 1;
  }
  if(newfile(argv[1]))
    yylex();
}

int
  newfile(char *fn)
{
  FILE *f = fopen(fn, "r");
  struct bufstack *bs = malloc(sizeof(struct bufstack));

  /* die if no file or no room */
  if(!f) { perror(fn); return 0; }
  if(!bs) { perror("malloc"); exit(1); }

  /* remember state */
  if(curbs)curbs->lineno = yylineno;
  bs->prev = curbs;

  /* set up current entry */
  bs->bs = yy_create_buffer(f, YY_BUF_SIZE);
  bs->f = f;
  bs->filename = fn;
  yy_switch_to_buffer(bs->bs);
  curbs = bs;
  yylineno = 1;
  curfilename = fn;
  return 1;
}

int
  popfile(void)
{
  struct bufstack *bs = curbs;
  struct bufstack *prevbs;

  if(!bs) return 0;

  /* get rid of current entry */
  fclose(bs->f);
  yy_delete_buffer(bs->bs);

  /* switch back to previous */
  prevbs = bs->prev;
  free(bs);

  if(!prevbs) return 0;

  yy_switch_to_buffer(prevbs->bs);
  curbs = prevbs;
  yylineno = curbs->lineno;
  curfilename = curbs->filename;
  return 1; 
}

