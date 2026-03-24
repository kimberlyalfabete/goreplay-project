#!/bin/bash
set -e

cd "$(dirname "$0")/.." || exit 1
mkdir -p results

if command -v wrk >/dev/null 2>&1; then
  WRK_BIN="$(command -v wrk)"
elif [ -x /opt/homebrew/bin/wrk ]; then
  WRK_BIN="/opt/homebrew/bin/wrk"
elif [ -x /usr/local/bin/wrk ]; then
  WRK_BIN="/usr/local/bin/wrk"
elif [ -x /usr/bin/wrk ]; then
  WRK_BIN="/usr/bin/wrk"
else
  echo "ERROR: wrk not found in PATH or standard locations" >&2
  exit 1
fi

echo "Using wrk: $WRK_BIN"

TEST_NAME="$1"

case "$TEST_NAME" in
  normal)
    "$WRK_BIN" -t2 -c20 -d30s "http://127.0.0.1:8080/api/data?q=hello" > results/benchmark_normal_load.txt 2>&1
    ;;
  another_normal)
    "$WRK_BIN" -t2 -c20 -d30s "http://127.0.0.1:8080/api/data?q=test123" > results/benchmark_query_load.txt 2>&1
    ;;
  slow)
    "$WRK_BIN" -t2 -c20 -d30s "http://127.0.0.1:8080/api/slow" > results/benchmark_slow_response.txt 2>&1
    ;;
  error)
    "$WRK_BIN" -t2 -c20 -d30s "http://127.0.0.1:8080/api/error" > results/benchmark_error_response.txt 2>&1
    ;;
  *)
    echo "Usage: $0 {normal|another_normal|slow|error}"
    exit 1
    ;;
esac

echo "wrk test '$TEST_NAME' completed"