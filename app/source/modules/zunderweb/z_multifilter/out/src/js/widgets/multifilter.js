( function ( $ ) {
    var afterAjax = function(baseurl){
        var options = { 
            dataType:  'json', 
            beforeSerialize:  showRequest,
            success:   processJson
        };
        $('#filterList').ajaxForm(options);
        mfSetUrl(baseurl);
        //DWA Lazyload nach Filter
        $( "img" ).unveil();
    }
    var mfSetUrl = function(baseurl){
        var querydata = {};
        var querystring = baseurl;
        if (!querystring) querystring  =  window.location.href;
        if ((querystring.indexOf("executefilter") != -1)) return false;
        
        $('.mf_filter').each(function() {
        if ( $(this).attr('type') == 'checkbox' ){
            if ( $(this).attr('checked') ){
                querydata[$(this).attr('name')] = $(this).val();
            }
        }
        else if ( $(this).attr('type') == 'hidden' ){
            if ($(this).val()){
                querydata[$(this).attr('name')] = $(this).val();
            }
        }
        else {
            if ( $(this).val() ){
                querydata[$(this).attr('name')] = $(this).val();
            }
        }
        });
        if (!$.isEmptyObject(querydata)){
            querydata.fnc = 'executefilter';
            if (querystring.indexOf("?") == -1) querystring += '?';
            else querystring += '&';
            querystring += $.param(querydata);
        }
        history.replaceState({data:''}, '', querystring);
    }

    function showRequest(formData, jqForm, options) {
        $('input[name=ajax]').val('1');
        $('input[name=mnid]').val('');
        $("#mfmask").show();
        return true; 
    }
    function processJson(data) {
        for(var index in data) { 
            if (data.hasOwnProperty(index)) {
                mfloadcontent(data[index], index);
            }
        }
        $("#mfmask").hide();
        afterAjax(data.baseurl);
    }
    function mfloadcontent(data, target) {
        if (target != "baseurl"){
            $('#'+target).html(data);
        }
    }
    $("#sidebar, #content").on("click", ".multifilter_reset_icon, .multifilter_reset_link", 
        function(e){
            $('#multifilter_reset').val($(this).attr('data-ident'));
            $('#filterList').submit(); 
            return false;
        }
    );    
    $("#multifilter_filters").on("click", ".colorpickerjs", 
        function (e){
            var inputElem = $(this).children('input');
            var currentVal = inputElem.val();
            if(!currentVal){
                inputElem.val('1');
            }
            else {
                inputElem.val('');   
            }
            $("#filterList").submit();
        }
    );    
    $("#multifilter_filters").on("click", ".attrfilter a", 
        function (e){
            $("#mfmask").show();
        }
    );
    $('.searchBox').append('<input type=\"hidden\" name=\"resetfilter\" value=\"1\" />');
    afterAjax();
})( jQuery );
