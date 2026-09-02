#!/usr/bin/env bash
# Descarga y compila pyblockMiner en el rig. Solo la primera vez.
set -e
cd /hive/miners/custom/pyblockminer

echo "=== Instalando dependencias ==="
apt-get update -qq
apt-get install -y -qq git gcc build-essential ocl-icd-opencl-dev opencl-headers curl

echo "=== Comprobando Rust ==="
if ! command -v cargo >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi
export PATH="$HOME/.cargo/bin:$PATH"

echo "=== Descargando pyblock-miner ==="
[[ ! -d pyblock-miner ]] && git clone https://github.com/GaltRanch/pyblock-miner

echo "=== Compilando ==="
cd pyblock-miner
./build.sh

echo "=== Listo ==="
