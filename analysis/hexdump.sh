#!/bin/bash
cd "$(dirname "$0")/.."
for p in payload.py payload_dark.py payload_rop.py payload_canary.py; do
  echo "--- $p ---"
  python3 "$p" | xxd
done
