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

function showPleaseWait()
{
     var mask = document.getElementById("pleasewaiting");
     
     for (i=0;i<document.getElementsByTagName("div").length; i++) { 
        if ( document.getElementsByTagName("div").item(i).className == "box") 
        {  
        	winW = document.getElementsByTagName("div").item(i).offsetWidth;
            winH = document.getElementsByTagName("div").item(i).offsetHeight;
        } 
     } 

     if(mask )
     {
         mask.style.height = winH - 2;
         mask.style.width = winW - 20;
         mask.style.left = 30;
         mask.style.visibility = 'visible';
     }
}

function hidePleaseWait()
{
    var mask = document.getElementById("pleasewaiting");
    if(mask) mask.style.visibility = 'hidden';
}

//-->
</script>
<style>
<!--

.box {
  background-image: url('https://update.draufgeschaut.de/img/dg.gif');
  background-repeat: no-repeat;
  background-position: right bottom;
} 
 
.dg { width: 24px;
      height: 24px;
      border: 1px solid #363431;
      padding: 1px 1px 1px 1px;
      background-color: #D1D2D2
}

.box {
  background-image: url('https://update.draufgeschaut.de/img/dg.gif?[{$smarty.now}]?[{$smarty.now}]?[{$smarty.now}]');
  background-repeat: no-repeat;
  background-position: right bottom;
}

div#pleasewaiting{
    background: red url('[{$oViewConf->getModuleUrl('dgotto','out/admin/img/loading-bar.gif') }]') no-repeat 50% 50%;
    z-index: 50;
    position: absolute; 
    top: 0px; 
    left: 0px; 
    width: 100%; 
    height: 100%; 
    background-color: rgb(255, 255, 255); 
    opacity: 0.8; 
    visibility: hidden;
}

.groupExp a.rc:hover b, .groupExp .exp a.rc b {
    color: #d4021d;
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
    <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
</form>

<div onclick="hidePleaseWait()" id="pleasewaiting" ></div>

<form name="myedit1" id="myedit1" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="InserTable" />
<input type="hidden" name="aStep" value="InserTable" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{$editlanguage}]" />

<div class="groupExp">
   <div[{if $aStep == "InserTable"}] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Installation Datenbank</b></a>
         <dl>
            <dt>
               <button type="submit" name="save" onclick="showPleaseWait();" [{$readonly}]>[{oxmultilang ident="DGOTTO_DB_SETUP"}]</button>
            </dt>
            <dd> </dd>
         </dl>
         <div class="spacer"></div>
   </div>
</div>
</form>

<form name="manufacturer" id="manufacturer" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="loadManufacturer" />
<input type="hidden" name="aStep" value="manufacturer" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{$editlanguage}]" />

<div class="groupExp">
   <div[{if $aStep == "manufacturer"}] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Brands downloaden</b></a>
         <dl>
            <dt style="font-weight:normal;">
               [{if $refreshBrands}]
                 [{$refreshBrands}] Brands eingetragen
               [{else}]
                  <button type="submit" name="save" onclick="showPleaseWait();" [{$readonly}]>Brands erstellen / aktualisieren</button>
               [{/if}]
            </dt>
            <dd> </dd>
         </dl>
         <div class="spacer"></div>
   </div>
</div>
</form>

<form name="categories" id="categories" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="loadCategories" />
<input type="hidden" name="aStep" value="categories" />
<input type="hidden" name="url" value="[{$refreshCategories->nextUrl}]" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{$editlanguage}]" />

<div class="groupExp">
   <div[{if $aStep == "categories"}] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Kategorien downloaden</b></a>
         <dl>
            <dt>
               [{if $refreshCategories->nextUrl}]
               <div class="errorbox">
                 <p style="color:#888;font-weight:normal;">
                  [{$refreshCategories->aInsertedCategories}] Kategorien eingetragen, aber es fehlen noch welche. Bitte weiterklicken
                 
                 <button type="submit" name="save" onclick="showPleaseWait();this.form.fnc.value='loadMoreCategories';" [{$readonly}]>weitere Kategorien erstellen</button>
                 </p>
               </div>
               [{elseif $refreshCategories->iInsertedCategories}]
                 [{$refreshCategories->iInsertedCategories}] Kategorien eingetragen
               [{else}]
                  <button type="submit" name="save" onclick="showPleaseWait();this.form.fnc.value='loadCategories';"  style="width: 230px;" [{$readonly}]>Kategorien erstellen / aktualisieren</button>
                  <br />
                  <button type="submit" name="save" onclick="this.form.target='_blank'" style="width: 230px;">neues Fenster</button>
               [{/if}]
            </dt>
            <dd> </dd>
         </dl>
         <div class="spacer"></div>
   </div>
</div>
</form>


[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]




















