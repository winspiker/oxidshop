[{assign var="oOtto" value=$oView->getOtto()}]
[{assign var="oOttoHook" value=false}]
[{if $oOtto->getOttoParam( 'dgOttoSqlHook' ) != ""}]
   [{assign var="oOttoHook" value=$oOtto->getExportHookField()}]
[{/if}]

[{if $oOttoHook != "oxactive" && !$oOtto->getOttoParam( 'dgOttoDontShowArticleList' )}]
  <td valign="top" class="listfilter first" height="20">
    <div class="r1">
        <div class="b1">
           <input class="listedit" type="text" size="1" maxlength="1" name="where[oxarticles][[{$oOttoHook}]]" value="[{$where.oxarticles.$oOttoHook}]" />
        </div>
    </div>
  </td>
[{/if}]

[{$smarty.block.parent}]