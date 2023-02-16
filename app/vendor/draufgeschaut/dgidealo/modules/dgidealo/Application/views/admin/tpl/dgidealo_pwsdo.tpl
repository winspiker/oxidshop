<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title>[dg] Amazon Ticker</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  [{if isset($refresh) }]
  <meta http-equiv="Refresh" content="[{$refresh}];URL=[{ $oViewConf->getSelfLink() }]cl=[{ $iClass }]&iStart=[{$iStart}]&fnc=dgrun&iPlace=[{$oIdealo->getLocation()}]&shp=[{$oIdealo->getShopId()}]&art=[{if $art}][{$art}][{else}][{$smarty.now}][{/if}]" />
  [{/if}]
    <link rel="stylesheet" href="[{$oViewConf->getResourceUrl()}]nav.css">
    <link rel="stylesheet" href="[{$oViewConf->getResourceUrl()}]colors.css">
</head>

<body>
<div style="padding: 5px;">

[{if !isset($refresh)}]
    [{ if !isset($iError) }]
        noch nicht gestartet
    [{else}]
        [{ if $iError}]
            [{ if $iError == -2}]
              [{ if $iClass == "dgamazonident"}]
                Aktualisierung durchgef&uuml;hrt.
              [{else}] 
                Export beendet.
                <b>Erfolg! Der Export wurde ausgef&uuml;hrt.
              [{/if}]
            [{/if}]

            [{ if $iError == -1}]Unbekannter Fehler![{/if}]
            [{ if $iError == 1 }]Konnte Exportdatei  ([{$sOutputFile}]) nicht schreiben![{/if}]
        [{/if}]
    [{/if}]
[{else}]
Auftrag l&auml;uft. [{ if $iStart}]Arbeite [{ $iStart}][{else}]Arbeite 0[{/if}] [{ if $iEnd }]von insgesamt [{ $iEnd }].[{/if}] [{ if $iMemory }]( Speicherbedarf [{$iMemory }] MB )[{/if}]
[{/if}]
</div>
</body>
</html>