# OXID More-Tabs

Mit diesem Modul können Sie zusätzliche Tabs auf den Artikelseiten hinzufügen. Die Konfiguration erfolgt bequem via Backend.

## Installation

Sie können das Modul bequem über composer installieren:
```bash
composer require seemannit/more-tabs
```

Bitte generieren Sie die Views neu, nachdem Sie das Modul aktiviert haben. Gehen Sie dazu ins Backend auf *Service -> Tools* und klicken Sie auf *VIEWS jetzt updaten*.

## Features

* Pro Artikel können bis zu 5 zusätzliche Tabs hinzugefügt werden.
* Die Position der Tabs kann selbst festgelegt werden: nach dem Beschreibungs-Tab, nach dem Spezifikationen-Tab, nach dem Preisalarm-Tab, nach dem Tags-Tab oder nach dem Medien-Tab.
* Mehrsprachigkeit: Tabs können bei Bedarf mehrsprachig angelegt werden.
* Unterstützung von Vaterartikeln: Sind bei einem Kind-Artikel keine Tabs definiert, werden die Tabs vom Vater angezeigt. Diese können bei Bedarf bei jeder Variante überschrieben werden.

## Kompatibilität

Dieses Modul ist kompatibel mit OXID ab Version 6.x. Es ist kompatibel sowohl mit auf Azure oder auf Flow basierenden Templates als auch mit allen Templates der ROXID-Reihe.

Eine mit OXID 4.10.x kompatible Version ist im Branch [oxid-4.x](https://github.com/marten-seemann/oxid_moretabs/tree/oxid-4.x) verfügbar.
