#!/bin/bash

SERVICED="/etc/proman/service"

echo "Starting all proman services..."
echo

pm2 kill;

sleep 1

# Verifica se o diretório existe
if [[ ! -d "$SERVICED" ]]; then
    echo "Erro: Diretório $SERVICED não existe."
    exit 1
fi

# Navega até o diretório base
cd "$SERVICED" || { echo "Erro: Não foi possível acessar $SERVICED"; exit 1; }

# Loop através de cada subdiretório no diretório base
for DIR in */; do
    # Remove a barra final para obter o nome do subdiretório
    SERVICE_NAME="${DIR%/}"

    echo "Iniciando serviço: $SERVICE_NAME"

    # Verifica se o script de inicialização existe
    if [[ -e "$SERVICED/$SERVICE_NAME/start.sh" ]]; then

        echo "Caminho encontrado: $SERVICED/$SERVICE_NAME/start.sh"
        
        pm2 start "$SERVICED/$SERVICE_NAME/start.sh" \
            --max-memory-restart 45M \
            --name "$SERVICE_NAME" \
            --namespace proman && pm2 save
    else
        echo "Aviso: Caminho $SERVICED/$SERVICE_NAME/start.sh não encontrado."
    fi

    echo
done

echo "Todos os serviços foram processados."
