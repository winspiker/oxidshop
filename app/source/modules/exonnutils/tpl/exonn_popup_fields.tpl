[{assign var=oxidtemp value=$listitem->getId()}]
[{assign var=oxidblock value=exonn_popup_fields$oxidtemp}]

[{if ($searchpopup && method_exists($oView,'getTplPopupShow') && $oView->getTplPopupShow($oxidblock))}]

    <script type="text/javascript">
        aA = document.getElementById('row.[{$_cnt}]').getElementsByTagName('a');
        for(i=0; i<aA.length; i++) {
            if (aA[i].href.indexOf('top.oxid.admin.editThis(')) {
                aA[i].href = aA[i].href.replace('top.oxid.admin.editThis(','editThis(');
            }
        }

    </script>

    [{foreach from=$oView->aPopupFields item=field}]

        <div style="display:none" id="[{$field}]_[{ $listitem->getId()}]">[{ $listitem->$field->value }]</div>
    [{/foreach}]
[{/if}]