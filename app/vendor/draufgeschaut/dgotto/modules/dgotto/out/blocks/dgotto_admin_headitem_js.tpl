[{if $oViewConf->getTopActiveClassName() == "order_list" || $oViewConf->getTopActiveClassName() == "article_list"}]
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript">
$( document ).ready(function() {
    var iColSpan = $('td.pagination').attr( 'colspan' );
    $('td.pagination').attr( 'colspan', iColSpan + 1 ); 
});
</script>
<style>
<!--
.aiotto{
    background-size: 12px 12px;
    display:block;
    background: transparent url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAhFBMVEX////5+fny8vLr6+vxs7T1yMnaMzf+9/f0w8TbNTnaMDTyuLrtm53bOz788PH76On65OX53+D2zs/zvL7ytrfwrK7vp6nslpjofoHjZWjeS07eRkrdQkbcQEPZLDDXHyP++vr99PT98vL53d331dbwra/uoKLph4nphojgU1bYJyzYJyso7DFPAAAAaUlEQVQY07XBNQLDQAwEwE0i6djMGMb//y/9VW48g30o3dy5cuyIqzoF4GW2w2qGdVqC6RWS6a1/FNpGaCFvMmTia1taamf31d14herFdIXl1ycfgzwBpFRelE7yArcHn7HBIYJjBKfIH0aSBpChEX71AAAAAElFTkSuQmCC) no-repeat scroll 50% 50%;  
}
.aiottoblock{
    display:block;
}
.aiottoblock:hover,
.aiotto:hover{
    text-decoration:none;
    color:transparent;
}
</style>
[{/if}]
[{$smarty.block.parent}]