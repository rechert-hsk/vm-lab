# Debian-VM mit VirtualBox einrichten
IT-Systeme · Einheit 2 · Einrichtung für Windows und macOS · Stand 17.10.2026

Sie richten eine Debian-VM ein. Mit ihr bearbeiten Sie anschließend die Aufgaben aus dem Handout „Virtuelle Maschinen in der Praxis“. Arbeiten Sie zu zweit oder zu dritt an einem Rechner. **Ist Debian mit Xfce bereits einsatzbereit, beginnen Sie mit der Startkontrolle.**

## Vorbereitung

1. Laden Sie [VirtualBox](https://www.virtualbox.org/wiki/Downloads) für Ihr Hostbetriebssystem herunter und installieren Sie das Basispaket.
2. Ermitteln Sie die Prozessorarchitektur. Windows: **Einstellungen → System → Info → Systemtyp**. macOS: **Apple-Menü → Über diesen Mac**.
3. Laden Sie auf der [Debian-Downloadseite](https://www.debian.org/releases/trixie/debian-installer/) eine **Debian-13-netinst-ISO** herunter:

| Hostprozessor | Passende ISO |
|---|---|
| Intel oder AMD, auch Intel-Mac | amd64 |
| Apple Silicon, z. B. M1/M2/M3/M4 | arm64 |
| Windows mit ARM-Prozessor | vor der Einrichtung mit der Lehrperson abstimmen |

Der Gruppenrechner braucht für diesen Aufbau **mindestens 8 GB RAM und etwa 25 GB freien Speicher**. Die Installation benötigt Internetzugang. Genügt Ihr Rechner nicht oder dürfen Sie keine Software installieren, schließen Sie sich einer Gruppe mit geeignetem Rechner an.

## VM anlegen

1. Öffnen Sie VirtualBox und wählen Sie **Neu**. Name: `IT-Systeme Debian`. Behalten Sie den vorgeschlagenen VM-Ordner, sofern er nicht in einem synchronisierten Cloud-Ordner wie OneDrive oder iCloud liegt.
2. Wählen Sie die heruntergeladene ISO. Betriebssystem: **Linux / Debian**, passend zur Architektur. Schalten Sie **Unbeaufsichtigte Installation** aus bzw. aktivieren Sie **Skip Unattended Installation**.
3. Stellen Sie **2048 MB RAM**, **2 Prozessoren** und eine neue **dynamisch belegte VDI-Festplatte mit 20 GB** ein. Lassen Sie die übrigen vorgeschlagenen Hardwarewerte stehen.
4. Prüfen Sie unter **Ändern → Netzwerk → Adapter 1**: Adapter aktiviert, **NAT**, **Kabel verbunden**. Speichern Sie die Einstellungen und starten Sie die VM.

<!-- seitenumbruch -->

## Debian installieren

1. Wählen Sie im Startmenü der VM **Graphical install**. Im textbasierten Installer wechseln Sie mit Tab zwischen Feldern, markieren mit der Leertaste und bestätigen mit Enter.
2. Wählen Sie **Deutsch**, Ihren Standort und das passende Tastaturlayout. Lassen Sie das Netzwerk automatisch einrichten. Rechnername: `it-systeme`; Domain: leer.
3. Lassen Sie das Root-Passwort leer. Der erste Benutzer erhält dann Administratorrechte über `sudo`; die Aufgaben setzen das voraus. Legen Sie den Benutzer `student` an und wählen Sie ein eigenes Übungspasswort.
4. Wählen Sie **Geführt - vollständige Festplatte verwenden**, die virtuelle Festplatte mit etwa **20 GB** und **Alle Dateien auf eine Partition**. Bestätigen Sie das Schreiben der Änderungen. Werden mehrere Festplatten angeboten, klären Sie die Auswahl vor dem Bestätigen mit der Lehrperson.
5. Weitere Installationsmedien: **Nein**. Netzwerkspiegel: **Deutschland**, dann `deb.debian.org`. HTTP-Proxy: leer. Die Teilnahme an der Paketverwendungsstatistik können Sie ablehnen.
6. Markieren Sie bei der Softwareauswahl **Debian-Desktop-Umgebung**, **Xfce** und **Standard-Systemwerkzeuge**. Wählen Sie GNOME und die übrigen Desktop-Umgebungen ab. Warten Sie, bis die Installation abgeschlossen ist.
7. Fragt der Installer nach dem Bootloader GRUB, installieren Sie ihn auf die virtuelle Festplatte. Beenden Sie die Installation und starten Sie neu. Erscheint erneut das Installationsmenü, werfen Sie die ISO im virtuellen CD/DVD-Laufwerk aus.
8. Melden Sie sich als `student` an. Erscheint eine Sitzungsauswahl, wählen Sie **Xfce**.

## Bedienung

**Host** ist Ihr Laptop mit Windows oder macOS. **Gast** ist Debian im VM-Fenster. Die Einstellungen der VM ändern Sie in VirtualBox auf dem Host, und nur bei vollständig heruntergefahrenem Gast.

| Tätigkeit im Gast | Bedienung |
|---|---|
| Terminal öffnen | **Anwendungen → Terminal-Emulator** |
| Programm starten | Menü **Anwendungen**, dort Zubehör, System oder Internet |
| Datei bearbeiten | **Anwendungen → Zubehör → Mousepad**; Strg+S speichert |
| Internetseite öffnen | **Anwendungen → Internet → Firefox ESR** |
| Gast herunterfahren | **Anwendungen → Abmelden → Herunterfahren** |

Im Gast gelten die Tastenkombinationen von Linux: Verwenden Sie auch auf einem Mac **Strg**.

> **Startkontrolle:** Öffnen Sie im Gast `https://www.debian.org/`. Öffnen Sie das Terminal und führen Sie `sudo true` aus; nach Eingabe Ihres Passworts darf keine Fehlermeldung erscheinen. Fahren Sie Debian herunter und starten Sie die VM erneut. Scheitert ein Schritt, nutzen Sie die Hilfe unten.

## Hilfe bei Problemen

- **Die VM startet nicht:** Prüfen Sie, ob die ISO zur Architektur passt. Notieren Sie die vollständige Fehlermeldung. Bei Hinweisen auf VT-x, AMD-V oder Hyper-V ziehen Sie die Lehrperson hinzu; ändern Sie BIOS- oder Windows-Sicherheitsoptionen nicht selbst.
- **Der Installer startet erneut:** Werfen Sie die ISO im virtuellen CD/DVD-Laufwerk aus. Die installierte virtuelle Festplatte bleibt eingebunden.
- **Maus oder Tastatur bleiben im VM-Fenster gefangen:** Die Taste zur Freigabe steht unten rechts im VM-Fenster; unter Windows ist es meist die rechte Strg-Taste.
- **`sudo` meldet, `student` sei nicht in der sudoers-Datei:** Bei der Installation wurde ein Root-Passwort gesetzt. Melden Sie sich im Terminal mit `su -` als `root` an, führen Sie `usermod -aG sudo student` aus und melden Sie sich ab und wieder an.
- **Eine Einstellung ist gesperrt:** Fahren Sie Debian vollständig herunter. Eine pausierte VM oder ein gespeicherter Zustand genügt nicht.
- **Ein Schritt scheitert weiterhin:** Notieren Sie Schritt, Einstellung und Fehlermeldung und ziehen Sie die Lehrperson hinzu.

## Dokumentation

[Debian-Installation](https://www.debian.org/releases/trixie/amd64/ch06s03.en.html) · [VirtualBox: VM anlegen](https://docs.oracle.com/en/virtualization/virtualbox/7.2/user/create-vm.html)
