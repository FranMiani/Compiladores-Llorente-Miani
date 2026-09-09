#ifndef SIMBOLO
#define SIMBOLO

typedef enum {
    INT1, BOOL1, NOT_TYPE
} ExprType;

typedef struct Simbolo {
    ExprType exprType;
    int value; 
    char *name;
    char *dir;
    struct Simbolo *next;
} Simbolo;



#endif