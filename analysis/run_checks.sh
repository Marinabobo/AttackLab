#!/bin/bash
set -u
cd "$(dirname "$0")/.."
ulimit -c 0
run_case() {
  local script="$1" target="$2" expected="$3"
  echo "========== $script -> $target =========="
  python3 "$script" > /tmp/payload.bin
  echo "payload bytes: $(wc -c < /tmp/payload.bin)"
  ( cd attack && timeout 10s ./"$target" < /tmp/payload.bin > /tmp/out.txt 2> /tmp/err.txt )
  local st=$?
  echo "exit=$st"
  echo '--- stdout ---'
  cat -v /tmp/out.txt
  echo '--- stderr ---'
  cat -v /tmp/err.txt
  echo
  if grep -Fq -- "$expected" /tmp/out.txt; then
    echo "PASS: $script"
  else
    echo "FAIL: $script (missing: $expected)"
  fi
  echo
}
run_case payload.py dark-calc 'You have successfully detonated the bomb! Congratulations!'
run_case payload_dark.py dark-calc 'Hope A will be your grade!'
run_case payload_rop.py dark-calc-nx 'Hope A will be your grade!'
run_case payload_canary.py dark-log 'Hope A will be your grade!'
