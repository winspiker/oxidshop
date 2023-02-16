[{strip}]
					[{if $oView->getBreadCrumb()}]
                    <ol id="breadcrumb" class="breadcrumb" itemscope itemtype="http://schema.org/BreadcrumbList">
                			
                        <li class="text-muted" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"><a href="/" itemprop="item"><span itemprop="name">Startseite</span></a><meta itemprop="position" content="1" /></li>
                            
                            [{foreach from=$oView->getBreadCrumb() item="sCrum" name="breadcrumb"}]
                                <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" [{if $smarty.foreach.breadcrumb.last}] class="active"[{/if}]>
                                    <a href="[{if $sCrum.link}][{$sCrum.link}][{else}]#[{/if}]" title="[{$sCrum.title|escape:'html'}]" itemprop="item">
                                        <span itemprop="name">[{$sCrum.title}]</span>
                                    </a>
                                    <meta itemprop="position" content="[{math equation="x + y" x=$smarty.foreach.breadcrumb.index y=2}]" />
                                </li>
                            [{/foreach}]
                   
                    </ol>
                    [{/if}]

     
    [{/strip}]