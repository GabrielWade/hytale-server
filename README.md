# 🎮 Hytale Minigames Server

Servidor Hytale com arquitetura multi-servidor escalável para minigames.

## 📋 Arquitetura

```
┌─────────────┐
│   LOBBY     │ ← Jogadores conectam aqui (Porta 5520)
│  (Gateway)  │
└──────┬──────┘
       │
       ├─────► Minigame:  SkyWars (Porta 5521)
       └─────► Minigame:  N (Escalável)
```

## 🚀 Requisitos

- **Java 25** ([Adoptium](https://adoptium.net/))
- **4GB+ RAM**
- **Linux** (Ubuntu/Debian recomendado)
- **Conta Hytale** (para autenticação do servidor)

## 📦 Instalação

### 1. Clonar o repositório

```bash
git clone https://github.com/GabrielWade/hytale-server.git
cd hytale-server
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
cp -r "$HYTALE_PATH/Server" minigame-skywars/
```

**Alternativa:** Use o [Hytale Downloader CLI](https://hypixel.com/docs/hytale-server-manual#server-files)

### 3. Configurar permissões

```bash
chmod +x lobby/start-lobby. sh
chmod +x minigame-skywars/start-skywars.sh
chmod +x scripts/start-all.sh
chmod +x scripts/stop-all. sh
```

### 4. Configurar firewall

```bash
sudo ufw allow 5520/udp comment "Hytale Lobby"
sudo ufw allow 5521/udp comment "Hytale SkyWars"
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

# SkyWars
./minigame-skywars/start-skywars.sh
```

### Parar todos os servidores

```bash
./scripts/stop-all.sh
```

### Autenticar servidores

Na primeira execução, cada servidor precisa ser autenticado:

1. Execute o servidor
2. No console, digite: `/auth login device`
3. Visite: `https://accounts.hytale.com/device`
4. Insira o código mostrado
5. Autorize com sua conta Hytale

**Importante:** Você pode autenticar até 100 servidores por licença do Hytale.

## 📂 Estrutura do Projeto

```
hytale-server/
├── lobby/                    # Servidor de entrada (Gateway)
│   ├── Server/              # Binários do servidor Hytale
│   ├── mods/                # Mods do lobby
│   ├── universe/            # Mundo e dados dos jogadores
│   ├── logs/                # Logs do servidor
│   ├── start-lobby.sh       # Script de inicialização
│   └── config.json          # (Gerado automaticamente)
│
├── minigame-skywars/        # Minigame: SkyWars
│   ├── Server/
│   ├── mods/
│   ├── universe/
│   ├── logs/
│   ├── start-skywars.sh
│   └── config.json
│
├── shared/                   # Recursos compartilhados
│   └── Assets.zip           # Assets do Hytale (3GB)
│
├── scripts/                  # Scripts auxiliares
│   ├── start-all.sh         # Inicia todos os servidores
│   └── stop-all.sh          # Para todos os servidores
│
├── config.example.json       # Exemplo de configuração
├── . gitignore
└── README. md
```

## 🔧 Configuração

### Portas dos Servidores

| Servidor | Porta | Uso              |
|----------|-------|------------------|
| Lobby    | 5520  | Entrada principal|
| SkyWars  | 5521  | Minigame         |

### Memória Alocada

- **Lobby:** 2GB (`-Xmx2G -Xms2G`)
- **SkyWars:** 1GB (`-Xmx1G -Xms1G`)

Ajuste conforme necessário nos scripts `.sh`

### Configuração Avançada

Copie o arquivo de exemplo e ajuste conforme necessário:

```bash
cp config.example.json config. json
nano config.json
```

## 🛠️ Desenvolvimento

### Adicionar um novo minigame

1. Copie a estrutura do SkyWars:
```bash
cp -r minigame-skywars minigame-NOVO
```

2. Edite o script de inicialização: 
```bash
nano minigame-NOVO/start-NOVO. sh
# Altere a porta (ex: 5522) e o nome
```

3. Torne executável:
```bash
chmod +x minigame-NOVO/start-NOVO.sh
```

4. Configure o firewall:
```bash
sudo ufw allow 5522/udp comment "Hytale NOVO"
```

5. Atualize o `scripts/start-all.sh` para incluir o novo servidor

### Instalar mods

Coloque arquivos `.jar` ou `.zip` na pasta `mods/` do servidor desejado:

```bash
cp meu-mod.jar lobby/mods/
```

**Dica:** Baixe mods de fontes confiáveis como [CurseForge](https://www.curseforge.com/hytale)

### Transferir jogadores entre servidores

Use a API de Player Referral no seu código Java:

```java
// No lobby, ao jogador selecionar SkyWars: 
PlayerRef.referToServer("localhost", 5521, null);
```

## 📊 Monitoramento

### Ver logs em tempo real

```bash
# Lobby
tail -f lobby/logs/latest.log

# SkyWars
tail -f minigame-skywars/logs/latest.log
```

### Verificar processos ativos

```bash
ps aux | grep HytaleServer
```

### Verificar uso de recursos

```bash
htop
# Procure por processos "java"
```

## 🐛 Troubleshooting

| Problema | Solução |
|----------|---------|
| "Java não encontrado" | Instale Java 25: [Adoptium](https://adoptium.net/) |
| "Porta já em uso" | Altere a porta no script `.sh` com `--bind PORTA` |
| "Permissão negada" | Execute:  `chmod +x *.sh` |
| "Assets.zip não encontrado" | Verifique se copiou para `shared/` |
| "Não consegue conectar" | Verifique firewall: `sudo ufw status` |
| "Limite de 100 servidores" | Compre licenças adicionais ou aplique para Server Provider |
| Servidor trava/lento | Reduza `ViewDistance` no config.json para 8-10 chunks |

### Protocolo QUIC

Hytale usa **QUIC sobre UDP**, não TCP. Certifique-se de: 

- Port forwarding configurado para **UDP**, não TCP
- Firewall liberando **UDP** na porta correta
- Se usar proxy/load balancer, deve suportar QUIC

## 📚 Recursos

- [Hytale Server Manual](https://hypixel.com/docs/hytale-server-manual)
- [Java 25 Download (Adoptium)](https://adoptium.net/)
- [Mods para Hytale](https://www.curseforge.com/hytale)
- [Server Provider Authentication Guide](https://hypixel.com/docs/server-provider-auth)

## 🔐 Segurança

⚠️ **Importante:** Ao transferir jogadores entre servidores com payloads: 

- O cliente pode modificar o payload
- Sempre use assinatura criptográfica (HMAC) com chave compartilhada
- Valide payloads no servidor de destino antes de confiar nos dados

## 📝 Licença

Este projeto é um MVP para fins educacionais.

## 👤 Autor

**Gabriel Wade** - [@GabrielWade](https://github.com/GabrielWade)

---

⭐ Se este projeto te ajudou, deixe uma star! 

## 🚀 Roadmap

- [x] Servidor Lobby
- [x] Minigame:  SkyWars
- [ ] Sistema de fila/matchmaking
- [ ] Sistema de parties
- [ ] Minigame:  BedWars
- [ ] Minigame: The Bridge
- [ ] Dashboard web com Query plugin
- [ ] Integração com sistema de pagamentos do Hytale