#include <stdio.h>
#include "ast.h"

int main() {
    printf("Probando la construccion del AST manualmente...\n");

    // Construir: 200 / 12
    Node *num1 = create_node(NODE_VAL_NUM, NULL, NULL, 200, NULL);
    Node *num2 = create_node(NODE_VAL_NUM, NULL, NULL, 12, NULL);
    Node *div = create_node(NODE_OP_DIV, num1, num2, 0, NULL);

    printf("Arbol generado para '200 / 12':\n");
    print_ast(div, 0);

    free_ast(div);
    printf("Memoria liberada correctamente.\n");

    return 0;
}
