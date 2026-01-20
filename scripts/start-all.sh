#!/bin/bash

echo "========================================="
echo "🚀 Iniciando Servidores Hytale"
echo "========================================="

# Função para iniciar servidor em background
start_server() {
    local name=$1
    local script=$2
    
    echo "▶️  Iniciando $name..."
    cd "$(dirname "$0")/.."
    ". /$script" > /dev/null 2>&1 &
    echo "✅ $name iniciado (PID: $!)"
}

# Iniciar servidores
start_server "LOBBY" "lobby/start-lobby.sh"
sleep 3

start_server "SKYWARS" "minigame-skywars/start-skywars.sh"
sleep 2

echo ""
echo "========================================="
echo "✅ Servidores iniciados!"
echo "========================================="
echo ""
echo "📊 Verificar processos:"
echo "   ps aux | grep HytaleServer"
echo ""
echo "📝 Ver logs:"
echo "   tail -f lobby/logs/latest.log"
echo "   tail -f minigame-skywars/logs/latest. log"
echo ""
echo "🛑 Parar todos:"
echo "   ./scripts/stop-all.sh"
echo ""