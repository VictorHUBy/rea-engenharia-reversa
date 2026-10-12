#!/usr/bin/env bash
# Roda o REA sem tocar na configuração do seu agente: HOME e cache do npm numa pasta de teste,
# teto de memória e de tempo no processo inteiro (systemd-run, Linux). Mede tempo e pico de RAM.
#
# Uso:  ./rodar-isolado.sh <nome> <segundos> <argumentos do rea...>
# Ex.:  ./rodar-isolado.sh meuapp 900 analyze-javascript-application /caminho/absoluto/app.asar \
#         --max-heap-mb 1024 --analysis-timeout-ms 60000 --json
#       ./rodar-isolado.sh plano 120 setup --dry-run
#
# Saída: <nome>.json (resultado), <nome>.err (progresso e medições), linha em resumo.txt.
set -u
[ $# -ge 3 ] || { sed -n 2,10p "$0"; exit 1; }
nome=$1; seg=$2; shift 2
VERSAO=${REA_VERSAO:-6.4.0}
TESTE=${REA_HOME_TESTE:-/tmp/rea-teste}
mkdir -p "$TESTE/npm"
ini=$(date +%s.%N)
systemd-run --user --scope -q -p MemoryMax=8G -p MemorySwapMax=0 -p RuntimeMaxSec="$seg" \
  env HOME="$TESTE" npm_config_cache="$TESTE/npm" npm_config_update_notifier=false \
  /usr/bin/time -v npx -y "rea-agents@$VERSAO" "$@" > "$nome.json" 2> "$nome.err"
rc=$?
fim=$(date +%s.%N)
ram=$(grep -o 'Maximum resident set size (kbytes): [0-9]*' "$nome.err" | grep -o '[0-9]*$')
echo "$nome rc=$rc tempo=$(awk "BEGIN{printf \"%.1f\", $fim-$ini}")s ram_max_kb=$ram json=$(wc -c < "$nome.json")B" | tee -a resumo.txt
