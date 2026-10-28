set pagination off
set confirm off
set disassembly-flavor intel

printf "\n===== [A] 20-character input: stop right after gets =====\n"
break *0x40199f
run < /tmp/in20.txt
printf "\n-- rbp / saved rbp / return address --\n"
info registers rbp rsp
x/6gx $rbp-0x10
printf "\nsaved rbp = "
x/1gx $rbp
printf "return address = "
x/1gx $rbp+8

printf "\n===== [B] 32-character input: stop right after gets =====\n"
delete breakpoints
break *0x40199f
run < /tmp/in32.txt
printf "\n-- rbp / saved rbp / return address --\n"
info registers rbp rsp
x/6gx $rbp-0x10
printf "\nsaved rbp = "
x/1gx $rbp
printf "return address = "
x/1gx $rbp+8

printf "\n===== [C] main's first three instructions in memory =====\n"
delete breakpoints
break *0x401ac3
run < /tmp/in1.txt
printf "\n-- bytes starting at main (0x401ac3) --\n"
x/20xb 0x401ac3
printf "\n-- first four instructions --\n"
x/4i 0x401ac3
printf "\n-- rip before each single step --\n"
info registers rip
si
info registers rip
si
info registers rip
si
info registers rip
si
info registers rip
