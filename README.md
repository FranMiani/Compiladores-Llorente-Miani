# Compiladores-Llorente-Miani

bison -d parser.y
flex lexer.l
gcc lex.yy.c parser.tab.c -o compilador
./run_tests.sh