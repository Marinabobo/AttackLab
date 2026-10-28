set pagination off
set confirm off
set disassembly-flavor intel
file ./attack/dark-calc
break *0x401a6b
run < /tmp/payload.bin
printf "\n===== Task 1: hijacked return reaches eval's system() call site =====\n"
info registers rip rdi rsp rbp
printf "command_buf = "
x/s 0x6030d0
printf "\nstack:\n"
x/6gx $rsp
printf "\ninstructions:\n"
x/4i $rip
