[{foreach from=$oxidBlock_sidebar item="_block"}]
    [{$_block}]
    [{/foreach}]

[{block name="sidebar"}]
    [{if $oView->getClassName() == 'alist' }]


    [{if false}]
        [{if $oxcmp_user && ($oxcmp_user->oxuser__oxusername->rawValue == 'alert@exonn.de' || $oxcmp_user->oxuser__oxusername->rawValue == 'k.zhilina@kaufbei.tv')}]
        [{else}]
        <div class="box well well-sm categorytree">
            <section>
                [{oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() deepLevel=0 noscript=1 nocookie=1}]
            </section>
        </div>
        [{/if}]
    [{/if}]

    [{assign var="oContentCat" value=$oView->getActiveCategory()}]

    [{if $oView->getActiveLangAbbr() == 'de' && $oContentCat->getId() == 'a3d8bf408f297ddbf264771ab2ab08b6'}]
    <div class="box-filter" style="padding: 30px; background: rgba(135,177,68,0.10);" data-category-id="{{ $oContentCat->getId() }}">
        <div class="title-filter">
            <p>TOP KATEGORIEN</p>
        </div>
        <ul class="list-item-filter list-cat">
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/Lebensmittel/Nahrungsmittel/Brotaufstriche/Fruchtaufstrich/Konfitueren/"><i class="far fa-angle-right"></i>Konfitüren</a>
            </li>
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/Lebensmittel/Nahrungsmittel/Honig/"><i class="far fa-angle-right"></i>Honig</a>
            </li>
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/Russische-Produkte/Pastila-Belyov/"><i class="far fa-angle-right"></i>Pastila Belyov</a>
            </li>
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/Lebensmittel/Wein-Spirituosen-Tabak/Spirituosen-Mischgetraenke/Vodka/"><i class="far fa-angle-right"></i>Vodka</a>
            </li>
        </ul>
    </div>
    [{/if}]
    [{if $oView->getActiveLangAbbr() == 'de' && $oContentCat->getId() == 'a4ef100acbbbf7135c9bc712235bdbd0'}]
    <div class="box-filter" style="padding: 30px; background: rgba(135,177,68,0.10);" data-category-id="{{ $oContentCat->getId() }}">
        <div class="title-filter">
            <p>TOP KATEGORIEN</p>
        </div>
        <ul class="list-item-filter list-cat">
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/Themenwelt/Drogerie-Beauty/Von-Wahl-Kosmetik/"><i class="far fa-angle-right"></i>Von Wahl Kosmetik</a>
            </li>
        </ul>
    </div>
    [{/if}]

    [{if $oView->getActiveLangAbbr() == 'ru' && $oContentCat->getId() == 'a3d8bf408f297ddbf264771ab2ab08b6'}]
    <div class="box-filter" style="padding: 30px; background: rgba(135,177,68,0.10);" data-category-id="{{ $oContentCat->getId() }}">
        <div class="title-filter">
            <p>TOP KATEGORIEN</p>
        </div>
        <ul class="list-item-filter list-cat">
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/ru/produkty-pitaniya/Prodovolystvennye-tovary/Varenye-i-dzhemy/Varenye/Dzhemy//"><i class="far fa-angle-right"></i>Джемы</a>
            </li>
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/ru/produkty-pitaniya/Prodovolystvennye-tovary/Med/"><i class="far fa-angle-right"></i>Мёд</a>
            </li>
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/ru/Tematicheskie-rubriki/Russkie-produkty/Pastila-Belevskaya/"><i class="far fa-angle-right"></i>Пастила Белёвская</a>
            </li>
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/ru/produkty-pitaniya/Alkogolynye-napitki-i-tabachnye-izdeliya/Alkogolynye-napitki/Vodka/"><i class="far fa-angle-right"></i>Водка</a>
            </li>
        </ul>
    </div>
    [{/if}]
    [{if $oView->getActiveLangAbbr() == 'ru' && $oContentCat->getId() == 'a4ef100acbbbf7135c9bc712235bdbd0'}]
    <div class="box-filter" style="padding: 30px; background: rgba(135,177,68,0.10);" data-category-id="{{ $oContentCat->getId() }}">
        <div class="title-filter">
            <p>TOP KATEGORIEN</p>
        </div>
        <ul class="list-item-filter list-cat">
            <li style="margin-bottom: 0; margin-top: 10px;">
                <a href="https://www.kaufbei.tv/ru/Tematicheskie-rubriki/Krasota-i-zdorovye/Kosmetika-Von-Wahl/"><i class="far fa-angle-right"></i>Косметика Von Wahl</a>
            </li>
        </ul>
    </div>
    [{/if}]

    [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedTop() attributes=$oView->getAttributes() listDisplayType=true itemsPerPage=true sort=true place="side"}]
    [{/if}]







    <div id="filter-attributes" [{if $oxcmp_user && ($oxcmp_user->oxuser__oxusername->rawValue == 'alert@exonn.de' || $oxcmp_user->oxuser__oxusername->rawValue == 'k.zhilina@kaufbei.tv')}] style="display: block;"[{/if}]>
    [{block name="sidebar_categoriestree"}]

    [{/block}]
    </div>



    [{block name="sidebar_boxproducts"}][{/block}]

    [{block name="sidebar_recommendation"}]
    [{if $oViewConf->getShowListmania() && $oView->getSimilarRecommListIds()}]
    [{oxid_include_widget nocookie=1 cl="oxwRecommendation" aArticleIds=$oView->getSimilarRecommListIds() searchrecomm=$oView->getRecommSearch()}]
    [{elseif $oViewConf->getShowListmania() && $oView->getRecommSearch()}]
    [{oxid_include_widget nocookie=1 cl="oxwRecommendation" _parent=$oView->getClassName() searchrecomm=$oView->getRecommSearch()}]
    [{/if}]
    [{/block}]



    [{block name="sidebar_news"}]
    [{if $oxcmp_news|count}]
    [{include file="widget/sidebar/news.tpl" oNews=$oxcmp_news}]
    [{/if}]
    [{/block}]

    [{block name="sidebar_facebookfacepile"}]
    [{if $oView->isActive('FbFacepile') && $oView->isConnectedWithFb()}]
    <div id="facebookFacepile" class="box well well-sm">
        <section>
            <div class="page-header h3">[{oxmultilang ident="FACEBOOK_FACEPILE"}]</div>
            <div class="content" id="productFbFacePile">
                [{include file="widget/facebook/enable.tpl" source="widget/facebook/facepile.tpl" ident="#productFbFacePile"}]
            </div>
        </section>
    </div>
    [{/if}]
    [{/block}]

    [{/block}]


