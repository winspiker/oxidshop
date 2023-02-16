[{if (!$oView->isWawi)}]
    [{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]
    [{/if}]

<script type="text/javascript">
    <!--
    function _groupExp(el) {
        var _cur = el.parentNode;

        if (_cur.className == "exp") _cur.className = "";
        else _cur.className = "exp";
    }
    //-->
</script>

[{ if $readonly}]
[{assign var="readonly" value="readonly disabled"}]
[{else}]
[{assign var="readonly" value=""}]
[{/if}]

[{cycle assign="_clear_" values=",2" }]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="exonn_delext_configs">
    <input type="hidden" name="fnc" value="">
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]">
    <input type="hidden" name="updatenav" value="">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

[{if ($oView->isWawi)}]
<form name="search_[{$smarty.request.iframeId}]" id="search_[{$smarty.request.iframeId}]"
      action="javascript:oxid.admin.submitSearchForm('[{$smarty.request.iframeId}]')">
    [{else}]
    <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
        [{/if}]
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="cl" value="exonn_delext_configs">
        <input type="hidden" name="fnc" value="save">
        <input type="hidden" name="oxid" value="[{$oxid}]">
        <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oxid }]">

        <h2>[{ oxmultilang ident="delextconfig" }]</h2>


        <table>
            <tr>
                <td colspan="2">
                    <input type="hidden" name="confbools[exonn_delext_testmode]" value="false">
                    <input id="testmode" type="checkbox" name="confbools[exonn_delext_testmode]"
                           value="true" [{if $confbools.exonn_delext_testmode}]checked="true" [{/if}]>
                    <label for="testmode">[{ oxmultilang ident="EXONN_DELEXT_TESTMODE" }]</label>
                </td>
                <div class="spacer"></div>
            </tr>
            <tr>
                <td>
                    [{ oxmultilang ident="EXONN_DELEXT_URSPRUNGSLAND" }]
                </td>
                <td>
                  <input type="text" class="editinput" size="10" maxlength="30" name=confstrs[exonn_delext_origncountry] value="[{$confstrs.exonn_delext_origncountry}]" [{ $readonly }]>
                </td>
            </tr>
            <tr>
                <td>
                    [{ oxmultilang ident="EXONN_DELEXT_ZOLLTARIFNUMMER" }]
                </td>
                <td>
                  <input type="text" class="editinput" size="10" maxlength="30" name=confstrs[exonn_delext_commoditycode] value="[{$confstrs.exonn_delext_commoditycode}]" [{ $readonly }]>
                </td>
            </tr>
        </table>
        <br>
        <br>
        <div class="groupExp">
            <div>
                <a href="#" onclick="_groupExp(this);return false;" class="rc">
                    <b>Absender</b>
                </a>
                <dl>
                    <table>
                        <tr>
                            <td colspan="2">
                                <input type="hidden" name="confbools[exonn_delext_blAlternativeAddress]" value="false">
                                <input type="checkbox" name="confbools[exonn_delext_blAlternativeAddress]" value="true"
                                       [{if ($confbools.exonn_delext_blAlternativeAddress) }]checked="" [{/if}]>
                                Diese Adress- und Bankdaten verwenden anstatt den Daten aus den Oxid Grundeinstellungen
                            </td>
                            <div class="spacer"></div>
                        </tr>
                        <tr>
                            <td>
                                Firmenname
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;"
                                       name="confstrs[exonn_delext_Company]" value="[{$confstrs.exonn_delext_Company}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>
                        <tr>
                            <td>
                                Vorname Nachname
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 120px;"
                                       name="confstrs[exonn_delext_FirstName]"
                                       value="[{$confstrs.exonn_delext_FirstName}]">
                                <input type="text" class="txt" style="width: 120px;"
                                       name="confstrs[exonn_delext_LastName]"
                                       value="[{$confstrs.exonn_delext_LastName}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>

                        <tr>
                            <td>
                                Straße / Hausnummer
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 180px;"
                                       name="confstrs[exonn_delext_Street]" value="[{$confstrs.exonn_delext_Street}]">
                                <input type="text" class="txt" style="width: 55px;"
                                       name="confstrs[exonn_delext_StreetNr]"
                                       value="[{$confstrs.exonn_delext_StreetNr}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>

                        <tr>
                            <td>
                                PLZ / Ort
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 55px;" name="confstrs[exonn_delext_Zip]"
                                       value="[{$confstrs.exonn_delext_Zip}]">
                                <input type="text" class="txt" style="width: 180px;" name="confstrs[exonn_delext_City]"
                                       value="[{$confstrs.exonn_delext_City}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>

                        <tr>
                            <td>
                                E-Mail Adresse
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;" name="confstrs[exonn_delext_Email]"
                                       value="[{$confstrs.exonn_delext_Email}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>

                        <tr>
                            <td>
                                Telefonnnummer
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;" name="confstrs[exonn_delext_Phone]"
                                       value="[{$confstrs.exonn_delext_Phone}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>
                        <tr>
                            <td>
                                Kontobesitzer
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;"
                                       name="confstrs[exonn_delext_AccountOwner]"
                                       value="[{$confstrs.exonn_delext_AccountOwner}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>
                        <tr>
                            <td>
                                Kontonummer
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;"
                                       name="confstrs[exonn_delext_AccountNumber]"
                                       value="[{$confstrs.exonn_delext_AccountNumber}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>
                        <tr>
                            <td>
                                BLZ
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;"
                                       name="confstrs[exonn_delext_BankCode]"
                                       value="[{$confstrs.exonn_delext_BankCode}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>
                        <tr>
                            <td>
                                Bankname
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;"
                                       name="confstrs[exonn_delext_BankName]"
                                       value="[{$confstrs.exonn_delext_BankName}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>
                        <tr>
                            <td>
                                IBAN
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;" name="confstrs[exonn_delext_Iban]"
                                       value="[{$confstrs.exonn_delext_Iban}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>
                        <tr>
                            <td>
                                BIC
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;" name="confstrs[exonn_delext_Bic]"
                                       value="[{$confstrs.exonn_delext_Bic}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>
                        <tr>
                            <td>
                                Ust. Ident.
                            </td>
                            <td>
                                <input type="text" class="txt" style="width: 250px;"
                                       name="confstrs[exonn_delext_VatNumber]"
                                       value="[{$confstrs.exonn_delext_VatNumber}]">
                            </td>

                            <div class="spacer"></div>
                        </tr>
                    </table>
                </dl>
            </div>
        </div>
        <br>
        <input type="submit" class="confinput" name="save" value="[{ oxmultilang ident="GENERAL_SAVE" }]" [{ $readonly}]>
        <br>
        <br>
    </form>

    [{include file="bottomnaviitem.tpl"}]
    [{include file="bottomitem.tpl"}]