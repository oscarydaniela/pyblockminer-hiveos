#!/usr/bin/env bash
cd $(dirname $0)
source config.txt

export PATH="$HOME/.cargo/bin:$PATH"

BIN=./pyblock-miner/target/release/pyblockMiner

if [[ ! -x $BIN ]]; then
  echo "Binario no encontrado, compilando..."
  ./build.sh 2>&1 | tee -a $CUSTOM_LOG_BASENAME.log
fi

echo "=== Arrancando pyblockMiner ==="
echo "Pool: $POOL"
echo "Addr: $ADDR"

$BIN $EXTRA --addr "$ADDR" --pool "$POOL" 2>&1 | tee -a $CUSTOM_LOG_BASENAME.log
