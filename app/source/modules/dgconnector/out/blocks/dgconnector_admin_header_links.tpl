[{* |header.tpl|admin_header_links|dgconnector_admin_header_links.tpl|9| *}]
[{ $smarty.block.parent }]

<li class="sep">
  <a href="[{$oViewConf->getSelfLink()}]&cl=navigation&item=header.tpl&fnc=dgClearTmp" target="_self" class="rc"><b>TMP leeren[{ if $blTmpSuccess }] &#10004;[{/if}]</b></a>
</li>
<li class="sep">
  <a href="[{$oViewConf->getSelfLink()}]&cl=navigation&item=header.tpl&fnc=dgUpdateViews" target="_self" class="rc"><b>Views updaten[{ if $blViewSuccess }] &#10004;[{/if}]</b></a>
</li>