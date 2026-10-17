# Schreibt kleine Blöcke und erzwingt nach jedem Block mit fsync das Schreiben auf das Gerät.
import os

N = 2_000
BLOCK = b"x" * 4096
DATEI = "schreibtest.dat"

fd = os.open(DATEI, os.O_WRONLY | os.O_CREAT | os.O_TRUNC)
for _ in range(N):
    os.write(fd, BLOCK)
    os.fsync(fd)
os.close(fd)
os.remove(DATEI)

print("Blöcke geschrieben:", N)
