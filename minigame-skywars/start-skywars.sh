#!/bin/bash
echo "========================================"
echo " Iniciando SKYWARS - Porta 5521"
echo "========================================"
cd "$(dirname "$0")/Server" || { echo "Server directory not found"; exit 1; }
java -Xmx1G -Xms1G -jar HytaleServer.jar --assets ../../shared/Assets.zip --bind 0.0.0.0:5521