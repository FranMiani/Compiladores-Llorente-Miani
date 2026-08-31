#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

Node* create_node(NodeType type, Node *left, Node *right, int value, char *name) {
    Node *node = (Node*)malloc(sizeof(Node));
    node->type = type;
    node->left = left;
    node->right = right;
    node->value = value;
    node->name = name ? strdup(name) : NULL;
    return node;
}

void print_ast(Node *node, int indent) {
    if (!node) return;
    for (int i = 0; i < indent; i++) printf("  ");
    
    printf("Tipo: %d", node->type);
    if (node->type == NODE_VAL_NUM) printf(" (valor: %d)", node->value);
    if (node->name) printf(" (nombre: %s)", node->name);
    printf("\n");
    
    print_ast(node->left, indent + 1);
    print_ast(node->right, indent + 1);
}

void free_ast(Node *node) {
    if (!node) return;
    free_ast(node->left);
    free_ast(node->right);
    if (node->name) free(node->name);
    free(node);
}
