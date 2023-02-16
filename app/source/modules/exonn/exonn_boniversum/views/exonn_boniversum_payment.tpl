[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign }]

<script type="text/javascript">

    function deleteThis( sID)
    {
        blCheck = confirm("[{oxmultilang ident="ARTICLE_VARIANT_YOUWANTTODELETE"}]");
        if( blCheck == true)
        {
            var oSearch = document.getElementById("myedit");
            oSearch.oxid.value=sID;
            oSearch.submit();
        }
    }
</script>


[{assign var="blWhite" value=""}]
[{assign var="listclass" value=listitem$blWhite}]

<form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="cl" value="exonn_boniversum_payment">
    <input type="hidden" name="fnc" value="deleteBoniversumPayment">
    <input type="hidden" name="oxid" value="">
</form>
<div style="overflow-x:auto;">
    <table>
        <tr>
            <td valign="top">
    <table cellspacing="0" cellpadding="0" border="0" width="730">
        <tr>
            <td class="listheader first">[{oxmultilang ident="BONIVERSUM_PAYMENT_ADRESSVALIDIERUNG"}] </td>
            <td class="listheader">[{oxmultilang ident="BONIVERSUM_PAYMENT_PERSONIDENTIFIKATION"}] </td>
            <td class="listheader">[{oxmultilang ident="BONIVERSUM_PAYMENT_SCOREBEWERTUNG"}]</td>
            <td class="listheader " height="15">[{oxmultilang ident="BONIVERSUM_PAYMENT_PAYMENTS"}] </td>
            <td class="listheader "  colspan="2" height="15">[{oxmultilang ident="BONIVERSUM_PAYMENT_kreditlimit"}] </td>
        </tr>




        [{assign var=listitem_new value=$oView->getListitemNew()}]

        [{assign var="listclass" value=listitem$blWhite}]
        <form name="myedit4" id="myedit4" action="[{$oViewConf->getSelfLink()}]" method="post">
            [{$oViewConf->getHiddenSid()}]
            <input type="hidden" name="cl" value="exonn_boniversum_payment">
            <input type="hidden" name="fnc" value="savepayment">

        <tr>


                <td class="[{$listclass}]"  style="height: 90px" valign="top">
                    <select name="editval[exonn_boniversumpayments__oxadressvalidierung][]" multiple>
                        <option value="01" [{if in_array('01', $listitem_new->getArrayData('exonn_boniversumpayments__oxadressvalidierung'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_ADRESSVALIDIERUNG_01"}]</option>
                        <option value="02" [{if in_array('02', $listitem_new->getArrayData('exonn_boniversumpayments__oxadressvalidierung'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_ADRESSVALIDIERUNG_02"}]</option>
                        <option value="03" [{if in_array('03', $listitem_new->getArrayData('exonn_boniversumpayments__oxadressvalidierung'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_ADRESSVALIDIERUNG_03"}]</option>

                    </select>


                </td>
                <td class="[{$listclass}]" style="height: 90px" valign="top">
                    <select name="editval[exonn_boniversumpayments__oxpersonidentifikation][]" multiple>
                        <option value="02" [{if in_array('02', $listitem_new->getArrayData('exonn_boniversumpayments__oxpersonidentifikation'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_PERSONIDENTIFIKATION_02"}]</option>
                        <option value="01" [{if in_array('01', $listitem_new->getArrayData('exonn_boniversumpayments__oxpersonidentifikation'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_PERSONIDENTIFIKATION_01"}]</option>
                        <option value="03" [{if in_array('03', $listitem_new->getArrayData('exonn_boniversumpayments__oxpersonidentifikation'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_PERSONIDENTIFIKATION_03"}]</option>
                        <option value="04" [{if in_array('04', $listitem_new->getArrayData('exonn_boniversumpayments__oxpersonidentifikation'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_PERSONIDENTIFIKATION_04"}]</option>

                    </select>


                </td>
                <td class="[{$listclass}]"  style="height: 90px" valign="top">
                    <div style="float: left">
                        <select name="editval[exonn_boniversumpayments__scorecalc]" style="width: 250px" onchange="if (this.value=='klasse') {document.getElementById('boni_klasse_new').style.display='';document.getElementById('boni_ampel_new').style.display='none';document.getElementById('boni_wert_new').style.display='none';} else if (this.value=='ampel') {document.getElementById('boni_klasse_new').style.display='none';document.getElementById('boni_ampel_new').style.display='';document.getElementById('boni_wert_new').style.display='none';} else {document.getElementById('boni_klasse_new').style.display='none';document.getElementById('boni_ampel_new').style.display='none';document.getElementById('boni_wert_new').style.display='';} ">
                            <option value="klasse" [{if 'klasse'== $listitem_new->exonn_boniversumpayments__scorecalc->value}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_KLASSE"}]</option>
                            <option value="ampel" [{if 'ampel'==$listitem_new->exonn_boniversumpayments__scorecalc->value}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_AMPEL"}]</option>
                            <option value="wert" [{if 'wert'==$listitem_new->exonn_boniversumpayments__scorecalc->value}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_WERT"}]</option>

                        </select>
                    </div>

                    <div style="float: left; [{if ($listitem_new->exonn_boniversumpayments__scorecalc->value && $listitem_new->exonn_boniversumpayments__scorecalc->value<>'klasse')}]display:none[{/if}]" id="boni_klasse_new" >

                        von
                        <input type="text" class="editinput" size="4" maxlength="[{$listitem_new->exonn_boniversumpayments__scoreklassefrom->fldmax_length}]" name="editval[exonn_boniversumpayments__scoreklassefrom]" value="[{$listitem_new->exonn_boniversumpayments__scoreklassefrom->value}]" [{$readonly}]>
                        bis
                        <input type="text" class="editinput" size="4" maxlength="[{$listitem_new->exonn_boniversumpayments__scoreklasseto->fldmax_length}]" name="editval[exonn_boniversumpayments__scoreklasseto]" value="[{$listitem_new->exonn_boniversumpayments__scoreklasseto->value}]" [{$readonly}]>

                    </div>

                    <div style="float: left; [{if ($listitem_new->exonn_boniversumpayments__scorecalc->value<>'ampel')}]display:none[{/if}]" id="boni_ampel_new" >

                        <select name="editval[exonn_boniversumpayments__scoreampel][]" style="width: 250px" size="3" multiple>
                            <option value="gruen" [{if in_array("gruen", $listitem_new->getArrayData('exonn_boniversumpayments__scoreampel'))}] selected [{/if}] >[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_AMPEL_GRUEN"}]</option>*
                            <option value="gelb" [{if in_array("gelb", $listitem_new->getArrayData('exonn_boniversumpayments__scoreampel'))}] selected [{/if}] >[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_AMPEL_GELB"}]</option>*
                            <option value="rot" [{if in_array("rot", $listitem_new->getArrayData('exonn_boniversumpayments__scoreampel'))}] selected [{/if}] >[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_AMPEL_ROT"}]</option>*
                        </select>

                    </div>

                    <div style="float: left; [{if ($listitem_new->exonn_boniversumpayments__scorecalc->value<>'wert')}]display:none[{/if}]" id="boni_wert_new" >

                        von
                        <input type="text" class="editinput" size="4" maxlength="[{$listitem_new->exonn_boniversumpayments__scorewertfrom->fldmax_length}]" name="editval[exonn_boniversumpayments__scorewertfrom]" value="[{$listitem_new->exonn_boniversumpayments__scorewertfrom->value}]" [{$readonly}]>
                        bis
                        <input type="text" class="editinput" size="4" maxlength="[{$listitem_new->exonn_boniversumpayments__scorewertto->fldmax_length}]" name="editval[exonn_boniversumpayments__scorewertto]" value="[{$listitem_new->exonn_boniversumpayments__scorewertto->value}]" [{$readonly}]>

                    </div>


                </td>
                <td class="[{$listclass}]" align="center" style="height: 90px" valign="top">
                    <select name="editval_payments[]" multiple>
                        [{foreach from=$oPayments item=oPayment}]
                        <option value="[{$oPayment->oxpayments__oxid->value}]" [{if in_array($oPayment->oxpayments__oxid->value, $listitem_new->getPayments())}]selected[{/if}]>[{$oPayment->oxpayments__oxdesc->value}]</option>
                        [{/foreach}]

                    </select>


                </td>
                <td class="[{$listclass}]" align="center" style="height: 90px" valign="top">
                    <input type="text" class="editinput" size="10" maxlength="[{$listitem_new->exonn_boniversumpayments__kreditlimit->fldmax_length}]" name="editval[exonn_boniversumpayments__kreditlimit]" value="[{$listitem_new->exonn_boniversumpayments__kreditlimit->value}]" [{$readonly}]>


                </td>

                <td class="[{$listclass}]"  align="right" style="height: 90px" >
                    <input class="edittext" type="submit"  value=" [{oxmultilang ident="BONIVERSUM_PAYMENT_ADD"}]" [{$readonly}]>
                </td>

        </tr>

        </form>


            <form name="myedit2" id="myedit2" action="[{$oViewConf->getSelfLink()}]" method="post">
                [{$oViewConf->getHiddenSid()}]
                <input type="hidden" name="cl" value="exonn_boniversum_payment">
                <input type="hidden" name="fnc" value="savepayments">



                [{if $mylist->count()>0}]
                <tr>
                    <td colspan="6" align="right">
                        <br><br><br><br><br><br><br>
                        <input class="edittext" type="submit"  value=" [{oxmultilang ident="BONIVERSUM_PAYMENT_SAVE"}]" [{$readonly}]>
                    </td>
                </tr>
                [{/if}]


                [{foreach from=$mylist item=listitem}]
                [{assign var="_cnt1" value=$_cnt1+1}]





                <tr id="test_payment.[{$_cnt1}]">
        [{assign var="listclass" value=listitem$blWhite}]
        <td class="[{$listclass}]"  style="height: 90px" valign="top">
            <select name="editval[[{$listitem->exonn_boniversumpayments__oxid->value}]][exonn_boniversumpayments__oxadressvalidierung][]" multiple>
                <option value="01" [{if in_array('01', $listitem->getArrayData('exonn_boniversumpayments__oxadressvalidierung'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_ADRESSVALIDIERUNG_01"}]</option>
                <option value="02" [{if in_array('02', $listitem->getArrayData('exonn_boniversumpayments__oxadressvalidierung'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_ADRESSVALIDIERUNG_02"}]</option>
                <option value="03" [{if in_array('03', $listitem->getArrayData('exonn_boniversumpayments__oxadressvalidierung'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_ADRESSVALIDIERUNG_03"}]</option>

            </select>


        </td>
        <td class="[{$listclass}]"  style="height: 90px" valign="top">
            <select name="editval[[{$listitem->exonn_boniversumpayments__oxid->value}]][exonn_boniversumpayments__oxpersonidentifikation][]" multiple>
                <option value="02" [{if in_array('02', $listitem->getArrayData('exonn_boniversumpayments__oxpersonidentifikation'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_PERSONIDENTIFIKATION_02"}]</option>
                <option value="01" [{if in_array('01', $listitem->getArrayData('exonn_boniversumpayments__oxpersonidentifikation'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_PERSONIDENTIFIKATION_01"}]</option>
                <option value="03" [{if in_array('03', $listitem->getArrayData('exonn_boniversumpayments__oxpersonidentifikation'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_PERSONIDENTIFIKATION_03"}]</option>
                <option value="04" [{if in_array('04', $listitem->getArrayData('exonn_boniversumpayments__oxpersonidentifikation'))}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_PERSONIDENTIFIKATION_04"}]</option>

            </select>


        </td>
        <td class="[{$listclass}]" valign="top"  style="height: 90px" >
            <div style="float: left">
            <select name="editval[[{$listitem->exonn_boniversumpayments__oxid->value}]][exonn_boniversumpayments__scorecalc]"  style="width: 250px" onchange="if (this.value=='klasse') {document.getElementById('boni_klasse_[{$listitem->exonn_boniversumpayments__oxid->value}]').style.display='';document.getElementById('boni_ampel_[{$listitem->exonn_boniversumpayments__oxid->value}]').style.display='none';document.getElementById('boni_wert_[{$listitem->exonn_boniversumpayments__oxid->value}]').style.display='none';} else if (this.value=='ampel') {document.getElementById('boni_klasse_[{$listitem->exonn_boniversumpayments__oxid->value}]').style.display='none';document.getElementById('boni_ampel_[{$listitem->exonn_boniversumpayments__oxid->value}]').style.display='';document.getElementById('boni_wert_[{$listitem->exonn_boniversumpayments__oxid->value}]').style.display='none';} else {document.getElementById('boni_klasse_[{$listitem->exonn_boniversumpayments__oxid->value}]').style.display='none';document.getElementById('boni_ampel_[{$listitem->exonn_boniversumpayments__oxid->value}]').style.display='none';document.getElementById('boni_wert_[{$listitem->exonn_boniversumpayments__oxid->value}]').style.display='';} ">
                <option value="klasse" [{if 'klasse'== $listitem->exonn_boniversumpayments__scorecalc->value}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_KLASSE"}]</option>
                <option value="ampel" [{if 'ampel'==$listitem->exonn_boniversumpayments__scorecalc->value}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_AMPEL"}]</option>
                <option value="wert" [{if 'wert'==$listitem->exonn_boniversumpayments__scorecalc->value}]selected[{/if}]>[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_WERT"}]</option>

            </select>
            </div>

            <div style="float: left; [{if ($listitem->exonn_boniversumpayments__scorecalc->value && $listitem->exonn_boniversumpayments__scorecalc->value<>'klasse')}]display:none[{/if}]" id="boni_klasse_[{$listitem->exonn_boniversumpayments__oxid->value}]" >

                von
                <input type="text" class="editinput" size="4" maxlength="[{$listitem->exonn_boniversumpayments__scoreklassefrom->fldmax_length}]" name="editval[[{$listitem->exonn_boniversumpayments__oxid->value}]][exonn_boniversumpayments__scoreklassefrom]" value="[{$listitem->exonn_boniversumpayments__scoreklassefrom->value}]" [{$readonly}]>
                bis
                <input type="text" class="editinput" size="4" maxlength="[{$listitem->exonn_boniversumpayments__scoreklasseto->fldmax_length}]" name="editval[[{$listitem->exonn_boniversumpayments__oxid->value}]][exonn_boniversumpayments__scoreklasseto]" value="[{$listitem->exonn_boniversumpayments__scoreklasseto->value}]" [{$readonly}]>

            </div>

            <div style="float: left; [{if ($listitem->exonn_boniversumpayments__scorecalc->value<>'ampel')}]display:none[{/if}]" id="boni_ampel_[{$listitem->exonn_boniversumpayments__oxid->value}]" >

                <select name="editval[[{$listitem->exonn_boniversumpayments__oxid->value}]][exonn_boniversumpayments__scoreampel][]"  style="width: 250px" size="3" multiple>
                    <option value="gruen" [{if in_array("gruen", $listitem->getArrayData('exonn_boniversumpayments__scoreampel'))}] selected [{/if}] >[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_AMPEL_GRUEN"}]</option>*
                    <option value="gelb" [{if in_array("gelb", $listitem->getArrayData('exonn_boniversumpayments__scoreampel'))}] selected [{/if}] >[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_AMPEL_GELB"}]</option>*
                    <option value="rot" [{if in_array("rot", $listitem->getArrayData('exonn_boniversumpayments__scoreampel'))}] selected [{/if}] >[{oxmultilang ident="BONIVERSUM_PAYMENT_SCORETYPE_AMPEL_ROT"}]</option>*
                </select>

            </div>

            <div style="float: left; [{if ($listitem->exonn_boniversumpayments__scorecalc->value<>'wert')}]display:none;[{/if}]" id="boni_wert_[{$listitem->exonn_boniversumpayments__oxid->value}]">

                von
                <input type="text" class="editinput" size="4" maxlength="[{$listitem->exonn_boniversumpayments__scorewertfrom->fldmax_length}]" name="editval[[{$listitem->exonn_boniversumpayments__oxid->value}]][exonn_boniversumpayments__scorewertfrom]" value="[{$listitem->exonn_boniversumpayments__scorewertfrom->value}]" [{$readonly}]>
                bis
                <input type="text" class="editinput" size="4" maxlength="[{$listitem->exonn_boniversumpayments__scorewertto->fldmax_length}]" name="editval[[{$listitem->exonn_boniversumpayments__oxid->value}]][exonn_boniversumpayments__scorewertto]" value="[{$listitem->exonn_boniversumpayments__scorewertto->value}]" [{$readonly}]>

            </div>


        </td>
        <td class="[{$listclass}]" align="center" style="height: 90px" valign="top">
            <select name="editval_payments[[{$listitem->exonn_boniversumpayments__oxid->value}]][]" multiple>
                [{foreach from=$oPayments item=oPayment}]
                <option value="[{$oPayment->oxpayments__oxid->value}]" [{if in_array($oPayment->oxpayments__oxid->value, $listitem->getPayments())}]selected[{/if}]>[{$oPayment->oxpayments__oxdesc->value}]</option>
                [{/foreach}]

            </select>


        </td>
        <td class="[{$listclass}]" align="center" style="height: 90px" valign="top">
            <input type="text" class="editinput" size="10" maxlength="[{$listitem->exonn_boniversumpayments__kreditlimit->fldmax_length}]" name="editval[[{$listitem->exonn_boniversumpayments__oxid->value}]][exonn_boniversumpayments__kreditlimit]" value="[{$listitem->exonn_boniversumpayments__kreditlimit->value}]" [{$readonly}]>


        </td>

        <td class="[{$listclass}]" style="height: 90px" >
            <a href="Javascript:deleteThis('[{$listitem->exonn_boniversumpayments__oxid->value}]');" class="delete"[{include file="help.tpl" helpid=item_delete}]></a>
        </td>
    </tr>

    [{if $blWhite == "2"}]
    [{assign var="blWhite" value=""}]
    [{else}]
    [{assign var="blWhite" value="2"}]
    [{/if}]
    [{/foreach}]

    [{if $mylist->count()>0}]
    <tr>
        <td colspan="6" align="right">
            <input class="edittext" type="submit"  value=" [{oxmultilang ident="BONIVERSUM_PAYMENT_SAVE"}]" [{$readonly}]>
        </td>
    </tr>

    <tr>
        <td  colspan=6 align=right>&nbsp;</td>
    </tr>
    [{/if}]
    </form>




</table>
            </td>
            <td valign="top">
                <img src="[{$oViewConf->getModuleUrl('exonn/exonn_boniversum', 'boniversum_score.PNG')}]" style="width: 510px; height: 800px; margin-left: 10px">
            </td>
        </tr>
    </table>

</div>




[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
