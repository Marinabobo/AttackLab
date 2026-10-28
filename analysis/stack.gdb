set pagination off
set confirm off
set disassembly-flavor intel
set print pretty off

printf "\n===== [1] stop at input+8 (0x40197f) =====\n"
break *0x40197f
run < /tmp/in1.txt
printf "\n-- registers --\n"
info registers rip rbp rsp
printf "\n-- backtrace --\n"
bt
printf "\n-- stack around input frame (buffer at rbp-0x10) --\n"
x/8gx $rbp-0x10
printf "\n-- code just before stop --\n"
x/7i $rip-9

printf "\n===== [2] step from main's call instruction into input =====\n"
delete breakpoints
break *0x401ac7
run < /tmp/in1.txt
printf "\n-- before main's mov/call --\n"
info registers rip rbp rsp
x/4gx $rsp
si
printf "\n-- after mov eax,0 --\n"
info registers rip
si
printf "\n-- after call input: return address pushed at old rsp-8 --\n"
info registers rip rbp rsp
x/6gx $rsp
si
printf "\n-- after input's push rbp --\n"
info registers rip rbp rsp
x/6gx $rsp
si
printf "\n-- after mov rbp,rsp --\n"
info registers rip rbp rsp
si
printf "\n-- after sub rsp,0x10 --\n"
info registers rip rbp rsp
x/6gx $rbp-0x10

printf "\n===== [3] step over leave and ret =====\n"
delete breakpoints
break *0x4019d5
run < /tmp/in1.txt
printf "\n-- before leave --\n"
info registers rip rbp rsp
x/6gx $rbp-0x10
si
printf "\n-- after leave (rsp=old rbp, saved rbp popped) --\n"
info registers rip rbp rsp
x/4gx $rsp-8
si
printf "\n-- after ret (back in main) --\n"
info registers rip rbp rsp
x/4gx $rsp
