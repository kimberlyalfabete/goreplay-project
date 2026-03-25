#!/bin/bash
set -e

cd "$(dirname "$0")/.." || exit 1
mkdir -p results

cd source-app || exit 1
nohup python3 app.py > ../results/source.log 2>&1 &
echo $! > ../results/source.pid
echo "Source app started with PID $(cat ../results/source.pid)"s