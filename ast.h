#ifndef AST_H
#define AST_H

typedef enum {
    // Operaciones Aritméticas
    NODE_OP_ADD, NODE_OP_SUB, NODE_OP_MUL, NODE_OP_DIV,
    // Operadores Relacionales
    NODE_OP_LESS, NODE_OP_GREAT, NODE_OP_LESSE, NODE_OP_GREATE, 
    NODE_OP_EQUAL, NODE_OP_NEQUAL,
    // Operadores Lógicos
    NODE_OP_AND, NODE_OP_OR, NODE_OP_NOT,
    // Otros
    NODE_VAL_NUM, NODE_VAL_TRUE, NODE_VAL_FALSE,
    NODE_VAR,
    NODE_ASSIGN,
    NODE_DECLARATION,
    NODE_OP_RETURN,
    NODE_ID,
    NODE_OP_NEWLINE, 
    NODE_OP_FUNC
    
} NodeType;


typedef enum {
    INT1, BOOL1, NOT_TYPE
} ExprType;

typedef struct Simbolo{
    ExprType exprType;
    int value; 
    char *name; 
} Simbolo;

typedef struct Node {
    NodeType type;
    struct Simbolo *info;
    struct Node *left;
    struct Node *right;
} Node;

Node* create_node(NodeType type, Simbolo *simb, Node *left, Node *right);
Simbolo* create_simb(ExprType exprtype, int value, char *name);
void print_ast(Node *node, int indent);
void free_ast(Node *node);

#endif
