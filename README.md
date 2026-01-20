# 🎮 Hytale Minigames Server MVP

Servidor Hytale com arquitetura multi-servidor escalável para minigames. 

## 📋 Arquitetura

```
┌─────────────┐
│   LOBBY     │ ← Jogadores conectam aqui (Porta 5520)
│  (Gateway)  │
└──────┬──────┘
       │
       ├─────► Minigame:  Spleef (Porta 5521)
       ├─────► Minigame: Parkour (Porta 5522)
       └─────► Minigame: N (Escalável)
```

## 🚀 Requisitos

- **Java 25** ([Adoptium](https://adoptium.net/))
- **4GB+ RAM**
- **Linux** (Ubuntu/Debian recomendado)
- **Conta Hytale** (para autenticação do servidor)

## 📦 Instalação

### 1. Clonar o repositório

```bash
git clone https://github.com/SEU_USUARIO/hytale-minigames-server.git
cd hytale-minigames-server
```

### 2. Baixar arquivos do servidor

Você precisa copiar os arquivos do Hytale para o projeto:

```bash
# Localização dos arquivos no Linux
HYTALE_PATH=~/.var/app/com.hypixel.HytaleLauncher/data/Hytale/install/release/package/game/latest

# Copiar Assets.zip
cp "$HYTALE_PATH/Assets.zip" shared/

# Copiar Server para cada servidor
cp -r "$HYTALE_PATH/Server" lobby/
cp -r "$HYTALE_PATH/Server" minigame-spleef/
cp -r "$HYTALE_PATH/Server" minigame-parkour/
```

**Alternativa:** Use o [Hytale Downloader CLI](https://hypixel.com/docs/hytale-server-manual#server-files)

### 3. Configurar permissões

```bash
chmod +x lobby/start-lobby.sh
chmod +x minigame-spleef/start-spleef.sh
chmod +x minigame-parkour/start-parkour.sh
chmod +x scripts/start-all.sh
chmod +x scripts/stop-all. sh
```

### 4. Configurar firewall

```bash
sudo ufw allow 5520/udp comment "Hytale Lobby"
sudo ufw allow 5521/udp comment "Hytale Spleef"
sudo ufw allow 5522/udp comment "Hytale Parkour"
```

## 🎯 Uso

### Iniciar todos os servidores

```bash
./scripts/start-all.sh
```

### Iniciar servidores individualmente

```bash
# Lobby
./lobby/start-lobby.sh

# Spleef
./minigame-spleef/start-spleef.sh

# Parkour
./minigame-parkour/start-parkour. sh
```

### Autenticar servidores

Na primeira execução, cada servidor precisa ser autenticado: 

1. Execute o servidor
2. No console, digite: `/auth login device`
3. Visite:  `https://accounts.hytale.com/device`
4. Insira o código mostrado
5. Autorize com sua conta Hytale

## 📂 Estrutura do Projeto

```
hytale-minigames/
├── lobby/                    # Servidor de entrada (Gateway)
│   ├── Server/              # Binários do servidor Hytale
│   ├── mods/                # Mods do lobby
│   ├── start-lobby.sh       # Script de inicialização
│   └── config.json          # (Gerado automaticamente)
│
├── minigame-spleef/         # Minigame: Spleef
│   ├── Server/
│   ├── mods/
│   ├── start-spleef.sh
│   └── config.json
│
├── minigame-parkour/        # Minigame: Parkour
│   ├── Server/
│   ├── mods/
│   ├── start-parkour.sh
│   └── config.json
│
├── shared/                   # Recursos compartilhados
│   └── Assets.zip           # Assets do Hytale (3GB)
│
├── scripts/                  # Scripts auxiliares
│   ├── start-all.sh         # Inicia todos os servidores
│   └── stop-all.sh          # Para todos os servidores
│
├── . gitignore
└── README.md
```

## 🔧 Configuração

### Portas dos Servidores

| Servidor | Porta | Uso |
|----------|-------|-----|
| Lobby | 5520 | Entrada principal |
| Spleef | 5521 | Minigame 1 |
| Parkour | 5522 | Minigame 2 |

### Memória Alocada

- **Lobby:** 2GB (`-Xmx2G -Xms2G`)
- **Minigames:** 1GB (`-Xmx1G -Xms1G`)

Ajuste conforme necessário nos scripts `.sh`

## 🛠️ Desenvolvimento

### Adicionar um novo minigame

1. Copie a estrutura de um minigame existente: 
```bash
cp -r minigame-spleef minigame-NOVO
```

2. Edite o script de inicialização:
```bash
nano minigame-NOVO/start-NOVO.sh
# Altere a porta e o nome
```

3. Torne executável:
```bash
chmod +x minigame-NOVO/start-NOVO.sh
```

4. Configure o firewall:
```bash
sudo ufw allow PORTA/udp
```

### Instalar mods

Coloque arquivos `.jar` ou `.zip` na pasta `mods/` do servidor desejado: 

```bash
cp meu-mod.jar lobby/mods/
```

## 📊 Monitoramento

### Ver logs em tempo real

```bash
# Lobby
tail -f lobby/logs/latest.log

# Spleef
tail -f minigame-spleef/logs/latest. log
```

### Verificar uso de recursos

```bash
htop
# Procure por processos "java"
```

## 🐛 Troubleshooting

| Problema | Solução |
|----------|---------|
| "Java não encontrado" | Instale Java 25: `sudo apt install openjdk-25-jdk` |
| "Porta já em uso" | Altere a porta no script `.sh` |
| "Permissão negada" | Execute:  `chmod +x *.sh` |
| "Assets.zip não encontrado" | Verifique se copiou para `shared/` |
| "Não consegue conectar" | Verifique firewall:  `sudo ufw status` |

## 📚 Recursos

- [Hytale Server Manual](https://hypixel.com/docs/hytale-server-manual)
- [Java 25 Download](https://adoptium.net/)
- [Mods para Hytale](https://www.curseforge.com/hytale)

## 📝 Licença

Este projeto é um MVP para fins educacionais. 

## 👤 Autor

**Gabriel Wade** - [@GabrielWade](https://github.com/GabrielWade)

---

⭐ Se este projeto te ajudou, deixe uma star! 