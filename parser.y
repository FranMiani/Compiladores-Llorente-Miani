%{
#include <stdio.h>
#include <stdlib.h>
#include <libgen.h>

extern FILE *yyin;
int yylex(void);
void yyerror(const char *s);
%}

%token IF ELSE WHILE FOR INT CONST RETURN
%token LESSE GREATERE EQUAL NEQUAL AND OR NOT
%token ID NUM TRUE FALSE BOOL VOID

%nonassoc LESSE GREATERE '<' '>' EQUAL NEQUAL '!'
%left AND OR
%left '+' '-'
%left '*' '/'

%%

input:
    INT ID '(' ')' '{' Linea '}' {printf("ok\n");}
    | BOOL ID '(' ')' '{' Linea '}' {printf("ok\n");}
    | VOID ID '(' ')' '{' Linea '}' {printf("ok\n");}
    ;

Linea:
    Exp';' Linea
    | Dec';' Linea
    | As';' Linea
    | RETURN Exp ';' Linea
    | Exp';'
    | Dec';'
    | As';'
    | RETURN Exp ';'
    ;

Exp: 
    Exp '+' Exp
    | Exp '*' Exp
    | Exp '-' Exp
    | Exp '/' Exp
    | '('Exp')'
    | Exp EQUAL Exp
    | Exp AND Exp
    | Exp OR Exp
    | Exp '<' Exp
    | Exp '>' Exp
    | Exp LESSE Exp
    | Exp GREATERE Exp
    | Exp NEQUAL Exp
    | '!'Exp
    | NUM | FALSE | TRUE | ID
    ;

Dec:
    INT ID
    | BOOL ID
    | CONST INT ID
    | CONST BOOL ID
    ;

As:
    ID '=' Exp
    ;
    
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <archivo_a_compilar>\n", basename(argv[0]));
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        fprintf(stderr, "Error: No se pudo abrir el archivo '%s'\n", argv[1]);
        return 1;
    }

    yyparse();
    fclose(yyin);
    return 0;
}

