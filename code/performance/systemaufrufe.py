# Führt viele System Calls aus, aber ohne Gerätezugriff:
# Jedes os.read ist ein read-Aufruf an den Kernel; /dev/zero liefert Nullbytes aus dem Kernel.
import os

N = 5_000_000

fd = os.open("/dev/zero", os.O_RDONLY)
for _ in range(N):
    os.read(fd, 1)
os.close(fd)

print("System Calls:", N)
