[{if $installMessage}]
    [{$installMessage}]
[{elseif $result}]
    [{$result}]
[{elseif $moduleId != ""}]

    [{foreach from=$moduleDataArray item="moduleEntry"}]
        <html>
        <head>
            <script type="text/javascript">
                var specialfunction = "";
            </script>
        </head>
        <body>
        <div class="container">
            <div class="row mt10">
                <div class="one-half column">
                    <img src="https://www.shopmodul24.de/out/azure/img/schwinkendorf-it-systeme-logo.png"
                         title="Schwinkendorf IT Systeme" alt="Schwinkendorf IT Systeme"/>
                </div>
                <div class="one-half column textright">
                    <h2>Modulverwaltung</h2>
                </div>
            </div>
            <div class="row">
                <div class="u-full-width">

                    <table class="u-full-width" id="modulesInstalled">
                        <thead>
                        <tr>
                            <th class="one column"></th>
                            <th class="two columns">Modul</th>
                            <th class="five columns">Beschreibung</th>
                            <th class="one columns">Version</th>
                            <th class="one column">Lizenz</th>
                            <th class="one column">Status</th>
                            <th class="one column"></th>
                        </tr>
                        </thead>
                        <tbody>
                        [{if $moduleEntry.installed == 1}]
                            <tr class="moduleListing" id="[{$moduleEntry.path}]">
                                <td><img id="moduleConfigurationButton" style="max-width: 50px;"
                                         src="https://www.shopmodul24.de/out/azure/img/start-settings-bw.png"
                                         alt="[{$moduleEntry.title}] Konfigurieren"
                                         title="[{$moduleEntry.title}] Konfigurieren"/></td>
                                <td>[{$moduleEntry.title}]</td>
                                <td>[{$moduleEntry.shortdescription}]</td>
                                <td id="[{$moduleEntry.path}]_version_img"
                                    class="[{if $moduleEntry.version > $moduleEntry.installedVersion }]orange[{else}]green[{/if}]"
                                    title="[{$moduleEntry.installedVersion}] (Verfügbar [{$moduleEntry.version}])"
                                    alt="[{$moduleEntry.installedVersion}] (Verfügbar [{$moduleEntry.version}])"></td>
                                <td id="[{$moduleEntry.path}]_status_img" class="[{$moduleEntry.aboInfo.status}]"
                                    title="[{$moduleEntry.aboInfo.message}]" alt="[{$moduleEntry.aboInfo.message}]"></td>
                                <td id="[{$moduleEntry.path}]_function_img" class="[{$moduleEntry.function.maincheck}]"
                                    title="[{$moduleEntry.function.maincheckmessage}]"
                                    alt="[{$moduleEntry.function.maincheckmessage}]"></td>
                                <td><img style="max-width: 50px;"
                                         src="https://www.shopmodul24.de/out/pictures/master/product/1/[{$moduleEntry.image}]"
                                         alt="[{$moduleEntry.title}]" title="[{$moduleEntry.title}]"/></td>
                            </tr>
                            <tr class="moduleConfiguration" id="[{$moduleEntry.path}]_configuration">
                                <td colspan="7">
                                    <div id="sitConfigTabsMain">

                                        [{foreach from=$moduleEntry.config key="tabTitle" item="configFile" name="config"}]
                                        <div class="sitConfigTabMain" id="moduleConfig[{$smarty.foreach.config.iteration}]"
                                             data-file="[{$configFile}]">[{$tabTitle}]
                                        </div>
                                        [{/foreach}]

                                        <div class="sitConfigTabMain tabactive" id="moduleStatus">Modulstatus</div>

                                        <div class="sitConfigTabContentMain" id="moduleStatusContent">

                                            <div id="sitConfigTabContentMainData">

                                                <div id="sitConfigEntry" class="sitConfigEntry">

                                                    <div id="moduleFunction" class="[{$moduleEntry.function.maincheck}]">
                                                        <h5>Funktionalität</h5>
                                                        <ul>
                                                            [{foreach from=$moduleEntry.function.checkArray item="checkEntry"}]
                                                            <li class="[{$checkEntry.check}]">
                                                                [{$checkEntry.checktitle}]: [{$checkEntry.checkmessage}]
                                                            </li>
                                                            [{/foreach}]
                                                        </ul>
                                                    </div>

                                                    <div id="moduleVersion"
                                                         [{if $moduleEntry.version > $moduleEntry.installedVersion}]class="update"
                                                         [{/if}]>
                                                        <h5>Version</h5>
                                                        <ul>
                                                            <li>Installierte Version: [{$moduleEntry.installedVersion}]</li>
                                                            [{if $moduleEntry.version > $moduleEntry.installedVersion}]
                                                            <li>Es ist eine aktuellere Modulversion verfügbar
                                                                ([{$moduleEntry.version}])
                                                            </li>
                                                            [{else}]
                                                            <li>Ihre Modulversion ist auf dem aktuellen Stand</li>
                                                            [{/if}]
                                                        </ul>
                                                    </div>

                                                    <div id="moduleAbo" class="[{$moduleEntry.aboInfo.status}]">
                                                        <h5>Abonnement</h5>
                                                        <ul>
                                                            <li id="moduleAboStatus">[{$moduleEntry.aboInfo.message}]</li>
                                                        </ul>

                                                        <a class="button" href="[{$moduleEntry.aboInfo.aboManagerUrl}]" target="_blank">Abo verwalten</a>
                                                    </div>

                                                </div>
                                            </div>

                                            <div id="sitConfigTabContentTabData" style="display: none;">
                                                <div id="sitConfigListMain"></div>
                                                <div id="sitConfigListNavigation"></div>
                                                <div id="sitMessageMain">
                                                    <div id="sitMessage"></div>
                                                </div>
                                                <div id="sitConfigEntryData"></div>
                                            </div>

                                        </div>

                                    </div>
                                </td>
                            </tr>
                            [{/if}]
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        [{$sitmoduleframework}]
        </body>
        </html>
    [{/foreach}]
[{/if}]