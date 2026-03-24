#!/bin/bash

cd "$(dirname "$0")/../source-app" || exit 1
nohup python3 app.py > ../results/source.log 2>&1 &
echo $! > ../results/source.pid
echo "Source app started with PID $(cat ../results/source.pid)"