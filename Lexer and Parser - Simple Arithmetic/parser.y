/* CS 155 PARSING LAB EX.                   */
/* 2020-05499                               */
/* parser.y as parser                       */
/* some parts derived from rpcalc.y/calc.y  */

%define parse.error detailed 

%token NUM VAR ADD_OP SUB_OP MULT_OP LEFT_PAREN RIGHT_PAREN ERROR

%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern void yyerror(char const *s);
%}

%left ADD_OP SUB_OP
%left MULT_OP

/* Grammar follows */
%%

input:    /* empty string */
    | input line
    ;

line: 	expression '\n' { printf("Parse successful\n"); }
	| '\n'          
    ;

expression: NUM
    | VAR
    | expression ADD_OP expression
    | expression SUB_OP expression
    | expression MULT_OP expression
    | LEFT_PAREN expression RIGHT_PAREN
    ;

%%

void yyerror(char const *s) {                       /* Called by yyparse on error */
    fprintf(stderr, "Parser error: %s\n", s);
    exit(1);
}