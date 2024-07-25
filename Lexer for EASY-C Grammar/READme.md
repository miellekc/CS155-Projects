## Student Info
- **Name:** Jaimielle Kyle C. Calderon
- **Student Number:** 202005499

## Notes:
- Reserved *words* from `reserved.ec` are recognized as RESERVED_WORDS
- Other Characters from `reserved.ec` are recognized depending on the character:
    - ":=" is ASSIGN,
    - "+" is ADD_OP,
    - "-" is SUB_OP, and so on.
- Characters inside two """ are recognized as STRING
- Identifiers starting with numbers are INVALID (ex. 123abc)
- Identifiers with characters "." and "_" are INVALID (ex. abc.abc)

## How to run 
```
flex le1-202005499.flex
```
```
gcc lex.yy.c -o [name]
```
```
./[name] [input/input file]
```
