# Compiladores-Llorente-Miani

Integrantes del grupo: Mateo Llorente y Francisco Miani

Pasos para compilar el proyecto y ejecutar con un programa de prueba:

```
bison -d parser.y   
flex lexer.l  
gcc parser.tab.c lex.yy.c ast.c instruccion.c symbol_table.c -o compilador
./compilador programa.txt 
```
