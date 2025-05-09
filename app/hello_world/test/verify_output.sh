#!/bin/bash
# Usage: ./verify_output.sh output.log

LOG_FILE=$1
EXPECTED="Hello World! qemu_cortex_m3"

if grep -q "$EXPECTED" "$LOG_FILE"; then
  echo "[PASS] UART output verified."
  exit 0
else
  echo "[FAIL] Expected output not found."
  exit 1
fi
