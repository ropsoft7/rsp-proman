#!/bin/bash

SUBDIR="/etc/proman/service"

echo
echo "Listing all proman services..."
echo

# Navega até o diretório base
if [[ -d "$SUBDIR" ]]; then
    cd "$SUBDIR" || { echo "Erro: Não foi possível acessar $SUBDIR"; exit 1; }
else
    echo "Erro: Diretório $SUBDIR não existe."
    exit 1
fi

# Inicializa o contador
INDEX=1

# Loop através de cada subdiretório no diretório base
for DIR in */; do
    # Remove a barra final para obter apenas o nome do subdiretório
    SERVICE_NAME="${DIR%/}"
    echo "  $INDEX. $SERVICE_NAME.pro"
    ((INDEX++)) # Incrementa o contador
done
