#!/bin/bash
set -u
cd "$(dirname "$0")/.."
echo '===== dark-calc baseline ====='
printf '1+1\n' | ./attack/dark-calc; echo "exit=$?"
echo '===== dark-calc-nx baseline ====='
printf '1+1\n' | ./attack/dark-calc-nx; echo "exit=$?"
echo '===== dark-log baseline ====='
printf 'hello\n' | ./attack/dark-log; echo "exit=$?"
