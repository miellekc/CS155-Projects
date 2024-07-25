/* CS 155 LE1 Flex  */
/* 2020-05499       */

%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
int line_no = 1;
void ret_print(char *token_type);
void yyerror();
%}

/* DEFINITIONS */
LETTER  [a-zA-Z]
DIGIT   [0-9]
IDENT   {LETTER}({LETTER}|{DIGIT})*
NUMBER  (".")?{DIGIT}+("."{DIGIT}*)?
STRING  \"[^"]*\"


/* RULES */

%%
"PROCEDURE"|"VAR"|"INTEGER"|"REAL"|"BOOLEAN"|"STRING"|"WRITELN"|"NOT"|"OR"|"DIV"|"MOD"|"AND"|"IF"|"THEN"|"ELSE"|"WHILE"|"DO"|"FOR"|"TO"|"DOWNTO"|"BEGIN"|"END"                       {ret_print("RESERVED_WORD");}

                /*handle when there is a double quote inside the string (must be invalid)*/ 
{IDENT}	        {ret_print("IDENT");}
{NUMBER}        {ret_print("NUMBER");}
{STRING}        {ret_print("STRING");}


":="            {ret_print("ASSIGN");}
"+"             {ret_print("ADD_OP");}
"-"             {ret_print("SUB_OP");}      
"*"             {ret_print("MULT_OP");}
"/"             {ret_print("DIV_OP");}

"="             {ret_print("EQUAL");}            
"<>"            {ret_print("INEQUAL");}
"<"             {ret_print("LESSTHAN");}
"<="            {ret_print("LESSTHAN_EQ");}
">"             {ret_print("GREATERTHAN");}
">="            {ret_print("GREATERTHAN_EQ");}

","             {ret_print("COMMA");}
";"             {ret_print("SEMICOLON");}
":"             {ret_print("COLON");}
"("             {ret_print("LEFT_PAREN");}
")"             {ret_print("RIGHT_PAREN");}
"\""            {ret_print("QUOTE");}
	            

"\n"            {line_no++;}
[ \t\r\f]+	    /* eat up whitespace */
{DIGIT}+{LETTER}+{DIGIT}* {yyerror();}  /*handle when an IDENT starts with a number (must be invalid)*/
{DIGIT}*"_"*{LETTER}+*"_"*|{LETTER}*"_"*{DIGIT}+*"_"*|{LETTER}*"_"*{DIGIT}+*"_"*{LETTER}+* {yyerror();}    /*handle when there is a _ in any IDENT*/
{LETTER}*"."+{LETTER}+"."* {yyerror();} /*handle when there is a . anywhere in an IDENT*/
.	            {yyerror();}

%%

void ret_print(char *token_type){
   printf("L%d: <%s, %s>\n", line_no, token_type, yytext);
}

void yyerror(){
   printf("L%d: lexical error %s\n", line_no, yytext);
   exit(1);
}

int main(int argc, char *argv[]){
   yyin = fopen(argv[1], "r");
   yylex();
   fclose(yyin);
   return 0;
}
