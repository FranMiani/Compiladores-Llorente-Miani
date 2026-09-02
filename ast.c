#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

Node* create_node(NodeType type, Simbolo *simb, Node *left, Node *right) {
    Node *node = (Node*)malloc(sizeof(Node));
    node->type = type;
    node->left = left;
    node->right = right;
    node->info = simb;
    return node;
}

Simbolo* create_simb(ExprType exprtype, int value, char *name){
    Simbolo *simb = (Simbolo*)malloc(sizeof(Simbolo));
    simb->exprType = exprtype;
    simb->value = value;
    simb->name  = name;
    return simb;
}


void print_ast(Node *node, int indent) {
    if (!node) return;
    for (int i = 0; i < indent; i++) printf("  ");
    
    printf("Tipo: %d", node->type);
    printf("\n");
    
    print_ast(node->left, indent + 1);
    print_ast(node->right, indent + 1);
}

void free_ast(Node *node) {
    if (!node) return;
    free_ast(node->left);
    free_ast(node->right);
    free(node);
}
