#!/bin/bash
set -e

cd "$(dirname "$0")/.." || exit 1
mkdir -p results

if command -v gor >/dev/null 2>&1; then
  GOR_BIN="$(command -v gor)"
elif [ -x /usr/local/bin/gor ]; then
  GOR_BIN="/usr/local/bin/gor"
elif [ -x /usr/bin/gor ]; then
  GOR_BIN="/usr/bin/gor"
else
  echo "ERROR: gor not found in PATH or standard locations" | tee results/gor.log
  exit 1
fi

echo "Using gor: $GOR_BIN" | tee results/gor.log

nohup "$GOR_BIN" --input-raw :8080 --output-http http://127.0.0.1:8081 >> results/gor.log 2>&1 &
echo $! > results/gor.pid
echo "GoReplay started with PID $(cat results/gor.pid)"