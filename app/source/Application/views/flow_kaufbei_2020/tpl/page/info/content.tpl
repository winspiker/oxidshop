[{capture append="oxidBlock_content"}]
    [{assign var="oContent" value=$oView->getContent()}]
    [{assign var="tpl" value=$oViewConf->getActTplName()}]
    [{assign var="oxloadid" value=$oViewConf->getActContentLoadId()}]
    [{assign var="template_title" value=$oView->getTitle()}]
	[{ if $template_title != 'Go' }]
    <h1 class="page-header">[{$template_title}]</h1>
	[{/if}]
    <article class="cmsContent">
        [{ if $template_title != 'Karriere' }]
        	[{$oView->getParsedContent()}]
        [{else}]
        [{$oView->getParsedContent()}]
        <br>
        <br>
        	<ul class="list-carrier">
				<li><a href="[{ oxgetseourl ident="strategischereinkaufer" type="oxcontent" }]">Strategischer Einkäufer (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="oxbrokaufmann" type="oxcontent" }]">Bürokaufmann / Bürokauffrau (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="oxeinkaufsmanager" type="oxcontent" }]">Einkaufsmanager (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="fachkraftfrlagerlogistik" type="oxcontent" }]">Fachkraft für Lagerlogistik (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="oxgastmoderator" type="oxcontent" }]">Gast-Moderator (m/w/d) auf Selbstständiger Basis</a></li>
        		<li><a href="[{ oxgetseourl ident="oxkundenberater" type="oxcontent" }]">Kundenberater in Teilzeit oder Vollzeit (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="oxlagermitarbeiter" type="oxcontent" }]">Lagermitarbeiter in Teilzeit oder Vollzeit (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="oxmoderator" type="oxcontent" }]">Moderator (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="onlinemarketingmanager" type="oxcontent" }]">Online Marketing Manager (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="oxproduktmanagerbeauty" type="oxcontent" }]">Produktmanager Beauty (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="oxproduktmanager" type="oxcontent" }]">Produktmanager (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="programmiererphp" type="oxcontent" }]">Programmierer PHP (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="oxstudentischeaushilfe" type="oxcontent" }]">Studentische Aushilfe - Logistik (m/w/d)</a></li>
        		<li><a href="[{ oxgetseourl ident="webprogrammierer" type="oxcontent" }]">Web-Programmierer (m/w/d)</a></li>

        	</ul>
        [{/if}]
        
	
		[{ if $template_title == 'TVSHOP' || $oView->getClassName() == "start" }]
		<script>
			var $source_inline = 'https://api.alpaca.t62a.com/hls/9103/index.m3u8';
			if(document.querySelector('.languages-menu li.active a').getAttribute('hreflang') == 'ru') {
				$source_inline = 'https://api.alpaca.t62a.com/hls/9112/index.m3u8';
			}
			var player = new Clappr.Player( {
			  source: $source_inline,
			  parentId: "#player",
			  autoPlay: false,
			  width: '100%',
			  height: '100%',
			  hlsMinimumDvrSize: 999999,
			  plugins: [LevelSelector],
			  levelSelectorConfig: {
				labelCallback: function(playbackLevel, customLabel) {
				  return playbackLevel.level.height + 'p';
				}
			  },
			} );
 		</script>
       [{/if}]
    </article>

    [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]
[{include file="layout/page.tpl"}]