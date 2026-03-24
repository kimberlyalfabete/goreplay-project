#!/bin/bash
set +e

cd "$(dirname "$0")/.." || exit 1

for service in source target gor; do
  PID_FILE="results/${service}.pid"
  if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    kill "$PID" 2>/dev/null
    rm -f "$PID_FILE"
    echo "Stopped $service (PID $PID)"
  else
    echo "No PID file found for $service"
  fi
done