//por ahora la tabla de simbolos solo tiene un nivel

#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H
#include "simbolo.h"

typedef struct {
    Simbolo *head;
} SymbolTable;

SymbolTable* init_table();
Simbolo* insert_symbol(SymbolTable *table, ExprType type, char *name, int value);
Simbolo* find_symbol(SymbolTable *table, char *name);
void free_table(SymbolTable *table);
Simbolo* create_simb(ExprType exprtype, int value, char *name);
Simbolo* insert_symbolo(SymbolTable *table, Simbolo *s);
void add_dir(Simbolo *sim, char *direccion);

#endif