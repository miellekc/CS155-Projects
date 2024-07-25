/* CS 155 PARSING LAB EX.           */
/* 2020-05499                       */
/* main.c to run flex and bison     */

#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h" // IMPORTANT!!! always add bison-generated header: parser.y filename, so parser.tab.h header name

extern int yyparse();
extern FILE* yyin; 

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }

    // Open file
    FILE *input_file = fopen(argv[1], "r");
    if (input_file == NULL) {
        fprintf(stderr, "Error: Unable to open file\n");
        return 1;
    }

    // File will be the input of the lexer
    yyin = input_file;

    // Parse
    if (yyparse() == 0) {
        // Parsing successful when no error (yyparse() should return 0)
        // printf("Parse successful\n"); // One extra parse successful at the very end 
    } else {
        // Parsing error if yyparse returned 1
        printf("Parse error\n");
    }

    // Close file
    fclose(input_file);

    return 0;
}