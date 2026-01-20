#!/bin/bash
echo "========================================"
echo " Iniciando LOBBY - Porta 5520"
echo "========================================"
cd "$(dirname "$0")/Server" || { echo "Server directory not found"; exit 1; }
java -Xmx2G -Xms2G -jar HytaleServer.jar --assets ../../shared/Assets.zip --bind 0.0.0.0:5520