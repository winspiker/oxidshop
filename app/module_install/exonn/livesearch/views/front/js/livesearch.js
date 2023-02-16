(function($){$(function(){
    var $search = $('#exonnsearch');
    var $searchParam = $search.find('#searchParam');
    var autoc = $searchParam.autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: $search.attr('action'),
                dataType: 'jsonp',
                data: {
                    maxRows: 12,
                    searchparam: request.term,
                    cl: 'exonn_livesearch_controller',
                    type: 'JSON',
                },
                success: function( data ) {
                    response( $.map( data.slice (0,5), function( item, key ) {
                        return {
                            label: item,
                            value: item.title,
                        }
                    }));
                }
            });

        },
        messages: {
            noResults: '',
            results: function() {}
        },
        minLength: 2,
        open: function() {
            $.ajax({
                url: $search.attr('action') + $search.serialize(),
                type: 'get',
                dataType: 'html',
                success: function( data ) {
                    var price = $(data).find('.countSearch').text();
                    $('.search--result-f-count b').text(price);
                }
            });
            $('.ui-autocomplete').append('<li class=\"search--result-f\"><span class=\"search--result-f-count\"><b>...</b> Ergebnisse gefunden.</span> <button class=\"search--result-f-all\">Alle Ergebnisse anzeigen <i class=\"fa fa-arrow-circle-right\"></i></button></li>');

            $('.search--result-f-all').on('click.exonn', function(){
                $search.submit();
                return false;
            });

            $('.nav_overlay').fadeIn();
            $('.ui-autocomplete').css({
                'max-height': '700px',
                'transition': 'max-height 0.15s ease-in'
            });
        },
        close: function() {
            $('.nav_overlay').fadeOut();
            $('.ui-autocomplete').css({
                'max-height': '0',
                'transition': 'max-height 0.15s ease-out'
            });
        }
    });

    var render = autoc.data( 'uiAutocomplete' )
        ? autoc.data( 'uiAutocomplete' )
        : (autoc.data( 'autocomplete' )
            ? autoc.data( 'autocomplete' )
            : autoc.data( 'ui-autocomplete')
        );
    render._renderItem = function( ul, item ) {
        return $( '<li>' )
            .append( '<a class=\"search-result\" href=\"' + item.label.link + '\"><table><tr><td class=\"img-result\"><img src=\"' + item.label.ico + '\"/></td><td><b>' + item.label.title + '</b><label>Artikelnummer: ' + item.label.artnum + '</label></td></tr></table></a>' )
            .appendTo( ul );
    };

    $(document).on('click', '.search-result', function(e) {
        console.log(this);
        e.preventDefault();
        var tmpvar = $.parseHTML('<div>' + $searchParam.val() + '</div>');

        console.log(tmpvar);
        $searchParam.val($(tmpvar).text());
        window.location.href = $(this).attr('href');
        //console.log($('#searchParam').val());
        /*
        e.stopPropagation();
        console.log($(this).find('b').html());
        if(!$(this).attr('data-original-link')) {
            $(this).attr('data-original-link', $(this).find('b').html());
        }

        $(this).find('b').html($(this).attr('data-original-link').replace('<span>', '').replace('</span>', ''));
        */
    });

    /*$('#searchParam').on('change keyup paste', function() {
        console.log($(this).val());
    });*/

})})(jQuery);