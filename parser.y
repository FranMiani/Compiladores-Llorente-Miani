%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>
#include "ast.h"
#include "symbol_table.h"

SymbolTable *tabla;

int lines = 1;
void addLine(){
    lines++;
}

extern FILE *yyin;
int yylex(void);
void yyerror(const char *s);
%}

%union {
    int num;
    char *str;
    struct Node *node;
}

%token IF ELSE WHILE FOR INT CONST RETURN BOOL
%token LESSE GREATERE EQUAL NEQUAL AND OR NOT
%token <str> ID
%token <num> NUM TRUE FALSE
%token VOID

%type <node> Exp Dec As Linea input

%nonassoc LESSE GREATERE '<' '>' EQUAL NEQUAL '!'
%left AND OR
%left '+' '-'
%left '*' '/'

%%

input:
    INT ID '(' ')' '{' Linea '}' {
        Simbolo *simb = create_simb(INT1, 0, $2);
        $$ = create_node(NODE_OP_FUNC, simb, NULL, $6);
        print_ast($$,0);
        }
    | BOOL ID '(' ')' '{' Linea '}' {
        Simbolo *simb = create_simb(BOOL1, 0, $2);
        $$ = create_node(NODE_OP_FUNC, simb, NULL, $6);
        print_ast($$,0);
        }
    | VOID ID '(' ')' '{' Linea '}' {
        Simbolo *simb = create_simb(NOT_TYPE, 0, $2);
        $$ = create_node(NODE_OP_FUNC, simb, NULL, $6);
        print_ast($$,0);
        }
    ;

Linea:
    Exp';' Linea {$$ = create_node(NODE_OP_NEWLINE, NULL, $1, $3);}
    | Dec';' Linea {$$ = create_node(NODE_OP_NEWLINE, NULL, $1, $3);}
    | As';' Linea {$$ = create_node(NODE_OP_NEWLINE, NULL, $1, $3);}
    | RETURN Exp ';' Linea {
        Simbolo *simb = NULL;
        Node *node = create_node(NODE_OP_RETURN, simb, $2, NULL);
        $$ = create_node(NODE_OP_NEWLINE, NULL, node, $4);
        }
    | Exp';' {$$ = $1;}
    | Dec';' {$$ = $1;}
    | As';' {$$ = $1;}
    | RETURN Exp ';' {
        Simbolo *simb = NULL;
        $$ = create_node(NODE_OP_RETURN, simb, $2, NULL);
        }
    ;

Exp:
    Exp '+' Exp {
        Simbolo *simb = NULL;
        if($3->info->exprType != $1->info->exprType || $1->info->exprType != INT1){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        simb = create_simb($3->info->exprType, $1->info->value + $3->info->value, NULL);
        $$ = create_node(NODE_OP_ADD, simb, $1, $3);
        }
    | Exp '*' Exp {
        Simbolo *simb = NULL;
        if($3->info->exprType != $1->info->exprType || $1->info->exprType != INT1){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        simb = create_simb($3->info->exprType, $1->info->value * $3->info->value, NULL);
        $$ = create_node(NODE_OP_MUL, simb, $1, $3);
        }
    | Exp '-' Exp {
        Simbolo *simb = NULL;
        if($3->info->exprType != $1->info->exprType || $1->info->exprType != INT1){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        $$ = create_node(NODE_OP_SUB, simb, $1, $3);
        }
    | Exp '/' Exp {
        Simbolo *simb = NULL;
        if($3->info->exprType != $1->info->exprType || $1->info->exprType != INT1){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        $$ = create_node(NODE_OP_DIV, simb, $1, $3);
        }
    | '('Exp')' {
        $$ = $2;
        }
    | Exp EQUAL Exp {
        Simbolo *simb = create_simb(BOOL1, 0, NULL);
        $$ = create_node(NODE_OP_EQUAL, simb, $1, $3);
        }
    | Exp AND Exp {
        Simbolo *simb = create_simb(BOOL1, 0, NULL);
        $$ = create_node(NODE_OP_AND, simb, $1, $3);
        }
    | Exp OR Exp {
        Simbolo *simb = create_simb(BOOL1, 0, NULL);
        $$ = create_node(NODE_OP_OR, simb, $1, $3);
        }
    | Exp '<' Exp {
        Simbolo *simb = create_simb(BOOL1, 0, NULL);
        if($3->info->exprType != $1->info->exprType || $1->info->exprType != INT1){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        $$ = create_node(NODE_OP_LESS, simb, $1, $3);
        }
    | Exp '>' Exp {
        Simbolo *simb = create_simb(BOOL1, 0, NULL);
        if($3->info->exprType != $1->info->exprType || $1->info->exprType != INT1){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        $$ = create_node(NODE_OP_GREAT, simb, $1, $3);
        }
    | Exp LESSE Exp {
        Simbolo *simb = create_simb(BOOL1, 0, NULL);
        if($3->info->exprType != $1->info->exprType || $1->info->exprType != INT1){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        $$ = create_node(NODE_OP_LESSE, simb, $1, $3);
        }
    | Exp GREATERE Exp {
        Simbolo *simb = create_simb(BOOL1, 0, NULL);
        if($3->info->exprType != $1->info->exprType || $1->info->exprType != INT1){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        $$ = create_node(NODE_OP_GREATE, simb, $1, $3);
        }
    | Exp NEQUAL Exp {
        Simbolo *simb = create_simb(BOOL1, 0, NULL);
        if($3->info->exprType != $1->info->exprType){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        $$ = create_node(NODE_OP_NEQUAL, simb, $1, $3);
        }
    | '!'Exp {Simbolo *simb;
        if(BOOL1 != $2->info->exprType){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        if($2->info->value==0){
            simb = create_simb(BOOL1, 1, NULL);
        }else{
            simb = create_simb(BOOL1, 0, NULL);
        }
        $$ = create_node(NODE_OP_NOT, simb, $2, NULL);}
    | NUM {Simbolo *simb = create_simb(INT1, $1, NULL);
        $$ = create_node(NODE_VAL_NUM, simb, NULL, NULL);}
    | FALSE {Simbolo *simb = create_simb(BOOL1, 0, NULL);
        $$ = create_node(NODE_VAL_FALSE, simb, NULL, NULL);}
    | TRUE {Simbolo *simb = create_simb(BOOL1, 1, NULL);
        $$ = create_node(NODE_VAL_TRUE, simb, NULL, NULL);}
    | ID {
        Simbolo *existente = find_symbol(tabla, $1);
        if (existente == NULL) {
            fprintf(stderr, "Error semantico: variable '%s' no declarada. En la linea %d\n", $1, lines);
            YYABORT;
        }
        Simbolo *simb = existente;
        $$ = create_node(NODE_ID, simb, NULL, NULL);
        }
    ;

Dec:
    INT ID {
        if (find_symbol(tabla, $2) != NULL) {
            fprintf(stderr, "Error semantico: variable '%s' ya declarada. En la linea %d\n", $2, lines);
            YYABORT;
        }
        Simbolo *simb = create_simb(INT1, 0, $2);
        insert_symbolo(tabla, simb);
        $$ = create_node(NODE_DECLARATION, simb, NULL, NULL);
        }
    | BOOL ID  {
        if (find_symbol(tabla, $2) != NULL) {
            fprintf(stderr, "Error semantico: variable '%s' ya declarada. En la linea %d\n", $2, lines);
            YYABORT;
        }
        Simbolo *simb = create_simb(BOOL1, 0, $2);
        insert_symbolo(tabla, simb);
        $$ = create_node(NODE_DECLARATION, simb, NULL, NULL);
        }
    ;

As:
    ID '=' Exp {
        Simbolo *existente = find_symbol(tabla, $1);
        if (existente == NULL) {
            fprintf(stderr, "Error semantico: variable '%s' no declarada. En la linea %d\n", $1, lines);
            YYABORT;
        }
        if(existente->exprType != $3->info->exprType){
            fprintf(stderr, "Error de tipo. En la linea %d\n", lines);
            YYABORT;
        }
        existente->value = $3->info->value;
        Simbolo *simb = create_simb(existente->exprType, existente->value, $1);
        $$ = create_node(NODE_ASSIGN, simb, NULL, $3);
        }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s En la linea %d\n", s, lines);
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

    tabla = init_table();

    yyparse();
    fclose(yyin);

    free_table(tabla);
    printf("%d", lines);
    return 0;
}
