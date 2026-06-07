# Nexus Control Panel - All Control Commands

**Centralized repository for command, control, monitoring, and orchestration of the entire Nexus ecosystem.**

This repository serves as the single source of truth for all operational commands, scripts, configurations, automation playbooks, and interfaces used to manage:

- **Mesh Networking**: xMesh, NovaNet, QNET, Yggdrasil, Tenda Nova, Docker-based nodes, privacy layers (Tor/I2P)
- **AI Agents & Swarms**: Grok/Liaura agents, agent swarms, emotional/self-improving AI (Ara), assembler nets
- **Blockchain & Economy**: XCoin/QCoin, QNET integration, runes (Wizard Q), arbitrage bots, token mechanics
- **Hardware Prototypes & Devices**: Soilnova, Vista Nova, York Autotype, Lumia, Grok Launcher (Rust + egui), sensor/actuator controls
- **System Infrastructure**: Monitoring, logging, networking optimization, C-Corp operations support

**Repository Goal**: Provide a unified, secure, auditable, and extensible control layer so that any operator (human or AI agent) can discover, execute, and monitor commands across the full stack from one place.

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/digitaldesignerjazz/nexus-control-panel.git
cd nexus-control-panel
```

### 2. Install `nexus-ctl` + Shell Completions (recommended)

```bash
make install-user install-completions

# Or manually:
# ./install.sh --user --completions
```

After installation:

```bash
nexus-ctl mesh status          # Tab completion now works!
nexus-ctl agents list<TAB>
nexus-ctl --dry-run<TAB>
```

### 3. Alternative installation methods

```bash
make install-user                 # Binary only
make install-completions          # Completions only
./install.sh --user --completions # Full featured install
```

### 4. Run without installing

```bash
chmod +x nexus-ctl
./nexus-ctl --help
```

**Currently live commands**: `mesh status` and `system status` perform real queries. Tab completion is available for all categories, actions, and common flags.

## Command Categories & Registry

All commands are organized by domain for easy discovery and maintenance. Each category has its own detailed specification.

### 1. Mesh Network Commands (`mesh/`)

**Purpose**: Control and monitor the decentralized mesh fabric (Yggdrasil + custom xMesh/NovaNet/QNET overlays).

**Core Commands** (examples to be implemented):

| Command | Description | Example |
|---------|-------------|---------|
| `mesh status` | Show node health, peers, routes, bandwidth | `nexus-ctl mesh status --verbose` |
| `mesh peer add/remove` | Manage peer connections | `nexus-ctl mesh peer add --pubkey <key> --addr <ip:port>` |
| `mesh restart` | Restart Yggdrasil/Tenda/Docker services (with confirmation + --force) | `nexus-ctl mesh restart --service yggdrasil --dry-run` |
| `mesh config apply` | Push new configuration | `nexus-ctl mesh config apply --file nova-net.yaml` |
| `mesh monitor start` | Launch real-time monitoring | `nexus-ctl mesh monitor --prometheus` |
| `mesh privacy enable` | Activate Tor/I2P tunneling | `nexus-ctl mesh privacy enable --layer i2p` |
| `mesh qnet join/leave` | QNET blockchain-mesh integration | `nexus-ctl mesh qnet join --chain xcoin` |

**Related Files**: `completions/`, `docs/mesh-commands.md`

### 2. AI Agent & Swarm Commands (`agents/`)

**Purpose**: Deploy, orchestrate, introspect, and evolve AI agent swarms.

**Core Commands**:

| Command | Description | Example |
|---------|-------------|---------|
| `agents list` | List active agents and swarms | `nexus-ctl agents list --swarm alpha` |
| `agents deploy` | Deploy new agent or swarm | `nexus-ctl agents deploy --template grok-launcher` |
| `agents scale` | Scale swarm horizontally | `nexus-ctl agents swarm scale --replicas 10` |
| `agents introspect` | Query agent state and emotions (Ara) | `nexus-ctl agents introspect --agent id-042` |
| `agents improve` | Trigger self-improvement cycle | `nexus-ctl agents improve` |
| `agents task assign` | Assign goals or roleplay tasks | `nexus-ctl agents task assign --swarm alpha` |
| `agents log` | Stream agent decision logs | `nexus-ctl agents log tail --follow` |

**Related Files**: `docs/agents-commands.md`

### 3. Blockchain & Crypto Commands (`blockchain/`)

**Purpose**: XCoin/QCoin operations, QNET integration, runes, arbitrage.

**Core Commands**:

| Command | Description | Example |
|---------|-------------|---------|
| `blockchain status` | Wallet / node status | `nexus-ctl blockchain status --coin xcoin` |
| `blockchain tx` | Send transaction or rune | `nexus-ctl blockchain tx send` |
| `blockchain arbitrage` | Scan for opportunities | `nexus-ctl blockchain arbitrage scan` |
| `blockchain rune` | Special rune operations | `nexus-ctl blockchain rune cast` |

**Related Files**: `docs/blockchain-commands.md`

### 4. Hardware & Prototype Commands (`hardware/`)

**Purpose**: Soilnova, Vista Nova, York Autotype, Lumia, Grok Launcher.

**Core Commands**:

| Command | Description | Example |
|---------|-------------|---------|
| `hardware status` | Device inventory and readings | `nexus-ctl hardware status --device soilnova-01` |
| `hardware control` | Send actuator commands | `nexus-ctl hardware control --device vista-nova` |
| `hardware grok-launcher` | Manage Grok Launcher instances | `nexus-ctl hardware grok-launcher start --gui` |

**Related Files**: `docs/hardware-commands.md`

### 5. System Commands (`system/`)

**Purpose**: Observability, security, orchestration, backups.

**Core Commands**:

| Command | Description | Example |
|---------|-------------|---------|
| `system status` | Overall Nexus health | `nexus-ctl system status --full` |
| `system logs` | Aggregate component logs | `nexus-ctl system logs --component mesh` |
| `system orchestrate` | Run automation playbooks | `nexus-ctl system orchestrate --playbook deploy-nova.yaml` |

**Related Files**: `docs/system-commands.md`

## Shell Completions

Tab completion is now available for:

- All command categories (`mesh`, `agents`, `blockchain`, `hardware`, `system`)
- All actions within each category
- Common flags (`--dry-run`, `--verbose`, `--json`, `--service`, `--coin`, etc.)

**Installation**:
```bash
make install-completions
# or
./install.sh --user --completions
```

Completions are installed to:
- Bash: `~/.local/share/bash-completion/completions/nexus-ctl`
- Zsh: `~/.zfunc/_nexus-ctl`

After installing zsh completions, make sure your `~/.zshrc` contains:
```zsh
fpath+=($HOME/.zfunc)
autoload -Uz compinit && compinit
```

## Interface Options (Future / Planned)

The control panel supports multiple interfaces:
- **CLI** (`nexus-ctl`) — current primary interface with tab completion
- **TUI / egui GUI** (planned)
- **Agent API / MCP** (planned — so swarms can call these commands)
- **Web Dashboard** (future)

## Security & Best Practices

All control commands include `--dry-run` support. High-impact actions (restart, hardware control, blockchain tx) require confirmation unless `--force` is used.

## Implementation Roadmap

1. **Phase 1 (Current)**: Full install system (`install.sh` + `Makefile`), shell completions (bash + zsh), live `mesh status` + `system status`.
2. **Phase 2**: Expand real implementations for more mesh, agent, blockchain, and hardware commands.
3. **Phase 3**: egui GUI version.
4. **Phase 4**: Native agent/MCP tool calling interface.
5. **Phase 5+**: Web dashboard, voice, full automation engine.

**Noble Principle**: Clarity, safety, and elegance in every control interface.

**Maintained by**: Sven Norman Esslinger — Esslinger Corporation

*Last updated: June 2026*