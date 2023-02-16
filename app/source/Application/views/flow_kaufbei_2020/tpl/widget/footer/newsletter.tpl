[{block name="dd_footer_newsletter_form"}]
    <form class="form-inline footer--newsletter-form" action="[{$oViewConf->getSslSelfLink()}]" method="post">
        [{block name="dd_footer_newsletter_form_inner"}]
            <div class="hidden">
                [{$oViewConf->getHiddenSid()}]
                <input type="hidden" name="fnc" value="fill">
                <input type="hidden" name="cl" value="newsletter">
                [{if $oView->getProduct()}]
                    [{assign var="product" value=$oView->getProduct()}]
                    <input type="hidden" name="anid" value="[{$product->oxarticles__oxnid->value}]">
                [{/if}]
            </div>

            [{block name="dd_footer_newsletter_form_inner_group"}]
                <label class="sr-only" for="footer_newsletter_oxusername">[{oxmultilang ident="NEWSLETTER"}]</label>
                <input class="form-control" type="email" name="editval[oxuser__oxusername]" id="footer_newsletter_oxusername" value="">
                <button class="btn btn-primary" type="submit"><i class="fa fa-angle-right"></i></button>
            [{/block}]
        [{/block}]
    </form>
[{/block}]