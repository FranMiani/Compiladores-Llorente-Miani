#include <stdio.h>
#include <stdlib.h>
#include "ast.h"


Node* create_node(NodeType type, Simbolo *simb, Node *left, Node *right) {
    Node *node = (Node*)malloc(sizeof(Node));
    node->type = type;
    node->left = left;
    node->right = right;
    node->info = simb;
    return node;
}

void print_ast(Node *node, int indent) {
    if (!node) return;
    for (int i = 0; i < indent; i++) printf("  ");
    
    printf("Tipo: %d  ", node->type);
    if(node->info){
        printf("Valor: %d", node->info->value);
    }
    printf("\n");
    
    print_ast(node->left, indent + 1);
    print_ast(node->right, indent + 1);
}

void print_postorden(Node *node){
    if(!node) return;
    print_postorden(node->left);
    print_postorden(node->right);
    printf("Tipo: %d  ", node->type);
    if(node->info){
        printf("Valor: %d", node->info->value);
    }
    printf("\n");
}

void node_to_instruction(Node *node){
    
}

void free_ast(Node *node) {
    if (!node) return;
    free_ast(node->left);
    free_ast(node->right);
    free(node);
}
