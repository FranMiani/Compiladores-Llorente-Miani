#!/bin/bash

COMPILADOR="./compilador"

run_test() {
    local archivo="$1"
    local esperado="$2"
    
    output=$($COMPILADOR "$archivo")
    if [ "$output" == "$esperado" ]; then
        echo "[PASS] $archivo"
    else
        echo "[FAIL] $archivo"
        echo "   Esperado: $esperado"
        echo "   Obtenido: $output"
    fi
}

echo "Ejecutando tests..."
run_test "tests/test_basico.txt" "ok"
