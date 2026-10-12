# Resultados REA 6.4.0 — servidor Linux ARM64 (Node 24.13), 12/10/2026

Execução: `rodar-isolado.sh` (nesta pasta) = `npx -y rea-agents@6.4.0` com HOME e cache do npm numa pasta de teste, `systemd-run` MemoryMax=8G + RuntimeMaxSec. Config do agente na máquina antes/depois: sem mudança (0 entradas do REA em ~/.claude.json, ~/.codex/config.toml e skills).

| Teste | Comando | Resultado |
|---|---|---|
| App Electron que TRAVOU na 6.3.0 (>20 min, só kill -9) | `analyze-javascript-application "/opt/NVIDIA AI Workbench/resources/app.asar" --max-heap-mb 1024 --analysis-timeout-ms 60000 --json` | **terminou em 94,5 s**, pico 1,26 GB; 210 arquivos, 202 JS lidos, 0 falhas, 7.915.450 nós de sintaxe, 13.500 achados, 4.898 módulos; JSON 41 MB; 377 limitações declaradas (177 "Resource constraint"). O arquivo que travava (`about.renderer…js`) manteve os fatos estáticos e a análise semântica foi pulada e declarada |
| Projeto Node nosso (um bot, sem node_modules/.git/.env) | idem | 19,7 s, 0,55 GB; 313 arquivos, 203 JS, 123.346 nós, 1.295 achados, grafo 998 nós / 1.260 arestas; 319 limitações |
| Binário Go (gh, ELF aarch64) | `inspect-artifact <gh> --json` | 1,4 s: formato ELF, sha256, inventário (Evidence `rea-artifact-graph`) |
| Instalação sem mexer em nada | `setup --dry-run` | plano vazio no HOME de teste; diagnóstico: Ghidra (GHIDRA_INSTALL_DIR) e IDA (REA_IDA_MCP_CONFIG) não configurados; 18 clientes conhecidos |
| Nome do código ≠ CLI publicada | `inspect-go-binary` | `COMMAND_NOT_FOUND` (sugere `inspect-artifact`) |

Conceitos confirmados na documentação (docs/javascript-application-workflows.md): comparação de versões só chama de "removido" quando a cobertura do outro lado é completa; com cobertura parcial, vira "unknown". Tudo é Evidence (evidence_id, subject sha256, provider, confidence, limitations).
