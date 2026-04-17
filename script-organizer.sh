#!/bin/bash

pasta_alvo="projetos"
mkdir -p "$pasta_alvo"

echo "--- Iniciando Organização ---"

for arquivo in *; do

    if [ -f "$arquivo" ] && [ "$arquivo" != "$(basename "$0")" ]; then
        
        ext="${arquivo##*.}"
        nome_pasta="${ext^}"

        mkdir -p "$pasta_alvo/$nome_pasta"
        mv "$arquivo" "$pasta_alvo/$nome_pasta/"

        echo "$arquivo movido para $pasta_alvo/$nome_pasta/"
    fi
done

echo "--- Concluído ---"i
