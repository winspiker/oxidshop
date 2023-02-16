[{if $oView->isEnabled() && $smarty.cookies.displayedCookiesNotification != '1'}]
    [{oxscript include="js/libs/jquery.cookie.min.js"}]
    [{oxscript add="$.cookie('testing', 'yes'); if(!$.cookie('testing')) $('#cookieNote').hide(); else{ $('#cookieNote').show(); $.cookie('testing', null, -1);}"}]
    [{oxscript include="js/widgets/oxcookienote.min.js?asdas"}]
    <div id="cookieNote">
        <div class="alert alert-info" style="margin: 0; border-radius: 0; text-align: center;">
            [{oxmultilang ident='COOKIE_NOTE'}]
            <button type="button" class="btn btn-primary cookie-agree" style="background: #2eb3f5;">[{oxmultilang ident='COOKIE_AGREE'}]</button>
            <button type="button" class="btn btn-primary cookie-agree" style="background: #fff; color: #000 !important;">[{oxmultilang ident='COOKIE_NOTE_DISAGREE'}]</button>
        </div>
    </div>
    [{oxscript add="$('#cookieNote').oxCookieNote();"}]
[{/if}]
[{oxscript widget=$oView->getClassName()}]
[{**}]
