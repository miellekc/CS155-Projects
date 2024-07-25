/* CS 155 MP2 TAC-Quad Representation   */
/* 2020-05499                           */
/* labex.flex as lexer                  */

%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

extern YYSTYPE yylval;
%}

%%

[a-z]+ {
    yylval.str = strdup(yytext);  // IMPORTANT!!! for VAR; so $1,$2,$3 can be used 
    return VAR; // treat lowercase letters or words as variables 
}

[0-9]+ {
    yylval.str = strdup(yytext);  // For NUM
    return NUM; 
}

"+"     { return ADD_OP;        }
"-"     { return SUB_OP;        }
"*"     { return MULT_OP;       }
"("     { return LEFT_PAREN;    }
")"     { return RIGHT_PAREN;   }

[ \t\r\f]+                      /* eat up whitespace */
\n           { return '\n'; }   // match newline character

. { fprintf(stderr, "Lexical error: Unexpected character '%c'\n", yytext[0]); return ERROR; } // Print out error and immediately stop if char not recognized

%%
