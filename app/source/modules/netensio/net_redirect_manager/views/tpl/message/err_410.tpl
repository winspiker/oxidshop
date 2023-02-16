[{capture append="oxidBlock_content"}]
    <div class="err-410">
        <h1 class="page-header">[{oxmultilang ident="ERROR"}]</h1>
        <div class="row">
            <div class="col-md-6">
                <p>
                    [{if $sUrl}]
                        [{assign var="sModifiedUrl" value=$sUrl|escape }]
                        [{assign var="sModifiedUrl" value="<i><strong>'"|cat:$sModifiedUrl|cat:"'</strong></i>"}]
                        [{ oxmultilang ident="ERROR_410" args=$sModifiedUrl }]
                    [{else}]
                        [{oxmultilang ident="ERROR_410"}]
                    [{/if}]
                </p>

                <p>
                    [{oxmultilang ident="NET_ERR_410_START_TEXT"}]<br>
                    <a href="[{$oViewConf->getHomeLink()}]" class="btn btn-default" title="[{oxmultilang ident="NET_ERR_410_START_BUTTON"}]">[{oxmultilang ident="NET_ERR_410_START_BUTTON"}]</a>
                </p>

                <p>
                    [{oxmultilang ident="NET_ERR_410_CONTACT_TEXT"}]<br>
                    <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=contact"}]" class="btn btn-default" title="[{oxmultilang ident="NET_ERR_410_CONTACT_BUTTON"}]">[{oxmultilang ident="NET_ERR_410_CONTACT_BUTTON"}]</a>
                </p>
            </div>
        </div>
    </div>
[{/capture}]
[{include file="layout/page.tpl" blHideBreadcrumb=true}]