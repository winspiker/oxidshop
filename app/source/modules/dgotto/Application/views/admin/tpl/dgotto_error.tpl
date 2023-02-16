[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<script type="text/javascript">
<!--

function EditThis( sID)
{
    var oTransfer = document.getElementById("article");
    oTransfer.oxid.value=sID;
    oTransfer.cl.value='article';
    oTransfer.submit();
}

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

function showHelp()
{
     var mask = document.getElementById("dgpopup");
     
     for (i=0;i<document.getElementsByTagName("div").length; i++) { 
        if ( document.getElementsByTagName("div").item(i).className == "box") 
        {  
        	winW = document.getElementsByTagName("div").item(i).offsetWidth;
            winH = document.getElementsByTagName("div").item(i).offsetHeight;
        } 
     } 

     if(mask )
     {
         mask.style.left = (( winW - 400 ) / 2);
         mask.style.visibility = 'visible';
     }
}

function closeHelp()
{
    var mask = document.getElementById("dgpopup");
    if(mask) mask.style.visibility = 'hidden';
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

.dgask { width: 18px;
      height: 18px;
      border: 1px solid #363431;
      background-color: #295B7C; 
      color:#FFFFFF; 
      font-family:Arial; 
      font-weight:bold; 
      padding: 0px 3px 0px 3px;
}

.dglook { width: 18px;
      height: 18px;
      border: 1px solid #363431;
      background-color: #C23410; 
      color:#FFFFFF; 
      font-family:Arial; 
      font-weight:bold; 
      padding: 0px 6px 0px 6px;
}

.dgresult { width: 18px;
      height: 18px;
      border: 1px solid #363431;
      background-color: #008000; 
      color:#FFFFFF; 
      font-family:Arial; 
      font-weight:bold; 
      padding: 0px 3px 0px 3px;
}

.dgdelete{
      height: 18px;
      border: 1px solid #363431;
      background-color: #FFFFFF; 
      color:#C23410; 
      font-family:Arial; 
      font-weight:bold; 
      padding: 0px 3px 0px 3px;	
}

div#dgpopup  {
	position: absolute; 
	width:  400px; 
	height: 400px; 
	z-index: 151; 
	visibility: hidden; 
	left: 20%; 
	top: 1%;
	border: 1px solid #808080;
	background: #fafafa;
}

td#statistik{
   text-align: center;
   line-height: 20px;
   color: #fff;  
}

div#pleasewaiting{
     background: url('[{$oViewConf->getModuleUrl('dgotto','out/admin/img/loading-bar.gif') }]') no-repeat 50% 50%;
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

-->
</style>

[{if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

[{cycle assign="_clear_" values=",2"}]

<div onclick="hidePleaseWait()" id="pleasewaiting" ></div>

<form name="article" id="article" action="[{$oViewConf->getSelfLink()}]" method="post" target="new">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="cl" value="" />
    <input type="hidden" name="language" value="0" />
    <input type="hidden" name="editlanguage" value="0" />
</form>

<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
      [{$oViewConf->getHiddenSid()}]
      <input type="hidden" name="oxid" value="[{$oOtto->getShopId() }]" />
      <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
      <input type="hidden" name="actshop" value="[{$oOtto->getShopId()}]" />
      <input type="hidden" name="updatenav" value="" />
      <input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
    </form>

     <div class="groupExp">
     
        <div id="errorbox" class="exp">
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Fehlermeldungen</b></a>
            <dl>
              <dd>
                 <form action="[{$oViewConf->getSelfLink()}]" method="post">
                 <input type="hidden" name="fnc" value="" />
                 <input type="hidden" name="aStep" value="1" />
                 <input type="hidden" name="cl" value="dgotto_error" />
                 <input type="hidden" name="oxid" value="[{$oxid}]" />
                 [{$oViewConf->getHiddenSid()}]
                 <table border="0" cellspacing="0" cellpadding="3" width="100%">
                 <colgroup>
                   <col width="10%">
                   <col width="10%">
                   <col width="12%">
                   <col width="7%">
                   <col width="6%">
                   <col width="49%">
                   <col width="5%">
                 </colgroup>
                   <tr>
                      <td>                    
                        Datum: ( jjjj-mm-dd )<br />
                        <input name="editval[oxtimestamp]" value="[{$editval.oxtimestamp}]" size="20" />
                      </td>
                      <td>                    
                        Artikel Nr: <br />
                        <input name="editval[oxartnum]" value="[{$editval.oxartnum}]" size="20" />
                      </td>
                      <td>                    
                        Fehler: <br />
                        <select name="editval[oxerror]" size="1" onchange="Javascript:showPleaseWait();this.form.fnc.value='';this.form.submit();">
                        <option value="" [{if $editval.oxerror == ""}]SELECTED[{/if}]> - keine -</option>
                        [{foreach from=$distincterrorlist item=allitem}]
                        <option value="[{$allitem->dgottoerror__oxerror->value}]" [{if $allitem->dgottoerror__oxerror->value == $editval.oxerror}][{assign var="button" value=$allitem->dgottoerror__oxerror->value}]SELECTED[{/if}]>[{$allitem->dgottoerror__oxerror->rawValue}] ( [{$allitem->dgottoerror__amount->rawValue}] / [{$allitem->dgottoerror__oxplattform->value}] )</option>
                        [{/foreach}]
                        </select>
                      </td>
                      <td>
                        Art: <br />
                        <select name="editval[oxtype]" size="1"  onChange="Javascript:showPleaseWait();this.form.fnc.value='';this.form.submit();">
                          <option value="" [{if $editval.oxtype == ""       }]SELECTED[{/if}]> - keine -</option>
                          [{foreach from=$distinctoxerrortype item=allitem}]
                            <option value="[{$allitem->dgottoerror__oxerrortype->value}]" [{if $allitem->dgottoerror__oxerrortype->value == $editval.oxtype}]SELECTED[{/if}]>[{$allitem->dgottoerror__oxerrortype->value}] ( [{$allitem->dgottoerror__amount->rawValue}] / [{$allitem->dgottoerror__oxplattform->value}] )</option>
                           [{/foreach}]
                        </select>
                      </td>
                      <td>
                        Plattform: <br />
                        <select name="editval[oxplattform]" size="1"  onChange="Javascript:showPleaseWait();this.form.fnc.value='';this.form.submit();">
                        <option value=""        [{if $editval.oxtype == ""       }]SELECTED[{/if}]> - keine -</option>
                        [{foreach from=$distinctlocationlist item=allitem}]
                        <option value="[{$allitem->dgottoerror__oxplattform->value}]" [{if $allitem->dgottoerror__oxplattform->value == $editval.oxplattform}]SELECTED[{/if}]>[{$allitem->dgottoerror__oxplattform->value}] ( [{$allitem->dgottoerror__amount->rawValue}] )</option>
                        [{/foreach}]
                        </select>
                      </td>
                      <td align="left" valign="bottom">[{if $button}]<button type="submit" class="edittext" name="save" onclick="showPleaseWait();this.form.fnc.value='deletefromlog'">alle [{$button}] l&ouml;schen</button><button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='csvlog'">alle [{$button}] als CSV speichern</button>[{/if}] &nbsp; </td>
                      <td align="right" valign="bottom"><button type="submit" class="edittext" name="save" onclick="showPleaseWait();">anzeigen</button>&nbsp; </td>
                    </tr>
				  </form>
                  [{if $pageNavigation->NrOfPages > 1}]
                    <tr>
                      <td colspan="7" align="right">
                         <table width="100%">
                            <tr>
                              <td align="left" class="edittext">Seite [{$pageNavigation->actPage }] / [{$pageNavigation->NrOfPages }] ( [{$pageNavigation->iArtCnt}] Eintr&auml;ge )</td>
                              <td  align="right">[{if $pageNavigation->previousPage}]<a class="edittext" href="[{$pageNavigation->previousPage}]" >Seite zur&uuml;ck</a>[{/if}]
                                [{foreach key=iPage from=$pageNavigation->changePage item=page}]
                                [{if $iPage > ($pageNavigation->actPage - 10) && $iPage < ($pageNavigation->actPage + 10)}]
                                <a href="[{$page->url}]" class="[{if $iPage == $pageNavigation->actPage}]conftext2[{else}]edittext[{/if}]">[{$iPage}]</a>
                                [{/if}]
                                [{/foreach}]
                                [{if $pageNavigation->nextPage}] <a class="edittext" href="[{$pageNavigation->nextPage}]" >n&auml;chste Seite</a>[{/if}]
                              </td>
                            </tr>
                         </table>
                      </td>
                    </tr>
                  [{/if}]
                  [{if $errorlogs|@count > 0}]
				    <tr>
                       <td valign="top" class="listheader">Datum</td>
                       <td valign="top" class="listheader">ArtNr.</td>
                       <td valign="top" colspan="5" class="listheader">Beschreibung</td>
   	                </tr>
                  [{/if}]
                  [{assign var="blWhite" value=""}]
                  [{foreach from=$errorlogs item=allitem}]
                  <form name="article" id="[{$allitem->dgottoerror__oxobjectid->value}]" action="[{$oViewConf->getSelfLink()}]" method="post" target="dghelp">
                   [{$oViewConf->getHiddenSid()}]
                    <input type="hidden" name="oxid" value="[{$shopid}]"/>
                    <input type="hidden" name="cl" value="dgotto_help"/>
                    <input type="hidden" name="oxerror" value="[{$allitem->dgottoerror__oxerror->value}]"/>
                    <input type="hidden" name="oxerrorid" value="[{$allitem->dgottoerror__oxid->value}]"/>
                    <input type="hidden" name="oxobjectid" value="[{$allitem->dgottoerror__oxobjectid->value}]"/>
                  </form>
                    <tr>
                      <td valign="top" class="listitem[{$blWhite}]">[{$allitem->dgottoerror__oxtimestamp->value}]</td>
                      <td valign="top" class="listitem[{$blWhite}]">[{$allitem->dgottoerror__oxartnum->value}]</td>
                      <td colspan="5" class="listitem[{$blWhite}]">[{$allitem->dgottoerror__oxdesc->value}]
                      [{if $allitem->helpText}]<br /><br />[{$allitem->helpText}]
					  <li><span class="dgask">?</span>&nbsp;<a href="#" onclick="showHelp();return false;"><b>Hilfe aufrufen</b></a></li>[{else}]<ol class="noname" style="list-style-type: none;">[{/if}]
					  <li><span class="dgdelete">x</span>&nbsp;<a href="[{$sUrl}]&amp;fnc=removeError&amp;id=[{$allitem->dgottoerror__oxid->value}]"><b>Eintrag [{$allitem->dgottoerror__oxerror->value}] Artikel [{$allitem->dgottoerror__oxartnum->value}] l&ouml;schen</b></a></li><ol>
					   </ol>
					  </td>
   	                </tr>
                  [{if $blWhite == "2"}]
                     [{assign var="blWhite" value=""}]
                  [{else}]
                    [{assign var="blWhite" value="2"}]
                  [{/if}]
                    [{/foreach}]
                  [{if $pageNavigation->NrOfPages > 1}]
                    <tr>
                      <td colspan="7">
                         <table width="100%">
                            <tr>
                              <td align="left" class="edittext">Seite [{$pageNavigation->actPage }] / [{$pageNavigation->NrOfPages }]</td>
                              <td  align="right">[{if $pageNavigation->previousPage}]<a class="edittext" href="[{$pageNavigation->previousPage}]" >Seite zur&uuml;ck</a>[{/if}]
                                [{foreach key=iPage from=$pageNavigation->changePage item=page}]
                                [{if $iPage > ($pageNavigation->actPage - 10) && $iPage < ($pageNavigation->actPage + 10)}]
                                <a href="[{$page->url}]" class="[{if $iPage == $pageNavigation->actPage}]conftext2[{else}]edittext[{/if}]">[{$iPage}]</a>
                                [{/if}]
                                [{/foreach}]
                                [{if $pageNavigation->nextPage}] <a class="edittext" href="[{$pageNavigation->nextPage}]" >n&auml;chste Seite</a>[{/if}]
                              </td>
                            </tr>
                         </table>
                      </td>
                    </tr>
                  [{/if}]
                  </table> 

			  </dd>
            <div class="spacer"></div>
          </dl>
       </div>
    </div>
    
    <div class="groupExp">     
        <div>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Fehlermeldungen l&ouml;schen</b></a>
            <dl>
              <dd>
                 <form action="[{$oViewConf->getSelfLink()}]" method="post">
                 <input type="hidden" name="fnc" value="removeallerror" />
                 <input type="hidden" name="aStep" value="1" />
                 <input type="hidden" name="cl" value="dgotto_error" />
                 <input type="hidden" name="oxid" value="[{$oxid}]" />
                 [{$oViewConf->getHiddenSid()}]
                 <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">alle Fehlermeldungen l&ouml;schen</button>
			  </dd>
            <div class="spacer"></div>
          </dl>
       </div>
    </div>
	<div id="dgpopup"><div style="float: right"><a href="#" onclick="closeHelp();return false;" class="rc"><b>schliessen x</b></a>&nbsp;&nbsp;</div>
	</div>
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]