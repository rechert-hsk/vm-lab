# Debian-VM mit UTM einrichten
IT-Systeme · Einheit 2 · Einrichtung für macOS · Stand 17.10.2026

Sie richten eine Debian-VM ein. Mit ihr bearbeiten Sie anschließend die Aufgaben aus dem Handout „Virtuelle Maschinen in der Praxis“. Arbeiten Sie zu zweit oder zu dritt an einem Rechner. **Ist Debian mit Xfce bereits einsatzbereit, beginnen Sie mit der Startkontrolle.**

## Vorbereitung

1. Laden Sie UTM über den kostenlosen **Download** auf der [UTM-Webseite](https://mac.getutm.app/) herunter. Öffnen Sie die DMG-Datei und ziehen Sie UTM in den Programme-Ordner.
2. Ermitteln Sie den Prozessor: **Apple-Menü → Über diesen Mac**.
3. Laden Sie auf der [Debian-Downloadseite](https://www.debian.org/releases/trixie/debian-installer/) eine **Debian-13-netinst-ISO** herunter:

| Hostprozessor | Passende ISO |
|---|---|
| Apple Silicon, z. B. M1/M2/M3/M4 | arm64 |
| Intel | amd64 |

Der Gruppenrechner braucht für diesen Aufbau **mindestens 8 GB RAM und etwa 25 GB freien Speicher**. Die Installation benötigt Internetzugang. Genügt Ihr Rechner nicht oder dürfen Sie keine Software installieren, schließen Sie sich einer Gruppe mit geeignetem Rechner an.

## VM anlegen

1. Öffnen Sie UTM und wählen Sie **+ → Virtualisieren/Virtualize → Linux**.
2. Lassen Sie **Apple Virtualization verwenden/Use Apple Virtualization** ausgeschaltet; UTM verwendet dann QEMU, das die Aufgaben voraussetzen. Wählen Sie **Boot from ISO image** und die heruntergeladene ISO.
3. Stellen Sie **2048 MB RAM**, **2 CPU-Kerne** und eine neue virtuelle Festplatte mit **20 GB** ein. Überspringen Sie den freigegebenen Ordner.
4. Speichern Sie die VM unter dem Namen `IT-Systeme Debian` lokal auf dem Mac, nicht in einem iCloud-Ordner.
5. Öffnen Sie **Bearbeiten → Netzwerk** und wählen Sie als **Netzwerkmodus/Network Mode** die Option **Shared Network**. Lassen Sie die übrigen Geräte unverändert. Speichern Sie und starten Sie die VM.

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

**Host** ist Ihr Mac. **Gast** ist Debian im VM-Fenster. Die Einstellungen der VM ändern Sie in UTM auf dem Host, und nur bei vollständig heruntergefahrenem Gast.

| Tätigkeit im Gast | Bedienung |
|---|---|
| Terminal öffnen | **Anwendungen → Terminal-Emulator** |
| Programm starten | Menü **Anwendungen**, dort Zubehör, System oder Internet |
| Datei bearbeiten | **Anwendungen → Zubehör → Mousepad**; Strg+S speichert |
| Internetseite öffnen | **Anwendungen → Internet → Firefox ESR** |
| Gast herunterfahren | **Anwendungen → Abmelden → Herunterfahren** |

Im Gast gelten die Tastenkombinationen von Linux: Verwenden Sie **Strg** statt der Befehlstaste.

> **Startkontrolle:** Öffnen Sie im Gast `https://www.debian.org/`. Öffnen Sie das Terminal und führen Sie `sudo true` aus; nach Eingabe Ihres Passworts darf keine Fehlermeldung erscheinen. Fahren Sie Debian herunter und starten Sie die VM erneut. Scheitert ein Schritt, nutzen Sie die Hilfe unten.

## Hilfe bei Problemen

- **Die VM startet nicht:** Prüfen Sie, ob Sie **Virtualisieren** gewählt haben und die ISO zum Prozessor passt. Notieren Sie die vollständige Fehlermeldung.
- **Der Installer startet erneut:** Werfen Sie die ISO im virtuellen CD/DVD-Laufwerk aus. Die installierte virtuelle Festplatte bleibt eingebunden.
- **Maus oder Tastatur bleiben im VM-Fenster gefangen:** UTM zeigt die Tastenkombination zur Freigabe in der Werkzeugleiste des VM-Fensters an.
- **`sudo` meldet, `student` sei nicht in der sudoers-Datei:** Bei der Installation wurde ein Root-Passwort gesetzt. Melden Sie sich im Terminal mit `su -` als `root` an, führen Sie `usermod -aG sudo student` aus und melden Sie sich ab und wieder an.
- **Eine Einstellung ist gesperrt:** Fahren Sie Debian vollständig herunter. Eine pausierte VM genügt nicht.
- **Ein Schritt scheitert weiterhin:** Notieren Sie Schritt, Einstellung und Fehlermeldung und ziehen Sie die Lehrperson hinzu.

## Dokumentation

[Debian-Installation](https://www.debian.org/releases/trixie/arm64/ch06s03.en.html) · [UTM: System](https://docs.getutm.app/settings-qemu/system/) · [UTM: Netzwerk](https://docs.getutm.app/settings-qemu/devices/network/network/)
