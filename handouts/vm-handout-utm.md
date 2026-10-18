# Debian-VM mit UTM einrichten
IT-Systeme · Einheit 2 · Einrichtung für macOS

Voraussetzung: Mac mit mindestens 8 GB RAM, 25 GB freiem Speicher und Internetzugang. Ist Debian bereits installiert, beginnen Sie mit der Startkontrolle.

## Vorbereitung

1. UTM von [mac.getutm.app](https://mac.getutm.app/) laden, die DMG-Datei öffnen und UTM in den Programme-Ordner ziehen.
2. Prozessor ermitteln: **Apple-Menü → Über diesen Mac**.
3. Von der [Debian-Downloadseite](https://www.debian.org/releases/trixie/debian-installer/) die **netinst-ISO** laden: **arm64** für Apple Silicon (M1 bis M4), **amd64** für Intel.

## VM anlegen

1. UTM: **+ → Virtualisieren → Linux**.
2. **Apple Virtualization verwenden** ausgeschaltet lassen; die Aufgaben setzen QEMU voraus. **Boot from ISO image** wählen, die ISO auswählen.
3. **2048 MB** Arbeitsspeicher, **2** CPU-Kerne, **20 GB** Festplatte. Freigegebenen Ordner überspringen.
4. Name `IT-Systeme Debian`; nicht in einem iCloud-Ordner speichern.
5. **Bearbeiten → Netzwerk → Netzwerkmodus: Shared Network**. Speichern, VM starten.

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

**Host** ist Ihr Mac, **Gast** ist Debian im VM-Fenster.

| im Gast | Bedienung |
|---|---|
| Terminal | Anwendungen → Terminal-Emulator |
| Texteditor | Anwendungen → Zubehör → Mousepad |
| Browser | Anwendungen → Internet → Firefox ESR |
| Herunterfahren | Anwendungen → Abmelden → Herunterfahren |

Im Gast gilt **Strg** statt der Befehlstaste.

> **Startkontrolle:** Im Gast `https://www.debian.org/` öffnen. Im Terminal `sudo true` ausführen: Nach der Passworteingabe erscheint keine Fehlermeldung. Debian herunterfahren und neu starten.

## Hilfe

- **VM startet nicht:** Passt die ISO zum Prozessor? Ist **Virtualisieren** gewählt? Fehlermeldung notieren.
- **Installer startet erneut:** ISO auswerfen.
- **Maus bleibt im VM-Fenster:** Die Tastenkombination zur Freigabe zeigt UTM in der Werkzeugleiste des VM-Fensters.
- **`sudo`: student ist nicht in der sudoers-Datei:** Im Terminal `su -`, Root-Passwort, `usermod -aG sudo student`; ab- und wieder anmelden.
- **Einstellung gesperrt:** Debian vollständig herunterfahren.

[Debian-Installationsanleitung](https://www.debian.org/releases/trixie/arm64/ch06s03.en.html) · [UTM-Dokumentation](https://docs.getutm.app/)
