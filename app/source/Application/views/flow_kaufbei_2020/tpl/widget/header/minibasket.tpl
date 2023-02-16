[{assign var="count" value=$oxcmp_basket->getItemsCount()}]
[{assign var="currency" value=$oView->getActCurrency()}]
<button type="button" class="header-cart">
    <div class="header-cart--count">

        [{if $count > 0}]<span>[{if $count > 99}]99+[{else}][{$count}][{/if}]</span>[{/if}]
    </div>
    <div class="header-cart--desc">
        <i class="fal fa-shopping-cart"></i>
        <div class="header-cart--text">[{oxmultilang ident="CART"}]</div>
    </div>
</button>