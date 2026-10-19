# Liest 1 Million Mal 64 KiB aus /dev/zero.
import os

N = 1_000_000
BLOCK = 65536

fd = os.open("/dev/zero", os.O_RDONLY)
for _ in range(N):
    os.read(fd, BLOCK)
os.close(fd)

print("Gelesene Blöcke:", N)
