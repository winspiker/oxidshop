
<input type="hidden" name="searchpopup" value="[{$searchpopup}]">


[{if (method_exists($oView,'getTplPopupShow') && $oView->getTplPopupShow('admin_formparams') )}]
<script type="text/javascript">



    function editThis( sID, func )
    {
        if (opener)
        {
            if (opener.setSelectedData)
            {
                opener.searchDialog_selectedoxid = sID;
                opener.setSelectedData();

                return;
            }
        }
        //exonn_retoure_end
        var oTransfer = top.basefrm.edit.document.getElementById( "transfer" );
        oTransfer.oxid.value = sID;
        oTransfer.cl.value = top.oxid.admin.getClass( sID );

        if (func)
            eval(func);
        //forcing edit frame to reload after submit
        top.forceReloadingEditFrame();

        var oSearch = top.basefrm.list.document.getElementById( "search" );
        oSearch.oxid.value = sID;
        oSearch.submit();
    }


</script>
[{/if}]