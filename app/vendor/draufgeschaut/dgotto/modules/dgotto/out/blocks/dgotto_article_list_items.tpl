[{assign var="oOtto" value=$oView->getOtto()}]
[{assign var="oOttoHook" value=false}]
[{if $oOtto->getOttoParam( 'dgOttoSqlHook' ) != ""}]
   [{assign var="oOttoHook" value=$oOtto->getExportHookField()}]  
[{/if}]

[{if $oOttoHook != "oxactive" && !$oOtto->getOttoParam( 'dgOttoDontShowArticleList' )}]
  [{assign var="aField" value="oxarticles__"|cat:$oOtto->getExportHookField()}]
  [{if $listitem->oxarticle__oxstorno->value == 1}]
    [{assign var="listclass" value=listitem3}]
  [{else}]
    [{if $listitem->blacklist == 1}]
    [{assign var="listclass" value=listitem3}]
    [{else}]
    [{assign var="listclass" value=listitem$blWhite}]
    [{/if}]
  [{/if}]
  [{if $listitem->getId() == $oxid}]
    [{assign var="listclass" value=listitem4}]
  [{/if}]
  
  <td valign="top" height="15" class="[{$listclass}]">
    <div class="listitemfloating[{if $listitem->$aField->value == 1}] aiotto[{/if}]">
        [{if $listitem->$aField->value == 1}]<a href="Javascript:top.oxid.admin.editThis('[{$listitem->oxarticles__oxid->value}]');" class="[{$listclass}] "><span class="aiottoblock"> &nbsp; &nbsp; </span></a>[{else}]&nbsp;[{/if}]
    </div>
  </td>
[{assign var="colspan" value=$colspan+1}]
[{/if}]


[{$smarty.block.parent}]