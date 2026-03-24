#!/bin/bash
set -e

cd "$(dirname "$0")/.." || exit 1
mkdir -p results

cd target-app || exit 1
nohup python3 app_target.py > ../results/target.log 2>&1 &
echo $! > ../results/target.pid
echo "Target app started with PID $(cat ../results/target.pid)"