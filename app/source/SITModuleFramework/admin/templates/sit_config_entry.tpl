[{* ENTRY DATA *}]	
[{if $entryData}]
<div id="sitConfigTabsMain">

	<div class="sitConfigTabMain" id="MAIN">Einstellungen</div>
	[{if $entryData.tab }]
		[{foreach from=$entryData.tab key=tabName item="entryDataTab"}]
    		<div class="sitConfigTab" id="[{$tabName}]">[{$entryDataTab.tabtitle}]</div>
    	[{/foreach}]
 	[{/if}]

	<div class="sitConfigTabContentMain" id="MAIN_CONTENT">
        <div id="sitConfigTabContentDataMain">
    		<div id="sitConfigEntry">
        		<form id="sitConfigForm" action="" method="post" enctype="multipart/form-data">
        			
        			[{include file="sit_config_fields.tpl" entryData=$entryData}]
        				
    				[{if $entryData.specialfunctions }]
						[{foreach from=$entryData.specialfunctions key=moduleRoot item="specialfunction"}]
							<script type="text/javascript" src="[{$specialfunction.0.scriptroot}]SITModuleFramework/modules/[{$moduleRoot}]/javascript/[{$specialfunction.0.scriptfile}]"></script>
							<script type="text/javascript">
								specialfunction = '[{$specialfunction.0.function}]';
							</script>
							<div id="[{$specialfunction.0.function}]"></div>
    					[{/foreach}]
    				[{/if}]
        			
        		</form>
        	</div>
    	</div>
	</div>

	[{if $entryData.tab }]
        [{* CHECK ENTRY TABS *}]
    	[{foreach from=$entryData.tab key=tabName item="entryDataTab"}]
    		<div class="sitConfigTabContent" id="[{$tabName}]_CONTENT">
    			<div id="sitConfigTabContentList"></div>
    			<div id="sitConfigTabContentListNavigation"></div>
    			<div id="sitConfigTabContentData"></div>
    		</div>
    	[{/foreach}]
    [{/if}]
    
</div>	
[{* ENTRY DATA SUBTAB *}]	
[{elseif $entryDataTab}]
   <div id="sitConfigEntry">
		<form id="sitConfigForm" action="" method="post" enctype="multipart/form-data">
		
			[{include file="sit_config_fields.tpl" entryData=$entryDataTab}]
			
			[{if $entryDataTab.specialfunctions }]
				[{foreach from=$entryDataTab.specialfunctions key=moduleRoot item="specialfunction"}]
					<script type="text/javascript" src="[{$specialfunction.0.scriptroot}]SITModuleFramework/modules/[{$moduleRoot}]/javascript/[{$specialfunction.0.scriptfile}]"></script>
					<script type="text/javascript">
						var parentId = $('#sitConfigEntryData #MAIN_CONTENT').find('#sitConfigForm input[name="id"]').val();
						var specialfunctionTabData = '[{$specialfunction.0.function}]';
						window[specialfunctionTabData](parentId);
						specialfunction = '[{$specialfunction.0.function}]';
					</script>
					<div id="[{$specialfunction.0.function}]"></div>
    			[{/foreach}]
    		[{/if}]
		</form>
	</div>
[{/if}]
