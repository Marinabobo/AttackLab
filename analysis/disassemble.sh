#!/bin/bash
set -u
cd "$(dirname "$0")/.."
mkdir -p analysis/disasm
for f in dark-calc dark-calc-nx dark-log; do
  objdump -d -M intel "attack/$f" > "analysis/disasm/$f.asm"
  readelf -sW "attack/$f" > "analysis/disasm/$f.syms"
  objdump -s -j .rodata "attack/$f" > "analysis/disasm/$f.rodata"
done
echo '===== dark-calc ====='
sed -n '/<input>:/,/<eval>:/p' analysis/disasm/dark-calc.asm
sed -n '/<eval>:/,/<grade_eval>:/p' analysis/disasm/dark-calc.asm
sed -n '/<grade_eval>:/,/<main>:/p' analysis/disasm/dark-calc.asm
sed -n '/<main>:/,/<init_fixed_stack>:/p' analysis/disasm/dark-calc.asm
sed -n '/<init_fixed_stack>:/,/<__wrap_main>:/p' analysis/disasm/dark-calc.asm
sed -n '/<__wrap_main>:/,/<__libc_csu_init>:/p' analysis/disasm/dark-calc.asm
echo '===== dark-calc-nx ====='
sed -n '/<input>:/,/<eval>:/p' analysis/disasm/dark-calc-nx.asm
sed -n '/<eval>:/,/<grade_eval>:/p' analysis/disasm/dark-calc-nx.asm
sed -n '/<grade_eval>:/,/<main>:/p' analysis/disasm/dark-calc-nx.asm
sed -n '/<main>:/,/<__libc_csu_init>:/p' analysis/disasm/dark-calc-nx.asm
sed -n '/<__libc_csu_init>:/,/<__libc_csu_fini>:/p' analysis/disasm/dark-calc-nx.asm
echo '===== dark-log ====='
sed -n '/<grade_eval>:/,/<input>:/p' analysis/disasm/dark-log.asm
sed -n '/<input>:/,/<main>:/p' analysis/disasm/dark-log.asm
sed -n '/<main>:/,/<__libc_csu_init>:/p' analysis/disasm/dark-log.asm
