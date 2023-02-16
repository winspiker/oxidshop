# Quick Start Guide CrefoPay Plugin "Payments" für Oxid eShop  

## 1. Einleitung  

Dieser Quick Start Guide soll die Installation und Konfiguration des CrefoPay Payment Plugin für den Oxid eShop 6 vereinfachen. Die Schritt f&uuml;r Anleitung beinhaltet alle notwenidgen Schritte zur Inbetriebnahme. Weiterf&uuml;rende Informationen sind in dem umfangreicheren [Benutzerhandbuch](doc/admin/manual.md) enthalten.  

### 1.1 Bevor es los geht  

Bevor es mit der Installation und Konfiguration des CrefoPay Payment Plugin los gehen kann, sollten die folgenden Informationen bereit gehalten werden:  

* FTP Zugang zur Oxid Installation  
  * Server (z.B.: ftp.meinoxidshop.de)
  * Benutzername[^1]
  * Passwort
  * Port  
* CrefoPay Payment Plugin f&uuml;r Oxid eShop 6[^2]  
* CrefoPay Zugangsdaten[^3]
  * Merchant ID  
  * Store ID(s)  
  * Public Key  
  * Private Key  

[^1]: Der Benutzer ben&ouml;tigt Schreibberechtigung auf den modules Ordner der Oxid Installation und sollte sich min. Gruppenberechtigung mit dem Webserver-Benutzer (Bsp: www-data) teilen.  
[^2]: Sofern das Plugin als Archivdatei (Zip/tar.gz) vorliegt, bitte zun&auml;chst die Dateien entpacken.  
[^3]: Noch keine Zugangsdaten f&uuml;r CrefoPay? Das CrefoPay Service Team ist f&uuml;r alle R&uuml;ckfragen rund um CrefoPay unter [service@crefopay.de](mailto:service@crefopay.de) erreichbar.

### 1.2 Haftungsausschluss  

Die CrefoPayment GmbH & Co. KG als Herausgeber der Software &uuml;bernimmt keinerlei Haftung f&uuml;r etwaige Schäden, die durch die Verwendung des CrefoPay Payment Plugin entstehen. Um vor der Inbetriebnahme im Produktivbetrieb ausf&uuml;hliche Funktions-Tests durchf&uuml;ren zu k&ouml;nnen, kann beim CrefoPay Service Team unter [service@crefopay.de](mailto:service@crefopay.de) ein Zugang zur CrefoPay [Sandbox](https://sandbox.crefopay.de) angefragt werden.  

### 2 Backup  

Das CrefoPay Payment Plugin ist ausf&uuml;hrlich getestet und von der Qaulit&auml;tssicherung der CrefoPayment GmbH & Co. KG gepr&uuml;ft und freigegeben worden. Dennoch kann es bei jeder Software unter ung&uuml;stigen Umst&auml;nden zu unerwarteten Fehlern bei der Installation bzw. der Inbetriebnahme kommen. Aus diesem Grund wird *dringend* dazu geraten eine Systemsicherung (Backup) zu erstellen, bevor die Software installiert und in Betrieb genommen wird.  
  
## 3. Installation  

F&uuml;r die Installation des CrefoPay Payment Plugin k&ouml;nnen Sie entweder den mitgelieferten PHP Installer f&uuml;r die automatische Installation verwenden oder die notwendigen Dateien und Order direkt per FTP auf Ihren Webserver kopieren.

### (a) Mit PHP Installer  

Diese Funktion steht in der aktuellen Version nicht zur Verfügung. Weitere Informationen zur Installation k&ouml;nnen unter [service@crefopay.de](mailto:service@crefopay.de) beim CrefoPay Service Team angefragt werden.

### (b) Manuelle Installation via FTP  

<lead>In der folgenden Schritt f&uuml;r Schritt Anleitung wird das OpenSource Tool FileZilla (DE Version 3.15.0.2) zur FTP Daten&uuml;bertragung verwendet. Weitere Informationen und ausf&uuml;hrliche Dokumentation unter [welcome.filezilla-project.org](https://welcome.filezilla-project.org/welcome?type=client&category=documentation_more&version=3.15.0.2).<br/>
Es werden die FTP Zugangsdaten zum Webserver ben&ouml;tigt.</lead>  

#### Dateien kopieren  

1. Im ersten Schritt muss zun&auml;chst FileZilla gestartet.  
2. Nachdem FileZille ge&ouml;ffnet wurde k&ouml;nnen die bereitgestellten Zugansdaten eingetragen werden. Ein anschließender Klick auf *Verbinden* sollte die FTP Verbindung mit dem Webserver aufbauen.  
3. Nach erfolgreichem Aufbau der Verbindung zum Webserver kann im Tab *zu &uuml;bertragende Daten* auf der linken Seite unter *Lokal:* das Verzeichnis mit den lokalen Plugin Dateien ge&ouml;fffnet werden.  
4. Im selben Tab kann auf der rechten Seite unter *Server:* in das Verzeichnis der Oxid Installation auf dem Webserver navigiert werden.  
5. Nun muss nur noch das lokale Verzeichnis *modules* in das gleichnamige Serververzeichnis kopiert werden. **Achtung!** Eventuell vorhandene, gleichnamige Dateien werden ggf. ersetzt bzw. &uuml;berschrieben.  
6. Zuletzt muss die Dateiberechtigung der hinzugef&uuml;gten Dateien gepr&uuml;ft werden. Dazu wird auf *Server:* Seite zun&auml;chst durch Doppelklick in den Ordner *modules* navigiert und mit Rechtsklick auf den Ordner *crefopay* der Punkt *Dateiberechtigungen...* ausgew&auml;hlt.  
7. Im Fenster *Dateiattribute &auml;ndern, m&ueml;ssen dann folgende Optionen gesetzt werden:  
   * *Numerischer Wert*: 664
   * *Unterverzeichnisse einbeziehen:* aktiviert
   * Auf alle Dateien und Verzeichnisse anwenden
  
Wurden alle Dateien erfolgreich kopiert und haben die richtige Berechtigung erhalten, ist der Dateitransfer abgeschlossen und FileZilla kann geschlossen werden.  

## 4. Aktivierung  

### 4.1 Eintragen der Zugangsdaten  

<lead>F&uuml;r die Aktivierung des CrefoPay Payment Plugin werden die CrefoPay Zugangsdaten[^3] ben&ouml;tigt.</lead>  
Die Aktivierung der CrefoPay Bezahlarten erfolgt &uuml;ber den Men&uuml;punkt *Erweiterungen > Module* im Oxid Backend.  

1. Zun&auml;st muss das Modul *CrefoPay Bezahlarten* angeklickt werden, um den Stamm-Tab zu &ouml;ffnen.  
2. Als n&auml;stes muss auf den *Einstell.* Tab gewechselt und der Bereich Zugangsdaten ge&ouml;ffnet werden.  
3. Dort sind nun die bereitgestellten CrefoPay Zugangsdaten einzutragen und anschlie&szlig;end mit *Speichern* zu best&auml;tigen. **Hinweis:** Die Fragezeichen-Symbole liefern weitere Informationen zu den zugeh&ouml;rigen Eingabefeldern.  
4. Zuletzt kann das Plugin durch einen Klick auf *Aktivieren* aktiviert werden. **Hinweis:** Sollten bei der Aktivierung Fehler auftreten werden diese angezeigt. Der angezeigten Fehler sollte unbedingt DOkumentiert werden, damit dass das [CrefoPay Service Team](mailto:service@crefopay.de) bei der L&ouml;sung etwaiger Fehler bestm&ouml;glich unterst&uuml;tzen kann.  

### 4.2 Aktivierung der CrefoPay Bezahlarten  

<lead>Sofern bei der vorangegangenen Aktivierung des Moduls keine Fehler aufgetreten sind, wurden die CrefoPay Bezahlarten bereits mit der Standard-Versandart verkn&uuml;pft. Sind weitere Versandarten konfiguriert, m&uuml;ssen diesen ebenfalls die gew&uuml;nschten CrefoPay Bezahlarten zugewiesen werden.</lead>
Unabh&auml;ngig von der gew&auml;hlten Versandart muss jede Bezahlart im Backend &uuml;ber den Men&uuml;punkt *Shopeinstellungen > Zahlungsarten* aktiviert werden.

1. Zun&auml;chst muss die zu aktivierende Zahlugnsart in der Liste angeklickt werden. **Hinweis:** Sind sehr viele Zahlungsarten im Shop verf&uuml;gbar, kann die Suchfunktion genutzt werden, in dem der Begriff *CrefoPay* in die Suchleiste eingtragen wird.  
2. Nach dem anklicken einer Bezahlart kann diese individuell konfiguriert werden[^4].  
3. Zur Aktivierung der Bezahlart muss nun die Checkbox *Aktiv* gesetzt werden.  
4. Im Feld *Name* ist der im Shop Frontend anzuzeigende Name der Bezahlart zu definieren.  
5. Zuletzt werden die Einstellungen mit einem Klick auf *Speichern* &uuml;bernommen.  
*Die Schritte 1 bis 5 m&uuml;ssen f&uuml;r alle zu aktivierenden CrefoPay Bezahlarten wiederholt werden.*  

[^4]: Genauere Informationen zu den m&ouml;glichen Konfigutationsoptionen k&ouml;nnen der Oxid eShop Dokumentation entnommen werden. Der Quick Start Guide beschr&auml;kt sich ausschlie&szlig;lich auf die f&uuml;r die AKtivierung von CrefoPay wichtigen Informationen.

## 5. Konfiguration  

<lead>Die Konfiguration des Moduls erfolgt, ebenso wie bereits die Aktivierung, &uuml;ber den *Einstell.* Tab. Im Folgenden sind die m&ouml;glichen Optionen tabellarisch zusammengefasst.</lead>
<table>
  <thead>
    <tr>
      <th>#</th>
      <th>Option</th>
      <th>Kategorie</th>
      <th>Werte</th>
      <th>Bemerkung</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1.1</td>
      <td>Betriebsmodus</td>
      <td>Umgebung</td>
      <td>Sandbox<br>Livebetrieb</td>
      <td>Im Rahmen der CrefoPay Integration werden zun&auml;chst Sandbox Daten verwendet, um die Anbindung an CrefoPay in einer Staging-Umgebung zu testen.</td>
    </tr>
    <tr>
      <td>1.2</td>
      <td>Standard Sprache</td>
      <td>Umgebung</td>
      <td>Deutsch<br>Englisch<br>Spanisch<br>Franz&ouml;sisch<br>Italienisch<br>Niederl&auml;ndisch</td>
      <td>Das CrefoPay Modul verwendet, soweit m&ouml;glich, die vom Browser des Endkunden vorgegebene Spracheinstellung. Wird eine nicht unterst&uuml;tzte Sprache erkannt, wird die hier festgelegte Standard Sprache verwendet.</td>
    </tr>
    <tr>
      <td>1.3</td>
      <td>Nicht CrefoPay Bezahlarten</td>
      <td>Umgebung</td>
      <td>Ausblenden<br>Erlauben</td>
      <td>Das CrefoPay Modul ist in der Lage, konkurrierende Bezahlarten auszublenden. Steht diese Option auf <i>Ausblenden</i> werden ausschlie&szlig;lich CrefoPay Bezahlarten im Checkout erlaubt.</td>
    </tr>
    <tr>
      <td>1.4.1</td>
      <td>Log Level</td>
      <td>Umgebung</td>
      <td>Debug<br>Warn<br>Error</td>
      <td>Das Modul verf&uuml;gt &uuml;ber verschiedene Protokollierungslevel. <i>Debug</i> protokolliert alle relevanten Aktionen des Moduls. <i>Warn</i> protokolliert schwere und leichte Fehler des Moduls. <i>Error</i> protokolliert nur die schweren Fehler, die kritische Auswirkungen auf die Prozessabl&auml;fe der CrefoPay Anbindung haben.</td>
    </tr>
    <tr>
      <td>1.4.2</td>
      <td>Log Datei</td>
      <td>Umgebung</td>
      <td><i>Textfeld</i></td>
      <td>Neben der Standard Log Datei <code>crefopay.log</code> kann hier ein individueller Dateiname f&uuml;r das Logfile angegeben werden.</td>
    </tr>
    <tr>
      <td>2.1</td>
      <td>Auto Capture</td>
      <td>Bestellungen</td>
      <td><i>Checkbox</i></td>
      <td>Der Auto Capture sorgt daf&uuml;r, dass CrefoPay Bestellungen direkt bei Authorisierung durch den Endkunden bereits gebucht, also in Rechnung gestellt werden. Diese Funktion sollte nur f&uuml;r den Verkauf digitaler G&uuml;ter oder in Absprache mit dem CrefoPay Service Team aktiviert werden.</td>
    </tr>
    <tr>
      <td>2.2</td>
      <td>Business Transaktionen</td>
      <td>Bestellungen</td>
      <td>Deaktivieren<br>Aktivieren</td>
      <td>Ist diese Funktion deaktiviert, werden alle Bestellungen automatisch als Privatkundentransaktionen behandelt. Bei aktivierter Option, werden Transaktionen, bei deinen ein Firmenname angegeben wurde als Businesstransaktion behandelt. F&uuml;r die Bezahlarten Rechnung und Lastschrift bedeutet das auch, dass die entsprechende Schnittstelle zur Bonit&auml;tsabfrage angesprochen wird.</td>
    </tr>
    <tr>
      <td>2.3</td>
      <td>Zahlungsziel Vorkasse</td>
      <td>Bestellungen</td>
      <td><i>Textfeld (INT)</i></td>
      <td>Das Modul erweitert unter anderem die E-Mail zur Bestellbest&auml;tigung und erg&auml;nzt diese im Falle einer Bestellung mit der Bezahlart Vorkasse um die f&uuml;r den Endkunden wichtigen (Bankkonto-) Informationen. Mit dieser Option kann das Zahlungsziel (in Tagen) angegeben werden, zu dem eine &Uuml;berweisung des K&auml;ufers sp&auml;testens erwartet wird.</td>
    </tr>
    <tr>
      <td>2.4</td>
      <td>Zahlungsziel Rechnung</td>
      <td>Bestellungen</td>
      <td><i>Textfeld (INT)</i></td>
      <td>&Auml;hnlich wir das Zahlungsziel f&uuml;r Vorkasse kann hier festgelegt werden, ab welchem Zeitraum (in Tagen) die Zahlung der Rechnung durch den K&auml;ufer f&auml;llig wird.</td>
    </tr>
    <tr>
      <td>2.5.1</td>
      <td>G&uuml;ltigkeit Warenkorb</td>
      <td>Bestellungen</td>
      <td><i>Textfeld (INT)</i></td>
      <td>CrefoPay Transaktionen haben eine G&uuml;ltigkeit zwischen Erstellung und erfolgreichem Abschluss. Mit dieser Option kann dieser Zeitraum definiert werden. Hier <b>muss</b> eine Zahl angegeben werden da es sonst zu Kommnunikationsfehlern mit der CrefoPay API kommt.</td>
    </tr>
    <tr>
      <td>2.5.2</td>
      <td>Einheit der Gültigkeitsdauer</td>
      <td>Bestellungen</td>
      <td>Stunden<br>Minuten<br>Tage</td>
      <td>Hier wird die zu 2.6.1 geh&ouml;rende Einheit festgelegt.</td>
    </tr>
    <tr>
      <td>3.1</td>
      <td>CVV Hilfe</td>
      <td>Payment Logos</td>
      <td>Einblenden<br>Ausblenden</td>
      <td>Mit dieser Option wird bei Auswahl der Bezahlart Kreditkarte im Checkout ein Bild eingeblendet, in dem markiert ist, wo der Endkunde auf seiner Kreditkarte die CVV findet.</td>
    </tr>
    <tr>
      <td>3.2</td>
      <td>MasterCard Logo</td>
      <td>Payment Logos</td>
      <td>Einblenden<br>Ausblenden</td>
      <td>Mit dieser Option wird bei Auswahl der Bezahlart Kreditkarte im Checkout das MasterCard Logo angezeigt.</td>
    </tr>
    <tr>
      <td>3.3</td>
      <td>VISA Logo</td>
      <td>Payment Logos</td>
      <td>Einblenden<br>Ausblenden</td>
      <td>Mit dieser Option wird bei Auswahl der Bezahlart Kreditkarte im Checkout das VISA Logo angezeigt.</td>
    </tr>    
  </tbody>
</table>

### Verweise
