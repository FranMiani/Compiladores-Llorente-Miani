#!/bin/bash

bison -d parser.y;
flex lexer.l;
gcc parser.tab.c lex.yy.c ast.c instruccion.c symbol_table.c -o compilador;
./compilador programa.txt;