[{* |headitem.tpl|admin_headitem_js|dgidealo_admin_headitem_js.tpl|1| *}]

[{ if $oViewConf->getTopActiveClassName() == "order_list" }]
[{assign var="oIdealo" value=$oView->getIdealo() }]
[{ if !$oIdealo->getIdealoParam('dgIdealoDontShowOrderList') }]  
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript">
$( document ).ready(function() {
    var iColSpan = $('td.pagination').attr( 'colspan' );
    $('td.pagination').attr( 'colspan', iColSpan + 1 ); 
});
</script>
[{/if}]


[{ elseif $oViewConf->getTopActiveClassName() == "article_list" }]

   [{assign var="oIdealo" value=$oView->getIdealo() }]

   [{ if (( $oIdealo->getIdealoParam('dgIdealoActive') != "" && $oIdealo->getIdealoParam('dgIdealoActive')|lower != "oxactive" ) || $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" ) && !$oIdealo->getIdealoParam('dgIdealoDontShowArticleList') }]  
   <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
   <script type="text/javascript">$( document ).ready(function() { var iColSpan = $('td.pagination').attr( 'colspan' );  $('td.pagination').attr( 'colspan', iColSpan + 1 ); });</script>
   <style>
   <!--
   .idico{ display: block; text-align: center; background: transparent url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyxpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDIxIDc5LjE1NDkxMSwgMjAxMy8xMC8yOS0xMTo0NzoxNiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIEVsZW1lbnRzIDEzLjAgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjUzNThEOUJFRTFDQjExRTk5MDQ5RDg0RkExMzdGMDk4IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjUzNThEOUJGRTFDQjExRTk5MDQ5RDg0RkExMzdGMDk4Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NTM1OEQ5QkNFMUNCMTFFOTkwNDlEODRGQTEzN0YwOTgiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NTM1OEQ5QkRFMUNCMTFFOTkwNDlEODRGQTEzN0YwOTgiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6B27IZAAAAO0lEQVR42mLkMk9kIAUwMZAISNbAgsb/emIehMFtkTRInITLJUPJD+gu1J8PdeHFRHo5iXHwJT6AAAMA9M4LELcdBPYAAAAASUVORK5CYII=) no-repeat scroll 50% 50%!important; }
   .didico{ display: block; text-align: center; background: transparent url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyxpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDIxIDc5LjE1NDkxMSwgMjAxMy8xMC8yOS0xMTo0NzoxNiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIEVsZW1lbnRzIDEzLjAgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkVCODNGRjdFRTFDQjExRTk5ODUxQkEzQUJEQjM1MzBBIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkVCODNGRjdGRTFDQjExRTk5ODUxQkEzQUJEQjM1MzBBIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6RUI4M0ZGN0NFMUNCMTFFOTk4NTFCQTNBQkRCMzUzMEEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6RUI4M0ZGN0RFMUNCMTFFOTk4NTFCQTNBQkRCMzUzMEEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7LtlNZAAAA9klEQVR42mL8//8/AymAkQoaPnz/e+nZDyDDTpkbi47/GODCk2/shReA6D82gN1JzTtetO56aafMgya+K1uZBcF7fIGh15Hh+weGmvMMDBJAgUN3vyCrtgW7EEmDsAKDbz2EcejuG0xr5YXYYBpuHmDY0ggVljVg4BJgYMCmQZANyQa4Tzj5gcThu191pTgEOJmRjffT5YdpUHdgUD+AZp6BNBfEDdichAHkBFkXn36HJuirwycgzYklHt5/+1O8/umB25+xcpkwjZ988PWUQ683XfkIjZOdL4DcS0+/44vppu3PgQZDuECzJx14Becy0jy1AgQYALTLznmQOp38AAAAAElFTkSuQmCC) no-repeat scroll 50% 50%!important; }
   .didico:hover, .idico:hover{ text-decoration:none; }
   -->
   </style>
   [{/if}]


[{/if}]
[{$smarty.block.parent}]
