[{assign var="user" value=$edit->getOrderUser()}]

[{if $user->oxuser__ustid_lastcheck->value < date("Y-m-d",strtotime('-3 month')) or ($edit->oxorder__oxbillustid->value && !$user->oxuser__ustid_valid->value)}]
    <div class="alert alert-danger" style="color:red">
        <b>Achtung! Die UstID des Rechnungsempf&auml;ngers konnte nicht verifiziert werden<br> oder wurde zuletzt vor mehr als 3 Monaten gepr&uuml;ft!</b> <a class="jumplink" href="[{$oViewConf->getSelfLink()}]cl=admin_user&oxid=[{$edit->oxorder__oxuserid->value}]" target="basefrm" onclick="_homeExpActByName('admin_user');">User prüfen</a>    </div>
 [{/if}]


