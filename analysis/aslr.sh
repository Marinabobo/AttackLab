#!/bin/bash
set -u
cd "$(dirname "$0")/.."
cc -O0 -o /tmp/aslr src/aslr.c
echo '===== normal runs: stack address is randomized ====='
for i in 1 2 3 4 5 6 7 8; do /tmp/aslr; done
echo
echo '===== under GDB: ASLR is disabled by default ====='
gdb -q -batch -ex 'set pagination off' -ex 'break main' -ex 'run' -ex 'print/x &i' /tmp/aslr
gdb -q -batch -ex 'set pagination off' -ex 'break main' -ex 'run' -ex 'print/x &i' /tmp/aslr
