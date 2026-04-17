#!/bin/bash

echo "--- Iniciando Processo de Classificação ---"
echo "--- Insira o nome do diretório de destino (ex: projetos) ---"
read pasta

# 1. Validação da Pasta Principal
if [[ ! -d "$pasta" ]]; then
    echo "Erro: O diretório '$pasta' não existe ou não é uma pasta."
    exit 1
fi

echo "--- Diretorio '$pasta' encontrado. Processando arquivos... ---"

# 2. Loop por todos os itens no diretório atual
for arquivo in *; do
    
    # 3. Filtro: Processa apenas se for um arquivo comum
    if [[ -f "$arquivo" ]]; then
        
        # Ignora o próprio script para ele não se mover
        if [[ "$arquivo" == "$(basename "$0")" ]]; then
            continue
        fi

        # 4. Extração da extensão
        ext="${arquivo##*.}"

        # Caso o arquivo não tenha extensão, definimos um nome padrão
        if [[ "$arquivo" == "$ext" ]]; then
            ext="sem_extensao"
        fi

        # 5. Definição dos caminhos para a "Ponte"
        subpasta_destino="$pasta/$ext"
        caminho_final="$subpasta_destino/$arquivo"

        # 6. Verifica se a subpasta da extensão existe
        if [[ -d "$subpasta_destino" ]]; then
            
            # 7. Regra do Projeto: Não sobrescrever
            if [[ -e "$caminho_final" ]]; then
                echo "[AVISO] O arquivo '$arquivo' já existe em '$subpasta_destino'. Não movido."
            else
                mv "$arquivo" "$subpasta_destino/"
                echo "[SUCESSO] '$arquivo' -> '$subpasta_destino/'"
            fi
        # Opcional: Se quiser silenciar arquivos sem pasta, basta manter este bloco vazio
        fi
    fi
done

echo "--- Processo Finalizado ---"
