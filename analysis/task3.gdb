set pagination off
set confirm off
set disassembly-flavor intel
file ./attack/dark-calc-nx
break *0x401978
run < /tmp/payload_rop.bin
printf "\n===== Task 3: enter grade_eval through ROP =====\n"
info registers rip rdi rsp rbp
printf "rsp mod 16 = "
p/x ((unsigned long)$rsp % 16)
x/4i $rip
