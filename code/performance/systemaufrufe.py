# Liest 5 Millionen Mal ein Byte aus /dev/zero.
import os

N = 5_000_000

fd = os.open("/dev/zero", os.O_RDONLY)
for _ in range(N):
    os.read(fd, 1)
os.close(fd)

print("Gelesene Bytes:", N)
