#!/usr/bin/env bash
cd $(dirname $0)
source config.txt

LOG=/var/log/miner/custom/main.log
mkdir -p /var/log/miner/custom

export PATH="$HOME/.cargo/bin:/home/user/.cargo/bin:$PATH"

BIN=./pyblock-miner/target/release/pyblockMiner

if [[ ! -x $BIN ]]; then
  echo "=== Binario no encontrado ===" | tee -a $LOG
  if command -v cargo >/dev/null 2>&1; then
    echo "Compilando (esto puede tardar 5-25 min segun la CPU)..." | tee -a $LOG
    ./build.sh 2>&1 | tee -a $LOG
  else
    echo "ERROR: falta Rust (cargo). Instalalo o copia el binario ya compilado a:" | tee -a $LOG
    echo "  $(pwd)/pyblock-miner/target/release/pyblockMiner" | tee -a $LOG
    exit 1
  fi
fi

echo "=== Arrancando pyblockMiner ===" | tee -a $LOG
echo "Pool: $POOL" | tee -a $LOG
echo "Addr: $ADDR" | tee -a $LOG
echo "Extra: $EXTRA" | tee -a $LOG

$BIN $EXTRA --addr "$ADDR" --pool "$POOL" 2>&1 | tee -a $LOG
