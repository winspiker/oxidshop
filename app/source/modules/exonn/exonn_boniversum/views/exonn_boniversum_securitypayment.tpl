[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign }]


[{assign var="blWhite" value=""}]
[{assign var="listclass" value=listitem$blWhite}]

<h3>[{oxmultilang ident="exonnboniversumsicherpayment"}]</h3>

<form name="myedit2" id="myedit2" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="cl" value="exonn_boniversum_securitypayment">
    <input type="hidden" name="fnc" value="save">

<div style="overflow-x:auto;">
    <table>
        <tr>
            <td valign="top">
    <table cellspacing="0" cellpadding="0" border="0">
                [{foreach from=$mylist item=listitem}]
                [{assign var="_cnt1" value=$_cnt1+1}]
    <tr id="test_payment.[{$_cnt1}]">
        [{assign var="listclass" value=listitem$blWhite}]
        <td class="[{$listclass}]"  >
            <input type="checkbox" name="boniversumsecuritypayment[[{$listitem->oxpayments__oxid->value}]]" value="1" [{if $listitem->oxpayments__boniversumsecuritypayment->value}]checked[{/if}] >

            [{$listitem->oxpayments__oxdesc->value}]


        </td>
    </tr>

    [{if $blWhite == "2"}]
    [{assign var="blWhite" value=""}]
    [{else}]
    [{assign var="blWhite" value="2"}]
    [{/if}]
    [{/foreach}]

    <tr>
        <td >
            <br>
            <input class="edittext" type="submit"  value=" [{oxmultilang ident="BONIVERSUM_PAYMENT_SAVE"}]" [{$readonly}]>
        </td>
    </tr>

    </table>

</div>

</form>




[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
