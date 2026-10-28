set pagination off
set confirm off
set disassembly-flavor intel
file ./attack/dark-log
break *0x4017db
run < /tmp/payload_canary.bin
printf "\n===== Task 4: after memcpy, before canary check =====\n"
printf "f.len (rbp-0x20): "
x/1dw $rbp-0x20
printf "canary (rbp-0x8): "
x/1gx $rbp-8
printf "fs:0x28:          "
p/x *(unsigned long*)($fs_base+0x28)
printf "saved rbp / ret:  \n"
x/2gx $rbp
x/4i $rip
printf "\n===== Task 4: canary check passed, grade_eval entered =====\n"
delete breakpoints
break *0x401677
run < /tmp/payload_canary.bin
info registers rip rdi rsp rbp
printf "rsp mod 16 = "
p/x ((unsigned long)$rsp % 16)
x/4i $rip
