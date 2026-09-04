#!/usr/bin/env bash

LOG=/var/log/miner/custom/main.log
algo="blake2b"
unit="hs"
khs=0
stats="null"

LINE=$(grep -a "GH/s" $LOG 2>/dev/null | tail -n 1)

if [[ -n $LINE ]]; then
  GHS=$(echo "$LINE" | sed -n "s/.* \([0-9.]*\) GH\/s.*/\1/p")
  ACC=$(echo "$LINE" | sed -n "s/.* \([0-9]*\) acc.*/\1/p")
  REJ=$(echo "$LINE" | sed -n "s/.*rej \([0-9]*\)).*/\1/p")

  [[ -z $GHS ]] && GHS=0
  [[ -z $ACC ]] && ACC=0
  [[ -z $REJ ]] && REJ=0

  khs=$(echo "$GHS * 1000000" | bc)

  UP=$(ps -o etimes= -C pyblockMiner 2>/dev/null | tr -d " ")
  [[ -z $UP ]] && UP=0

  stats=$(jq -nc \
    --argjson k "$khs" \
    --argjson a "$ACC" \
    --argjson r "$REJ" \
    --argjson u "$UP" \
    '{hs:[$k],hs_units:"khs",ar:[$a,$r],uptime:$u,algo:"blake2b"}')
fi

total_khs=$khs
