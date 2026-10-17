# Virtuelle Maschinen mit UTM
IT-Systeme · Einheiten 1 und 2 · Arbeitsblatt für macOS · Stand 17.10.2026

Sie richten eine Debian-VM ein, ändern ihre Hardware und Netzwerkanbindung und ordnen eine Gastdatei dem Festplattenabbild auf dem Host zu. Halten Sie Ihre Beobachtungen in den Ergebnisfeldern fest.

**Arbeiten Sie zu zweit oder zu dritt.** Wechseln Sie nach jedem Auftrag die Person an der Tastatur. Die Einrichtung erfolgt vor der Aufgabenphase. **Ist Debian mit Xfce bereits einsatzbereit, beginnen Sie auf Seite 3.** Planen Sie für die drei Aufträge und den Abschluss etwa 60 Minuten; die Snapshot-Demonstration erfolgt gemeinsam.

## Vorbereitung

1. Laden Sie UTM über den kostenlosen **Download** auf der [UTM-Webseite](https://mac.getutm.app/) herunter. Öffnen Sie die DMG-Datei und ziehen Sie UTM in den Programme-Ordner.
2. Öffnen Sie **Apple-Menü → Über diesen Mac**. Ermitteln Sie den Prozessor.
3. Laden Sie auf der [Debian-Downloadseite](https://www.debian.org/releases/trixie/debian-installer/) eine **Debian-13-netinst-ISO** herunter:

| Hostprozessor | Passende ISO |
|---|---|
| Apple Silicon, z. B. M1/M2/M3/M4 | arm64 |
| Intel | amd64 |

Für diesen Aufbau ist ein Gruppenrechner mit **mindestens 8 GB RAM und etwa 25 GB freiem Speicher** vorgesehen. Die Installation benötigt Internetzugang. Wenn Softwareinstallationen nicht erlaubt sind oder die Ausstattung nicht genügt, schließen Sie sich einer Gruppe mit geeignetem Rechner an.

## VM anlegen

1. Öffnen Sie UTM und wählen Sie **+ → Virtualisieren/Virtualize → Linux**.
2. Lassen Sie **Apple Virtualization verwenden/Use Apple Virtualization** ausgeschaltet. Der Aufbau verwendet QEMU mit Hardwarevirtualisierung. Wählen Sie **Boot from ISO image** und die heruntergeladene ISO.
3. Stellen Sie **2048 MB RAM**, **2 CPU-Kerne** und eine neue virtuelle Festplatte mit **20 GB** ein. Überspringen Sie den freigegebenen Ordner.
4. Speichern Sie die VM unter dem Namen `IT-Systeme Debian`. Speichern Sie sie lokal auf dem Mac.
5. Öffnen Sie **Bearbeiten → Netzwerk** und wählen Sie als **Network Mode** die Option **Shared Network**. Lassen Sie die übrigen Geräte unverändert. Speichern Sie und starten Sie die VM.

**20 GB** ist die Kapazität der virtuellen Festplatte. Das Festplattenabbild im UTM-Paket enthält später Debian, Programme, Einstellungen und Ihre Gastdateien.

<!-- seitenumbruch -->

## Debian installieren

1. Starten Sie die VM. Wählen Sie **Graphical install**. Im textbasierten Installer wechseln Sie mit Tab zwischen Feldern, markieren mit der Leertaste und bestätigen mit Enter.
2. Wählen Sie **Deutsch**, Ihren Standort und das passende Tastaturlayout. Lassen Sie das Netzwerk automatisch einrichten. Rechnername: `it-systeme`; Domain: leer.
3. Lassen Sie das Root-Passwort leer. Legen Sie den Benutzer `student` an und wählen Sie ein eigenes Übungspasswort. Merken Sie es sich.
4. Wählen Sie **Geführt - vollständige Festplatte verwenden**, die virtuelle Festplatte mit etwa **20 GB** und **Alle Dateien auf eine Partition**. Bestätigen Sie das Schreiben der Änderungen. Falls mehrere Festplatten angeboten werden, klären Sie vor dem Bestätigen die Auswahl mit der Lehrperson.
5. Weitere Installationsmedien: **Nein**. Netzwerkspiegel: **Deutschland**, dann `deb.debian.org`. HTTP-Proxy: leer. Die Teilnahme an der Paketverwendungsstatistik können Sie ablehnen.
6. Markieren Sie bei der Softwareauswahl **Debian-Desktop-Umgebung**, **Xfce** und **Standard-Systemwerkzeuge**. Wählen Sie GNOME und die übrigen Desktop-Umgebungen ab. Warten Sie, bis die Installation abgeschlossen ist.
7. Falls nach dem Bootloader GRUB gefragt wird, installieren Sie ihn auf die virtuelle Systemfestplatte. Beenden Sie die Installation und starten Sie neu. Falls erneut das Installationsmenü erscheint, werfen Sie die ISO im virtuellen optischen Laufwerk aus.
8. Melden Sie sich als `student` an. Falls eine Sitzungsauswahl erscheint, wählen Sie **Xfce**.

## Die ersten Schritte im Gast

**Host** ist Ihr Laptop mit Windows oder macOS. **Gast** ist Debian im VM-Fenster. Die Einstellungen der VM öffnen Sie im Virtualisierungsprogramm auf dem Host.

| Tätigkeit im Gast | Bedienung |
|---|---|
| Programm starten | Menü **Anwendungen** öffnen; dort Zubehör, System oder Internet wählen |
| Datei bearbeiten | **Zubehör → Mousepad** bzw. **Texteditor** öffnen; mit Strg+S speichern |
| Ordner öffnen | Auf **Persönlicher Ordner** doppelklicken |
| Internetseite öffnen | **Internet → Firefox ESR** starten |
| Gast herunterfahren | **Anwendungen → Abmelden → Herunterfahren** wählen |

> **Startkontrolle:** Öffnen Sie eine Internetseite. Speichern Sie im Texteditor eine Datei im persönlichen Ordner. Fahren Sie Debian herunter, starten Sie die VM wieder und öffnen Sie die Datei. Wenn einer dieser Schritte scheitert, verwenden Sie die Hilfe auf Seite 5.

Für Tastenkombinationen im Gast verwenden Sie **Strg**, auch auf einem Mac. Arbeiten Sie zunächst im Fenster. Ändern Sie VM-Hardware und Netzwerkmodus erst, wenn Debian vollständig heruntergefahren ist.

<!-- seitenumbruch -->

## Auftrag 1: Arbeitsspeicher zuweisen

**Ziel:** Prüfen Sie, wie eine Einstellung außerhalb des Gasts die im Gast verfügbare Hardware verändert.

1. Öffnen Sie im Gast **Anwendungen → System → Taskmanager**. Zeigen Sie mit der Maus auf die Speicheranzeige und lesen Sie die Gesamtgröße ab. Notieren Sie den Wert mit Einheit.
2. Fahren Sie Debian herunter. Öffnen Sie die VM-Einstellungen über **Bearbeiten → System → Arbeitsspeicher**. Notieren Sie den bisherigen Wert und ändern Sie **2048 auf 3072 MB**.
3. Starten Sie die VM und lesen Sie die Gesamtgröße im Gast erneut ab. Fahren Sie danach herunter und stellen Sie den Ausgangswert wieder her.

**Falls die Anzeige nur Prozentwerte zeigt:** Öffnen Sie Mousepad, wählen Sie **Datei → Öffnen**, drücken Sie im Dateidialog Strg+L und geben Sie `/proc/meminfo` ein. Lesen Sie den Wert hinter `MemTotal` ab. Diese vom System bereitgestellte Anzeige wird nur gelesen.

> **Ergebnis 1:** Notieren Sie die beiden VM-Einstellungen und die zugehörigen Gastanzeigen. Erklären Sie, wer die zusätzliche Speichermenge bereitstellt. Die Gastanzeige darf wegen reservierter Bereiche etwas kleiner ausfallen.
<!-- antwort:ram|44|Einstellung und Gastanzeige vorher/nachher; Erklärung -->

## Auftrag 2: Gastdatei und Festplattenabbild zuordnen

**Ziel:** Verfolgen Sie, wo ein im Gast gespeichertes Dokument auf dem Host liegt.

1. Starten Sie Debian. Schreiben Sie in Mousepad `Diese Datei wurde im Gast gespeichert.` und speichern Sie als `vm-notiz.txt` direkt im persönlichen Ordner. Der Gastpfad lautet `/home/student/vm-notiz.txt`.
2. Fahren Sie Debian herunter. Ermitteln Sie auf dem Host die eingebundene Systemfestplatte: Öffnen Sie **Bearbeiten** und wählen Sie unter **Laufwerke/Drives** die Systemfestplatte. Notieren Sie den Image-Namen. Öffnen Sie über das Kontextmenü der VM **Im Finder zeigen**. Klicken Sie im Finder mit der rechten Maustaste auf die **.utm**-Datei und wählen Sie **Paketinhalt zeigen**. Suchen Sie im Ordner **Data** nach dem zuvor notierten Festplattenabbild.
3. Notieren Sie den Namen und den Hostpfad des Abbilds. Betrachten Sie die Dateien nur; lassen Sie Namen, Speicherorte und Inhalte unverändert.
4. Starten Sie Debian und öffnen Sie `vm-notiz.txt` erneut.

> **Ergebnis 2:** Halten Sie Gastpfad und Hostpfad fest. Erklären Sie, weshalb Sie die Textdatei auf dem Host nicht als einzelne Datei im VM-Ordner sehen. Welche Rolle hat die heruntergeladene ISO nach der Installation?
<!-- antwort:disk|55|Gastpfad; Hostpfad; Erklärung zur Image-Datei und ISO -->

<!-- seitenumbruch -->

## Auftrag 3: Die Netzwerkanbindung verändern

**Ziel:** Unterscheiden Sie eine lokale Netzwerkverbindung des Gasts von dessen Internetzugang.

**NAT** beziehungsweise **Shared Network** ermöglicht hier den Internetzugriff über den Host. **Host-only** verbindet den Gast mit einem lokalen virtuellen Netz ohne regulären Weg ins Internet. Die **IPv4-Adresse** ist die Adresse der Verbindung im jeweiligen Netz.

1. Starten Sie die VM im Ausgangsmodus **Shared Network**. Öffnen Sie im Gast über das Netzwerksymbol **Verbindungsinformationen/Connection Information**. Notieren Sie Verbindungstyp und IPv4-Adresse. Schließen Sie das Fenster.
2. Prüfen Sie im Gast und auf dem Host den Internetzugriff. Verwenden Sie jeweils ein **neues privates Browserfenster**, rufen Sie `https://www.debian.org/` auf und schließen Sie das private Fenster danach. Notieren Sie für beide Rechner „erreichbar“ oder die Fehlermeldung.
3. Fahren Sie Debian herunter. Öffnen Sie **Bearbeiten → Netzwerk**. Ändern Sie den **Netzwerkmodus/Network Mode** von **Shared Network** auf **Host Only**. Lassen Sie weitere Netzwerkeinstellungen unverändert; legen Sie kein zusätzliches benanntes Host-Netz an.
4. Starten Sie Debian. Lesen Sie Verbindungstyp und IPv4-Adresse erneut ab. Wiederholen Sie den Browserversuch mit neuen privaten Fenstern im Gast und auf dem Host.
5. Fahren Sie herunter, stellen Sie **Shared Network** wieder ein und starten Sie erneut. Wiederholen Sie den Browserversuch.

| Zustand | IPv4-Adresse des Gasts | Internet im Gast | Internet auf dem Host |
|---|---|---|---|
| Shared Network vorher | | | |
| Host-only | | | |
| Shared Network wiederhergestellt | | | |

> **Ergebnis 3:** Tragen Sie die drei Beobachtungszeilen in das Feld ein. Erklären Sie anschließend, ob die Anzeige „verbunden“ bereits einen Internetzugang belegt und warum Host und Gast unterschiedliche Ergebnisse liefern können.
<!-- antwort:network|88|Drei Beobachtungszeilen und Begründung -->

**Wenn das Ergebnis abweicht:** Erhält der Gast keine IPv4-Adresse, ist die lokale Verbindung noch nicht vollständig eingerichtet. Das belegt allein keine erfolgreiche Internettrennung. Prüfen Sie den ausgewählten Modus und die oben genannten Einstellungen. Stellt auch der Host keine Internetverbindung her, wiederholen Sie den Ausgangstest nach Behebung der Hostverbindung. Halten Sie verbleibende Probleme fest und holen Sie die Lehrperson dazu.

<!-- seitenumbruch -->

## Demonstration: Einen Snapshot zurücksetzen

Die Lehrperson zeigt den Ablauf in VirtualBox. Ein **Snapshot** hält einen VM-Zustand fest, zu dem später zurückgekehrt werden kann.

Die Ausgangsdatei `vm-notiz.txt` enthält `Version 1`. Die Lehrperson fährt den Gast herunter und legt einen Snapshot an. Danach ändert sie den Inhalt auf `Version 2`, erstellt `nachher.txt` und startet Debian zunächst normal neu.

> **Beobachtungsauftrag:** Notieren Sie vor dem Zurücksetzen Ihre Vorhersage für beide Dateien. Vergleichen Sie sie nach dem Zurücksetzen mit der Beobachtung. Erklären Sie den Unterschied zwischen Neustart und Wiederherstellung.
<!-- antwort:snapshot|55|Vorhersage; Beobachtung; Unterschied zum Neustart -->

## Abschluss

> **Ergebnis 4:** Erklären Sie Ihre eigene VM in vier Sätzen. Verwenden Sie Ihre Beobachtungen: Wer stellt den Arbeitsspeicher bereit? Wo liegt das gespeicherte Dokument? Was legt den Internetzugang fest? Warum hilft ein Snapshot auf derselben ausgefallenen Host-Festplatte nicht weiter?
<!-- antwort:abschluss|68|Vier Sätze zur eigenen VM -->

Stellen Sie **2048 MB RAM** und **Shared Network** wieder her. Fahren Sie Debian über das Gastmenü herunter. Speichern Sie dieses ausgefüllte PDF auf dem Host. Alternativ führen Sie ein Dokument mit den Ergebnissen 1 bis 4 und der Snapshot-Beobachtung.

## Hilfe bei Problemen

- **Die VM startet nicht:** Prüfen Sie die Architektur der ISO anhand von Seite 1. Notieren Sie die vollständige Fehlermeldung. Prüfen Sie, ob Sie „Virtualisieren“ und die zum Mac passende Architektur gewählt haben.
- **Der Installer startet erneut:** Werfen Sie die ISO im virtuellen CD/DVD-Laufwerk aus. Die installierte virtuelle Festplatte bleibt eingebunden.
- **Anzeige oder Maus sind unbrauchbar:** Nutzen Sie zunächst den Fenstermodus. Die Freigabe der Eingabe finden Sie in der UTM-Werkzeugleiste bzw. im Menü zur Eingabe. Holen Sie bei anhaltenden Problemen die Lehrperson dazu.
- **Eine Hardwareeinstellung ist gesperrt:** Debian vollständig herunterfahren. Ein pausierter oder gespeicherter Maschinenzustand genügt nicht.
- **Ein Arbeitsschritt scheitert:** Notieren Sie Schritt, Einstellung und Fehlermeldung. Arbeiten Sie nach Rücksprache an einem funktionierenden Gruppenrechner weiter.

## Dokumentation

[Debian-Installation](https://www.debian.org/releases/trixie/amd64/ch06s03.en.html) · [UTM: Einstellungen](https://docs.getutm.app/settings-qemu/system/) · [UTM: Netzwerk](https://docs.getutm.app/settings-qemu/devices/network/network/) · [Xfce-Taskmanager](https://docs.xfce.org/apps/xfce4-taskmanager/start)
