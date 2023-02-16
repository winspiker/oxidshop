Version: 3.0
Author: EXONN
Shopversion:  4.7.x/5.0.x - 4.9.x/5.2.x

Bitte folgen Sie dieser Anleitung das Modul in Ihrem Shop zu installieren. Sichern Sie bitte Ihre Shop Daten. Sollte Sie Bedenken bezüglich der Installation des Moduls haben, lassen Sie diese von fachkundigem 
Personal vornehmen, gerne unterstützen wir Sie dabei.

1.Stellen Sie eine Verbindung z.B. via FTP zu Ihrem Webserver her.Kopieren Sie den Inhalt des Verzeichnisses copy_this in Ihr Shop Stammverzeichnis.

2.Klicken Sie unter Erweiterungen auf Module. Wählen Sie aus der Liste das EXONN Google Merchant Modul und aktivieren Sie dieses.

3.Folgende Cronjobs müssen eingerichtet werden: 

    alle 24 Std. - yoursiteurl/index.php?cl=exonn_sengines_export&fnc=google_xml&rto=2500
    alle 24 Std. - yoursiteurl/index.php?cl=exonn_sengines_export&fnc=google_xml&rto=2500&at=50001&idx=1
    alle 24 Std. - yoursiteurl/index.php?cl=exonn_sengines_export&fnc=google_xml&rto=2500&at=100001&idx=2

4.Daten-Feed hochladen:

    a. Melden Sie sich unter http://www.google.com/merchants an und klicken Sie auf den Link Daten-Feeds.
    b. Klicken Sie auf "Neuer Datenfeed" 3 neue Feed's
    c. Klicken Sie auf "Zeitplan erstellen" und tragen sie Feed-URL ein:  

Für CE und PE Shopversion

    Feed1: - yoursiteurl/export/google.xml
    Feed2: - yoursiteurl/export/google1.xml
    Feed3: - yoursiteurl/export/google2.xml

Für EE Shopversion

Bei Enterprise Edition enthält die Export-Datei den Shop-Namen: z.B. shopname_google.xml, bitte tragen Sie den Shopnamen (Stammdaten => Grundeinstellungen) in Feed-URL ein:

    Feed1: - yoursiteurl/export/shopname_google.xml
    Feed2: - yoursiteurl/export/shopname_google1.xml
    Feed3: - yoursiteurl/export/shopmame_google2.xml

5. Fertig!

