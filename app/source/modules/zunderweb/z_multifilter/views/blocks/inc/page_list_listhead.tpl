[{if $oView->getDisplayTop()}]
    [{oxstyle include=$oViewConf->getModuleUrl('z_multifilter',"out/src/css/multifilter_sidebar.css")}]
    [{oxstyle include=$oViewConf->getModuleUrl('z_multifilter',"out/src/css/multifilter_top.css")}]
    [{oxstyle include=$oViewConf->getModuleUrl('z_multifilter',"out/src/css/jquery.ui.theme.css")}]
    [{oxscript include=$oViewConf->getModuleUrl('z_multifilter','out/src/js/jquery.form.js') priority=10 }]
    [{oxscript include=$oViewConf->getModuleUrl('z_multifilter','out/src/js/widgets/multifilter.js') priority=10 }]            
    [{oxscript include=$oViewConf->getModuleUrl('z_multifilter','out/src/js/widgets/mfslider.js') priority=10 }]
    [{oxscript include=$oViewConf->getModuleUrl('z_multifilter','out/src/js/widgets/attrcol.js') priority=10 }]
    <div id="multifilter_filters">
    [{include file=$oViewConf->getModulePath('z_multifilter',"views/tpl/widget/multifilter/z_multifilter_sidebar.tpl")}]
    </div>
[{/if}]
