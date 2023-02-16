[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="oxidCopy" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="category_sengines">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

<style type="text/css">select {width: 100px;}</style>
<form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="cl" value="category_sengines">
        <input type="hidden" name="fnc" value="">
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="editval[category__oxid]" value="[{ $oxid }]">
        <table>
            <tr>
                <td class="edittext" width="120">
                    [{ oxmultilang ident="ARTICLE_MAIN_ACTIVE" }]
                </td>
                <td class="edittext">
                    <input type="hidden" name="use_engineInfo[exonn_googlem__active]" value="1">
                    <input type="hidden" name="engineInfo[exonn_googlem__active]" value="0">
                    <input class="edittext" type="checkbox" name="engineInfo[exonn_googlem__active]" value='1'
                    [{if $engineInfo->exonn_googlem__active->value == 1}]checked[{/if}] [{ $readonly }]>
                    [{ oxinputhelp ident="HELP_ARTICLE_MAIN_ACTIVE" }]
                </td>
            </tr>
        </table>
        <hr>
   <table>
   <tr>
   <td valign="top">

    <table>
        <tr>
            <td class="edittext" width="120">
                <input type="checkbox" name="use_engineInfo[exonn_googlem__title2]"> Titelzusatz
            </td>
            <td class="edittext">
                <input type="edit" name="engineInfo[exonn_googlem__title2]" value="[{$engineInfo->exonn_googlem__title2->value }]">
            </td>
        </tr>
    </table>

    <fieldset>
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_APPAREL_PRODUCTS" }]</legend>
        <table>

            <tr>
                <td class="edittext" width="120">
                    <input type="checkbox" name="use_engineInfo[exonn_googlem__gender]"> [{ oxmultilang ident="ARTICLE_SENGINES_GENDER" }]
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
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__age_group]"> [{ oxmultilang ident="ARTICLE_SENGINES_AGE_GROUP" }]
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
        <legend>[{ oxmultilang ident="ARTICLE_SENGINES_MERCHANT_DEFINED_MULTIPACKS" }]</legend>
        <table>
            <tr>
                <td class="edittext" width="120">
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__multipack]"> [{ oxmultilang ident="ARTICLE_SENGINES_MULTIPACK" }]
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
                  <input type="checkbox" name="use_engineInfo[exonn_googlem__adult]">  [{ oxmultilang ident="ARTICLE_SENGINES_ADULT" }]
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
                  <input type="checkbox" name="use_engineInfo[exonn_googlem__adwords_grouping]">  [{ oxmultilang ident="ARTICLE_SENGINES_ADWORDS_GROUPING" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__adwords_grouping]" value="[{$engineInfo->exonn_googlem__adwords_grouping->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_ADWORDS_GROUPING" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                  <input type="checkbox" name="use_engineInfo[exonn_googlem__adwords_labels]">  [{ oxmultilang ident="ARTICLE_SENGINES_ADWORDS_LABELS" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__adwords_labels]" value="[{$engineInfo->exonn_googlem__adwords_labels->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_ADWORDS_LABELS" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__adwords_redirect]"> [{ oxmultilang ident="ARTICLE_SENGINES_ADWORDS_REDIRECT" }]
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
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__custom_label_0]"> [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 1
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__custom_label_0]" value="[{$engineInfo->exonn_googlem__custom_label_0->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CUSTOM_LABEL" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__custom_label_1]"> [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 2
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__custom_label_1]" value="[{$engineInfo->exonn_googlem__custom_label_1->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CUSTOM_LABEL" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__custom_label_2]"> [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 3
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__custom_label_2]" value="[{$engineInfo->exonn_googlem__custom_label_2->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CUSTOM_LABEL" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__custom_label_3]"> [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 4
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__custom_label_3]" value="[{$engineInfo->exonn_googlem__custom_label_3->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_CUSTOM_LABEL" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__custom_label_4]"> [{ oxmultilang ident="ARTICLE_SENGINES_CUSTOM_LABEL" }] 5
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
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__unit_pricing_measure]"> [{ oxmultilang ident="ARTICLE_SENGINES_UNIT_PRICING_MEASURE" }]
                </td>
                <td class="edittext">
                    <input name="engineInfo[exonn_googlem__unit_pricing_measure]" value="[{$engineInfo->exonn_googlem__unit_pricing_measure->value}]" size="30"/>
                    [{ oxinputhelp ident="HELP_ARTICLE_SENGINES_UNIT_PRICING_MEASURE" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" width="120">
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__unit_pricing_base_measure]"> [{ oxmultilang ident="ARTICLE_SENGINES_UNIT_PRICING_BASE_MEASURE" }]
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
                   <input type="checkbox" name="use_engineInfo[exonn_googlem__energy_efficiency_class]"> [{ oxmultilang ident="ARTICLE_SENGINES_ENERGY_EFFICIENCY_CLASS" }]
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
    </td>
   <td>&nbsp;</td>
   <td valign="top">
    [{ assign var="oConf" value=$oViewConf->getConfig() }]
    [{assign var="http" value="http"}]
    [{if $oConf->getConfigParam( 'sSSLShopURL' )}][{assign var="http" value="https"}][{/if}]

        <label><b>[{ oxmultilang ident="ARTICLE_SENGINES_GOOGLE_PRODUKTKATEGORIE" }]:</b></label><br>
        <input type="hidden" name="use_engineInfo[exonn_googlem__googlecategory]" value="1">
        <textarea id="sel_xml" name="engineInfo[exonn_googlem__googlecategory]" cols="160" rows="1" readonly="da" >[{$engineInfo->exonn_googlem__googlecategory->rawValue}]</textarea>
        <span id="sel_csv" style="display: none;"></span>
        <br><br>

        <label><b>[{ oxmultilang ident="ARTICLE_SENGINES_SEARCH" }]:</b></label><br>
        <input type="text" id="typotree" class="searchbox" style="border: 1px solid #999;">

        <br><br>
        <div class="article_content" id="article-content-div">
          <link rel="stylesheet" type="text/css" href="[{$oViewConf->getBaseDir()}]/modules/exonn_sengines/views/css/treestyle.css">
          [{ assign var="oConf" value=$oViewConf->getConfig() }]
          [{if $oConf->isUtf() }]
          <script src="[{$oViewConf->getBaseDir()}]/modules/exonn_sengines/views/js/taxonomy-utf.js" type="text/javascript"></script>
          [{else}]
          <script src="[{$oViewConf->getBaseDir()}]/modules/exonn_sengines/views/js/taxonomy.js" type="text/javascript"></script>
          [{/if}]
          <script src="[{$oViewConf->getBaseDir()}]/modules/exonn_sengines/views/js/taxtree.js" type="text/javascript"></script>

          <span onclick="expandAll(ic_config);" class="expandall">[{ oxmultilang ident="ARTICLE_SENGINES_ALLE_MAXIMIEREN" }] &gt;&gt;</span><br>
          <div width="100%" id="itemclass_searchable_root">

          </div>
          <script language="JavaScript">tree_initialize();</script>
        </div>
     </td>
   </tr>
   </table>
     <br><br>
     <input type="submit" class="edittext" id="oLockButton" name="saveCategory" value="[{ oxmultilang ident="ARTICLE_MAIN_SAVE" }]" onClick="Javascript:document.myedit.fnc.value='save'" >
    <br><br>

     </form>

[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
