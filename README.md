# vm-lab

Übungsmaterial zu virtuellen Maschinen für die Vorlesung IT-Systeme. Die Studierenden installieren Debian 13 mit Xfce in UTM (macOS) oder VirtualBox (Windows, macOS) und untersuchen ihre VM überwiegend im Terminal.

## Inhalt

- `handouts/` – Handouts für Studierende
  - `vm-uebung-aufgaben.md` – Aufgaben für beide Programme: Pflichtteil und Themen A bis E
  - `vm-handout-utm.md` – Einrichtung und Aufgaben mit UTM
  - `vm-handout-vbox.md` – Einrichtung und Aufgaben mit VirtualBox
- `code/performance/` – Programme für die Performance-Messung im Gast, Aufruf mit `time`
  - `rechnen.py` – Rechenschleife ohne System Calls
  - `systemaufrufe.py` – viele System Calls ohne Gerätezugriff
  - `schreiben.py` – kleine Schreibzugriffe mit `fsync`
  - `emulation.sh` – Skizze: dasselbe Programm nativ und als fremde ISA mit `qemu-user`

Stand: in Vorbereitung, im Gast noch nicht getestet.
