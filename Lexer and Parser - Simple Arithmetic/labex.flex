/* CS 155 PARSING LAB EX.   */
/* 2020-05499               */
/* labex.flex as lexer      */

%option noyywrap

%{
#include <stdio.h>
#include "parser.tab.h"
%}

%%

[a-z]   { return VAR;           }
[0-9]+  { return NUM;           }

"+"     { return ADD_OP;        }
"-"     { return SUB_OP;        }
"*"     { return MULT_OP;       }
"("     { return LEFT_PAREN;    }
")"     { return RIGHT_PAREN;   }

[ \t\r\f]+                              /* eat up whitespace */
\n      { return '\n';          }       // important! match newline character and return it as a token
.       { fprintf(stderr, "Lexical error: Unexpected character '%c'\n", yytext[0]); return ERROR; }

%%

