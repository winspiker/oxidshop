[{if $oViewConf->getActiveClassName() == "search" || $oViewConf->getActiveClassName() == "alist" || $oViewConf->getActiveClassName() == "manufacturerlist"}]

	[{assign var="currency" value=$oView->getActCurrency()}]
	[{assign var="currentSession" value=$oViewConf->getSession()}]
	[{assign var="basePath" value=$oViewConf->getBaseDir()}]

	<link rel="stylesheet" type="text/css" href="[{$basePath}]SITModuleFramework/modules/SITMultiFilter/css/SITMultiFilter.css">

	<div id="mf_filterList"></div>

	[{oxscript include=$basePath|cat:"SITModuleFramework/modules/SITMultiFilter/javascript/SITMultiFilter.js"}]

  	[{capture name="filterscript"}]
		mf_useLayoutAccordeonOpenFirst = true;
        mf_rewriteBase          = '[{$basePath}]';
        mf_currencyId           = '[{$currency->id}]';
		mf_languageId           = '[{$oViewConf->getActLanguageId()}]';
		mf_shopId     			= '[{$oViewConf->getActiveShopId()}]';
        mf_sessionId			= '[{$currentSession->getId()}]';
        mf_sessionToken			= '[{$currentSession->getSessionChallengeToken()}]';

		[{if $oViewConf->getActiveClassName() == "search"}]
			mf_categoryId           = 'search';
		[{elseif $oViewConf->getActiveClassName() == "manufacturerlist"}]
			mf_categoryId           = 'manufacturer';
		[{else}]
			mf_categoryId           = '[{$oViewConf->getActCatId()}]';
		[{/if}]

		if ( $('#boxwrapper_productList').length ) {
			mf_mainContainerId 		= 'boxwrapper_productList';
		}
		else if ( $('#boxwrapper_searchList').length ) {
			mf_mainContainerId 		= 'content';
		}
		else {
			mf_mainContainerId = 'boxwrapper_productList';
			$('#content').append('<div id="boxwrapper_productList"><div class="list-container" id="productList"></div></div>');
		}

		[{if $smarty.get.pgNr > 0}]
			mf_currentPage = [{$smarty.get.pgNr}];
		[{/if}]
		
		$(document).ready(function() {

			[{if $smarty.get.setFilter == 1}]
				mf_setFilter('[{$smarty.get.filter}]');
				mf_coreStartFilterRequest(true, true, true, false);
			[{else}]
			
				[{if $oViewConf->getActiveClassName() == "search"}]
					if ( typeof ps_loadFilter != 'function' ) {
						mf_coreStartFilterRequest(true, false, false, true);
					}
				[{else}]
						mf_coreStartFilterRequest(true, false, false, true);
				[{/if}]
			[{/if}]
		});

	[{/capture}]
	[{oxscript add=$smarty.capture.filterscript}]
	
  	[{capture name="imagescript"}]
		function mf_loadHtmlArticlesHook() {
		   
			$('#content').find('.img-responsive').each(
				function() {
					$(this).attr('src', $(this).attr('data-src'));
				}
			);
			$('#content').find('.img-fluid').each(
				function() {
					$(this).attr('src', $(this).attr('data-src'));
				}
			);
			$('#content').find('.dropdown-menu li').each( 
				function() {
					$(this).bind('click', function(a) {
						a.preventDefault();
						var b = $(this);
						b.parent().prev().val(b.children().first().data("selection-id"));
						b.closest("form").submit();
					});
				}
			);
			$('#mf_productList').find('li.productData input[name^="pgNr"]').each(function() {
			
				$(this).val(mf_currentPage);
			});
		}
	[{/capture}]
	[{oxscript add=$smarty.capture.imagescript}]
	
[{/if}]
[{$smarty.block.parent}]