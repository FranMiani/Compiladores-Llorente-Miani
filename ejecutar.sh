#!/bin/bash

bison -d parser.y;
flex lexer.l;
gcc lex.yy.c ast.c parser.tab.c -o compilador;
./run_tests.sh;