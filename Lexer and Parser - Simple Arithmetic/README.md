## Student Info
- **Name:** Jaimielle Kyle C. Calderon
- **Student Number:** 202005499
- **Lab Section:** LAB 1 (WED)

## Notes:
- Part 1 fully implemented (can print out "Parse successful" or "Parse error" with a more specific error description)
- Part 2 not fully implemented
- Assumed from specs document: 
    - Only lower case letters are accepted as VAR (variable)
    - Only whole numbers/integers are recognized by NUM (number)
    - Other characters not a lower case letter, an integer, a "+", a "-", or a "*" will be considered as an **unrecognized** character and will raise an error. 
- main.c takes in a string from a **FILE** as an input.
- Program **exits** when a line results in an error (syntax is incorrect or there is an unrecognized character). 
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
1 + 1
1 + 2 - 3 * 4
( x ) + 1 * ( a + b )
( 1 + 21 ) * 55 + 1
23 - 33 + (61 - 10)
11 * 11 * ( 12 ) * 12
x + 1

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