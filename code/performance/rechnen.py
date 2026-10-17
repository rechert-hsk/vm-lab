# Rechnet nur im User Mode: Die Schleife enthält keinen System Call.
N = 50_000_000

summe = 0
for i in range(N):
    summe += i * i % 7

print("Ergebnis:", summe)
