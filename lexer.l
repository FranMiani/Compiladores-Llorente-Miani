%{
#include <stdio.h>
#include "parser.tab.h"
%}

DIGITO    [0-9]
LETRA     [a-zA-Z]
ID        {LETRA}({LETRA}|{DIGITO})*
NUMERO    "-"?{DIGITO}+

%%
"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"for" {return FOR;}
"int" {return INT;}
"bool" {return BOOL;}
"const" {return CONST;}
"return" {return RETURN;}
"{" {return '{';}
"}" {return '}';}
"(" {return '(';}
")" {return ')';}
";" {return ';';}
"<" {return '<';}
">" {return '>';}
"<=" {return LESSE;}
">=" {return GREATERE;}
"==" {return EQUAL;}
"!=" {return NEQUAL;}
"and" {return AND;}
"or" {return OR;}
"!" {return '!';}
"=" {return '=';}
"+" {return '+';} 
"-" {return '-';}
"*" {return '*';} 
"/" {return '/';}
"false" {return FALSE;}
"true" {return TRUE;}
{ID} {return ID;}
{NUMERO} {return NUM;}
[ \t\n]+    ; /* Ignorar espacios y saltos de línea */
.           { printf("Error léxico: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}


