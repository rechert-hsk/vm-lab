# Rechnet in einer Schleife 50 Millionen Mal mit ganzen Zahlen.
N = 50_000_000

summe = 0
for i in range(N):
    summe += i * i % 7

print("Ergebnis:", summe)
