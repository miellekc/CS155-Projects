/* CS 155 MP2 TAC-Quad Representation   */
/* 2020-05499                           */
/* parser.y as parser                   */

%define parse.error detailed

/* Need to explicitly declare tokens as strings */

%token <str> NUM
%token <str> VAR
%token <str> ADD_OP
%token <str> SUB_OP
%token <str> MULT_OP
%token <str> LEFT_PAREN
%token <str> RIGHT_PAREN
%token <str> ERROR

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern void yyerror(char const *s);
extern int temp_count;  

/* Function to print out equivalent TAC Quadruple Representation in number, op, arg1, arg2, res format */
/* Simply maps the tokens into op, arg1, arg2, and gets a temp variable for result */
/* Then prints using the format number, op, arg1, arg2, res OR res = arg1 op arg2 */  
void eval_expr(int count, char* op, char* arg1, char* arg2, char* res) {
    printf("%d, %s, %s, %s, %s\n", count, op, arg1, arg2, res);
    // printf("%s = %s %s %s\n", res, arg1, op, arg2); // Other format 
}

int temp_counter = 0;
int tac_counter = 0;

/* Help in keeping track of temp variables */
char* new_temp() {
    char* temp = (char*)malloc(10 * sizeof(char));
    sprintf(temp, "$t%d", temp_counter++);
    return temp;
}

%}

%union {
    char* str;
    int num;
}

%type <str> expression

%left ADD_OP SUB_OP
%left MULT_OP

%%

input: /* empty */
    | input line
    ;

/* Should print out last after printing TAC Rep. */
line: expression '\n' { printf("Parse successful\n"); tac_counter = 0; temp_counter = 0;}
    | '\n'          
    ;

expression: NUM { $$ = $1; }
    | VAR { $$ = $1; }
    | SUB_OP VAR { $$ = new_temp(); eval_expr(tac_counter++, "-", $2, "", $$); }  
    | SUB_OP NUM { $$ = new_temp(); eval_expr(tac_counter++, "-", $2, "", $$); }   
    | expression ADD_OP expression { $$ = new_temp(); eval_expr(tac_counter++, "+", $1, $3, $$); }  
    | expression SUB_OP expression { $$ = new_temp(); eval_expr(tac_counter++, "-", $1, $3, $$); }  
    | expression MULT_OP expression { $$ = new_temp(); eval_expr(tac_counter++, "*", $1, $3, $$); } 
    | LEFT_PAREN expression RIGHT_PAREN { $$ = $2; }
    ;

%%

/* Exit immediately if parse error */ 
void yyerror(char const *s) {
    fprintf(stderr, "Parser error: %s\n", s);
    exit(1);
}
