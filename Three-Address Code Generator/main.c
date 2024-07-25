/* CS 155 MP2 TAC-Quad Representation   */
/* 2020-05499                           */
/* main.c                               */

#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h" 

int temp_count = 0;     // Global variable to track temporary variables count
extern int yyparse();
extern FILE* yyin;      // Declare yyin to handle input file

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }

    // Open the input file
    FILE *input_file = fopen(argv[1], "r");
    if (input_file == NULL) {
        fprintf(stderr, "Error: Unable to open file\n");
        return 1;
    }

    // Set input file for lexer
    yyin = input_file;

    // Parse the input
    if (yyparse() == 0) {
        printf("Parse successful\n");
    } else {
        printf("Parse error\n");
    }

    // Close the input file
    fclose(input_file);

    return 0;
}
