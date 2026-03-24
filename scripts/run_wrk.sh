#!/bin/bash

cd "$(dirname "$0")/.." || exit 1

TEST_NAME="$1"

case "$TEST_NAME" in
  normal)
    wrk -t2 -c20 -d30s "http://127.0.0.1:8080/api/data?q=hello" > results/wrk_normal.txt
    ;;
  another_normal)
    wrk -t2 -c20 -d30s "http://127.0.0.1:8080/api/data?q=test123" > results/wrk_another_normal.txt
    ;;
  slow)
    wrk -t2 -c20 -d30s http://127.0.0.1:8080/api/slow > results/wrk_slow.txt
    ;;
  error)
    wrk -t2 -c20 -d30s http://127.0.0.1:8080/api/error > results/wrk_error.txt
    ;;
  *)
    echo "Usage: $0 {normal|another_normal|slow|error}"
    exit 1
    ;;
esac

echo "wrk test '$TEST_NAME' completed"