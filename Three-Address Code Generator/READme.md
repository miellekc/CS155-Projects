## Student Info
- **Name:** Jaimielle Kyle C. Calderon
- **Student Number:** 202005499
- **Lab Section:** LAB 1 (WED)

## Notes:
- For MP 2 
- This project converts an expression into its corresponding Three Address Code (Quadruple) Representation 
    - The TAC printed is in this format: num, op, arg1, arg2, result (following the table from the slides)
    - The other format can also be done using the code: result = arg1 op arg2 (I commented this out; I chose the one above) 
- I reused most of the codes from the parsing exercise, I just added the eval_expr() function that prints out the conversion.
- I also modified the lexer so that parser.y can still access the actual values from the input. These are the values that are printed out in the converter function. 
- I also added some test cases to check the output.  

- Assumed from specs document: 
    - Only lower case letters are accepted as VAR (variable)
    - Only whole numbers/integers are recognized by NUM (number)
    - Other characters not a lower case letter, an integer, a "+", a "-", or a "*" will be considered as an **unrecognized** character and will raise an error. 
    - Negative of a NUM is accepted
- main.c takes in a string from a **FILE** as an input.
- Program immediately **exits** when a line results in an error (syntax is incorrect or there is an unrecognized character). 
- Need to compile the flexer and parser with the separate **main.c** file. 

## How to run 
```
flex labex.flex
```
```
bison -d parser.y
```
```
gcc -o parser main.c lex.yy.c parser.tab.c -lfl
```
```
./parser correct.txt
```

## Inside the sample files:
### correct.txt
This should print out "Parse successful" for each line
```
1 + - 1
1 + 2 - 3 * 4
( x ) + 1 * ( a + b )
( 1 + 21 ) * 55 + 1
23 - 33 + (61 - 10)
11 * 11 * ( 12 ) * 12
x + 1
b * - c + b * - c
- 1

```

### Output when correct.txt is used as an input
```
0, -, 1, , $t0
1, +, 1, $t0, $t1
Parse successful
0, +, 1, 2, $t0
1, *, 3, 4, $t1
2, -, $t0, $t1, $t2
Parse successful
0, +, a, b, $t0
1, *, 1, $t0, $t1
2, +, x, $t1, $t2
Parse successful
0, +, 1, 21, $t0
1, *, $t0, 55, $t1
2, +, $t1, 1, $t2
Parse successful
0, -, 23, 33, $t0
1, -, 61, 10, $t1
2, +, $t0, $t1, $t2
Parse successful
0, *, 11, 11, $t0
1, *, $t0, 12, $t1
2, *, $t1, 12, $t2
Parse successful
0, +, x, 1, $t0
Parse successful
0, -, c, , $t0
1, *, b, $t0, $t1
2, -, c, , $t2
3, *, b, $t2, $t3
4, +, $t1, $t3, $t4
Parse successful
0, -, 1, , $t0
Parse successful
Parse successful
```

### error.txt
This would print out the error from the first line and then exit. But I have tested out each line and they all printed an error message.
```
1 + ) 2 - 3 * 4
11 * 11 * 1 1
23 - 33 + (61 - 10) *
( 1 + 21 ) * ( 55 + 1
1 + 1 -
;;;

```

Error message for each line:
1. 1 + ) 2 - 3 * 4
```
Parser error: syntax error, unexpected RIGHT_PAREN, expecting NUM or VAR or LEFT_PAREN

```
2. 11 * 11 * 1 1
```
Parser error: syntax error, unexpected NUM, expecting ADD_OP or SUB_OP or MULT_OP or '\n'
```
3. 23 - 33 + (61 - 10) *
```
Parser error: syntax error, unexpected '\n', expecting NUM or VAR or LEFT_PAREN
```
4. ( 1 + 21 ) * ( 55 + 1
```
Parser error: syntax error, unexpected '\n', expecting ADD_OP or SUB_OP or MULT_OP or RIGHT_PAREN
```
5. 1 + 1 -
```
Parser error: syntax error, unexpected '\n', expecting NUM or VAR or LEFT_PAREN
```
6. ;;;
```
Lexical error: Unexpected character ';'
Parser error: syntax error, unexpected ERROR
```
