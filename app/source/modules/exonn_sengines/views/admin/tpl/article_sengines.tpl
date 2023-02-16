[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="oxidCopy" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="article_main">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

<style type="text/css">select {width: 100px;}</style>
<form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post"
      style="padding: 0px;margin: 0px;height:0px;">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="cl" value="article_sengines">
    <input type="hidden" name="fnc" value="">
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="voxid" value="[{ $oxid }]">

    <table>
        <tr>
            <td class="edittext" width="120">
                [{ oxmultilang ident="ARTICLE_MAIN_ACTIVE" }]
            </td>
            <td class="edittext">
                <input type="hidden" name="engineInfo[exonn_googlem__active]" value="0">
                <input class="edittext" type="checkbox" name="engineInfo[exonn_googlem__active]" value='1'
                [{if $engineInfo->exonn_googlem__active->value == 1}]checked[{/if}] [{ $readonly }]>
                [{ oxinputhelp ident="HELP_ARTICLE_MAIN_ACTIVE" }]
            </td>
        </tr>
        [{assign var="oConf" value=$oViewConf->getConfig() }]
        [{if $oConf->getConfigParam( 'EXONN_SENGINES_OFF_SHIPPING' )}]
        <tr>
            <td class="edittext" width="120">
                [{ oxmultilang ident="ARTICLE_SENGINES_USESHIPPING" }]
            </td>
            <td class="edittext">
                <input type="hidden" name="engineInfo[exonn_googlem__useshipping]" value="0">
                <input class="edittext" type="checkbox" name="engineInfo[exonn_googlem__useshipping]" value='1'
                [{if $engineInfo->exonn_googlem__useshipping->value == 1}]checked[{/if}] [{ $readonly }]>
                [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_USESHIPPING" }]
            </td>
        </tr>
        [{/if}]
    </table>
    <hr>
    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_BASIC_PRODUCT_INFORMATION" }]</legend>
        <table>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_CONDITION" }]
                </td>
                <td class="edittext">
                    <select name="engineInfo[exonn_googlem__acondition]">
                        <option value="new"
                        [{if $engineInfo->exonn_googlem__acondition->value == "new"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_SENGINES_CONDITION_NEW" }]</option>
                        <option value="used"
                        [{if $engineInfo->exonn_googlem__acondition->value == "used"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_SENGINES_CONDITION_USED" }]</option>
                        <option value="refurbished"
                        [{if $engineInfo->exonn_googlem__acondition->value == "refurbished"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_SENGINES_CONDITION_REFURBISHED" }]</option>
                    </select>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CONDITION" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_SALE_PRICE" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__sale_price]" value="[{$engineInfo->exonn_googlem__sale_price->value}]" size="15"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_SALE_PRICE" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_SALE_PRICE_EFFECTIVE_DATE" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__sale_price_effective_date1]" value="[{$engineInfo->exonn_googlem__sale_price_effective_date1->value}]" size="15"/>-<input name="engineInfo[exonn_googlem__sale_price_effective_date2]" value="[{$engineInfo->exonn_googlem__sale_price_effective_date2->value}]" size="15"/>

                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_SALE_PRICE_EFFECTIVE_DATE" }]
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_APPAREL_PRODUCTS" }]</legend>
        <table>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_GENDER" }]
                </td>
                <td class="edittext">
                    <select name="engineInfo[exonn_googlem__gender]">
                        <option value=""></option>
                        <option value="male"
                        [{if $engineInfo->exonn_googlem__gender->value == "male"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_SENGINES_GENDER_MALE" }]</option>
                        <option value="female"
                        [{if $engineInfo->exonn_googlem__gender->value == "female"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_SENGINES_GENDER_FEMALE" }]</option>
                        <option value="unisex"
                        [{if $engineInfo->exonn_googlem__gender->value == "unisex"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_SENGINES_GENDER_UNISEX" }]</option>
                    </select>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_GENDER" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_AGE_GROUP" }]
                </td>
                <td class="edittext">
                    <select name="engineInfo[exonn_googlem__age_group]">
                        <option value=""></option>
                        <option value="adult"
                        [{if $engineInfo->exonn_googlem__age_group->value == "adult"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_SENGINES_AGE_GROUP_ADULT" }]</option>
                        <option value="kids"
                        [{if $engineInfo->exonn_googlem__age_group->value == "kids"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_SENGINES_AGE_GROUP_KIDS" }]</option>
                    </select>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_AGE_GROUP" }]
                </td>
            </tr>
        </table>
    </fieldset>

    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_PRODUCT_VARIANTS" }]</legend>
        <table>
            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_COLOR" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__color]" value="[{$engineInfo->exonn_googlem__color->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_COLOR" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_SIZE" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__size]" value="[{$engineInfo->exonn_googlem__size->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_SIZE" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_MATERIAL" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__material]" value="[{$engineInfo->exonn_googlem__material->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_MATERIAL" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_PATTERN" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__pattern]" value="[{$engineInfo->exonn_googlem__pattern->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_PATTERN" }]
                </td>
            </tr>
        </table>
    </fieldset>

    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_MERCHANT_DEFINED_MULTIPACKS" }]</legend>
        <table>
            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_MULTIPACK" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__multipack]" value="[{$engineInfo->exonn_googlem__multipack->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_MULTIPACK" }]
                </td>
            </tr>
        </table>
    </fieldset>

    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_ADULT_PRODUCTS" }]</legend>
        <table>
            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_ADULT" }]
                </td>
                <td class="edittext">
                    <input type="hidden" name="engineInfo[exonn_googlem__adult]" value="0">
                <input class="edittext" type="checkbox" name="engineInfo[exonn_googlem__adult]" value='1'
                [{if $engineInfo->exonn_googlem__adult->value == 1}]checked[{/if}] [{ $readonly }]>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_ADULT" }]
                </td>
            </tr>
        </table>
    </fieldset>

    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_ADWORDS_ATTRIBUTES" }]</legend>
        <table>
            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_ADWORDS_GROUPING" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__adwords_grouping]" value="[{$engineInfo->exonn_googlem__adwords_grouping->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_ADWORDS_GROUPING" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_ADWORDS_LABELS" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__adwords_labels]" value="[{$engineInfo->exonn_googlem__adwords_labels->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_ADWORDS_LABELS" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_ADWORDS_REDIRECT" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__adwords_redirect]" value="[{$engineInfo->exonn_googlem__adwords_redirect->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_ADWORDS_REDIRECT" }]
                </td>
            </tr>
        </table>
    </fieldset>

    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABELS" }]</legend>
        <table>
            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 1
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__custom_label_0]" value="[{$engineInfo->exonn_googlem__custom_label_0->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CUSTOM_LABEL" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 2
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__custom_label_1]" value="[{$engineInfo->exonn_googlem__custom_label_1->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CUSTOM_LABEL" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 3
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__custom_label_2]" value="[{$engineInfo->exonn_googlem__custom_label_2->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CUSTOM_LABEL" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 4
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__custom_label_3]" value="[{$engineInfo->exonn_googlem__custom_label_3->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CUSTOM_LABEL" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 5
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__custom_label_4]" value="[{$engineInfo->exonn_googlem__custom_label_4->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CUSTOM_LABEL" }]
                </td>
            </tr>
        </table>
    </fieldset>

    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_UNIT_PRICES" }]</legend>
        <table>
            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_UNIT_PRICING_MEASURE" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__unit_pricing_measure]" value="[{$engineInfo->exonn_googlem__unit_pricing_measure->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_UNIT_PRICING_MEASURE" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_UNIT_PRICING_BASE_MEASURE" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__unit_pricing_base_measure]" value="[{$engineInfo->exonn_googlem__unit_pricing_base_measure->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_UNIT_PRICING_BASE_MEASURE" }]
                </td>
            </tr>
        </table>
    </fieldset>

    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_UNIT_PRICING_ENERGY_LABELS" }]</legend>
        <table>

            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_SENGINES_ENERGY_EFFICIENCY_CLASS" }]
                </td>
                <td class="edittext">
                    <select name="engineInfo[exonn_googlem__energy_efficiency_class]">
                        <option value=""></option>
                        <option value="G" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "G"}]selected[{/if}]>G</option>
                        <option value="F" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "F"}]selected[{/if}]>F</option>
                        <option value="E" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "E"}]selected[{/if}]>E</option>
                        <option value="D" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "D"}]selected[{/if}]>D</option>
                        <option value="C" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "C"}]selected[{/if}]>C</option>
                        <option value="B" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "B"}]selected[{/if}]>B</option>
                        <option value="A" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "A"}]selected[{/if}]>A</option>
                        <option value="A+" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "A+"}]selected[{/if}]>A+</option>
                        <option value="A++" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "A++"}]selected[{/if}]>A++</option>
                        <option value="A+++" [{if $engineInfo->exonn_googlem__energy_efficiency_class->value == "A+++"}]selected[{/if}]>A+++</option>
                    </select>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_ENERGY_EFFICIENCY_CLASS" }]
                </td>
            </tr>
        </table>
    </fieldset>
    <br>

    <input type="submit" class="edittext" id="oLockButton" name="saveArticle"
           value="[{ oxmultilang ident="ARTICLE_MAIN_SAVE" }]"
           onClick="Javascript:document.myedit.fnc.value='save'">
    <br>
</form>
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
