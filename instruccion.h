#ifndef INSTRUCCION
#define INSTRUCCION

typedef struct Instruccion{
    char *operador;
    char *val1;
    char *val2;
    char *val3;
    struct Instruccion *next;
} Instruccion;

typedef struct Pila{
    Instruccion *top;
    Instruccion *bottom;
} Pila;

Instruccion* create_inst(char *op, char *p1, char *p2, char *p3);

void add_inst(Pila *pila, Instruccion *inst);

void print_pila(Pila *pila);

Pila* crear_pila();

#endif
