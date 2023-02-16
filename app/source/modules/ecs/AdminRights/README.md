eComStyle.de::AdminRights
=========================


Composer name
----------------
ecs/adminrights


Shopversionen
---------------
OXID eShop CE/PE 6


Vorbereitung der Modulinstallation
-----------------------------------

Erstellen Sie via SSH-Client eine Verbindung mit dem Server, auf dem Ihr OXID eShop liegt.
Wechseln Sie in das OXID-Projektverzeichnis, in dem sich die Datei composer.json sowie die source- und vendor-Ordner befinden.
Führen Sie dort folgende Befehle aus (bitte jede Zeile einzeln ausführen):

    md vendor/zip

    composer config repo.meinzip artifact ./vendor/zip


Bitte beachten:
Die o.g. Vorbereitung der Installation muss nur einmal ausgeführt werden.
Bei weiteren Modulinstallation kann direkt mit der Modulinstallation begonnen werden.


Modulinstallation
------------------

1. Loggen Sie sich via FTP auf dem Server ein und kopieren Sie die ZIP-Datei (das eComStyle.de-Modul) unverändert in den Ordner vendor/zip.

2. Erstellen Sie via SSH-Client eine Verbindung mit dem Server, auf dem Ihr OXID eShop liegt.
Wechseln Sie in das OXID-Projektverzeichnis, in dem sich die Datei composer.json sowie die source- und vendor-Ordner befinden.
Führen Sie dort folgenden Befehl aus:

    composer require ecs/adminrights

Die dann folgenden Abfragen in der Console können einfach mit ENTER quittiert werden.

3. Loggen Sie sich anschließend in Ihren Shop-Admin ein und aktivieren das neue Modul unter Erweiterungen/Module.



Modulupdate
------------

1. Loggen Sie sich via FTP auf dem Server ein und kopieren Sie die ZIP-Datei (das eComStyle.de-Modul) unverändert in den Ordner vendor/zip.
Eine evtl. bereits vorhandene, gleichnamige ZIP-Datei (zB. eien alte Modulversion) kann einfach gelöscht werden.

2. Erstellen Sie via SSH-Client eine Verbindung mit dem Server, auf dem Ihr OXID eShop liegt.
Wechseln Sie in das OXID-Projektverzeichnis, in dem sich die Datei composer.json sowie die source- und vendor-Ordner befinden.
Führen Sie dort folgenden Befehl aus:

    composer update

Bei den dann folgenden Abfragen in der Console sollte sie für das upgedatete Modul die Frage "Do you want to overwrite them? (y/N)" mit "y" bestätigen.
Nur dann wird die alte Modulversion im Ordner source/modules/ecs durch die aktuelle Version ersetzt.

3. Loggen Sie sich anschließend in Ihren Shop-Admin ein, deaktivieren Sie das Modul einmal und aktivieren es dann wieder.
Dadurch werden ggf. neue Moduleinstellungen aktiviert, neue Datenbankfelder angelegt und der TMP geleert.





Bedienungsanleitung
-------------------

### Moduleinstellungen ###
* Bei eingeschränkten Zugang können Artikel, Benutzer und Bestellungen nicht gelöscht werden.



Fehler: Modul kann nicht aktiviert werden
-----------------------------------------
Falls sich ein Modul nach dem Update nicht mehr aktivieren lässt, können Sie mit folgenden SQL Statement die evtl. durcheinander geratenen Moduleinträge in der Datenbank resetten.
Nach vorangegangener Datenbank-Sicherung auszuführen unter *Service/Tools/SQL ausführen*:

    DELETE FROM `oxconfig` WHERE `OXVARNAME` LIKE '%module%'

Bitte beachten Sie, dass nach dem Reset **alle Module** in der Modulverwaltung deaktivert sind und ggf. wieder aktivert werden müssen.


Fehler melden oder sonstige Fragen
----------------------------------
Bitte werfen Sie zunächst einen Blick in unsere Online-FAQ unter <https://ecomstyle.de/blog/faq/> oder nutzen Sie bitte bevorzugt unser kostenloses Ticketsystem: <https://ecomstyle.de/meine-tickets/>.
Selbstverständlich erreichen Sie uns auch jederzeit per Email oder Telefon: <https://ecomstyle.de/kontakt/>

**Bitte beachten: Im OXID eSales-Forum gibt es keinen Support für unsere Produkte!**


Lizenzinformationen
-------------------
Copyright (C) Josef A. Puckl | eComStyle.de
All rights reserved – Alle Rechte vorbehalten
This commercial product must be properly licensed before being used!
Dieses kommerzielle Produkt muss vor der Verwendung ordnungsgemäß lizenziert werden!
Zur Prüfung der Lizenz wird zum Modulhersteller übertragen: modulname+version-shopurl


Sonstige Wünsche
----------------
Sehr gerne sind wir Ihnen bei allen Aufgaben rund um Ihren Onlineshop behilflich!
Fragen Sie bitte jederzeit einfach an: <https://ecomstyle.de/kontakt/>