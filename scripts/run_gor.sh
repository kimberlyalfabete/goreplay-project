#!/bin/bash
set -e

cd "$(dirname "$0")/.." || exit 1

mkdir -p results

GOR_BIN="/usr/local/bin/gor"

if [ ! -x "$GOR_BIN" ]; then
  echo "ERROR: gor not found at $GOR_BIN" | tee results/gor.log
  exit 1
fi

nohup "$GOR_BIN" --input-raw :8080 --output-http http://127.0.0.1:8081 > results/gor.log 2>&1 &
echo $! > results/gor.pid
echo "GoReplay started with PID $(cat results/gor.pid)"