[{foreach from=$listData item=listRow name="rows"}]

	[{assign var="idName" value="sitConfigList2"}]
   	[{if $smarty.foreach.rows.iteration == 1}]
   		[{assign var="idName" value="sitConfigHeader"}]
	[{else if $smarty.foreach.rows.iteration % 2 == 0 }]
   		[{assign var="idName" value="sitConfigList1"}]
   	[{/if}]

	<div id="[{$idName}]">
		[{assign var="count" value=$listRow.columns|count}]
		[{if $listRow.columns.0.nodelete == true}]
			[{math a=100 b=$count equation="a / (b-1)" assign="size"}]
		[{else}]
			[{math a=100 b=$count equation="a / b" assign="size"}]
		[{/if}]
		[{foreach from=$listRow.columns item=listColumn name="cols"}]
		
			<div id="sitConfigListItem" style="width: [{$size}]%; max-width: [{$size}]%;" 
				[{if $smarty.foreach.rows.iteration == 1}]
					[{if $sortField == $listColumn.column}]
						class="[{$sortOrder}]"
					[{/if}]
				[{/if}]
			>
				
			[{* Write header row *}]
				[{if $smarty.foreach.rows.iteration == 1}]
					
					[{* Write delete div and id to first column *}]
					[{if ($smarty.foreach.cols.iteration == 1 && $listColumn.nodelete == false) || $smarty.foreach.cols.iteration > 1 }]
							<div id="sitConfigListItemVarchar"
					
							data-sortfield="[{$listColumn.column}]"
					
							[{if $sortField == $listColumn.column}]
					
								[{if $sortOrder == "ASC"}]
									data-newsortorder="DESC"	
								[{else}]
									data-newsortorder="ASC"
								[{/if}]
								class="[{$sortOrder}]"
							[{else}]
								data-newsortorder="ASC"
							[{/if}]
					
							>[{$listColumn.name}]</div>
					
							[{foreach from=$listColumn.filter item=listFilter name="filters"}]
								<div id="sitConfigListItemFilter"> 
            						<input id="filter" name="[{$listFilter.name}]" class="filter" type="text" value="[{$listFilter.value}]" /> 
            					</div>
							[{/foreach}]
					[{/if}]
					
			[{* Write data row *}]
				[{else}]
				
					[{* Write delete div and id to first column *}]
						[{if $smarty.foreach.cols.iteration == 1}]
						
							[{if $listColumn.nodelete == false}]
								<div id="sitConfigListItemDelete" title="Eintrag mit ID [{$listColumn.value}] entfernen"></div>
							[{/if}]
							<div id="sitConfigListItemId">[{$listColumn.value}]</div>
							
					[{* Write value to other colums *}]
						[{else}]
						
							<div id="sitConfigListItemVarchar">[{$listColumn.value}]</div>
						[{/if}]
				
				[{/if}]
				
			</div>
			
		[{/foreach}]

	</div>
	<div id="sitClear"></div>
[{/foreach}]