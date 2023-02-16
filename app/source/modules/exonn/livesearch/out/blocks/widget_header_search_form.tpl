
    [{oxstyle include=$oViewConf->getModuleUrl('exonn_livesearch', "out/front/css/jquery-ui.css")}]
    [{oxscript include="js/widgets/oxinnerlabel.js" priority=10 }]
    [{*oxscript add="$( '#searchParam' ).oxInnerLabel();"*}]

    [{oxscript add="var autoc = $( '#searchParam' ).autocomplete({

			source: function( request, response ) {
				$.ajax({
					url: '"|cat:$oViewConf->getBaseDir()|cat:"index.php?cl=exonn_livesearch_controller&type=JSON',
					dataType: 'jsonp',
					data: {
						maxRows: 12,
						searchparam: request.term
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
							url: $('form.search').attr('action') + $('form.search').serialize(),
							type: 'get',
							dataType: 'html',
							success: function( data ) {
								var price = $(data).find('.countSearch').html();
								$('.search--result-f-count b').text(price);
							}
						});
			          $('.ui-autocomplete').append('<li class=\"search--result-f\"><span class=\"search--result-f-count\"><b>...</b> Ergebnisse gefunden</span><span class=\"search--result-f-all\">alle Ergebnisse anzeigen <i class=\"fa fa-arrow-circle-right\"></i></span></li>');


				$('.livesearch_overlay').fadeIn();
				$('.ui-autocomplete').css({
					'max-height': '700px',
    				'transition': 'max-height 0.15s ease-in'
				});
			},
			close: function() {
				$('.livesearch_overlay').fadeOut();
				$('.ui-autocomplete').css({
					'max-height': '0',
    				'transition': 'max-height 0.15s ease-out'
				});
			}
		});

		var render = autoc.data( 'uiAutocomplete' ) ? autoc.data( 'uiAutocomplete' ) : (autoc.data( 'autocomplete' ) ? autoc.data( 'autocomplete' ) : autoc.data( 'ui-autocomplete'));
		render._renderItem = function( ul, item ) {
            return $( '<li>' )
            .append( '<a class=\"search-result\" href=\"' + item.label.link + '\"><table><tr><td class=\"img-result\"><img src=\"' + item.label.ico + '\"/></td><td><b>' + item.label.title + '</b><label>Artikelnummer: ' + item.label.artnum + '</label></td></tr></table></a>' )
            .appendTo( ul );
    };

    $(document).on('click', '.search-result', function(e) {
    e.preventDefault();
    var tmpvar = $.parseHTML('<div>' + $('#searchParam').val() + '</div>');

    console.log(tmpvar);
    $('#searchParam').val($(tmpvar).text());
    window.location.href = $(this).attr('href');
    //console.log($('#searchParam').val());
    /*e.stopPropagation();
    	console.log($(this).find('b').html());
    	if(!$(this).attr('data-original-link')) {
    		$(this).attr('data-original-link', $(this).find('b').html());
    	}

    	$(this).find('b').html($(this).attr('data-original-link').replace('<span>', '').replace('</span>', ''));*/

    });

    /*$('#searchParam').on('change keyup paste', function() {
    	console.log($(this).val());
    });*/



    "}]

    <form class="form search" id="exonnsearch" action="[{ $oViewConf->getSelfActionLink() }]" method="get" name="search">
        <div class="searchBox">
            [{ $oViewConf->getHiddenSid() }]
            <input type="hidden" name="cl" value="exonn_livesearch_controller">

            [{block name="dd_widget_header_search_form_inner"}]
            <div class="input-group searchBox">
                [{block name="header_search_field"}]
                <div class="form-control">
                    <input
                        type="text"
                        id="searchParam"
                        name="searchparam"
                        value="[{$oView->getSearchParamForHtml()}]"
                        placeholder="[{oxmultilang ident="SEARCH"}]"
                    >
                </div>
                [{/block}]

                [{block name="dd_header_search_button"}]
                <button type="submit" class="btn btn-search searchSubmit" title="[{oxmultilang ident="SEARCH_SUBMIT"}]">
                    <i class="far fa-search"></i>
                </button>

                [{/block}]
            </div>
            [{/block}]
        </div>
    </form>

