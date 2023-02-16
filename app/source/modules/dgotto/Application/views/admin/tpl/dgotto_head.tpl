<script type="text/javascript">
<!--
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

function dgMoveAttribute(sId)
{
    var dgFrorm = document.getElementById("dgMoveAttributeTransfer");
    var bestaetigung = window.confirm( 'Soll "' + sId + '" aus dem Bereich "[{$dgOttoCategories->dgottocategories__oxcategory->value}]" entfernt werden?\n\nEin Reset der Attribute ist im GrundModul unter Admineinstellungen einzustellen.');
    if(bestaetigung){
       
       dgFrorm.atr.value=sId;
       dgFrorm.submit();
    }
}

function dgMoveTopList(sId)
{
    var dgFrorm = document.getElementById("dgMoveAttribute2Toplist");
    var bestaetigung = window.confirm( 'Soll "' + sId + '" aus dem Bereich "[{$dgOttoCategories->dgottocategories__oxcategory->value}]" entfernt werden?\n\n und in der oberren Liste einfuegen\n\nEin Reset der Attribute ist im GrundModul unter Admineinstellungen einzustellen.');
    if(bestaetigung){
       
       dgFrorm.atr.value=sId;
       dgFrorm.submit();
    }
}

function dgRemoveFromMoveTopList(sId)
{
    var dgFrorm = document.getElementById("dgRemoveFromMoveTopList");
    var bestaetigung = window.confirm( 'Soll "' + sId + '" aus dem Bereich "[{$dgOttoCategories->dgottocategories__oxcategory->value}]" entfernt werden?\n\n und in der oberren Liste einfuegen\n\nEin Reset der Attribute ist im GrundModul unter Admineinstellungen einzustellen.');
    if(bestaetigung){
       
       dgFrorm.atr.value=sId;
       dgFrorm.submit();
    }
}


function changeField(sName)
{
        var oField = document.getElementsByName( sName );
        doChange( oField[0], oField[1] );
        doChange( oField[1], oField[0] )
}

function doChange( oField1, oField2 )
    {
        if ( oField1.disabled ) {
            oField1.disabled = '';
            oField1.style.display = '';
            oField1.value = oField2.value;
        } else {
            oField1.disabled = 'disabled';
            oField1.style.display = 'none';
            oField2.value = oField1.value;
        }
    }

//-->
</script>
<style type="text/css">
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

.greenbutton_{
    background-color:#035303;
    border-color:#035303;
    color:#fff;width:32px;
}
.redbutton_{
    background-color:#c60909;
    border: 1px solid #c60909;
    color:#fff;width:32px;
}

.headerbutton{
    width:32px;
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
   opacity: 0.5;
   visibility: hidden; 
}

.search-results {
	left: auto;
    position: absolute;
    right: auto;
    top: auto;
    z-index: 1650;
    width: 550px;
    background: #fff;
    -moz-box-shadow: 2px 2px 5px #666;
    -webkit-box-shadow: 2px 2px 5px #666;
    box-shadow: 2px 2px 5px #666;
    display: table-row-group;
    overflow:scroll;
    max-height:250px;
}

#searchresults table{
    width: 550px;
}

#searchresults td{
    vertical-align: top;
    padding: 3px;
    border-bottom: 1px solid #eceff0;
    border-top: 1px solid #eceff0;
}

#searchresults tr:hover td{
    background: #eceff0;
}

.dgclosePop{
	float: right;
	padding:5px;
	-moz-border-radius: 2px;
    -webkit-border-radius: 2px;
    -khtml-border-radius: 2px;
    border-radius: 2px;
    background: #666666;
    margin:2px;
}

.box {
  background-image: url('https://www.draufgeschaut.de/img/dg.gif?[{$smarty.now}]');
  background-repeat: no-repeat;
  background-position: right bottom;
} 


.aiotto{
    background-size: 12px 12px;
    background: transparent url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAhFBMVEX////5+fny8vLr6+vxs7T1yMnaMzf+9/f0w8TbNTnaMDTyuLrtm53bOz788PH76On65OX53+D2zs/zvL7ytrfwrK7vp6nslpjofoHjZWjeS07eRkrdQkbcQEPZLDDXHyP++vr99PT98vL53d331dbwra/uoKLph4nphojgU1bYJyzYJyso7DFPAAAAaUlEQVQY07XBNQLDQAwEwE0i6djMGMb//y/9VW48g30o3dy5cuyIqzoF4GW2w2qGdVqC6RWS6a1/FNpGaCFvMmTia1taamf31d14herFdIXl1ycfgzwBpFRelE7yArcHn7HBIYJjBKfIH0aSBpChEX71AAAAAElFTkSuQmCC) no-repeat scroll 0px 50%!important;  
    padding-left: 20px!important;
}
.aiottoblock{
    display:block;
}
.aiottoblock:hover,
.aiotto:hover{
    text-decoration:none;
}

.groupExp .exp dt,
.groupExp .exp dl,
.groupExp dl dd,
.groupExp dl dt,
dl dt{
    font-weight:normal!important;
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
[{oxscript include="js/libs/jquery.min.js"}]
[{oxscript include="js/libs/jquery-ui.min.js"}]
