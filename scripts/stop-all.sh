#!/bin/bash

echo "========================================="
echo "🛑 Parando Servidores Hytale (Lobby & SkyWars)"
echo "========================================="

# Encontrar e matar todos os processos HytaleServer
PIDS=$(ps aux | grep HytaleServer.jar | grep -v grep | awk '{print $2}')

if [ -z "$PIDS" ]; then
    echo "ℹ️  Nenhum servidor Hytale em execução"
else
    echo "Processos encontrados:  $PIDS"
    echo ""
    
    for PID in $PIDS; do
        echo "🔪 Matando processo $PID..."
        kill -15 $PID
    done
    
    sleep 3
    
    # Verificar se ainda há processos
    REMAINING=$(ps aux | grep HytaleServer.jar | grep -v grep | awk '{print $2}')
    
    if [ -n "$REMAINING" ]; then
        echo "⚠️  Alguns processos não pararam, forçando..."
        kill -9 $REMAINING
    fi
    
    echo ""
    echo "✅ Todos os servidores foram parados!"
fi

echo "========================================="