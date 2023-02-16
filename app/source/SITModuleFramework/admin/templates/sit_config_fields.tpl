[{*
<pre>
[{$entryData|print_r}]
</pre>
*}]

[{assign var="showsavebutton" value="false"}]
[{assign var="lastGroup" value=""}]
[{foreach from=$entryData key=indexVal item=currentConfig}]

	[{if $currentConfig.group != "" && ($lastGroup == "" || $lastGroup != $currentConfig.group)}]
		
		[{if $lastGroup != ""}]
			</dd>
		</dl>
		[{/if}]
		[{assign var="lastGroup" value=$currentConfig.group}]
		<dl class="sitConfigFieldGroupTitle" id="[{$currentConfig.group}]">
			<dt>[{$currentConfig.group}]</dt>
			<dd>
	[{/if}]

[{if $indexVal != "tab" && $indexVal != "specialfunctions" }]
<div id="sitConfigField">
	[{if $indexVal == "id" || $indexVal == "oxid"}]
		<input type="hidden" value="[{$currentConfig.value}]" name="id">
	[{elseif $currentConfig.visibility != "hidden"}]	
  
		[{if $currentConfig.type != "boolean" && $currentConfig.type != "button"}]
			<div id="sitConfigEntryTitle">[{$currentConfig.entrytitle}]</div>
			<div id="sitConfigEntryDescription">
				<span>[{$currentConfig.description}]</span>
			</div>
		[{/if}]

		<div id="sitConfigEntryValue" class="[{$currentConfig.type}]">
			[{if $currentConfig.valueArray|count > 0}]

				[{assign var="showsavebutton" value="true"}]

				<select name="[{$currentConfig.name}]" style="width: 100%; height: 38px;">
					<option value="">-</option>
				[{foreach from=$currentConfig.valueArray key=optionId item="currentOption" }]
					<option value="[{$optionId}]" [{if $currentOption.selected}]selected[{/if}]>[{$currentOption.value}] [{if $optionId != $currentOption.value}] - [{$optionId}][{/if}]</option>
				[{/foreach}]
				</select>
		
			[{elseif $currentConfig.type == "varchar"}]

				[{assign var="showsavebutton" value="true"}]

				<input type="text" value=[{if $currentConfig.value == '"'}]'"'[{else}]"[{$currentConfig.value}]"[{/if}] name="[{$currentConfig.name}]" size="40" />

			[{elseif $currentConfig.type == "boolean"}]

				[{assign var="showsavebutton" value="true"}]

				<input type="checkbox" name="[{$currentConfig.name}]" value="1" [{if $currentConfig.value == 1}]checked[{/if}] />

			[{elseif $currentConfig.type == "text"}]

				[{assign var="showsavebutton" value="true"}]

				<textarea name="[{$currentConfig.name}]" cols="40" rows="5">[{$currentConfig.value}]</textarea>

			[{elseif $currentConfig.type == "file"}]
			
				[{assign var="showsavebutton" value="true"}]

				<input id="fileuploadText" type="text" value="[{$currentConfig.value}]" name="[{$currentConfig.name}]_cfgfile" size="40"/>
				<button id="fileuploadButton" name="[{$currentConfig.name}]">Datei auswählen</button>
				<div style="width: 0px; height: 0px; overflow: hidden;">
					<input id="fileupload" name="files[]" type="file" />
				</div>				
				<div id="progress">
    				<div class="bar" style="width: 0%;"></div>
				</div>
				
			[{elseif $currentConfig.type == "list"}]			
				
				<div class="select">
					Selektiert<br><br>
					<select name="[{$currentConfig.name}]selection" size="10" multiple="multiple">
					[{foreach from=$currentConfig.valueArraySelection key=optionId item="currentOption" }]
						<option value="[{$optionId}]">[{$currentOption}]</option>
					[{/foreach}]
					</select>
					<br>
					<button name="[{$currentConfig.name}]" id="listButton">Auswahl entfernen</button>
				</div>
				
				<div class="select">
					Verf&uuml;gbar<br><br>
					<select name="[{$currentConfig.name}]option" size="10" multiple="multiple">
					[{foreach from=$currentConfig.valueArrayOption key=optionId item="currentOption" }]
						<option value="[{$optionId}]">[{$currentOption}]</option>
					[{/foreach}]
					<br>
					</select>
					<br>
					<button name="[{$currentConfig.name}]" id="listButton">Auswahl hinzuf&uuml;gen</button>
				</div>
				
			[{elseif $currentConfig.type == "button"}]
			 
				<button name="[{$currentConfig.name}]">[{$currentConfig.entrytitle}]</button>
							
			[{/if}]
		</div>

		[{if $currentConfig.type == "boolean"}]
			<div id="sitConfigEntryTitle">[{$currentConfig.entrytitle}]</div>
			<div id="sitConfigEntryDescription">
				<span>[{$currentConfig.description}]</span>
			</div>
		[{/if}]

		<div id="sitClear"></div>
	[{/if}]
</div>
[{/if}]
[{/foreach}]

[{if $lastGroup != ""}]
		</dd>
	</dl>
[{/if}]
[{if $showsavebutton == "true"}]
	<input type="submit" value="[{if $entryData.id.value == 0}]Anlegen[{else}]Speichern[{/if}]" id="savebutton">
[{/if}]