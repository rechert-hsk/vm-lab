# Virtuelle Maschinen in der Praxis
IT-Systeme · Einheit 2 · Aufgaben für UTM und VirtualBox

**Gast:** Terminal in Debian (**Anwendungen → Terminal-Emulator**). **Host:** Ihr Laptop.

- Tab ergänzt Befehle und Dateinamen.
- Strg+C bricht einen Befehl ab; `q` beendet `top`.
- Strg+Umschalt+C und Strg+Umschalt+V kopieren und fügen im Terminal ein.
- `sudo` führt einen Befehl mit Administratorrechten aus und fragt nach Ihrem Passwort; die Eingabe bleibt unsichtbar.
- `&` am Ende eines Befehls startet ihn im Hintergrund.

## 1 · vCPU und Arbeitsspeicher

Die VM hat 2 vCPUs und 2048 MB Arbeitsspeicher.

> **Aufgabe 1:** Drei Programme rechnen im Gast ohne Pause. Welchen Anteil einer vCPU erhält jedes, und wie viele Kerne des Hosts belegt die VM?

1. Gast: `yes > /dev/null &`, dann `top`; Spalte `%CPU` ablesen.
2. Host: Last des VM-Prozesses ablesen.
3. Schritte 1 und 2 für das zweite und dritte `yes` wiederholen, danach Gast: `pkill yes`.

| Programme `yes` | `%CPU` je `yes` | Kerne des Hosts |
|---|---|---|
| 1 | | |
| 2 | | |
| 3 | | |

> **Aufgabe 2:** Ein Programm im Gast belegt 1500 MB Arbeitsspeicher und endet. Wie ändert sich der Speicherverbrauch der VM auf dem Host?

4. Debian herunterfahren, Arbeitsspeicher auf 3072 MB stellen, VM starten.
5. Gast: `python3 -c "import os; x = os.urandom(1500*1024*1024); input('Enter beendet')"`
6. Host: Speicher des VM-Prozesses vor Schritt 5, während das Programm wartet und nach Enter ablesen.

| vor dem Programm | Programm wartet | nach dem Programm |
|---|---|---|
| | | |

> **Ergebnis:** Ab welcher Summe der zugewiesenen vCPUs ist ein Host überbucht, und was merkt eine VM davon? Erhält der Host Arbeitsspeicher zurück, den der Gast freigibt?

## 2 · Image-Datei

Die Festplatte des Gasts ist eine Datei im Dateisystem des Hosts.

> **Aufgabe 1:** Der Gast schreibt eine Datei mit 2000 MB und löscht sie wieder. Wie groß ist die Image-Datei nach dem Schreiben und nach dem Löschen?

1. Gast: `df -h /`. Host: Größe der Image-Datei.
2. Gast: `dd if=/dev/urandom of=~/gross.dat bs=1M count=2000 && sync`. Beide Größen messen.
3. Gast: `rm ~/gross.dat && sync`. Beide Größen messen.

| | belegt im Gast | Image-Datei |
|---|---|---|
| Ausgang | | |
| nach `dd` | | |
| nach `rm` | | |

> **Aufgabe 2:** Lässt sich eine Datei des Gasts auf dem Host lesen, ohne die VM zu starten?

4. Gast: `echo "MARKE-$RANDOM$RANDOM" | tee ~/marke.txt && sync`. Debian herunterfahren.
5. Host: Image-Datei nach der ausgegebenen Marke durchsuchen.

> **Ergebnis:** Welche Datei muss eine Sicherung der VM enthalten, und wie viel Platz braucht sie? Wer kann die Daten der VM lesen?

## 3 · Snapshot

Nur VirtualBox.

Ein **Snapshot** hält den Zustand einer VM zu einem Zeitpunkt fest. Die Image-Datei bleibt danach unverändert; alle späteren Änderungen speichert der Hypervisor in einer eigenen Datei.

> **Aufgabe:** Nach dem Snapshot ändert der Gast eine Datei, entfernt Firefox und schreibt 500 MB. Welche Datei auf dem Host wächst, und was ist nach dem Zurücksetzen auf den Snapshot noch vorhanden?

1. Gast: `echo "Version 1" > ~/notiz.txt`. Debian herunterfahren. Host: Größe der `.vdi`-Dateien im VM-Ordner und im Unterordner `Snapshots`.
2. Snapshot `Ausgangszustand` erstellen. Host: wie in Schritt 1.
3. Gast: `echo "Version 2" > ~/notiz.txt && sudo apt purge -y firefox-esr && dd if=/dev/urandom of=~/gross.dat bs=1M count=500 && sync`. Debian herunterfahren. Host: wie in Schritt 1.
4. Snapshot wiederherstellen, den aktuellen Zustand dabei nicht sichern. Host: wie in Schritt 1.
5. Gast: `cat ~/notiz.txt; command -v firefox-esr; ls -l ~/gross.dat`

| | `.vdi` im VM-Ordner | `.vdi` in `Snapshots` |
|---|---|---|
| vor dem Snapshot | | |
| nach dem Snapshot | | |
| nach der Änderung | | |
| nach dem Zurücksetzen | | |

> **Ergebnis:** Welche Datei nimmt die Änderungen auf, und was geschieht beim Zurücksetzen mit ihr? Warum ersetzt ein Snapshot keine Datensicherung?

## 4 · Netzwerkanbindung

* *NAT* (VirtualBox) bzw. *Shared Network* (UTM): Der Gast erreicht über den Host das Internet.
* *Host-only:* Gast und Host sind über ein virtuelles Netz verbunden, das nur auf dem Host besteht und keinen Weg ins Internet hat.
* *Port-Weiterleitung:* Der Hypervisor leitet Verbindungen an einen Port des Hosts an einen Port des Gasts weiter.

> **Aufgabe:** Erreicht der Gast das Internet, und erreicht der Host einen Webserver im Gast? Antworten Sie für jede Anbindung der Tabelle.

1. Gast: `sudo apt install -y nginx`
2. Gast: `ip -br addr` (IPv4-Adresse in der Zeile `enp…`) und `wget -q --spider https://www.debian.org && echo ja || echo nein`
3. Host: Browser, `http://<IPv4-Adresse des Gasts>`
4. Debian herunterfahren, Anbindung wechseln, Schritte 2 und 3 wiederholen. Bei Port-Weiterleitung ruft der Host `http://localhost:8080` auf.
5. Ausgangsanbindung wiederherstellen.

| Anbindung | IPv4-Adresse | Gast → Internet | Host → Webserver |
|---|---|---|---|
| NAT bzw. Shared Network | | | |
| NAT mit Port-Weiterleitung 8080 → 80 (nur VirtualBox) | | | |
| Host-only | | | |

> **Ergebnis:** In welche Richtung lässt jede Anbindung Verbindungen zu? Welche Anbindung erhält eine VM, deren Webserver nur der Host erreichen soll und die keinen Internetzugang braucht?

## 5 · Gasterweiterungen und gemeinsamer Ordner

**Gasterweiterungen** sind Treiber und Dienste im Gast, die mit dem Hypervisor zusammenarbeiten. Ein **gemeinsamer Ordner** ist ein Ordner des Hosts, den der Hypervisor dem Gast bereitstellt.

> **Aufgabe 1:** Welche Prozesse kommen mit den Gasterweiterungen hinzu, und was ändert sich an der Zwischenablage?

1. Zwischenablage auf beidseitig stellen. Gast: `ps -e | grep -i -E "vbox|spice"`. Einen Text auf dem Host kopieren und im Gast in Mousepad einfügen.
2. Gasterweiterungen installieren:
   - VirtualBox, Gast: `sudo apt install -y build-essential linux-headers-$(uname -r) bzip2`. Dann **Geräte → Gasterweiterungen einlegen** und Gast: `sudo mount /dev/sr0 /mnt && sudo sh /mnt/VBoxLinuxAdditions.run`; auf Apple Silicon die `.run`-Datei mit `arm64` im Namen (`ls /mnt`).
   - UTM, Gast: `sudo apt install -y spice-vdagent`
3. Gast: `sudo reboot`. Schritt 1 wiederholen.

> **Aufgabe 2:** Kann der Gast eine Datei im gemeinsamen Ordner löschen, und was ändert ein schreibgeschützter Ordner?

4. Host: Ordner `austausch` mit einer Datei `host.txt` anlegen und für die VM freigeben.
5. Gast: `D=/media/sf_austausch` (VirtualBox) bzw. `D=/media/austausch` (UTM), dann:

   ```bash
   sudo cat $D/host.txt
   echo "aus dem Gast" | sudo tee $D/gast.txt
   sudo rm $D/host.txt
   ```

   Host: Ordner `austausch` nach jedem Befehl ansehen.
6. Debian herunterfahren, Ordner schreibgeschützt freigeben, VM starten, Schritt 5 wiederholen.

| | `cat` | `tee` | `rm` |
|---|---|---|---|
| Ordner beschreibbar | | | |
| Ordner schreibgeschützt | | | |

> **Ergebnis:** In welche Richtung fließen Daten über die Zwischenablage und über den gemeinsamen Ordner? Welche Einstellungen erhält eine VM, in der ein Dokument unbekannter Herkunft geöffnet wird?

## 6 · Laufzeit im Gast

`time befehl` misst drei Werte:

* *real:* vergangene Zeit von Start bis Ende
* *user:* Rechenzeit im User Mode
* *sys:* Rechenzeit im Kernel Mode, etwa für System Calls

1. Gast:

   ```bash
   wget -O vm-lab.tar.gz https://github.com/rechert-hsk/vm-lab/archive/refs/heads/main.tar.gz
   tar xzf vm-lab.tar.gz && cd vm-lab-main/code/performance
   cat rechnen.py systemaufrufe.py schreiben.py
   ```

> **Aufgabe 1:** Welcher der Werte `real`, `user` und `sys` ist bei jedem Programm der größte?

2. Gast: `time python3 rechnen.py`, ebenso `systemaufrufe.py` und `schreiben.py`; jedes Programm dreimal, den mittleren Wert eintragen.

| Programm | real | user | sys |
|---|---|---|---|
| `rechnen.py` | | | |
| `systemaufrufe.py` | | | |
| `schreiben.py` | | | |

> **Ergebnis 1:** Bei welchem Programm arbeitet der Gast nur im User Mode, bei welchem arbeitet der Gastkernel, und bei welchem ist der Hypervisor beteiligt? Welche Anwendungen der Stadtverwaltung bremst die Virtualisierung am stärksten?

**Optional: Emulation.** `qemu-user` führt ein Programm einer fremden ISA aus, indem es dessen Befehle emuliert.

> **Aufgabe 2:** Um welchen Faktor ist dieselbe Schleife emuliert langsamer?

3. Gast: `bash emulation.sh`. Das Skript zeigt die ISA beider Programme und misst die Schleife nativ und emuliert.

| | real |
|---|---|
| nativ | |
| emuliert | |

> **Ergebnis 2:** Warum läuft `rechnen.py` in der VM ohne Emulation?

## Host

| Tätigkeit | macOS | Windows |
|---|---|---|
| logische Prozessoren | Terminal: `sysctl -n hw.ncpu` | Task-Manager → Leistung → CPU |
| Last und Speicher des VM-Prozesses | Aktivitätsanzeige → CPU bzw. Speicher; 100 % = ein Kern | Task-Manager → Details; Kerne = CPU-Wert × logische Prozessoren / 100 |
| Größe einer Datei | Terminal: `du -h <Datei>` | Rechtsklick → Eigenschaften → Größe auf Datenträger |
| Text in einer Datei suchen | Terminal: `LC_ALL=C grep -a -o "MARKE-…" <Datei>` | `cmd`: `findstr /m /c:"MARKE-…" "<Datei>"` |

Einen Dateipfad fügen Sie im Terminal von macOS ein, indem Sie die Datei ins Fenster ziehen.

## Einstellungen

Einstellungen der VM ändern Sie nur bei heruntergefahrenem Gast.

| Einstellung | VirtualBox | UTM |
|---|---|---|
| Arbeitsspeicher | Ändern → System → Hauptplatine | Bearbeiten → System |
| Image-Datei | Ändern → Massenspeicher → `.vdi`-Datei, Feld Ort | Rechtsklick auf die VM → Im Finder zeigen → Paketinhalt zeigen → `Data` → `.qcow2`-Datei |
| Netzwerkanbindung | Ändern → Netzwerk → Adapter 1 → Angeschlossen an; Host-only fehlt: Datei → Werkzeuge → Netzwerkmanager | Bearbeiten → Netzwerk → Netzwerkmodus |
| Port-Weiterleitung | Adapter 1 → Erweitert → Port-Weiterleitung: TCP, Host-Port 8080, Gast-Port 80 | — |
| Snapshot | Menüsymbol neben dem VM-Namen → Snapshots → Erstellen bzw. Wiederherstellen | — |
| Zwischenablage | Ändern → Allgemein → Erweitert → Gemeinsame Zwischenablage | Bearbeiten → Freigabe |
| Gemeinsamer Ordner | Geräte → Gemeinsame Ordner: Name `austausch`, Automatisch einbinden; Nur lesbar | Bearbeiten → Freigabe → Verzeichnisfreigabe-Modus VirtFS; Ordner über das Ordnersymbol im VM-Fenster wählen; Schreibgeschützt. Gast: `sudo mkdir -p /media/austausch && sudo mount -t 9p -o trans=virtio,version=9p2000.L share /media/austausch` |

## Hilfe

- **Eine Einstellung ist gesperrt:** Debian vollständig herunterfahren; eine pausierte VM genügt nicht.
- **`apt` meldet eine Sperre:** Debian installiert im Hintergrund Updates. Eine Minute warten, Befehl wiederholen.
- **Die VM startet nach einer Änderung nicht:** Die zuletzt geänderte Einstellung zurückstellen und die Lehrperson hinzuziehen.
