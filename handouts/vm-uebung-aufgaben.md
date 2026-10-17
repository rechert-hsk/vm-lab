# Virtuelle Maschinen in der Praxis
IT-Systeme · Einheit 2 · Aufgaben für UTM und VirtualBox · Stand 17.10.2026

Sie untersuchen Ihre Debian-VM im Terminal und mit den Einstellungen des Virtualisierungsprogramms. Alle Gruppen bearbeiten den Pflichtteil; danach bearbeitet jede Gruppe ein Thema aus A bis E und stellt es vor.

Voraussetzung ist eine laufende VM nach dem Einrichtungs-Handout: Debian 13 mit Xfce, Benutzer `student`, 2048 MB RAM, 2 vCPUs, Netzwerk NAT (VirtualBox) bzw. Shared Network (UTM).

## Arbeitsweise

Arbeiten Sie zu zweit oder zu dritt und wechseln Sie nach jedem Auftrag die Person an der Tastatur.

Zu jedem Thema entstehen drei Produkte:

1. **Vorhersagekarte.** Vor jedem Versuch schreiben Sie Ihre Vorhersage auf und zeigen sie der Lehrperson. Danach wird die Vorhersage nicht mehr geändert.
2. **Messprotokoll.** Sie tragen jeden Messwert mit Einheit und dem Befehl ein, mit dem Sie ihn ermittelt haben. Ergänzen Sie Screenshots aus Ihrer VM.
3. **Regel für die Praxis.** Ein Satz, der aus Ihren Messungen folgt.

In der Präsentation führen Sie den Effekt an Ihrer VM vor. Danach stellt die Lehrperson eine Frage zu einer veränderten Situation; sie bestimmt, wer aus der Gruppe antwortet.

Jeder Befehlsblock ist mit **Gast** (Terminal in Debian) oder **Host** (Ihr Laptop) gekennzeichnet. Führen Sie Befehle nur dort aus.

<!-- seitenumbruch -->

## Das Terminal

Sie öffnen das Terminal in Debian über **Anwendungen → Terminal-Emulator**. Die Zeile `student@it-systeme:~$` ist die Eingabeaufforderung: Benutzer, Rechnername und aktueller Ordner; `~` steht für den persönlichen Ordner `/home/student`. Ein Befehl wird mit Enter ausgeführt.

| Befehl | Wirkung |
|---|---|
| `pwd` | zeigt den aktuellen Ordner |
| `ls -l` | listet die Dateien des aktuellen Ordners mit Größe und Datum |
| `cd ordner` | wechselt in einen Ordner; `cd` ohne Angabe wechselt in den persönlichen Ordner |
| `cat datei` | gibt den Inhalt einer Textdatei aus |
| `nano datei` | öffnet eine Datei im Editor; Strg+O speichert, Strg+X beendet |
| `sudo befehl` | führt einen Befehl mit Administratorrechten aus; fragt nach Ihrem Passwort |
| `sudo apt install -y paket` | installiert ein Paket aus den Debian-Quellen |
| `befehl &` | startet einen Befehl im Hintergrund; das Terminal bleibt bedienbar |

- Die Tab-Taste ergänzt angefangene Befehle und Dateinamen.
- Strg+C bricht den laufenden Befehl ab.
- Bei der Passworteingabe nach `sudo` erscheinen keine Zeichen.
- Eine Fehlermeldung nennt meist den Befehl und die Ursache, etwa `nano: command not found` oder `Permission denied`. Lesen Sie sie vollständig, bevor Sie den Befehl wiederholen.

Text kopieren Sie im Terminal mit Strg+Umschalt+C und fügen ihn mit Strg+Umschalt+V ein.

<!-- seitenumbruch -->

## Pflichtteil: Ressourcen einer VM dimensionieren

**Praxisfrage:** Wie viel CPU und Arbeitsspeicher kann ein Host seinen VMs geben?

### Ausgangswerte

**Gast:**

```bash
lscpu | head -8
nproc
free -m
lsblk
```

Notieren Sie Architektur, Anzahl der CPUs, Gesamtgröße des Arbeitsspeichers (Spalte `gesamt` bzw. `total`, Zeile `Speicher` bzw. `Mem`) und Größe der Festplatte `sda` bzw. `vda`.

Ermitteln Sie die Zahl der logischen Prozessoren des Hosts:

- **Host macOS:** Terminal öffnen, `sysctl -n hw.ncpu`
- **Host Windows:** Task-Manager → **Leistung** → **CPU** → Wert **Logische Prozessoren**

### Versuch 1: vCPUs unter Last

> **Vorhersage 1:** Die VM hat 2 vCPUs. Sie starten im Gast drei Programme, die jeweils ununterbrochen rechnen. Wie viel Rechenzeit erhält jedes Programm? Wie viele Kerne des Hosts belegt die VM?

1. Öffnen Sie auf dem Host die Prozessübersicht und sortieren Sie nach CPU-Last:
   - **macOS:** Aktivitätsanzeige → **CPU**. 100 % entsprechen einem vollständig belegten Kern.
   - **Windows:** Task-Manager → **Details**. Der Wert bezieht sich auf alle logischen Prozessoren zusammen; belegte Kerne = Wert × logische Prozessoren / 100.
2. Starten Sie im Gast ein Programm, das ohne Pause rechnet, und beobachten Sie die Last mit `top`. `top` beenden Sie mit `q`.

   **Gast:**

   ```bash
   yes > /dev/null &
   top
   ```

3. Lesen Sie in `top` die Spalte `%CPU` des Prozesses `yes` ab und auf dem Host die Last des Prozesses Ihres Virtualisierungsprogramms.
4. Wiederholen Sie Schritt 2 und 3 mit dem zweiten und dem dritten `yes`.
5. Beenden Sie alle Programme `yes`:

   **Gast:**

   ```bash
   pkill yes
   ```

| Programme `yes` im Gast | `%CPU` je `yes` im Gast | Last der VM auf dem Host | belegte Kerne des Hosts |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |

### Versuch 2: Arbeitsspeicher zuweisen und belegen

> **Vorhersage 2:** Sie erhöhen den Arbeitsspeicher der VM von 2048 auf 3072 MB. Welchen Wert zeigt `free -m` danach? Ein Programm im Gast belegt 1500 MB und wird beendet. Wie verändert sich der Speicherverbrauch der VM auf dem Host während des Programms und nach seinem Ende?

1. Fahren Sie Debian herunter: **Anwendungen → Abmelden → Herunterfahren**.
2. Stellen Sie den Arbeitsspeicher auf 3072 MB:
   - **VirtualBox:** **Ändern** → **System** → **Hauptplatine** → **Hauptspeicher**
   - **UTM:** VM auswählen → **Bearbeiten** → **System** → **Arbeitsspeicher**
3. Starten Sie die VM, öffnen Sie das Terminal und führen Sie `free -m` aus.
4. Lesen Sie auf dem Host den Speicherverbrauch des Prozesses Ihres Virtualisierungsprogramms ab:
   - **macOS:** Aktivitätsanzeige → **Speicher**
   - **Windows:** Task-Manager → **Details** → Spalte **Arbeitsspeicher**
5. Starten Sie im Gast ein Programm, das 1500 MB mit Zufallsdaten füllt und dann wartet:

   **Gast:**

   ```bash
   python3 -c "import os; x = os.urandom(1500*1024*1024); input('1500 MB belegt. Enter beendet das Programm.')"
   ```

6. Lesen Sie, solange das Programm wartet, `free -m` in einem zweiten Terminalfenster und den Verbrauch auf dem Host ab.
7. Beenden Sie das Programm mit Enter. Lesen Sie beide Werte erneut ab.

| Zeitpunkt | `free -m`: Spalte `benutzt`/`used` | Speicherverbrauch der VM auf dem Host |
|---|---|---|
| nach dem Start mit 3072 MB | | |
| Programm wartet | | |
| nach Programmende | | |

> **Ergebnis Pflichtteil:** Erklären Sie mit Ihren Messwerten, wer die Rechenzeit der vCPUs und den Arbeitsspeicher des Gasts bereitstellt. Formulieren Sie eine Regel, wie viele vCPUs und wie viel Arbeitsspeicher ein Host allen seinen VMs zusammen zuweisen kann, ohne dass eine VM auf Ressourcen wartet.

Lassen Sie 3072 MB eingestellt, wenn Ihr Host mindestens 8 GB RAM hat; sonst stellen Sie 2048 MB wieder ein.

<!-- seitenumbruch -->

## Thema A: Speicher und Sicherung

**Praxisfrage:** Wo liegen die Daten einer VM, wie viel Platz braucht sie, und was muss gesichert werden?

Die Image-Datei Ihrer VM finden Sie so:

- **VirtualBox:** **Ändern** → **Massenspeicher** → Festplatte mit der Endung **.vdi** auswählen; der Pfad steht unter **Ort**. Standardordner: `~/VirtualBox VMs/IT-Systeme Debian/` (macOS) bzw. `C:\Users\<Name>\VirtualBox VMs\IT-Systeme Debian\` (Windows).
- **UTM:** Rechtsklick auf die VM → **Im Finder zeigen**. Rechtsklick auf die `.utm`-Datei → **Paketinhalt zeigen** → Ordner `Data`; die Image-Datei hat die Endung **.qcow2**.

Die Größe der Image-Datei messen Sie auf dem Host:

- **macOS** (Terminal; Pfad durch Ziehen der Datei ins Terminalfenster einfügen):

  ```bash
  du -h <Pfad zur Image-Datei>
  ```

- **Windows:** Rechtsklick auf die Datei → **Eigenschaften** → **Größe auf Datenträger**

### Versuch 1: Gastsicht und Hostsicht

> **Vorhersage A1:** Der Gast schreibt eine Datei mit 2000 MB und löscht sie wieder. Wie groß ist die Image-Datei nach dem Schreiben und nach dem Löschen?

1. Messen Sie im Gast Größe und Belegung des Dateisystems und auf dem Host die Größe der Image-Datei.

   **Gast:**

   ```bash
   lsblk
   df -h /
   ```

2. Schreiben Sie im Gast 2000 MB Zufallsdaten in eine Datei. `sync` wartet, bis der Gast die Daten an seine Festplatte übergeben hat.

   **Gast:**

   ```bash
   dd if=/dev/urandom of=~/gross.dat bs=1M count=2000 status=progress
   sync
   ```

3. Messen Sie erneut im Gast (`df -h /`) und auf dem Host.
4. Löschen Sie die Datei und messen Sie erneut.

   **Gast:**

   ```bash
   rm ~/gross.dat
   sync
   df -h /
   ```

| Zeitpunkt | Festplatte im Gast (`lsblk`) | belegt im Gast (`df -h /`) | Image-Datei auf dem Host |
|---|---|---|---|
| Ausgang | | | |
| nach dem Schreiben | | | |
| nach dem Löschen | | | |

### Versuch 2: Gastdaten in der Image-Datei

> **Vorhersage A2:** Sie speichern im Gast eine Textdatei und fahren die VM herunter. Finden Sie den Text auf dem Host, ohne die VM zu starten?

1. Erzeugen Sie im Gast eine Datei mit einer Zeichenkette, die nur Ihre Gruppe kennt, und fahren Sie Debian herunter.

   **Gast:**

   ```bash
   echo "MARKE-$RANDOM$RANDOM" | tee ~/marke.txt
   sync
   ```

   Notieren Sie die ausgegebene Zeichenkette.

2. Durchsuchen Sie auf dem Host die Image-Datei nach der Zeichenkette:

   - **macOS:**

     ```bash
     LC_ALL=C grep -a -o "MARKE-12345678" <Pfad zur Image-Datei>
     ```

   - **Windows** (Eingabeaufforderung `cmd`):

     ```
     findstr /m /c:"MARKE-12345678" "<Pfad zur Image-Datei>"
     ```

   Ersetzen Sie `MARKE-12345678` durch Ihre Zeichenkette. Die Suche dauert je nach Größe der Image-Datei bis zu einigen Minuten.

> **Ergebnis A:** Erklären Sie mit Ihren Messwerten, wie die Image-Datei wächst und warum sie beim Löschen im Gast nicht kleiner wird. Begründen Sie, welche Datei eine Sicherung der VM enthalten muss, wie viel Platz sie auf dem Sicherungsziel braucht und warum die VM während der Sicherung ausgeschaltet ist. Leiten Sie aus Versuch 2 ab, wer die Daten einer VM lesen kann.

<!-- seitenumbruch -->

## Thema B: Snapshot vor einer riskanten Änderung

Nur mit VirtualBox.

**Praxisfrage:** Wie sichern Sie eine riskante Änderung an einer VM ab, und wovor schützt ein Snapshot nicht?

Ein **Snapshot** hält den Zustand einer VM zu einem Zeitpunkt fest. Die Image-Datei bleibt danach unverändert; alle späteren Änderungen speichert der Hypervisor in einer eigenen Datei.

Ihr VM-Ordner ist `~/VirtualBox VMs/IT-Systeme Debian/` (macOS) bzw. `C:\Users\<Name>\VirtualBox VMs\IT-Systeme Debian\` (Windows). Größen messen Sie wie in Thema A: auf macOS mit `du -h`, auf Windows über **Eigenschaften**.

### Versuch

1. **Ausgangszustand festhalten.** Notieren Sie die Ausgaben.

   **Gast:**

   ```bash
   echo "Version 1" > ~/vm-notiz.txt
   cat ~/vm-notiz.txt
   ls ~
   command -v firefox-esr
   ```

   Fahren Sie Debian herunter. Notieren Sie auf dem Host Größe und Änderungsdatum der `.vdi`-Datei im VM-Ordner und den Inhalt des Unterordners `Snapshots`.

2. **Snapshot anlegen.** Wählen Sie im VirtualBox-Hauptfenster die VM, öffnen Sie über das Menüsymbol neben dem VM-Namen die Ansicht **Snapshots** und wählen Sie **Erstellen**. Name: `Ausgangszustand`. Notieren Sie auf dem Host erneut den Inhalt des Ordners `Snapshots` mit Dateinamen und Größen.

> **Vorhersage B:** Sie ändern danach eine Datei, legen eine neue an, entfernen Firefox und schreiben 500 MB. Welche Datei auf dem Host wächst? Was ist nach einem normalen Neustart vorhanden, was nach dem Zurücksetzen auf den Snapshot?

3. **Ändern.** Starten Sie die VM.

   **Gast:**

   ```bash
   echo "Version 2" > ~/vm-notiz.txt
   touch ~/nachher.txt
   sudo apt purge -y firefox-esr
   dd if=/dev/urandom of=~/gross.dat bs=1M count=500 status=progress
   sync
   ```

4. **Neustart.** Starten Sie Debian über das Menü neu und führen Sie die Befehle aus Schritt 1 ohne die erste Zeile erneut aus. Fahren Sie herunter und messen Sie auf dem Host die `.vdi`-Datei im VM-Ordner und die Datei im Ordner `Snapshots`.
5. **Zurücksetzen.** Wählen Sie in der Ansicht **Snapshots** den Snapshot `Ausgangszustand` und **Wiederherstellen**. Entfernen Sie im folgenden Dialog das Häkchen bei der Sicherung des aktuellen Zustands. Messen Sie auf dem Host erneut.
6. **Prüfen.** Starten Sie die VM und führen Sie die Befehle aus Schritt 1 ohne die erste Zeile aus.

| Zeitpunkt | `vm-notiz.txt` | `nachher.txt` | Firefox | `.vdi` im VM-Ordner | Datei in `Snapshots` |
|---|---|---|---|---|---|
| vor dem Snapshot | | | | | — |
| nach dem Snapshot | | | | | |
| nach Änderung und Neustart | | | | | |
| nach dem Zurücksetzen | | | | | |

> **Ergebnis B:** Erklären Sie mit Ihren Messwerten, welche Datei die Änderungen nach dem Snapshot aufnimmt und was beim Zurücksetzen mit ihr geschieht. Begründen Sie, warum ein Snapshot keine Datensicherung ersetzt.

Löschen Sie nach der Präsentation den Snapshot über **Snapshots → Löschen**, damit Ihre VM wieder aus einer einzigen Image-Datei besteht.

<!-- seitenumbruch -->

## Thema C: Einen Dienst in der VM bereitstellen

**Praxisfrage:** Wer erreicht einen Webserver in der VM, und wovon hängt das ab?

Die Netzwerkanbindung der VM legt fest, mit welchem Netz die virtuelle Netzwerkkarte des Gasts verbunden ist:

- *NAT* (VirtualBox) bzw. *Shared Network* (UTM): Der Gast erreicht über den Host das Internet; Verbindungen von außen zum Gast stellt das Virtualisierungsprogramm nur nach ausdrücklicher Einrichtung her.
- *Host-only*: Gast und Host sind über ein virtuelles Netz verbunden, das nur auf dem Host existiert. Es hat keinen Weg ins Internet.
- *Port-Weiterleitung* (VirtualBox, NAT): Das Virtualisierungsprogramm leitet Verbindungen an einen Port des Hosts an einen Port des Gasts weiter.

### Vorbereitung: Webserver mit eigener Startseite

**Gast:**

```bash
sudo apt install -y nginx
systemctl status nginx
```

`systemctl status` zeigt `active (running)`, wenn der Webserver läuft; beenden Sie die Anzeige mit `q`. Schreiben Sie eine eigene Startseite:

**Gast:**

```bash
sudo nano /var/www/html/index.html
```

Inhalt, mit Ihren Namen:

```html
<h1>Bürgerportal – Gruppe [Namen]</h1>
```

Öffnen Sie im Gast Firefox mit `http://localhost`. Die Seite muss Ihre Überschrift zeigen.

### Versuch

> **Vorhersage C:** Für jede Netzwerkanbindung: Erreicht der Gast das Internet? Erreicht der Browser des Hosts Ihre Startseite?

Führen Sie in jeder Anbindung dieselben drei Messungen aus:

**Gast:**

```bash
ip -br addr
wget -q --spider https://www.debian.org && echo "Internet erreichbar" || echo "Internet nicht erreichbar"
```

**Host:** Browser öffnen, `http://<IPv4-Adresse des Gasts>` aufrufen. Die IPv4-Adresse steht in der Zeile `enp…` vor dem `/`.

Die Anbindung ändern Sie bei heruntergefahrener VM:

- **VirtualBox:** **Ändern** → **Netzwerk** → **Adapter 1** → **Angeschlossen an**. Für Host-only: Windows **Host-only Adapter**, macOS **Host-Only Network**; ist kein Netz vorhanden, legen Sie es unter **Datei → Werkzeuge → Netzwerkmanager** an.
- **UTM:** **Bearbeiten** → **Netzwerk** → **Netzwerkmodus**.

Reihenfolge:

1. Ausgangsanbindung (VirtualBox: NAT; UTM: Shared Network)
2. **Nur VirtualBox:** NAT mit Port-Weiterleitung. **Ändern** → **Netzwerk** → **Adapter 1** → **Erweitert** → **Port-Weiterleitung**, Regel hinzufügen: Protokoll TCP, Host-Port `8080`, Gast-Port `80`, IP-Felder leer. Auf dem Host zusätzlich `http://localhost:8080` aufrufen.
3. Host-only
4. Zurück zur Ausgangsanbindung

| Anbindung | IPv4-Adresse des Gasts | Gast → Internet | Host → Startseite (Adresse) |
|---|---|---|---|
| NAT bzw. Shared Network | | | |
| NAT mit Port-Weiterleitung (nur VirtualBox) | | | |
| Host-only | | | |

> **Ergebnis C:** Erklären Sie mit Ihren Messwerten, in welcher Richtung jede Anbindung Verbindungen zulässt. Begründen Sie, welche Anbindung die Stadtverwaltung für eine VM wählt, deren Webserver nur vom Host aus erreichbar sein soll, und welche für eine VM, die Updates aus dem Internet laden muss.

<!-- seitenumbruch -->

## Thema D: Gasterweiterungen und Isolation

Je eine Gruppe mit VirtualBox und mit UTM.

**Praxisfrage:** Was leisten Gasterweiterungen, und welche Verbindungen zwischen Gast und Host öffnen sie?

**Gasterweiterungen** sind Treiber und Dienste im Gast, die mit dem Hypervisor zusammenarbeiten. Sie werden im Gast installiert. VirtualBox nennt sie *Guest Additions*; unter UTM übernehmen die Pakete `spice-vdagent` und `qemu-guest-agent` diese Aufgabe.

> **Vorhersage D:** Welche Funktionen ändern sich nach der Installation? Kann der Gast nach dem Einrichten eines gemeinsamen Ordners eine Datei auf dem Host löschen?

### Schritt 1: Vorher messen

1. **Nur VirtualBox:** Stellen Sie bei heruntergefahrener VM **Ändern** → **Allgemein** → **Erweitert** → **Gemeinsame Zwischenablage** auf **bidirektional**. Unter UTM ist die gemeinsame Zwischenablage unter **Bearbeiten** → **Freigabe** voreingestellt.
2. Starten Sie die VM und führen Sie aus:

   **Gast:**

   ```bash
   ps -e | grep -i -E "vbox|spice|qemu-ga"
   xrandr --current | grep "\*"
   ```

   `ps -e` listet die laufenden Prozesse; `xrandr` zeigt die aktuelle Bildschirmauflösung des Gasts.

3. Vergrößern Sie das VM-Fenster und führen Sie `xrandr --current | grep "\*"` erneut aus.
4. Kopieren Sie auf dem Host einen Text und versuchen Sie, ihn im Gast in Mousepad (**Anwendungen → Zubehör → Mousepad**) einzufügen.

### Schritt 2: Installieren

**VirtualBox, Gast:**

```bash
sudo apt install -y build-essential linux-headers-$(uname -r) bzip2
```

Wählen Sie im VM-Fenster **Geräte → Gasterweiterungen einlegen**. Dann:

**Gast:**

```bash
sudo mount /dev/sr0 /mnt
ls /mnt
```

Führen Sie auf Intel/AMD `sudo sh /mnt/VBoxLinuxAdditions.run` aus, auf Apple Silicon die Datei mit `arm64` im Namen. Der Installer übersetzt Kernelmodule für den laufenden Kernel; das dauert einige Minuten. Starten Sie danach mit `sudo reboot` neu.

**UTM, Gast:**

```bash
sudo apt install -y spice-vdagent qemu-guest-agent
sudo reboot
```

### Schritt 3: Nachher messen

Wiederholen Sie Schritt 1, Punkte 2 bis 4. Führen Sie unter VirtualBox zusätzlich `lsmod | grep vbox` aus; der Befehl listet die geladenen Kernelmodule von VirtualBox.

| Messung | vorher | nachher |
|---|---|---|
| Prozesse (`ps -e`) | | |
| Auflösung, kleines Fenster | | |
| Auflösung, großes Fenster | | |
| Text Host → Gast | | |

### Schritt 4: Gemeinsamer Ordner

Legen Sie auf dem Host einen Ordner `vm-austausch` mit einer Textdatei `vom-host.txt` an.

**VirtualBox:** **Geräte → Gemeinsame Ordner → Einstellungen** → Ordner hinzufügen: Pfad zum Ordner `vm-austausch`, Name `austausch`, **Automatisch einbinden** und **Permanent** aktivieren. Der Benutzer `student` braucht die Gruppe `vboxsf`:

**Gast:**

```bash
sudo usermod -aG vboxsf student
sudo reboot
```

Nach dem Neustart liegt der Ordner unter `/media/sf_austausch`.

**UTM:** Bei heruntergefahrener VM **Bearbeiten** → **Freigabe** → **Verzeichnisfreigabe-Modus**: **VirtFS**. Starten Sie die VM, wählen Sie über das Ordnersymbol in der Fensterleiste den Ordner `vm-austausch` und binden Sie ihn ein:

**Gast:**

```bash
sudo mkdir -p /media/austausch
sudo mount -t 9p -o trans=virtio,version=9p2000.L share /media/austausch
```

**Versuch, VirtualBox, Gast:**

```bash
ls -l /media/sf_austausch
cat /media/sf_austausch/vom-host.txt
echo "Im Gast geschrieben" > /media/sf_austausch/vom-gast.txt
rm /media/sf_austausch/vom-host.txt
```

**Versuch, UTM, Gast:** Unter UTM schreibt nur `root` in den Ordner; `tee` übernimmt deshalb das Schreiben mit `sudo`.

```bash
ls -l /media/austausch
cat /media/austausch/vom-host.txt
echo "Im Gast geschrieben" | sudo tee /media/austausch/vom-gast.txt
sudo rm /media/austausch/vom-host.txt
```

Prüfen Sie nach jedem Befehl den Ordner auf dem Host.

### Schritt 5: Verbindungen schließen

Fahren Sie die VM herunter und ändern Sie:

- **VirtualBox:** **Gemeinsame Zwischenablage** auf **deaktiviert**; beim gemeinsamen Ordner **Nur lesbar** aktivieren.
- **UTM:** unter **Freigabe** die gemeinsame Zwischenablage abschalten und **Schreibgeschützt** aktivieren.

Starten Sie die VM, binden Sie unter UTM den Ordner erneut ein und wiederholen Sie den Zwischenablage-Test und den Schreibbefehl mit `echo`. Notieren Sie die Fehlermeldung.

> **Ergebnis D:** Erklären Sie mit Ihren Messwerten, welche Funktionen die Gasterweiterungen bereitstellen und welche Komponente im Gast sie umsetzt. Ordnen Sie jeder Funktion zu, in welche Richtung Daten zwischen Gast und Host fließen und wie die Verbindung geschlossen wird. Begründen Sie, welche Einstellungen eine VM erhält, in der ein Dokument unbekannter Herkunft geöffnet werden soll.

<!-- seitenumbruch -->

## Thema E: Performance

**Praxisfrage:** Welche Arbeitslasten laufen in einer VM so schnell wie auf dem Host, und welche nicht?

`time` misst die Laufzeit eines Programms in drei Werten:

- *real:* vergangene Zeit von Start bis Ende
- *user:* Rechenzeit der CPU im User Mode
- *sys:* Rechenzeit der CPU im Kernel Mode, etwa für System Calls

### Programme holen

**Gast:**

```bash
cd ~
wget -O vm-lab.tar.gz https://github.com/rechert-hsk/vm-lab/archive/refs/heads/main.tar.gz
tar xzf vm-lab.tar.gz
cd vm-lab-main/code/performance
ls
python3 --version
```

Lesen Sie jedes Programm mit `cat` und beschreiben Sie in einem Satz, was es tut:

| Programm | Was es tut |
|---|---|
| `rechnen.py` | |
| `systemaufrufe.py` | |
| `schreiben.py` | |

> **Vorhersage E1:** Welcher der drei Werte `real`, `user`, `sys` ist bei jedem Programm der größte? Bei welchem Programm erwarten Sie, dass `real` deutlich größer ist als `user` + `sys`?

### Versuch 1: Drei Arbeitslasten im Gast

Schließen Sie auf dem Host alle anderen Programme und schließen Sie das Netzteil an. Führen Sie jedes Programm dreimal aus und tragen Sie den mittleren der drei Werte (Median) ein.

**Gast:**

```bash
time python3 rechnen.py
time python3 systemaufrufe.py
time python3 schreiben.py
```

| Programm | real | user | sys |
|---|---|---|---|
| `rechnen.py` | | | |
| `systemaufrufe.py` | | | |
| `schreiben.py` | | | |

### Versuch 2: Vergleich mit dem Host

Nur, wenn auf dem Host Python 3 installiert ist. Laden Sie die Programme auf dem Host von `https://github.com/rechert-hsk/vm-lab` herunter (**Code → Download ZIP**) und notieren Sie die Python-Version (`python3 --version`).

- **macOS, Terminal:** `time python3 rechnen.py`, ebenso `systemaufrufe.py` und `schreiben.py`
- **Windows, PowerShell:** `Measure-Command { python rechnen.py }`, ebenso `schreiben.py`. `systemaufrufe.py` liest `/dev/zero` und läuft unter Windows nicht.

| Programm | real im Gast | real auf dem Host | Python-Version Gast / Host |
|---|---|---|---|
| `rechnen.py` | | | |
| `systemaufrufe.py` | | | |
| `schreiben.py` | | | |

Ein Unterschied der Python-Versionen verändert die Laufzeit unabhängig von der Virtualisierung. Unter `schreiben.py` vergleichen Sie zusätzlich zwei Betriebssysteme, deren `fsync` unterschiedlich arbeitet.

### Versuch 3 (optional): Emulation einer fremden ISA

`qemu-user` führt ein einzelnes Programm einer anderen ISA aus, indem es dessen Befehle emuliert. Wählen Sie die fremde Architektur nach Ihrem Gast (`uname -m`):

| Gast `uname -m` | `FREMD` | `QEMU` |
|---|---|---|
| `aarch64` | `amd64` | `qemu-x86_64` |
| `x86_64` | `arm64` | `qemu-aarch64` |

> **Vorhersage E3:** Dieselbe Schleife läuft einmal als Programm für die ISA des Gasts und einmal emuliert. Um welchen Faktor unterscheiden sich die Laufzeiten?

**Gast** (Werte für `FREMD` und `QEMU` aus der Tabelle):

```bash
FREMD=amd64
QEMU=qemu-x86_64
sudo apt install -y qemu-user busybox-static
sudo dpkg --add-architecture $FREMD
sudo apt update
apt download busybox-static:$FREMD
dpkg-deb -x busybox-static_*_$FREMD.deb fremd
file /bin/busybox fremd/bin/busybox
$QEMU fremd/bin/busybox uname -m
```

`file` zeigt die ISA der beiden Programmdateien. Messen Sie dann dreimal je Variante:

```bash
SCHLEIFE='i=0; while [ $i -lt 2000000 ]; do i=$((i+1)); done'
time busybox sh -c "$SCHLEIFE"
time $QEMU fremd/bin/busybox sh -c "$SCHLEIFE"
```

| Variante | real | user | sys |
|---|---|---|---|
| eigene ISA | | | |
| emuliert | | | |

> **Ergebnis E:** Erklären Sie mit Ihren Messwerten, warum `rechnen.py` im Gast fast so schnell läuft wie auf dem Host. Begründen Sie, bei welchem Programm der Hypervisor beteiligt ist und bei welchem nur der Gastkernel. Leiten Sie ab, welche Anwendungen der Stadtverwaltung in einer VM ohne messbare Einbußen laufen und bei welchen die Leistung vor dem Umzug in eine VM gemessen werden muss.

<!-- seitenumbruch -->

## Präsentation

Jede Gruppe hat 5 Minuten.

1. Praxisfrage
2. Vorhersage von der Karte
3. Vorführung des Effekts an Ihrer VM
4. Messprotokoll mit den entscheidenden Werten
5. Regel für die Praxis in einem Satz

Danach beantwortet ein von der Lehrperson bestimmtes Gruppenmitglied eine Frage zu einer veränderten Situation.

## Hilfe bei Problemen

- **Eine Einstellung ist gesperrt:** Fahren Sie Debian vollständig herunter. Eine pausierte VM oder ein gespeicherter Zustand genügt nicht.
- **Ein Befehl hängt:** Brechen Sie ihn mit Strg+C ab.
- **`sudo` meldet, `student` sei nicht in der sudoers-Datei:** Bei der Installation wurde ein Root-Passwort gesetzt. Melden Sie sich mit `su -` als `root` an und führen Sie `usermod -aG sudo student` aus; danach ab- und wieder anmelden.
- **`apt` meldet, eine Sperre sei belegt:** Debian installiert im Hintergrund Updates. Warten Sie eine Minute und wiederholen Sie den Befehl.
- **Die VM startet nach einer Änderung nicht mehr:** Stellen Sie die zuletzt geänderte Einstellung zurück. Notieren Sie Schritt und Fehlermeldung und ziehen Sie die Lehrperson hinzu.

## Dokumentation

[Debian-Referenz](https://www.debian.org/doc/manuals/debian-reference/) · [VirtualBox-Handbuch](https://docs.oracle.com/en/virtualization/virtualbox/7.2/user/) · [UTM-Dokumentation](https://docs.getutm.app/)
