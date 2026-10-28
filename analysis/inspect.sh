#!/bin/bash
set -u
cd "$(dirname "$0")/.."
chmod +x attack/*
file attack/*
echo '===== SECURITY ====='
for f in attack/dark-calc attack/dark-calc-nx attack/dark-log; do
  echo "--- $f ---"
  readelf -hW "$f" | grep Type
  readelf -lW "$f" | grep -E 'GNU_STACK|GNU_RELRO'
  readelf -dW "$f" | grep -E 'BIND_NOW' || true
done
echo '===== SYMBOLS ====='
for f in attack/dark-calc attack/dark-calc-nx attack/dark-log; do
  echo "--- $f ---"
  nm -n "$f" | grep -E ' (T|t|D|d|B|b) '
done
echo '===== STRINGS ====='
for f in attack/dark-calc attack/dark-calc-nx attack/dark-log attack/malware; do
  echo "--- $f ---"
  strings -a "$f"
done
