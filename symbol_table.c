#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

SymbolTable* init_table() {
    SymbolTable *table = (SymbolTable*)malloc(sizeof(SymbolTable));
    if (!table) return NULL;
    table->head = NULL;
    return table;
}

Simbolo* create_simb(ExprType exprtype, int value, char *name) {
    Simbolo *s = (Simbolo*)malloc(sizeof(Simbolo));
    if (!s) return NULL;
    s->exprType = exprtype;
    s->value = value;
    s->name = name ? strdup(name) : NULL;
    s->next = NULL;
    return s;
}

Simbolo* insert_symbol(SymbolTable *table, ExprType type, char *name, int value) {
    Simbolo *s = create_simb(type, value, name);
    if (!s) return NULL;
    s->next = table->head;
    table->head = s;
    return s;
}

Simbolo* find_symbol(SymbolTable *table, char *name) {
    if (!name) return NULL;
    Simbolo *current = table->head;
    while (current != NULL) {
        if (current->name && strcmp(current->name, name) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

void free_table(SymbolTable *table) {
    if (!table) return;
    Simbolo *current = table->head;
    while (current != NULL) {
        Simbolo *next = current->next;
        if (current->name) free(current->name);
        free(current);
        current = next;
    }
    free(table);
}
