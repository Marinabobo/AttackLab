#!/bin/bash
set -u
cd "$(dirname "$0")/.."
printf '1+1\n' > /tmp/in1.txt
gdb -q -batch ./attack/dark-calc -x analysis/stack.gdb
