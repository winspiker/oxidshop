
<script type="text/javascript">
    function showDialogSearch( sParams, windowName  )
    {
    if (!windowName)
    windowName = 'ajaxpopup';

    ajaxpopup = window.open('[{ $oViewConf->getSelfLink()|replace:"&amp;":"&" }]'+sParams, windowName, 'width=1200,height=680,scrollbars=yes,resizable=yes');
    }
</script>

[{ assign var="oConf" value=$oViewConf->getConfig() }]

<script type="text/javascript">

    var $jq = $.noConflict();
    $jq(document).ready(function() {
        //jQuery(function() {
        $jq('.datepicker').datepicker({
                prevText: '&#x3c;zurück', prevStatus: '',
            prevJumpText: '&#x3c;&#x3c;', prevJumpStatus: '',
            nextText: 'Vor&#x3e;', nextStatus: '',
            nextJumpText: '&#x3e;&#x3e;', nextJumpStatus: '',
            currentText: 'heute', currentStatus: '',
            todayText: 'heute', todayStatus: '',
            clearText: '-', clearStatus: '',
            closeText: 'schließen', closeStatus: '',
            monthNames: ['Januar','Februar','M&auml;rz','April','Mai','Juni',
            'Juli','August','September','Oktober','November','Dezember'],
            monthNamesShort: ['Jan','Feb','M&auml;r','Apr','Mai','Jun',
            'Jul','Aug','Sep','Okt','Nov','Dez'],
            dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
            dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
            dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
              changeMonth: true,
              changeYear: true,
              dateFormat: '[{if $oConf->getConfigParam( 'sLocalDateFormat' )=='ISO' }]yy-mm-dd[{elseif $oConf->getConfigParam( 'sLocalDateFormat' )=='EUR'}]dd.mm.yy[{else}]mm/dd/yy[{/if}]',
              });
        });
</script>
