#ifndef AST_H
#define AST_H

typedef enum {
    NODE_OP_ADD,
    NODE_OP_SUB,
    NODE_OP_MUL,
    NODE_OP_DIV,
    NODE_VAL_NUM,
    NODE_VAR,
    //etc
} NodeType;

typedef struct Node {
    NodeType type;
    int value;           // Para números
    char *name;          // Para variables
    struct Node *left;
    struct Node *right;
} Node;

Node* create_node(NodeType type, Node *left, Node *right, int value, char *name);
void print_ast(Node *node, int indent);
void free_ast(Node *node);

#endif
