[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

[{ if $isDone }]
<div style="padding-left: 10px;">
	<table>
		<tr>
			<td style="padding-left: 30px;">
				<center>
					<h2>[{ oxmultilang ident="EXONNSENGINES_INSTALLATION_DONE" }]</h2>
					<!-- GO TO THIS OTHER PART..... -->
					
				</center>
			</td>
		</tr>
	</table>
	<br />
</div>
[{ else }]

<div>
	<h1>[{ oxmultilang ident="EXONNSENGINES_INSTALLATION_STARTING" }]</h1>
	
		<div>
            [{if (!$status)}]
            <p style="color: red;">[{ oxmultilang ident="EXONNSENGINES_INSTALLATION_ERROR"}]</p>
            [{else}]

			<form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink()}]" method="post">

			[{ $oViewConf->getHiddenSid() }]
            <input type="hidden" name="oxid" value="[{ $oxid }]">
            <input type="hidden" name="cl" value="exonn_sengines_install">
            <input type="hidden" name="fnc" value="">
            <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]">
            <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
            <input type="submit" value="[{ oxmultilang ident="EXONNSENGINES_INSTALL" }]"  onClick="Javascript:document.myedit.fnc.value='save'" />

			</form>
            [{/if}]
		</div>
</div>
[{/if}]
[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]