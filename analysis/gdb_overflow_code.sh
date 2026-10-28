#!/bin/bash
set -u
cd "$(dirname "$0")/.."
python3 - <<'PY'
open('/tmp/in20.txt','wb').write(b'A'*20+b'\n')
open('/tmp/in32.txt','wb').write(b'A'*32+b'\n')
open('/tmp/in1.txt','wb').write(b'1+1\n')
PY
gdb -q -batch ./attack/dark-calc -x analysis/overflow_code.gdb

echo
echo '===== runtime: 20 chars ====='
set +e
timeout 3 ./attack/dark-calc < /tmp/in20.txt > /tmp/o20.txt 2> /tmp/e20.txt
echo "exit=$?"
echo '-- stdout --'; cat -v /tmp/o20.txt
echo '-- stderr --'; cat -v /tmp/e20.txt

echo
echo '===== runtime: 32 chars ====='
timeout 3 ./attack/dark-calc < /tmp/in32.txt > /tmp/o32.txt 2> /tmp/e32.txt
echo "exit=$?"
echo '-- stdout --'; cat -v /tmp/o32.txt
echo '-- stderr --'; cat -v /tmp/e32.txt
