# Debian-VM mit VirtualBox einrichten
IT-Systeme · Einheit 2 · Einrichtung für Windows und macOS

Voraussetzung: Rechner mit mindestens 8 GB RAM, 25 GB freiem Speicher und Internetzugang. Ist Debian bereits installiert, beginnen Sie mit der Startkontrolle.

## Vorbereitung

1. [VirtualBox](https://www.virtualbox.org/wiki/Downloads) für Ihr Betriebssystem laden und installieren.
2. Prozessor ermitteln: Windows **Einstellungen → System → Info → Systemtyp**; macOS **Apple-Menü → Über diesen Mac**.
3. Von der [Debian-Downloadseite](https://www.debian.org/releases/trixie/debian-installer/) die **netinst-ISO** laden: **amd64** für Intel und AMD, **arm64** für Apple Silicon. Bei Windows mit ARM-Prozessor vorher die Lehrperson fragen.

## VM anlegen

1. VirtualBox: **Neu**, Name `IT-Systeme Debian`. Der VM-Ordner liegt nicht in OneDrive oder iCloud.
2. ISO auswählen, Typ **Linux / Debian**. **Unbeaufsichtigte Installation** ausschalten.
3. **2048 MB** Arbeitsspeicher, **2** Prozessoren, neue **dynamisch belegte VDI-Festplatte mit 20 GB**.
4. **Ändern → Netzwerk → Adapter 1**: aktiviert, **NAT**. VM starten.

## Debian installieren

1. **Graphical install**. Im Installer: Tab wechselt das Feld, Leertaste markiert, Enter bestätigt.
2. Sprache **Deutsch**, Standort und Tastatur passend. Rechnername `it-systeme`, Domain leer.
3. Root-Passwort **leer lassen**; dann erhält der erste Benutzer Administratorrechte über `sudo`. Benutzer `student` mit eigenem Passwort anlegen.
4. **Geführt - vollständige Festplatte verwenden**, die 20-GB-Festplatte, **Alle Dateien auf eine Partition**, Änderungen schreiben.
5. Weitere Installationsmedien **Nein**, Spiegel **Deutschland → deb.debian.org**, Proxy leer.
6. Softwareauswahl: **Debian-Desktop-Umgebung**, **Xfce**, **Standard-Systemwerkzeuge**; GNOME abwählen.
7. GRUB auf die virtuelle Festplatte installieren, neu starten. Erscheint wieder der Installer: ISO im CD/DVD-Laufwerk der VM auswerfen.
8. Als `student` anmelden, Sitzung **Xfce**.

## Bedienung

**Host** ist Ihr Laptop, **Gast** ist Debian im VM-Fenster.

| im Gast | Bedienung |
|---|---|
| Terminal | Anwendungen → Terminal-Emulator |
| Texteditor | Anwendungen → Zubehör → Mousepad |
| Browser | Anwendungen → Internet → Firefox ESR |
| Herunterfahren | Anwendungen → Abmelden → Herunterfahren |

Im Gast gilt auch auf dem Mac **Strg**.

> **Startkontrolle:** Im Gast `https://www.debian.org/` öffnen. Im Terminal `sudo true` ausführen: Nach der Passworteingabe erscheint keine Fehlermeldung. Debian herunterfahren und neu starten.

## Hilfe

- **VM startet nicht:** Passt die ISO zum Prozessor? Fehlermeldung notieren. Bei Meldungen zu VT-x, AMD-V oder Hyper-V die Lehrperson fragen; BIOS- und Windows-Sicherheitseinstellungen nicht selbst ändern.
- **Installer startet erneut:** ISO auswerfen.
- **Maus bleibt im VM-Fenster:** Die Host-Taste steht unten rechts im VM-Fenster; Standard ist unter Windows die rechte Strg-Taste, auf dem Mac die linke Befehlstaste.
- **`sudo`: student ist nicht in der sudoers-Datei:** Im Terminal `su -`, Root-Passwort, `usermod -aG sudo student`; ab- und wieder anmelden.
- **Einstellung gesperrt:** Debian vollständig herunterfahren.

[Debian-Installationsanleitung](https://www.debian.org/releases/trixie/amd64/ch06s03.en.html) · [VirtualBox-Handbuch](https://docs.oracle.com/en/virtualization/virtualbox/7.2/user/)
