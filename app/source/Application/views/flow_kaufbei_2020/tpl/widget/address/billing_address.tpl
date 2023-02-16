
[{if $oxcmp_user->oxuser__oxcompany->value}] [{$oxcmp_user->oxuser__oxcompany->value}]<br> [{/if}]
[{if $oxcmp_user->oxuser__oxaddinfo->value}] [{$oxcmp_user->oxuser__oxaddinfo->value}]<br>[{/if}]
[{if $oxcmp_user->oxuser__oxustid->value}] [{oxmultilang ident="VAT_ID_NUMBER"}] [{$oxcmp_user->oxuser__oxustid->value}] <br>
    [{if $oxcmp_user->oxuser__ustid_lastcheck->value < date("Y-m-d",strtotime('-3 month'))}]
        <div class="alert alert-danger" style="color:red">
            [{oxmultilang ident="VAT_RECHECK"}]
            <button id="userChangeAddress" class="btn btn-xs btn-warning pull-right submitButton largeButton" name="changeBillAddress" type="submit" title="[{oxmultilang ident="CHANGE"}]">
                <i class="fa fa-pencil"></i>
            </button>
            [{oxscript add="$('#userChangeAddress').click( function() { $('#addressForm').show();$('#addressText').hide();$('#userChangeAddress').hide();return false;});"}]
        </div>
    [{/if}]
[{/if}]
[{if $oxcmp_user->oxuser__oxsal->value || $oxcmp_user->oxuser__oxfname->value || $oxcmp_user->oxuser__oxlname->value}][{$oxcmp_user->oxuser__oxsal->value|oxmultilangsal}]&nbsp;[{$oxcmp_user->oxuser__oxfname->value}]&nbsp;[{$oxcmp_user->oxuser__oxlname->value}]<br>[{/if}]
[{if $oxcmp_user->oxuser__oxstreet->value || $oxcmp_user->oxuser__oxstreetnr->value}][{$oxcmp_user->oxuser__oxstreet->value}]&nbsp;[{$oxcmp_user->oxuser__oxstreetnr->value}]<br>[{/if}]
[{if $oxcmp_user->oxuser__oxstateid->value}][{$oxcmp_user->oxuser__oxstateid->value}] [{/if}]
[{if $oxcmp_user->oxuser__oxzip->value || $oxcmp_user->oxuser__oxcity->value}][{$oxcmp_user->oxuser__oxzip->value}]&nbsp;[{$oxcmp_user->oxuser__oxcity->value}]<br>[{/if}]
[{if $oxcmp_user->oxuser__oxcountry->value}][{$oxcmp_user->oxuser__oxcountry->value}]<br><br>[{/if}]
[{if $oxcmp_user->oxuser__oxusername->value}]<strong>[{oxmultilang ident="EMAIL"}]</strong> [{$oxcmp_user->oxuser__oxusername->value}]<br><br>[{/if}]
[{if $oxcmp_user->oxuser__oxfon->value}]<strong>[{oxmultilang ident="PHONE"}]</strong> [{$oxcmp_user->oxuser__oxfon->value}]<br>[{/if}]
[{if $oxcmp_user->oxuser__oxfax->value}]<strong>[{oxmultilang ident="FAX"}]</strong> [{$oxcmp_user->oxuser__oxfax->value}]<br>[{/if}]
[{if $oxcmp_user->oxuser__oxmobfon->value}]<strong>[{oxmultilang ident="CELLUAR_PHONE"}]</strong> [{$oxcmp_user->oxuser__oxmobfon->value}]<br>[{/if}]
[{if $oxcmp_user->oxuser__oxprivfon->value}]<strong>[{oxmultilang ident="PERSONAL_PHONE"}]</strong> [{$oxcmp_user->oxuser__oxprivfon->value}]<br>[{/if}]