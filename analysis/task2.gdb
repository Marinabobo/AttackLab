set pagination off
set confirm off
set disassembly-flavor intel
file ./attack/dark-calc
break *0x401a87
run < /tmp/payload_dark.bin
printf "\n===== Task 2: enter grade_eval from stack shellcode =====\n"
info registers rip rdi rsp rbp
printf "rsp mod 16 = "
p/x ((unsigned long)$rsp % 16)
x/4i $rip
printf "\nstack around entry:\n"
x/6gx $rsp-16
