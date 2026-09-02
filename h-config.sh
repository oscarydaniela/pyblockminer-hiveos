#!/usr/bin/env bash
# Genera config.txt desde los campos de la Flight Sheet

[[ -z $CUSTOM_URL ]] && CUSTOM_URL="pool.pyblock.xyz:5574"
[[ -z $CUSTOM_TEMPLATE ]] && { echo "Falta la direccion en Wallet and worker template"; exit 1; }
[[ -z $CUSTOM_USER_CONFIG ]] && CUSTOM_USER_CONFIG="--network mainnet"

echo "POOL=$CUSTOM_URL"           >  $CUSTOM_CONFIG_FILENAME
echo "ADDR=$CUSTOM_TEMPLATE"      >> $CUSTOM_CONFIG_FILENAME
echo "EXTRA=$CUSTOM_USER_CONFIG"  >> $CUSTOM_CONFIG_FILENAME
