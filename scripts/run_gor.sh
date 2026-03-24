#!/bin/bash

cd "$(dirname "$0")/.." || exit 1

sudo -v || exit 1
nohup sudo gor --input-raw :8080 --output-http http://127.0.0.1:8081 > results/gor.log 2>&1 &
echo $! > results/gor.pid
echo "GoReplay started with PID $(cat results/gor.pid)"