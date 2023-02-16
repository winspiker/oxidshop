[{* |layout/base.tpl|base_js|dggoogleanalytics_base_js.tpl|7| *}]
[{ $smarty.block.parent }]


[{capture name=dgAddGogleanAnaytics}][{/capture}] 

[{ insert name="dggoogleanalytics" position="bottom" add=$smarty.capture.dgAddGogleanAnaytics}]

[{assign var="oConf" value=$oView->getConfig()}]
[{ if $oConf->getConfigParam('dgGoogleEnhancedEcommerceActiv')}]
[{ if !$oConf->getConfigParam('dgGoogleAnalyticsJsLoad')}]
[{oxscript include="js/libs/jquery.min.js" priority=1}]
[{/if}]

[{capture name=dgGogleanAnaytics}]
[{strip}]  
 jQuery(document).ready(function($) { 
   [{ if $oView->getClassName() == "alist" || $oView->getClassName() == "search" || $oView->getClassName() == "vendorlist" || $oView->getClassName() == "manufacturerlist" || $oView->getClassName() == "start"}] 
   $(".productData .submitButton, .productData a.viewAllHover, .productData a.title").bind("click", function() { 
      if( dgGoogleProducts !== null ){
        var aid = $(this).parent().closest('li').find('input[name="anid"][type="hidden"]:first').val();
        for(var i = 0, a = null; i < dgGoogleProducts.length; ++i) {
          if( dgGoogleProducts[i].anid == aid ) { 
            var a = dgGoogleProducts[i]; 
            ga("ec:addProduct", { "id": a.id, "name": a.id, "price": a.price, "category": a.category, "brand": a.brand, "variant": a.variant, "position": a.position, "list": a.list });
            ga("ec:setAction", "click", { "list": a.list });
            ga("send", "event", "UX", "click", a.id, { "nonInteraction": true });
            break; 
         }
      }}
   });
   [{/if}]
   [{if $oView->getClassName() == "details" || $oView->getClassName() == "start" }] 
   $(".articleBoxImage a, .articleTitle a").bind("click", function() { 
    if( dgGoogleProducts !== null ){
      var href = $(this).attr('href');
      for(var i = 0, href = null; i < dgGoogleProducts.length; ++i) {
        if( dgGoogleProducts[i].link == href ) { 
            var a = dgGoogleProducts[i]; 
            ga("ec:addProduct", { "id": a.id, "name": a.id, "price": a.price, "category": a.category, "brand": a.brand, "variant": a.variant, "position": a.position, "list": a.list });
            ga("ec:setAction", "click", { "list": a.list });
            ga("send", "event", "UX", "click", a.list, { "nonInteraction": true } );
            break; 
         }
       }}
   });   
   [{/if}] 
   
   [{ foreach from=$oView->getBreadCrumb() name='dgposiotion' item=sCrum}]
     [{capture append="dgBreadCrumb"}][{ $sCrum.title|replace:'"':''|replace:'/':'>' }][{/capture}]
   [{/foreach }]
    
   $("body a").bind("click", function() { 
      ga( "send", { "hitType": "event", "eventCategory": "[{ $oView->getClassName() }]", "eventAction": "click", "eventLabel": [{ if $dgBreadCrumb|count }][{ ' > '|implode:$dgBreadCrumb|json_encode }][{else}]""[{/if}], "nonInteraction": true });
   });   
   
   $(".search").submit( function(){
      ga("send", "event", "keyword_search", "submit", $("#searchParam").val(), { "nonInteraction": true });
   });        
});
[{/strip}]
[{/capture}] 
[{oxscript add=$smarty.capture.dgGogleanAnaytics }] 
[{/if}]