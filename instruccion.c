#include <stdio.h>
#include <stdlib.h>
#include "instruccion.h"

Instruccion* create_inst(char *op, char *p1, char *p2, char *p3){
    Instruccion *inst = (Instruccion*)malloc(sizeof(Instruccion));
    inst->operador = op;
    inst->val1 = p1;
    inst->val2 = p2;
    inst->val3 = p3;
    return inst;
}

void add_inst(Pila *pila, Instruccion *inst){
    if(!pila->top){
        pila->top = inst;
        pila->bottom = inst;
    } else {
        pila->bottom->next = inst;
        pila->bottom = inst; 
    }
}

void print_pila(Pila *pila){
    Instruccion *actual = pila->top;
    while(actual){
        printf("%s %s %s %s\n", actual->operador, actual->val1, actual->val2, actual->val3);
        actual = actual->next;
    }
}

Pila* crear_pila(){
    Pila *pila = (Pila*)malloc(sizeof(Pila));
    pila->top = NULL;
    pila->bottom = NULL;
    return pila;
}