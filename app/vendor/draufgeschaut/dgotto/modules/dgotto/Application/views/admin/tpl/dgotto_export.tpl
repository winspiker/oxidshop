[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<script type="text/javascript">
<!--
[{if $updatelist == 1}]
    UpdateList('[{$oxid}]');
[{/if}]

function UpdateList( sID)
{
    var oSearch = parent.list.document.getElementById("search");
    oSearch.oxid.value=sID;
    oSearch.submit();
}
function _groupExp(el) {
    var _cur = el.parentNode;

    if (_cur.className == "exp") _cur.className = "";
      else _cur.className = "exp";
}

//-->
</script>
<style>
<!--

.box {
  background-image: url('https://www.draufgeschaut.de/img/dg.gif?[{$smarty.now}]');
  background-repeat: no-repeat;
  background-position: right bottom;
}

.dg { width: 24px;
      height: 24px;
      border: 1px solid #363431;
      padding: 1px 1px 1px 1px;
      background-color: #D1D2D2
}

.greenbox{
    width: 6px;
    height: 6px;
    border: 1px solid #808080;
    background-color: #008000;
    float: left;
    margin: 4px 8px 4px 0px;
}

.redbox{
    width: 6px;
    height: 6px;
    border: 1px solid #808080;
    background-color: #C23410;
    float: left;
    margin: 4px 8px 4px 0px;
}

-->
</style>

[{if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

[{cycle assign="_clear_" values=",2"}]

<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oxid}]" />
    <input type="hidden" name="cl" value="dgotto_export" />
    <input type="hidden" name="actshop" value="[{$shop->id}]" />
    <input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
</form>

     <div class="groupExp">
        <div[{if $aStep == 1 || !$aStep}] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"></b></a>
            <dl>
              <dd>
                 <fieldset style="padding: 10px; width: 600px;">
                 <legend><b>Export durchf&uuml;hren</b></legend>
                 <form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" target="dynexport_do" method="post">
                 [{$oViewConf->getHiddenSid()}]
                 <input type="hidden" name="cl" value="dgotto_do" />
                 <input type="hidden" name="fnc" value="dgstart" />
                 <input type="hidden" name="shp" value="[{$oOtto->getShopId()}]" />
                 <input type="hidden" name="iPlace" value="[{$oOtto->getLocation()}]" />
                 <input type="hidden" name="pass" value="[{$oOtto->getCronjobKey()}]" />
                   [{oxmultilang ident="GENERAL_CATEGORYSELECT"}]<br />
                 <select name="acat[]" size="10" class="editinput" style="width: 210px;" multiple="multiple">
                  [{foreach from=$cattree item=oCat}]
                  <option value="[{$oCat->getId()}]">[{$oCat->oxcategories__oxtitle->value}]</option>
                  [{/foreach}]
                </select>
                <br /><br />

                <br />Exportart: 
                <select name="ExportArt" size="1" class="editinput">
                  [{foreach from=$ExportArt key=fnc item=oArt}]
                  <option value="[{$fnc}]">[{$oArt}]</option>
                  [{/foreach}]
                </select>
                <br />
                <br />
                <button onclick="this.form.target='dynexport_do'" type="submit" class="edittext" style="width: 210px;" name="save">[{oxmultilang ident="GENERAL_ESTART"}]</button>
                <br />
                <button onclick="this.form.target='_blank'" type="submit" class="edittext" style="width: 210px;" name="save">neues Fenster</button>
                </form>
                </fieldset>
                <br />
                <fieldset style="padding: 10px; width: 600px;">
                <legend><b>Exportstatus</b></legend>
                <iframe name="dynexport_do" marginwidth="0" marginheight="0" height="30" width="590" style="border: 1px solid #FFFFFF" src="[{$oViewConf->getSelfLink()}]&cl=dgotto_do&sid=[{$oViewConf->getSessionId()}]" scrolling="no"></iframe>
                </fieldset>
			  </dd>
            <div class="spacer"></div>
          </dl>
       </div>
    </div> 

</form>

[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]