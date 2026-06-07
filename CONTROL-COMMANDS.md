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

### 2. Install `nexus-ctl` (recommended)

**Easiest way (using make):**

```bash
make install-user     # Installs to ~/.local/bin (no sudo)
# make install        # System-wide (requires sudo)
```

**Alternative (using the install script directly):**

```bash
./install.sh --user
# sudo ./install.sh
```

After installation you can run `nexus-ctl` from anywhere:

```bash
nexus-ctl --help
nexus-ctl mesh status
nexus-ctl system status
```

### 3. Run without installing (quick test)

```bash
chmod +x nexus-ctl
./nexus-ctl --help
```

**Currently live**: `mesh status` and `system status` execute real queries against Yggdrasil and Docker on your system. All other commands have detailed, ready-to-implement specifications.

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
| `mesh config apply` | Push new configuration (e.g. via Docker compose or yggdrasil.conf) | `nexus-ctl mesh config apply --file nova-net.yaml` |
| `mesh monitor start` | Launch real-time monitoring dashboard or exporter | `nexus-ctl mesh monitor --prometheus` |
| `mesh privacy enable` | Activate Tor/I2P tunneling for specific traffic | `nexus-ctl mesh privacy enable --layer i2p` |
| `mesh qnet join/leave` | QNET blockchain-mesh integration commands | `nexus-ctl mesh qnet join --chain xcoin` |

**Related Files**: `docs/mesh-commands.md`, `scripts/mesh/`, `configs/yggdrasil/`, `docker-compose.mesh.yml`

### 2. AI Agent & Swarm Commands (`agents/`)

**Purpose**: Deploy, orchestrate, introspect, and evolve AI agent swarms and self-improving networks.

**Core Commands**:

| Command | Description | Example |
|---------|-------------|---------|
| `agents list` | List active agents, swarms, their states and capabilities | `nexus-ctl agents list --swarm alpha` |
| `agents deploy` | Deploy new agent or swarm from template | `nexus-ctl agents deploy --template grok-launcher --count 5` |
| `agents swarm scale` | Horizontally scale swarm size or resources | `nexus-ctl agents swarm scale --swarm alpha --replicas 10` |
| `agents introspect` | Query internal state, emotions (Ara), memory, goals | `nexus-ctl agents introspect --agent id-042 --deep` |
| `agents improve` | Trigger self-improvement cycle or assembler-net evolution | `nexus-ctl agents improve --target emotional-intelligence` |
| `agents task assign` | Assign high-level goals or roleplay scenarios | `nexus-ctl agents task assign --swarm alpha "Maintain NovaNet health"` |
| `agents log tail` | Stream agent decision logs and emotional traces | `nexus-ctl agents log tail --follow` |

**Integration**: Ties into Grok Launcher (Rust/egui), agent swarms for roleplay, long audio sessions, and creative output (Suno, stories).

**Related Files**: `docs/agents-commands.md`, `agents/`, `swarm-configs/`

### 3. Blockchain & Crypto Commands (`blockchain/`)

**Purpose**: Manage XCoin/QCoin operations, QNET mesh integration, runes, arbitrage, and economic layer.

**Core Commands**:

| Command | Description | Example |
|---------|-------------|---------|
| `blockchain status` | Wallet balances, node sync, QNET health | `nexus-ctl blockchain status --coin xcoin` |
| `blockchain tx send` | Send transactions or rune inscriptions | `nexus-ctl blockchain tx send --to <addr> --amount 42 --rune "Wizard Q"` |
| `blockchain arbitrage scan` | Scan for arbitrage opportunities across DEXes/chains | `nexus-ctl blockchain arbitrage scan --min-profit 0.5%` |
| `blockchain qnet sync` | Synchronize mesh state with blockchain state | `nexus-ctl blockchain qnet sync --force` |
| `blockchain rune cast` | Special rune operations (Wizard Q themed) | `nexus-ctl blockchain rune cast --name "Nova Shield"` |
| `blockchain monitor alerts` | Set price/liquidity/security alerts | `nexus-ctl blockchain monitor alerts --coin qcoin --threshold 5%` |

**Related Files**: `docs/blockchain-commands.md`, `blockchain/`, `configs/qcoin/`

### 4. Hardware & Prototype Commands (`hardware/`)

**Purpose**: Interface with physical and prototype devices: sensors, actuators, custom hardware, Grok Launcher instances.

**Core Commands**:

| Command | Description | Example |
|---------|-------------|---------|
| `hardware status` | Device inventory, sensor readings, firmware versions | `nexus-ctl hardware status --device soilnova-01` |
| `hardware control` | Send actuator commands (e.g. motor, LED, relay) | `nexus-ctl hardware control --device vista-nova --action deploy-solar` |
| `hardware flash` | OTA firmware update or config push | `nexus-ctl hardware flash --device york-autotype --firmware v1.2.3` |
| `hardware calibrate` | Run calibration routines for sensors/prototypes | `nexus-ctl hardware calibrate --device lumia --type spectral` |
| `hardware grok-launcher start` | Launch or manage Rust/egui Grok Launcher instances | `nexus-ctl hardware grok-launcher start --gui --project nova-net` |
| `hardware monitor stream` | Real-time telemetry from hardware (MQTT, serial, etc.) | `nexus-ctl hardware monitor stream --device all` |

**Related Files**: `docs/hardware-commands.md`, `hardware/`, `firmware/`, `prototypes/`

### 5. System, Monitoring & Security Commands (`system/`)

**Purpose**: Cross-cutting concerns: observability, logging, access control, privacy, backups, and meta-orchestration.

**Core Commands**:

| Command | Description | Example |
|---------|-------------|---------|
| `system status` | Overall Nexus health dashboard summary | `nexus-ctl system status --full` |
| `system logs` | Aggregate logs from all components with filtering | `nexus-ctl system logs --component mesh --level error --tail 100` |
| `system auth grant/revoke` | Manage operator and agent access permissions | `nexus-ctl system auth grant --user sven --role mesh-admin --scope nova-net` |
| `system backup` | Snapshot configurations, blockchain state, agent memories | `nexus-ctl system backup --include agents,blockchain --dest s3://nexus-backups/` |
| `system privacy audit` | Run privacy and leak detection across stack | `nexus-ctl system privacy audit --fix` |
| `system orchestrate` | High-level workflow execution (playbooks) | `nexus-ctl system orchestrate --playbook deploy-full-nova-net.yaml` |

**Related Files**: `docs/system-commands.md`, `monitoring/`, `security/`, `.github/workflows/`

## Interface Options (Future / Planned)

The control panel is designed to be multi-modal:

- **CLI** (`nexus-ctl`): Primary for scripting, automation, SSH/remote ops. Currently supports real `mesh status`, `system status`, `mesh restart --dry-run`. Python implementation for rapid integration; future Rust + egui version for GUI parity with Grok Launcher.
- **TUI / egui GUI** (`nexus-ctl-gui`): Rich interactive terminal or native GUI inspired by Grok Launcher (Rust + egui). Real-time dashboards, graphs, command palettes.
- **Web Dashboard**: Optional self-hosted web UI (perhaps using egui web or separate frontend) for visual control from any device.
- **Agent API / MCP**: Expose as MCP (Model Context Protocol) or OpenAI-compatible tool-calling endpoint so AI agents (Grok, Liaura, swarms) can natively call these commands.
- **Voice / Audio**: Integration with long audio sessions and Suno for voice-controlled operations (experimental).

## Security & Best Practices

Because these are **control commands** with real impact on infrastructure, agents, funds, and physical devices:

- All commands require authentication (API keys, mTLS, or hardware-backed keys).
- Role-Based Access Control (RBAC) with fine-grained scopes (mesh-only, blockchain-readonly, hardware-full, etc.).
- Full audit logging of every command execution (who, what, when, params, result).
- Dry-run / preview mode for dangerous operations (`--dry-run`).
- Sandboxing and confirmation prompts for high-impact actions (e.g. `mesh restart --all`).
- Encryption in transit and at rest for sensitive configs and agent memories.
- Integration with existing privacy stack (Tor, I2P, Yggdrasil encryption).
- Regular security audits and penetration testing of the control plane itself.

**Never commit secrets** to this repo. Use environment variables, secret managers, or hardware security modules.

## Implementation Roadmap

1. **Phase 1 (Current)**: Repository skeleton + comprehensive command registry + working `nexus-ctl` CLI + `install.sh` + `Makefile`. Live mesh & system status queries.
2. **Phase 2**: Expand real command implementations (more mesh features, agents, blockchain queries, hardware control). Add JSON output and config support.
3. **Phase 3**: egui GUI/TUI version with dashboards and command palette.
4. **Phase 4**: Agent-native MCP tool interface for swarm self-orchestration.
5. **Phase 5**: Web dashboard + voice integration + full playbook engine.
6. **Phase 6**: Enterprise / C-Corp features (multi-user, compliance, audit dashboards).

## Contributing

To add a new command or category:
1. Update the relevant section in this file
2. Implement or improve the corresponding logic in `nexus-ctl` or `scripts/`
3. Optionally add a Makefile target or improve `install.sh`
4. Open a PR with clear description and security notes

**Noble Principle**: All control interfaces must be designed with clarity, safety, sovereignty, and elegance — befitting a nobleman’s infrastructure.

## Related Projects

- Grok Launcher (Rust + egui)
- xMesh / NovaNet / QNET mesh prototypes
- Esslinger & Co. Delaware C-Corp infrastructure
- Agent swarms and creative AI work

**Maintained by**: Sven Norman Esslinger (SirLancelotEsq) — Esslinger Corporation

*Last updated: June 2026*

---

*This repository now provides a complete, easy-to-install foundation for the unified Nexus command layer.*