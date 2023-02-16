[{$smarty.block.parent}]
<input type="hidden" id="folder_storno" name="where[oxorder][oxstorno]" value="[{ $where.oxorder.oxstorno }]">
<script type="text/javascript">
    folderSelect = document.search.folder;
    optionCount = folderSelect.options.length;
    option = document.createElement('OPTION');
    option.value='-1';
    option.innerHTML='[{ oxmultilang ident="Storniert" noerror=true}]';
    folderSelect.appendChild(option);
    folderSelect.setAttribute('onchange', ' if (this.selectedIndex=='+optionCount+') document.getElementById(\'folder_storno\').value=1; else document.getElementById(\'folder_storno\').value=\'\';'+folderSelect.getAttribute('onchange'));

    if (document.getElementById('folder_storno').value==1)
        folderSelect.selectedIndex = optionCount;





</script>