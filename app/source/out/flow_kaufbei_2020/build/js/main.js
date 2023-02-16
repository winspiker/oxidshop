/**
 * This file is part of OXID eSales Flow theme.
 *
 * OXID eSales Flow theme is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OXID eSales Flow theme is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OXID eSales Flow theme.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @copyright (C) OXID eSales AG 2003-2016
 */
/* Windows Phone viewport fix */

//@prepros-prepend ../vendor/bootstrap/js/bootstrap.js
//@prepros-prepend ../vendor/bootstrap-select/js/bootstrap-select.js
//@prepros-prepend ../vendor/jquery-unveil/js/jquery.unveil.js

//@prepros-prepend ../vendor/swiper/js/swiper.js



(function ()
{
    if ( "-ms-user-select" in document.documentElement.style && navigator.userAgent.match( /IEMobile\/10\.0/ ) )
    {
        var msViewportStyle = document.createElement( "style" );
        msViewportStyle.appendChild(
            document.createTextNode( "@-ms-viewport{width:auto!important}" )
        );
        document.getElementsByTagName( "head" )[ 0 ].appendChild( msViewportStyle );
    }
})();

Flow = {};

// Short-Handle for document.ready
$( function ()

    {

        var $window = $( window ),
            $oBody = $( 'body' ),
            $oHeader = $( '#header' ),
            $oBasketList = $( '#basket_list' ),
            $oToTop = $( '#jumptotop' ),
            $oRecommendations = $( '#econdaRecommendations' ),
            $oChangeEmail = $( 'input.oxValidate_enterPass' ),
            $oSearchInput = $( '#searchParam' ),
            iHeaderWrapperHeight = parseInt( $oHeader.height() ),
            blIsCheckout = $oBody.hasClass( 'is-checkout' ),
            $oContentWrapper = $("#content");

        // Mobile detection
        window.isMobileDevice = function ()
        {
            var check = false;
            (function ( a )
            {
                if ( /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test( a ) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test( a.substr( 0, 4 ) ) )
                {
                    check = true;
                }
            })( navigator.userAgent || navigator.vendor || window.opera );
            return check;
        };

        // Scrolling header
        $window.scroll( function ( e )
            {
                var $this = $( this );
                var $mainNav = $( '#mainnav' );

                if ( !blIsCheckout && !( isMobileDevice() && $oSearchInput.is( ':focus' ) ) && !$oBody.hasClass( 'static-header' ))
                {
                    if ( $this.scrollTop() > iHeaderWrapperHeight )
                    {
                        if ( !$oBody.hasClass( 'fixed-header' ) )
                        {
                            $oBody.addClass( 'fixed-header' );

                            this.setTimeout( function()
                                {
                                    $mainNav.addClass( 'fadeIn' );
                                },
                                100
                            );
                        }
                    }
                    else
                    {
                        if ( $oBody.hasClass( 'fixed-header' ) )
                        {
                            $oBody.removeClass( 'fixed-header' );
                            $mainNav.removeClass( 'fadeIn' );
                        }
                    }
                }

                $oToTop.toggleClass( 'show', $this.scrollTop() >= 30 );
            }
        ).trigger( 'scroll' );

        // Search Toggle
        $( '.search-toggle' ).click( function( e )
            {
                e.preventDefault();

                $( 'html, body' ).animate(
                    {
                        scrollTop: ( $oSearchInput.position().top-10 || 0 )
                    },
                    300,
                    function()
                    {
                        $oSearchInput.focus();
                    }
                );

            }
        );

        // Unveil beim Wechsel eines Tabs durchführen
        $( 'a[data-toggle="tab"]' ).on( 'shown.bs.tab', function ( e )
            {

                $( this.getAttribute( 'href' ) ).find( 'img' ).unveil(200, function() {
                    var loader = $(this).closest('.img-loader');
                    $(this).load(function() {
                        loader.removeClass('.img-loader');
                    });
                });
                setTimeout(function() {
                    window.scrollTo(window.scrollX, window.scrollY - 1);
                    window.scrollTo(window.scrollX, window.scrollY + 1);
                }, 100);
            }
        );

        $oToTop.click( function ()
            {
                $( 'html, body' ).animate(
                    {
                        scrollTop: 0
                    },
                    300
                );
            }
        );

        // Fix um Eingabefelder in Bootstrap Dropdown-Menüs fokussieren zu können.
        $( '#header .dropdown-menu input, #header .dropdown-menu label, #header .dropdown-menu button, #header .dropdown-menu' ).click( function ( e )
            {
                e.stopPropagation();
            }
        );

        $( '.nav' ).on( 'mouseenter', 'li.dropdown', function ( e )
            {
                if ( $window.width() >= 760 )
                {
                    $( this ).addClass( 'open' );
                }
            }
        ).on( 'mouseleave', 'li.dropdown', function ( e )
            {
                if ( $window.width() >= 760 )
                {
                    $( this ).removeClass( 'open' );
                }
            }
        ).on( 'click', 'li.dropdown', function ( e )
            {
                if ( $window.width() >= 760 ) {
                    e.stopPropagation();
                }
            }
        );

        $oHeader.find( '.menu-dropdowns button[data-href]' ).click( function ( e )
            {
                var $this = $( this );

                if ( $( window ).width() <= 767 )
                {
                    e.stopPropagation();
                    document.location.href = $this.attr( 'data-href' );
                }
            }
        );


        if ( $oRecommendations.length )
        {
            $.get( window.sBaseUrl + 'cl=tpl&tpl=ajax_econda_recommendations.tpl&actcl=' + sActCl + '', function ( oData, sStatus, oXhr )
                {
                    $oRecommendations.html( oData );
                    $oRecommendations.find( 'img' ).unveil(200, function() {
                        var loader = $(this).closest('.img-loader');
                        $(this).load(function() {
                            loader.removeClass('.img-loader');
                        });
                    });
                }
            );
        }

        /* *********************************
         * List filter
         * *********************************/
        var $oFilterList = $( '#filterList' );

        if ( $oFilterList.length )
        {
            $oFilterList.find( '.dropdown-menu li' ).click( function ()
                {
                    var $this = $( this );
                    $this.parent().prev().val( $this.children().first().data( 'selection-id' ) );
                    $this.closest( 'form' ).submit();
                }
            );
        }

        var $oSidebar = $( '#sidebar' ),
            $oCategoryBox = $oSidebar.find( '.box.categorytree' );
        if ( $oCategoryBox.length )
        {
            $oCategoryBox.find( '.toggleTree' ).on( 'click touch', function ()
                {
                    var $this = $( this ),
                        $oCategoryTreeBox = $this.parents( '.categorytree' ).find( '.categoryBox' );

                    if ( $this.hasClass( 'fa-caret-down' ) )
                    {
                        $this.removeClass( 'fa-caret-down' );
                        $this.attr( 'class', 'fa-caret-up ' + $this.attr( 'class' ) );
                        $oCategoryTreeBox.attr( 'style', 'display:block!important' );
                    }
                    else
                    {
                        $this.removeClass( 'fa-caret-up' );
                        $this.attr( 'class', 'fa-caret-down ' + $this.attr( 'class' ) );
                        $oCategoryTreeBox.removeAttr( 'style' );
                    }
                }
            );
        }

        /* *********************************
         * Variant selection in lists
         * *********************************/
        var $oSelectionLists = $( '.listDetails .selectorsBox' );

        if ( $oSelectionLists.length )
        {
            $oSelectionLists.find( '.dropdown-menu li' ).click( function ( e )
                {
                    e.preventDefault();
                    var $this = $( this );
                    $this.parent().prev().val( $this.children().first().data( 'selection-id' ) );
                    $this.closest( 'form' ).submit();
                }
            );
        }


        /* *********************************
         * Details page
         * *********************************/
        Flow.initEvents = function ()
        {
            // Lazy Loading für Bilder
            $("img").unveil(200, function() {
                var loader = $(this).closest('.img-loader');
                $(this).load(function() {
                    loader.removeClass('img-loader');
                });
            });

            $( ".selectpicker" ).selectpicker();

            // Globale Tooltip-Klasse
            $( '.hasTooltip' ).tooltip({container: 'body'});

            // Globale PopOver-Klasse
            $( '.hasPopover' ).popover();
        };
        Flow.initEvents();

        function reRenderMainNav()
        {
            var $oMainNav = $( '#mainnav' ).find( '.navbar-collapse' ),
                $oNavList = $( '#navigation' ),
                $oMoreLinks = $oNavList.find( '.moreLinks' );

            // Abbrechen, wenn Fensterbreite <= 767
            if ( $window.width() <= 755 )
            {
                $oMoreLinks.before( $oMoreLinks.find( '> ul > li' ) );
                $oMoreLinks.remove();
                return;
            }

            if ( $oMoreLinks.length )
            {
                $oMoreLinks.before( $oMoreLinks.find( '> ul > li' ) );
            }
            else
            {
                var oMoreLinkElem = document.createElement( 'li' ),
                    oMoreLinkAElem = document.createElement( 'a' ),
                    oMoreLinkUlElem = document.createElement( 'ul' );

                oMoreLinkElem.className = 'dropdown moreLinks';

                oMoreLinkAElem.className = 'dropdown-toggle';
                oMoreLinkAElem.innerHTML = oFlow.i18n.DD_NAVIGATION_MORE + ' <span class="caret"></span>';
                oMoreLinkAElem.setAttribute( 'data-toggle', 'dropdown' );

                oMoreLinkUlElem.className = 'dropdown-menu';
                oMoreLinkUlElem.setAttribute( 'role', 'menu' );

                oMoreLinkElem.appendChild( oMoreLinkAElem );
                oMoreLinkElem.appendChild( oMoreLinkUlElem );

                $oNavList.append( oMoreLinkElem );
                $oMoreLinks = $( oMoreLinkElem );
            }

            var iMainNavWidth = $oMainNav.width(),
                $oNavItems = $oNavList.find( '> li' ).not( '.moreLinks' ),
                iNavItemsWidth = 0,
                aMoreLinkElems = [];

            iMainNavWidth -= $oMoreLinks.width();

            $oNavItems.each( function ()
                {
                    var $this = $( this );
                    iNavItemsWidth += $this.outerWidth();

                    if ( iNavItemsWidth > iMainNavWidth )
                    {
                        aMoreLinkElems.push( $this );
                    }
                }
            );

            if ( aMoreLinkElems.length )
            {
                $oMoreLinks.find( '> ul' ).append( aMoreLinkElems );
            }
            else
            {
                $oMoreLinks.remove();
            }
        }

        reRenderMainNav();
        $window.resize( function ()
        {
            reRenderMainNav();
        } );

        /* *********************************
         * Warenkorb
         * *********************************/
        if ( $oBasketList.length )
        {
            $( '#basket_form' ).on( 'submit', function ( e )
                {
                    var $this = $( this ),
                        $oHiddenXs = $this.find( '.hidden-xs' ),
                        $oVisibleXs = $this.find( '.visible-xs' );

                    if ( $oHiddenXs.is( ':hidden' ) )
                    {
                        $oHiddenXs.remove();
                    }

                    if ( $oVisibleXs.is( ':hidden' ) )
                    {
                        $oVisibleXs.remove();
                    }

                    //e.target.submit();
                }
            );

            $oBasketList.find( '.toggle-actions' ).click( function ( e )
                {
                    e.preventDefault();
                    var $this = $( this ),
                        $oToggable = $this.parents( 'li' ).first().find( '.row.toggable' );

                    $oToggable.slideToggle( 150, function ()
                        {
                            $this.find( 'i' ).attr( 'class', ( $oToggable.is( ':visible' ) ? 'fa fa-chevron-up' : 'fa fa-chevron-down' ) );
                        }
                    );
                }
            );
        }

        // Auswahllisten im Warenkorb
        $( '.basketItemDesc .selectorsBox .dropdown-menu li a', $oContentWrapper ).click( function( e )
            {
                e.preventDefault();
                var $this = $( this );
                $this.closest( '.selectbox' ).removeClass( 'open' );
                $this.parent().parent().prev().val( $this.attr( 'data-selection-id' ) );
                $this.parent().parent().prev().siblings( 'button' ).find( 'span' ).first().text( $this.text() );
            }
        );

        /* *********************************
         * Mein Konto
         * *********************************/
        if ( $oChangeEmail.length )
        {
            var sOldMail = $oChangeEmail.val(),
                $oPasswordElem = $( '.oxValidate_pwd' );
            $oChangeEmail.keyup( function ( e )
                {
                    if ( $oPasswordElem.length )
                    {
                        if ( sOldMail != e.target.value )
                        {
                            $oPasswordElem.slideDown( 'fast' );
                        }
                        else
                        {
                            if ( $oPasswordElem.is( ':visible' ) )
                            {
                                $oPasswordElem.slideUp( 'fast' );
                            }
                        }
                    }
                }
            );
        }

        /* *********************************
         * Private Sales Login
         * *********************************/
        $('#private-sales-login input.agb-check').click(function(){
            if((this).checked){
                $('#private-sales-login button.submitButton').removeAttr('disabled');
            } else {
                $('#private-sales-login button.submitButton').attr("disabled","disabled");
            }
        });

        /* *********************************
         * Fix for form validation
         * *********************************/
        $('input.form-control, textarea.form-control, select.form-control').each(function() {
            $(this).unbind(["keyup", "focus", "blur", "click"].join(".validation ") + ".validation");
        });
    }
);

$( window ).load( function ()
    {
        // Bugfix für das Nachladen von Bildern, wenn man die
        // Seite aktualisiert und dadurch nicht auf scrollTop 0 ist.
        window.setTimeout( function ()
        {
            // $( "img" ).unveil();
        }, 500 );
    }
);


(function() {
  if (
    "-ms-user-select" in document.documentElement.style &&
    navigator.userAgent.match(/IEMobile\/10\.0/)
  ) {
    var msViewportStyle = document.createElement("style");
    msViewportStyle.appendChild(
      document.createTextNode("@-ms-viewport{width:auto!important}")
    );
    document.getElementsByTagName("head")[0].appendChild(msViewportStyle);
  }
})();
Flow = {};
// Short-Handle for document.ready
$(function() {
  var $window = $(window),
    $oBody = $("body"),
    $oHeader = $("#header"),
    $oBasketList = $("#basket_list"),
    $oToTop = $("#jumptotop"),
    $oRecommendations = $("#econdaRecommendations"),
    $oChangeEmail = $("input.oxValidate_enterPass"),
    $oSearchInput = $("#searchParam"),
    iHeaderWrapperHeight = parseInt($oHeader.height()),
    blIsCheckout = $oBody.hasClass("is-checkout");
  // Mobile detection
  window.isMobileDevice = function() {
    var check = false;
    (function(a) {
      if (
        /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(
          a
        ) ||
        /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(
          a.substr(0, 4)
        )
      ) {
        check = true;
      }
    })(navigator.userAgent || navigator.vendor || window.opera);
    return check;
  };

// add images to paiement paypal
    $('body').find('#payment_paypalpluscw_paypalplus').siblings("label").append('<div class="wrapp-img-payment-paypalplu"><img src="https://kaufbei.tv/out/flow_kaufbei_2020/img/ratenzahlung-paypal--new.png" alt="paypal-logo"><img src="https://kaufbei.tv/out/flow_kaufbei_2020/img/rechnung1.svg" alt="rechnung-logo" class="rechnung-logo"><img src="https://www.paypalobjects.com/webstatic/ppplus/images/bank-logo.png" alt="bank-logo"><img src="https://www.paypalobjects.com/webstatic/ppplus/images/cc-logo.png" alt="cc-logo"></div>');
    $('body').find('#payment_oxidbarzahlen').siblings("label").find('b').html('<img id="barzahlen_logo" src="https://kaufbei.tv/out/flow_kaufbei_2020/img/barzahlen_logo_new.png" height="45" alt="Barzahlen im Laden" style="vertical-align:middle;">');

  // Scrolling top
  $window
    .scroll(function(e) {
      $oToTop.toggleClass("show", $(this).scrollTop() >= 300);
    })
    .trigger("scroll");
  // Search Toggle
  $(".search-toggle").click(function(e) {
    e.preventDefault();
    $("html, body").animate(
      {
        scrollTop: $oSearchInput.position().top - 10 || 0
      },
      300,
      function() {
        $oSearchInput.focus();
      }
    );
  });
  // Unveil beim Wechsel eines Tabs durchführen
  $('a[data-toggle="tab"]').on("shown.bs.tab", function(e) {
    $(this.getAttribute("href"))
      .find("img")
      .unveil(200, function() {
          var loader = $(this).closest('.img-loader');
          $(this).load(function() {
              loader.removeClass('img-loader');
          });
      });
  });

  $oToTop.click(function() {
    $("html, body").animate(
      {
        scrollTop: 0
      },
      300
    );
  });
  // Fix um Eingabefelder in Bootstrap Dropdown-Menüs fokussieren zu können.
  $(
    "#header .dropdown-menu input, #header .dropdown-menu label, #header .dropdown-menu button, #header .dropdown-menu"
  ).click(function(e) {
    e.stopPropagation();
  });
  $(".nav")
    .on("mouseenter", "li.dropdown", function(e) {
      if ($window.width() >= 760) {
        $(this).addClass("open");
      }
    })
    .on("mouseleave", "li.dropdown", function(e) {
      if ($window.width() >= 760) {
        $(this).removeClass("open");
      }
    })
    .on("click", "li.dropdown", function(e) {
      e.stopPropagation();
    });
  $oHeader.find(".menu-dropdowns button[data-href]").click(function(e) {
    var $this = $(this);
    if ($(window).width() <= 767) {
      e.stopPropagation();
      document.location.href = $this.attr("data-href");
    }
  });

  if ($oRecommendations.length) {
    $.get(
      window.sBaseUrl +
        "cl=tpl&tpl=ajax_econda_recommendations.tpl&actcl=" +
        sActCl +
        "",
      function(oData, sStatus, oXhr) {
        $oRecommendations.html(oData);
        $oRecommendations.find("img").unveil(200, function() {
            var loader = $(this).closest('.img-loader');
            $(this).load(function() {
                loader.removeClass('img-loader');
            });
        });
      }
    );
  }
  /**********************************
   * List filter
   * *********************************/
  var $oFilterList = $("#filterList");
  if ($oFilterList.length) {
    $oFilterList.find(".dropdown-menu li").click(function() {
      var $this = $(this);
      $this
        .parent()
        .prev()
        .val(
          $this
            .children()
            .first()
            .data("selection-id")
        );
      $this.closest("form").submit();
    });
  }
  var $oSidebar = $("#sidebar"),
    $oCategoryBox = $oSidebar.find(".box.categorytree");
  if ($oCategoryBox.length) {
    $oCategoryBox.find(".toggleTree").on("click touch", function() {
      var $this = $(this),
        $oCategoryTreeBox = $this.parents(".categorytree").find(".categoryBox");
      if ($this.hasClass("fa-caret-down")) {
        $this.removeClass("fa-caret-down");
        $this.attr("class", "fa-caret-up " + $this.attr("class"));
        $oCategoryTreeBox.attr("style", "display:block!important");
      } else {
        $this.removeClass("fs-caret-up");
        $this.attr("class", "fs-caret-down " + $this.attr("class"));
        $oCategoryTreeBox.removeAttr("style");
      }
    });
  }
  /**********************************
   * Variant selection in lists
   * *********************************/
  var $oSelectionLists = $(".selectorsBox");
  if ($oSelectionLists.length) {
    $oSelectionLists.find(".dropdown-menu li").click(function(e) {
      e.preventDefault();
      var $this = $(this);
      $this
        .parent()
        .prev()
        .val(
          $this
            .children()
            .first()
            .data("selection-id")
        );
      $this.closest("form").submit();
    });
  }


  $('#invCountrySelect').on('changed.bs.select', function (e, clickedIndex, isSelected, previousValue) {
    $('#zip_bill').jqBootstrapValidation("destroy");
    $('#zip_bill').jqBootstrapValidation("init");
  });


// if($('#zip_bill').length) {
// 	$('#zip_bill').on('keyup', function() {
// 		console.log(String($(this).val()).length);
// 		if( String($(this).val()).length < 5 ) {
// 			if(!$('.city_bill_container').next().find('.help-block').html().length) {
// 				$('.city_bill_container').next().find('.help-block').html('<ul class="list-unstyled text-danger" role="alert"><li>Das Feld muss mindestens 5 Ziffern enthalten.</li></ul>');
// 			}

// 			if(String($(this).val()).length == 0) {
// 				$('.city_bill_container').next().find('.help-block').html('<ul class="list-unstyled text-danger" role="alert"><li>Bitte Wert angeben.</li></ul>');
// 			}

// 		} else {
// 			if($('.city_bill_container').next().find('.help-block').html().length) {
// 				$('.city_bill_container').next().find('.help-block').html('');
// 			}
// 		}
// 	});
// }
  /**********************************
   * Details page
   * *********************************/
//  function squareImagesAll(imgResize) {
//    imgResize.parent().height(imgResize.parent().width());
//    imgResize.css("max-height", imgResize.parent().width());
//  }

	function squareImagesAll(imgResize) {
    imgResize.height(imgResize.width());
//    imgResize.css("max-height", imgResize.parent().width());
  }

  Flow.initEvents = function() {
    // Lazy Loading für Bilder
    $("img").unveil(200, function() {
        var loader = $(this).closest('.img-loader');
        $(this).load(function() {
            loader.removeClass('img-loader');
        });
    });
    $(".selectpicker").selectpicker();
    // Globale PopOver-Klasse
    $(".hasPopover").popover();
  };
  Flow.initEvents();
  function reRenderMainNav() {
    var $oMainNav = $("#mainnav").find(".navbar-collapse"),
      $oNavList = $("#navigation"),
      $oMoreLinks = $oNavList.find(".moreLinks");
    // Abbrechen, wenn Fensterbreite <= 767
    if ($window.width() <= 755) {
      $oMoreLinks.before($oMoreLinks.find("> ul > li"));
      $oMoreLinks.remove();
      return;
    }
    if ($oMoreLinks.length) {
      $oMoreLinks.before($oMoreLinks.find("> ul > li"));
    } else {
      var oMoreLinkElem = document.createElement("li"),
        oMoreLinkAElem = document.createElement("a"),
        oMoreLinkUlElem = document.createElement("ul");
      oMoreLinkElem.className = "dropdown moreLinks";
      oMoreLinkAElem.className = "dropdown-toggle";
      oMoreLinkAElem.innerHTML = 'Mehr <span class="caret"></span>';
      oMoreLinkAElem.setAttribute("data-toggle", "dropdown");
      oMoreLinkUlElem.className = "dropdown-menu";
      oMoreLinkUlElem.setAttribute("role", "menu");
      oMoreLinkElem.appendChild(oMoreLinkAElem);
      oMoreLinkElem.appendChild(oMoreLinkUlElem);
      $oNavList.append(oMoreLinkElem);
      $oMoreLinks = $(oMoreLinkElem);
    }
    var iMainNavWidth = $oMainNav.width(),
      $oNavItems = $oNavList.find("> li").not(".moreLinks"),
      iNavItemsWidth = 0,
      aMoreLinkElems = [];
    iMainNavWidth -= $oMoreLinks.width();
    $oNavItems.each(function() {
      var $this = $(this);
      iNavItemsWidth += $this.outerWidth();
      if (iNavItemsWidth > iMainNavWidth) {
        aMoreLinkElems.push($this);
      }
    });
    if (aMoreLinkElems.length) {
      $oMoreLinks.find("> ul").append(aMoreLinkElems);
    } else {
      $oMoreLinks.remove();
    }
  }
  reRenderMainNav();
  $window.resize(function() {
    reRenderMainNav();
  });
  /**********************************
   * Warenkorb
   * *********************************/
  if ($oBasketList.length) {
    $("#basket_form").on("submit", function(e) {
      var $this = $(this),
        $oHiddenXs = $this.find(".hidden-xs"),
        $oVisibleXs = $this.find(".visible-xs");
      if ($oHiddenXs.is(":hidden")) {
        $oHiddenXs.remove();
      }
      if ($oVisibleXs.is(":hidden")) {
        $oVisibleXs.remove();
      }
    });
    $oBasketList.find(".toggle-actions").click(function(e) {
      e.preventDefault();
      var $this = $(this),
        $oToggable = $this
          .parents("li")
          .first()
          .find(".row.toggable");

      $oToggable.slideToggle(150, function() {
        $this
          .find("i")
          .attr(
            "class",
            $oToggable.is(":visible")
              ? "fa fa-chevron-up"
              : "fa fa-chevron-down"
          );
      });
    });
  }
  /**********************************
   * Mein Konto
   * *********************************/
  if ($oChangeEmail.length) {
    var sOldMail = $oChangeEmail.val(),
      $oPasswordElem = $(".oxValidate_pwd");
    $oChangeEmail.keyup(function(e) {
      if ($oPasswordElem.length) {
        if (sOldMail != e.target.value) {
          $oPasswordElem.slideDown("fast");
        } else {
          if ($oPasswordElem.is(":visible")) {
            $oPasswordElem.slideUp("fast");
          }
        }
      }
    });
  }
  /**********************************
   * Private Sales Login
   * *********************************/
  $("#private-sales-login input.agb-check").click(function() {
    if (this.checked) {
      $("#private-sales-login button.submitButton").removeAttr("disabled");
    } else {
      $("#private-sales-login button.submitButton").attr(
        "disabled",
        "disabled"
      );
    }
  });
}); // End Oxideshop script

/*===============================================
    Script initialize load images
  	===============================================*/
$(window).load(function() {
  window.setTimeout(function() {
    $("img").unveil(200, function() {
        var loader = $(this).closest('.img-loader');
        $(this).load(function() {
            loader.removeClass('img-loader');
        });
    });
  }, 500);

  /*===============================================
    Список категорий и подкатегорий на Desktop
  	===============================================*/
  // if (window.matchMedia("(min-width: 992px)").matches) {
  //   $(".hasSubcats").each(function() {
  //     var tempStyle = $(".nav-row--category-list").attr("style");
  //     $(".nav-row--category-list").css({
  //       visibility: "hidden",
  //       display: "block"
  //     });
  //
  //   var navCategoryList = $('.nav-row--category-list');
  //
  //   var offset = navCategoryList.height();
  //   // console.log(offset);
  //     var li = $(this).parent();
  //     // var topSubCats = -(63 - li.height() + 1) / 2 + "px";
  //     var topSubCats = offset + "px";
  //     li.find(".sub-cats").css("top", topSubCats);
  //
  //     li.hover(
  //       function() {
  //           var thisLi = $(this);
  //         $(this)
  //           .find(".sub-cats")
  //           .stop(true, true)
  //           .delay(500)
  //           .fadeIn(200, function() {
  //               thisLi.find( "img" ).unveil();
  //           });
  //
  //         $(".nav_overlay")
  //           .stop(true, true)
  //           .delay(500)
  //           .fadeIn(200);
  //       },
  //       function() {
  //         $(this)
  //           .find(".sub-cats")
  //           .stop(true, true)
  //           .delay(500)
  //           .fadeOut(200);
  //         $(".nav_overlay")
  //           .stop(true, true)
  //           .delay(500)
  //           .fadeOut(200);
  //       }
  //     );
  //
  //     $(".nav-row--category-list").css({
  //       visibility: "",
  //       display: ""
  //     });
  //     $(".nav-row--category-list").attr("style", tempStyle);
  //   });
  // }
  // // Click toggle Category
  // $(".nav-row--nav-toggle-clickable").on("click", function() {
  //   $(".nav-row--category-list").slideToggle();
  //   $(".nav-row--category-list").toggleClass("open");
  //   //		$('#wrapper.open').height($('.nav-row--category-list.open').height());
  // });
  //
  // if ($(".nav-row--nav-toggle").hasClass("nav-row--nav-toggle-clickable")) {
  //   $(document).click(function(e) {
  //     if ($(e.target).closest(".nav-row--nav-toggle-clickable").length) return;
  //     $(".nav-row--category-list").slideUp();
  //     //			$('#wrapper').removeClass('open');
  //     //			$('#wrapper').height('auto');
  //     e.stopPropagation();
  //   });
  // }
  //	if ($('#wrapper').height() < $('.nav-row--category-list').height()) {
  //		$('#wrapper').height($('.nav-row--category-list').height());
  //	}
  // Высота категорий
  // if ($(".home-menu-buffer").length) {
  //   var menuHeight = $(".nav-row--category-list").height() - 20;
  //   $(".home-menu-buffer").outerHeight(menuHeight);
  // }





        // $('.nav-row--category-list li a.hasSubcats').hover(
        //   function() {
        //       var thisLink = $(this);
        //       var thisId = thisLink.data('child');
        //
        //
        //     $('#child_'+thisId)
        //       .stop(true, true)
        //       .delay(500)
        //       .fadeIn(200, function() {
        //           // thisLi.find( "img" ).unveil();
        //
        //       });
        //
        //     $(".nav_overlay")
        //       .stop(true, true)
        //       .delay(500)
        //       .fadeIn(200);
        //   },
        //   function() {
        //       var thisLink = $(this);
        //       var thisId = thisLink.data('child');
        //       $('#child_'+thisId)
        //       .stop(true, true)
        //       .delay(500)
        //       .fadeOut(200);
        //     $(".nav_overlay")
        //       .stop(true, true)
        //       .delay(500)
        //       .fadeOut(200);
        //   }
        // );





  /*===============================================
    Cart - Fancybox popup
  	===============================================*/
  $(document).on("click", ".header-cart, .cart-box--toggle", function() {

      $(".cart-box--wrapper").toggleClass('cart-box--wrapper--open');
      $('.nav_overlay').fadeToggle();
      setTimeout(function() {
          $("body").toggleClass("bodyHide");
      }, 200);
    // $.fancybox.open({
    //   src: ".cart-box--container",
    //   type: "inline",
    //   autoFocus: false,
    //   touch: {
    //       vertical: false,
    //       momentum: false
    //   },
    // });
  });

  /*===============================================
    "Добавить в корзину" - Ajax
  	===============================================*/
  $(document).on("click", ".cart-ajax", function() {
    $(this)
      .closest("form")
      .append(
        '<div class="w-overlay"><div class="loader loader--style1"><svg version="1.1" id="loader-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="80px" height="80px" viewBox="0 0 40 40" enable-background="new 0 0 40 40" xml:space="preserve"><path opacity="0.2" fill="#000" d="M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946 s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634 c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z"/><path fill="#000" d="M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0 C22.32,8.481,24.301,9.057,26.013,10.047z"><animateTransform attributeType="xml" attributeName="transform" type="rotate" from="0 20 20" to="360 20 20" dur="0.5s" repeatCount="indefinite"/></path></svg></div></div>'
      );
    var urlLink =
      $(this)
        .closest("form")
        .attr("action") +
      $(this)
        .closest("form")
        .serialize();

    var thisButton = $(this);
    var thisButtonText = $(this).html();
    thisButton.width(thisButton.width());
    thisButton.height(thisButton.height());
    thisButton.html('<span class="preloader"></div>');

//    console.log($(this).closest("form").serialize());
    $.ajax({
      url: urlLink,
      type: "get",
      dataType: "html",
      success: function(data) {
        var $response = $(data);
		  // console.log(data);
        var count = $response.find(".header-cart").html();
        var cart = $response.find("#basketModal").html();
        var errors = $response.find(".error-container").html();

          console.log('errors');
          console.log(errors);
          //console.log(count);
		  //console.log(cart);
        if(errors) {
            $.fancybox.open({
                src:
                    '<div class="error-popup">'+errors+'</div>',
                type: "inline",
                autoFocus: false,
                touch: {
                    vertical: false,
                    momentum: false
                },
            });
        }  else {
            $("#basketModal").html(cart);
            $(".header-cart").html(count);
            updatePriceCur($(".cart-list--item-price, .cart-list--total-price"));

            setTimeout(function () {
                $('.header-cart').trigger('click');
                // $.fancybox.open({
                //   src: ".cart-box--container",
                //   type: "inline",
                //   autoFocus: false,
                //   touch: {
                //       vertical: false,
                //       momentum: false
                //   },
                // });
            }, 200);
        }
        thisButton.html(thisButtonText);
        thisButton.removeAttr("style");
        $(".w-overlay").remove();
      }
    });
  });

  /*===============================================
    "Добавить в избранное" - Ajax
  	===============================================*/
  $(document).on("click", ".wishlist-ajax", function(e) {
    e.preventDefault();
    $(this)
      .closest("form")
      .append(
        '<div class="w-overlay"><div class="loader loader--style1"><svg version="1.1" id="loader-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="80px" height="80px" viewBox="0 0 40 40" enable-background="new 0 0 40 40" xml:space="preserve"><path opacity="0.2" fill="#000" d="M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946 s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634 c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z"/><path fill="#000" d="M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0 C22.32,8.481,24.301,9.057,26.013,10.047z"><animateTransform attributeType="xml" attributeName="transform" type="rotate" from="0 20 20" to="360 20 20" dur="0.5s" repeatCount="indefinite"/></path></svg></div></div>'
      );
    var thisButton = $(this);
    var wishlistForm = thisButton.closest("form");
    var wishlistFormActions = thisButton.closest("form .wishlistBlock");
    var wishlistFormId = "#" + thisButton.closest("form").attr("id");
    var cnid = wishlistForm.find('.hidden input[name="cnid"]').val(),
      actcontrol = wishlistForm.find('.hidden input[name="actcontrol"]').val(),
      stoken = wishlistForm.find('.hidden input[name="stoken"]').val(),
      lang = wishlistForm.find('.hidden input[name="lang"]').val(),
      pgNr = wishlistForm.find('.hidden input[name="pgNr"]').val(),
      cl = wishlistForm.find('.hidden input[name="cl"]').val(),
      anid = wishlistForm.find('.hidden input[name="anid"]').val();
    if (cl === "details") {
      if ($("body").hasClass("cl-start")) {
        cl = "start";
      }
      if ($("body").hasClass("cl-alist")) {
        cl = "alist";
      }
    }
    var urlLink =
      "/index.php?cnid=" +
      cnid +
      "&actcontrol=" +
      actcontrol +
      "&stoken=" +
      stoken +
      "&lang=" +
      lang +
      "&pgNr=" +
      pgNr +
      "&cl=" +
      cl +
      "&fnc=tonoticelist&aid=" +
      anid +
      "&anid=" +
      anid +
      "&am=1";

    if (thisButton.hasClass("wishlist-is")) {
      urlLink = urlLink.replace("am=1", "am=0");
      var wishlistPopupText = "Artikel gelöscht";
    }
    if (thisButton.hasClass("wishlist-not")) {
      var wishlistPopupText = "Artikel merken";
    }

    var thisButtonText = $(this).html();
    thisButton.width(thisButton.width());
    thisButton.height(thisButton.height());
    thisButton.find("i").replaceWith('<span class="preloader"></span>');
    $.ajax({
      url: urlLink,
      type: "get",
      dataType: "html",
      success: function(data) {
        var $response = $(data);
        var servicemenu = $response.find(".service-menu-box").html();
        $(".service-menu-box").html(servicemenu);
        wishlistFormActions.html(
          $response.find(wishlistFormId + " .wishlistBlock").html()
        );
        if (!isMobile.any()) {
          wishlistFormActions.find(".hasTooltip").tooltip();
        }
        $.fancybox.open({
          src:
            '<div style="display: inline-block; background: #fff; max-width: 320px; width: 100%;"><div style="width: 100%; max-width: 800px; "><div style="text-align: center;"><i class="fa fa-heart-o" aria-hidden="true" style="color: #F62F5E; font-weight: 700; margin-right: 10px;"></i>' +
            wishlistPopupText +
            '</div></div><button data-fancybox-close="" class="fancybox-close-small"></button></div>',
          type: "inline",
          autoFocus: false,
          touch: {
              vertical: false,
              momentum: false
          },
        });
        thisButton.html(thisButtonText);
        thisButton.removeAttr("style");
        $(".w-overlay").remove();
        setTimeout(function() {
          $.fancybox.close();
        }, 2000);
      }
    });
  });

  /*===============================================
    Удаление товара в Cart Fancybox
  	===============================================*/
  $(document).on("click", ".cart-list--item-info-remove", function() {
    $(this)
      .closest("form")
      .append('<input type="hidden" name="removeBtn" value="1" />');
    updateCart($(this));
  });

  /*===============================================
    Number Counter в Cart Fancybox
  	===============================================*/
  // прибавляем
  $(document).on("click", ".cart-list--item .number-icon .down", function() {

    var curInput = $(this)
      .parent()
      .find('input[type="text"]');
    if (curInput.val() > 1) {
      curInput.val(+curInput.val() - 1);
    }
    updateCart($(this));
  });
  // уменьшаем
  $(document).on("click", ".cart-list--item .number-icon .up", function() {
    var curInput = $(this)
      .parent()
      .find('input[type="text"]');
    curInput.val(+curInput.val() + 1);
    updateCart($(this));
  });
  // ввод с клавиатуры
  $('.cart-list--item .number-icon input[type="text"]').each(function() {
    $(this).on("keyup change", function() {
      if (/\D/g.test(this.value)) {
        this.value = this.value.replace(/\D/g, "");
      }
      $(this)
        .closest("form")
        .find('.hidden input[name="am"]')
        .val(this.value);
      updateCart($(this));
    });
  });

  // $( "#amountToBasket" ).change(function() {
  //   // var amounToBas = $(this).val();
  //   var curentItem = $(this);
  //   updateCart(curentItem);
  // });
  // Ajax
  function updateCart(targetThis) {
    $(".cart-box--container-inner").append(
      '<div class="w-overlay"><div class="loader loader--style1"><svg version="1.1" id="loader-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="80px" height="80px" viewBox="0 0 40 40" enable-background="new 0 0 40 40" xml:space="preserve"><path opacity="0.2" fill="#000" d="M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946 s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634 c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z"/><path fill="#000" d="M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0 C22.32,8.481,24.301,9.057,26.013,10.047z"><animateTransform attributeType="xml" attributeName="transform" type="rotate" from="0 20 20" to="360 20 20" dur="0.5s" repeatCount="indefinite"/></path></svg></div></div>'
    );
    var urlLink =
      targetThis.closest("form").attr("action") +
      targetThis.closest("form").serialize();
      console.log(urlLink);

    $.ajax({
      url: urlLink,
      type: "post",
      dataType: "html",
      success: function(data) {
        var $response = $(data);
        var count = $response.find(".header-cart").html();
        var cart = $response.find("#basketModal").html();
        $("#basketModal").html(cart);
        $(".header-cart").html(count);
        $('.cart-list--item .number-icon input[type="text"]').each(function() {
          $(this).on("keyup change", function() {
            if (/\D/g.test(this.value)) {
              this.value = this.value.replace(/\D/g, "");
            }
            $(this)
              .closest("form")
              .find('.hidden input[name="am"]')
              .val(this.value);
            updateCart($(this));
          });
        });
        updatePriceCur($(".cart-list--item-price, .cart-list--total-price"));

        $(".w-overlay").remove();
      }
    });
  }
  // Удаляем товар
  $(document).on("click", ".basketTotalForm--item-remove", function() {
    $(this)
      .closest("form")
      .append('<input type="hidden" name="removeBtn" value="1" />');
    updateCartTotal($(this));
  });

  /*===============================================
    Удаление всех товаров на странице Корзины
  	===============================================*/
  $(document).on("click", ".removeAllProducts", function() {
    $(".basketTotalForm--item").each(function() {
      $(".remove_main_all").val("1");
      $(this)
        .closest("form")
        .append('<input type="hidden" name="removeBtn" value="1" />');
    });
    updateCartTotal($(this));
  });

  /*===============================================
    Number Counter на странице Корзины
  	===============================================*/
  // уменьшаем
  $(document).on(
    "click",
    ".basketTotalForm--item .number-icon .down",
    function() {
      if ($(this).hasClass("mobile-sign")) {
        var curInputDefault = $(this)
          .parent()
          .find('input[type="text"]')
          .attr("name");
        var curInput = $(this)
          .closest("form")
          .find('#basket_table input[name="' + curInputDefault + '"]');
      } else {
        var curInput = $(this)
          .parent()
          .find('input[type="text"]');
      }
      if (curInput.val() > 1) {
        curInput.val(+curInput.val() - 1);
      }
      updateCartTotal($(this));
    }
  );
  // прибавляем
  $(document).on(
    "click",
    ".basketTotalForm--item .number-icon .up",
    function() {
      if ($(this).hasClass("mobile-sign")) {
        var curInputDefault = $(this)
          .parent()
          .find('input[type="text"]')
          .attr("name");
        var curInput = $(this)
          .closest("form")
          .find('#basket_table input[name="' + curInputDefault + '"]');
      } else {
        var curInput = $(this)
          .parent()
          .find('input[type="text"]');
      }
      curInput.val(+curInput.val() + 1);
      updateCartTotal($(this));
    }
  );
  // ввод с клавиатуры
  $('.basketTotalForm--item .number-icon input[type="text"]').each(function() {
    $(this).on("keyup change", function() {
      if ($(this).hasClass("mobile-sign-am")) {
        var curInputDefault = $(this).attr("name");
        var curInput = $(this)
          .closest("form")
          .find('#basket_table input[name="' + curInputDefault + '"]');
      } else {
        var curInput = $(this);
      }
      if (/\D/g.test(this.value)) {
        this.value = this.value.replace(/\D/g, "");
      }
      curInput.val(this.value);
      $(this)
        .closest("form")
        .find('.hidden input[name="am"]')
        .val(this.value);
      updateCartTotal($(this));
    });
  });
  // Ajax
  function updateCartTotal(targetThis) {
    $("#basketTotalForm").append(
      '<div class="w-overlay"><div class="loader loader--style1"><svg version="1.1" id="loader-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="80px" height="80px" viewBox="0 0 40 40" enable-background="new 0 0 40 40" xml:space="preserve"><path opacity="0.2" fill="#000" d="M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946 s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634 c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z"/><path fill="#000" d="M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0 C22.32,8.481,24.301,9.057,26.013,10.047z"><animateTransform attributeType="xml" attributeName="transform" type="rotate" from="0 20 20" to="360 20 20" dur="0.5s" repeatCount="indefinite"/></path></svg></div></div>'
    );
    var urlLink =
      targetThis.closest("form").attr("action") +
      targetThis.closest("form").serialize();

    $.ajax({
      url: urlLink,
      type: "post",
      dataType: "html",
      success: function(data) {
        var $response = $(data);
        var count = $response.find(".header-cart").html();
        var cart = $response.find("#basketTotalForm").html();
        if (cart) {
          $("#basketTotalForm").html(cart);
        } else {
          cart = $response.find("#empty-basket-warning").html();
          $("#basketTotalForm").replaceWith(
            '<div id="empty-basket-warning">' + cart + "</div>"
          );
          $(".well").remove();
        }
        $(".header-cart").html(count);

        $('.basketTotalForm--item .number-icon input[type="text"]').each(
          function() {
            $(this).on("keyup change", function() {
              if ($(this).hasClass("mobile-sign-am")) {
                var curInputDefault = $(this).attr("name");
                var curInput = $(this)
                  .closest("form")
                  .find('#basket_table input[name="' + curInputDefault + '"]');
              } else {
                var curInput = $(this);
              }
              if (/\D/g.test(this.value)) {
                this.value = this.value.replace(/\D/g, "");
              }
              curInput.val(this.value);
              $(this)
                .closest("form")
                .find('.hidden input[name="am"]')
                .val(this.value);
              updateCartTotal($(this));
            });
          }
        );

        updatePriceCur(
          $(".basketTotalForm--item-price, .basketTotalForm--price")
        );

        $(".w-overlay").remove();
      }
    });
  }

  /*===============================================
    Удаление всех товаров из Списка избранного
  	===============================================*/
  $(document).on("click", ".clearAllWishlist", function() {
    $("#boxwrapper_noticelistProductList .js-oxProductForm").each(function() {
      $(".remove_main_all").val("1");
      $(this).append('<input type="hidden" name="removeBtn" value="1" />');
    });
  });

  /*===============================================
    Sly Carousel
  	===============================================*/
//  $(".sly-carousel").each(function() {
//    if ($(this).hasClass("check-size-topcat")) {
//      var productContainer = $(".check-size-product-container-topcat").width();
//    } else {
//      var productContainer = $(".check-size-product-container-inner").width();
//    }
//    $(this)
//      .find("li")
//      .each(function() {
//        $(this).width(productContainer);
//        $(this).css("min-width", productContainer + "px");
//        $(this).css("max-width", productContainer + "px");
//        $(this)
//          .closest(".fadeIn")
//          .css("opacity", "1");
//      });
//    var $slidee = $(this)
//      .children("ul")
//      .eq(0);
//    var $wrap = $(this).parent();
//    $(this).sly({
//      horizontal: 1,
//      itemNav: "basic",
//      smart: 1,
//      // activateOn: 'click',
//      mouseDragging: 1,
//      touchDragging: 1,
//      releaseSwing: 1,
//      swingSpeed: 0.5,
//      startAt: 0,
//      scrollBar: $wrap.find(".scrollbar"),
//      scrollBy: 1,
//      pagesBar: $wrap.find(".pages"),
//      activatePageOn: "click",
//      speed: 500,
//      elasticBounds: 1,
//      easing: "swing",
//      dragHandle: 1,
//      dynamicHandle: 1,
//      clickBar: 1,
//      // Buttons
//      forward: $wrap.find(".forward"),
//      backward: $wrap.find(".backward"),
//      prev: $wrap.find(".prev"),
//      next: $wrap.find(".next"),
//      prevPage: $wrap.find(".prevPage"),
//      nextPage: $wrap.find(".nextPage")
//    });
//  });
	if($(".sly-carousel ul").length){
		$(".sly-carousel ul").owlCarousel({
		loop:false,
		margin:30,
		nav:false,
		dots:true,
		responsive:{
			0:{
				items:2,
				margin:15,
			},
			767:{
				items:4,
				margin:15,
			},
			992:{
				items:5
			},
			1200:{
				items:6
			},

		}
	});
	}



    if($('.top-cat').length){
      var mySwiper = new Swiper ('.top-cat', {
        slidesPerView: 4,
        spaceBetween: 8,
        loop: true,
          pagination: {
              el: '.swiper-pagination',
              clickable: true,
          },
          breakpoints: {
              0: {
                  slidesPerView: 2,
              },
              250: {
                  slidesPerView: 2,
              },
              500: {
                  slidesPerView: 3,
              },

              1000: {
                  slidesPerView: 4,
              }
          }
      })


    // if($('.top-themes').length){
    //   var mySwiper = new Swiper ('.top-themes', {
    //     slidesPerView: 'auto',
    //     spaceBetween: 0,
    //     loop: true
    //   })
    // }
  }

  // if ($(window).width() <= 991 || $('.subCat .subcatList').find('.item-cat').length > 3) {
  //   if($('.subCat').length){
  //     var mySwiper = new Swiper ('.subCat', {
  //       slidesPerView: 'auto',
  //       spaceBetween: 0,
  //       loop: true
  //     })
  //   }
  // }


//

    var mySwiper = new Swiper ('.swiper-product-carousel', {

        slidesPerView: 7,
        spaceBetween: 0,
        // pagination: {
        // el: '.swiper-pagination',
        // clickable: true,
        // },
        scrollbar: {
            el: ".swiper-scrollbar",
            hide: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        loop: false,
        breakpoints: {
            0: {
                slidesPerView: 2,
            },
            250: {
                slidesPerView: 2,
            },
            500: {
                slidesPerView: 3,
            },
            750: {
                slidesPerView: 4,
            },
            1000: {
                slidesPerView: 5,
            },
            1250: {
                slidesPerView: 6,
            },
            1500: {
                slidesPerView: 6,
            }
        }
    });

    var swiperMulti = new Swiper(".swiper--main-product--thumbs", {
        spaceBetween: 10,
        slidesPerView: 6,
        // freeMode: true,
        watchSlidesVisibility: true,
        watchSlidesProgress: true,
        navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
              },
        breakpoints: {
            0: {
                slidesPerView: 3,
            },
            500: {
                slidesPerView: 4,
            },
            750: {
                slidesPerView: 6,
            }
        }
    });
    var swiperMulti2 = new Swiper(".swiper--main-product--carousel", {
        spaceBetween: 10,
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        thumbs: {
            swiper: swiperMulti,
        },
    });



	if($('#cross.swiper-container').length){
    //initialize swiper when document ready
		var mySwiper = new Swiper ('#cross.swiper-container', {
		  	spaceBetween: 0,
			loop: false,
			  pagination: {
				el: '#boxwrapper_cross .swiper-pagination',
				clickable: true,
			  },
			  navigation: {
				nextEl: '#boxwrapper_cross .swiper-button-next',
				prevEl: '#boxwrapper_cross .swiper-button-prev',
			  },

		});


      }




	if($('.owl-top-cats, .cl-details .owl-products, .cl-thankyou .owl-products').length){
		$('.owl-top-cats, .cl-details .owl-products, .cl-thankyou .owl-products').owlCarousel({
		loop:false,
		margin:30,
		nav:false,
		responsive:{
			0:{
				items:1
			},
			400:{
				items:2,
				margin:15,
			},
			600:{
				items:3
			},
			800:{
				items:4
			}
		}
	});
	}


	// $(document).on('click', 'button.prevPage', function() {
	// 	$(this).closest('.boxwrapper').find('.owl-carousel').trigger('prev.owl.carousel');
	// });

	// $(document).on('click', 'button.nextPage', function() {
	// 	$(this).closest('.boxwrapper').find('.owl-carousel').trigger('next.owl.carousel');
	// });

	// $(document).on('click', '.prevPage', function() {
	// 	console.log('1');
	// 	$(this).closest('.sly-wrapper').find('.sly-carousel .owl-loaded').trigger('prev.owl.carousel');
	// });

	// $(document).on('click', '.nextPage', function() {
	// 	console.log('2');
	// 	$(this).closest('.sly-wrapper').find('.sly-carousel .owl-loaded').trigger('next.owl.carousel');
	// });

  /*===============================================
    Разделение цены
  	===============================================*/
  function priceTool(value) {
    return (
      value.split(",")[0] +
      '<span class="sup-price">' +
      value.split(",")[1].replace(/\s/g, "") +
      "</span>"
    );
  }

  function priceToolCur(value) {
    var price = value.replace(/\s/g, "").split("€")[0];
    if (2 !== price.length) {
        return value;
    }
    return (
      price.split(",")[0] +
      '<span class="sup-price">' +
      price.split(",")[1].replace(/\s/g, "") +
      "</span> €"
    );
  }



  function updatePriceCur(value) {
    value.each(function() {
      var newPrice = priceToolCur($(this).text());
      $(this).html(newPrice);
    });
  }

  updatePriceCur(
    $(
      ".cart-list--item-price, .cart-list--total-price, .basketTotalForm--item-price, .basketTotalForm--price"
    )
  );

  /*================================================================================================
	  ================================================================================================
	  ================================================================================================
      VAL.JS
	  ================================================================================================
	  ================================================================================================
	  ==============================================================================================*/

  /*===============================================
    Mobile detection
  	===============================================*/
  var isMobile = {
    Android: function() {
      return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
      return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
      return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
      return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
      return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
      return (
        isMobile.Android() ||
        isMobile.BlackBerry() ||
        isMobile.iOS() ||
        isMobile.Opera() ||
        isMobile.Windows()
      );
    }
  };

  /*===============================================
    Tooltop script initialize
  	===============================================*/
  if (!isMobile.any()) {
    $(".hasTooltip").tooltip();
  }

  /*===============================================
    Вырезаем title в карточке товара при моб.версии
  	================================================*/
  if ($("#detailsMain").length && isMobile.any()) {
    $(".details--top-info").addClass("details--top-info-bottom");
    $(".details-col-left").prepend(
      '<div class="details--top-info"><span class="small text-muted">' +
        $(".details--top-info .text-muted").text() +
        "</span></div>"
    );
    $(".details--top-info-bottom .text-muted").remove();
    $(".details-col-left").prepend($("#productTitle"));
  }

  /*===============================================
    Верхнее меню в мобильной версии
    ===============================================*/



  var sideMenu =
    '<div class="sideMenu"><div class="sideMenu--head">' +
    '<button type="button" class="sideMenuClose"><i class="far fa-chevron-right"></i></button></div><div class="sideMenu--wrapper">';
  sideMenu += '<div class="top-row--user"><p>Mein Konto</p>';
  if ($(".top-row--login").length) {
    sideMenu +=
      '<a class="top-row--login">' +
      $(".top-row--login").html() +
      "</a>" +
      '<div class="sideMenu--cabinet-form">' +
      $(".login-box--container-inner").html() +
      "</div>";
    // sideMenu += $(".top-row--register")
    //   .clone()
    //   .wrap("<div></div>")
    //   .parent()
    //   .html();
  } else {
    sideMenu +=
      '<div class="top-row--user-loggedin"><a class="top-row--profile">' +
      $(".top-row--profile").html() +
      "</a>";
    // sideMenu +=
    //   '<div class="sideMenu--cabinet-form"><ul>' +
    //   $("#services").html() +
    //   "</ul></div>";
    sideMenu += $(".prifile--out").html() + "</div>";
  }
  sideMenu +=
    '</div><div class="sideMenu--bottom">';
  sideMenu +=
    "<p>Info</p>" +
    '<div class="whatsap-row">' + $(".whatsapp").html() + '</div>';

  sideMenu +=
    "<p>Rückruf</p><p class='small'>Brauchen Sie Hilfe?<br>Rufen Sue uns an oder bestellen Sie ein Rückruf</span></p>";

  sideMenu +=
    '<div class="sideMenu--phone-col">' +
    $(".header-box > .phone-col").html() +
    // $(".phone-item-2").html() +
    "</div>";

  sideMenu +=
    '<div class="phone-col--callback-wrap">' +
    $(".callback-box--container").html() +
    "</div></div>";

  sideMenu +=
    '<div class="top-row--social"><p>Wir in sozialen Medien</p>' +
    $(".legal .social-links").html() +
    "</div></div>";

  $("body").prepend(sideMenu);
  // Toggle Side Menu
  $(".m-menu").on("click", function() {
    $(".sideMenu").toggleClass("sideMenuShow");
    $('.nav_overlay').fadeToggle();
    setTimeout(function() {
      $("body").toggleClass("bodyHide");
    }, 200);
  });
  // Hide Side Menu
  $("body").on("click", ".sideMenuClose, .nav_overlay", function() {
      $(".sideMenu").removeClass("sideMenuShow");
      $(".cart-box--wrapper").removeClass("cart-box--wrapper--open");
    $("body,html").removeClass("bodyHide");
      $('.nav_overlay').fadeOut();
  });

  // $("body").on("click", ".top-row--login, .top-row--profile", function() {
  //   $(this).toggleClass("menu--click");
  //   $(".sideMenu--cabinet-form").slideToggle(200);
  // });//



  if (isMobile.any()) {
    $("body").on("click", ".phone-col--callback", function() {
      $(this).toggleClass("menu--click");
      $(".phone-col--callback-wrap").slideToggle(200);
      $(".phone-col--number").toggleClass("hidden");
    });
  }

  if($(window).width() <= 991){
    $('.footer-box-manufacturers .whatsapp').clone().appendTo('.footer-right-part .col-sm-offset-0');
    $('.footer-box-manufacturers .whatsapp').remove();
  }





  $(".toggle-box-sort-in-cat").on("click", function() {
    $(".col-md-3.alist").addClass("sort-active");
      $('.nav_overlay').fadeIn();
    setTimeout(function() {
      $("body").addClass("bodyHide");
    }, 200);
      $(".close-sort").fadeIn();
  });//

    // $( document).on( "swipeleft", function () {
    //     if($(".col-md-3.alist").hasClass("sort-active")) {
    //         $(".col-md-3.alist").removeClass("sort-active");
    //         $('.nav_overlay').fadeOut();
    //         setTimeout(function() {
    //             $("body").removeClass("bodyHide");
    //         }, 200);
    //     }
    // } );

    // $(".col-md-3.alist").swipe( {
    //     //Generic swipe handler for all directions
    //     swipeLeft:function(event, direction, distance, duration, fingerCount, fingerData) {
    //         if($(this).hasClass("sort-active")) {
    //             $(".col-md-3.alist").removeClass("sort-active");
    //             $('.nav_overlay').fadeOut();
    //             setTimeout(function () {
    //                 $("body").removeClass("bodyHide");
    //             }, 200);
    //         }
    //     },
    //     //Default is 75px, set to 0 for demo so any distance triggers swipe
    //     threshold:0
    // });

  $(".close-sort").on("click", function() {
    $(".col-md-3.alist").removeClass("sort-active");
      $('.nav_overlay').fadeOut();
    $("body").removeClass("bodyHide");
      $(".close-sort").fadeOut();
  });





  if($('.subCat').length){
      var lang = $('html').attr('lang');
      var allCatWord = lang == 'ru' ? 'Все категории' : 'Weitere Kategorien'; //
    var subCatsList = $('.subCat .subcatList');
    var itemSubCats = subCatsList.find('.item-cat');
    itemSubCats.each(function(i, item) {
      if(i > 8){
        $(item).hide().addClass('hidenSubCat');
        if(i == 9){
          $('<div class="item-cat item-cat-show-all"><i class="far fa-plus"></i><span>' + allCatWord + '</span></div>').insertBefore($(item).prev().prev());
          $(item).prev().hide().addClass('hidenSubCat');
          $(item).prev().prev().hide().addClass('hidenSubCat');
        }

      }
    });
  }

  $("body").on("click", ".item-cat-show-all", function() {
    var subCatsList = $('.subCat .subcatList');
    var itemSubCats = subCatsList.find('.item-cat');
    $(this).hide();
    itemSubCats.each(function(i, item) {
      if($(item).hasClass('hidenSubCat')){
        $(item).slideDown();
      }
    });
  });

  /*===============================================
    Меню категорий в мобильной версии
  	===============================================*/
  // var mobileCategory =
  //   '<div class="mobileCategory"><div class="sideMenu--head"><button type="button" class="back-to-cat-in-nav"><i class="far fa-chevron-left"></i></button>' +
  //   '<button type="button" class="mobileCategoryClose">Mein Markt<i class="fal fa-times"></i></button></div><div class="sideMenu--wrapper">';
  // mobileCategory +=
  //   '<div class="sliding-menu-wrapper">' +
  //   $(".nav-row--category-list").html() +
  //   "</div></div></div>";
  // $("body").append(mobileCategory);
  // // Toggle Side Menu
  // $(".m-category-toggle").on("click", function() {
  //   $(".mobileCategory").toggleClass("mobileCategoryShow");
  //   $("body").prepend('<div class="overlay-site"></div>');
  //   setTimeout(function() {
  //     $("body").toggleClass("bodyHide");
  //   }, 200);
  // });
  // // Hide Side Menu
  // $("body").on("click", ".mobileCategoryClose, .overlay-site", function() {
  //   $(".mobileCategory").removeClass("mobileCategoryShow");
  //   $(".col-md-3.alist").removeClass("sort-active");
  //   $(".overlay-site").remove();
  //   $("body").removeClass("bodyHide");
  // });
  // if (window.matchMedia("(max-width: 991px)").matches || isMobile.any()) {
  //   //кнопка "назад" в подкатегориях
  //   // $(".sub-cats").prepend(
  //   //   '<a class="back" href="#"> <i class="fa fa-chevron-left"></i>zurück</a>'
  //   // );
  //   // $(".sub-cats .imageWrapper").html(
  //   //   '<i class="fa fa-chevron-circle-right" aria-hidden="true" style="color: #87B144;"></i>'
  //   // );
  //   var backTop;
  //   $(".mobileCategory .sub-cats").each(function() {
  //     var $this = $(this);
  //     $this.parent().append('<i class="far fa-chevron-right"></i>');
  //     var perentLink = $this.parent().find('a.hasSubcats').clone();
  //
  //     var dataHrefAttr = $this.parent().find("i");
  //
  //     var id = Math.random()
  //       .toString(36)
  //       .substring(3, 8);
  //     var dataHref = "#cat-id-" + id;
  //     $this.closest("ul").addClass("menu-cat-parent");
  //     $this.attr("id", "cat-id-" + id);
  //
  //
  //     $this.prepend(perentLink);
  //     dataHrefAttr.attr("data-href", dataHref);
  //     //$this.find('i').attr("data-href", dataHref);
  //     $this.detach();
  //
  //     $(".mobileCategory .sliding-menu-wrapper").append($this);
  //     $(".mobileCategory .sideMenu--wrapper").css(
  //       "height",
  //       $(".menu-cat-parent").height()
  //     );
  //     $(".sliding-menu-wrapper").css(
  //       "width",
  //       $(".sub-cats").length * $(".menu-cat-parent").width()
  //     );
  //
  //     dataHrefAttr.on("click", function() {
  //       backTop = $(this)
  //         .parent()
  //         .position().top;
  //       // $(".mobileCategory .sideMenu--wrapper").css(
  //       //   "height",
  //       //   $("#cat-id-" + id + " ul").height() + 60
  //       // );
  //
  //       $("#cat-id-" + id).insertAfter(".menu-cat-parent");
  //       $(".sliding-menu-wrapper").css("transform", "translate(-295px, 0px)");
  //
  //
  //       $(".back-to-cat-in-nav").css("opacity", "1");
  //
  //     });
  //
  //
  //     // $(".back").on("click", function() {
  //     //   // $(".mobileCategory .sideMenu--wrapper").css(
  //     //   //   "height",
  //     //   //   $(".menu-cat-parent").height()
  //     //   // );
  //     //   $(".sliding-menu-wrapper").css("transform", "translate(0px, 0px)");
  //     //   // $('#cat-id-' + id).css('display', 'none');
  //
  //     //   $(".mobileCategory").animate(
  //     //     {
  //     //       scrollTop: backTop + 82 + "px"
  //     //     },
  //     //     0
  //     //   );
  //     // });
  //   });
  //
  //
  //   $(document).on("click", ".back-to-cat-in-nav", function(e) {
  //     if($(this).attr('id')){
  //       $(".sub-cats#" + $(this).attr('id')).insertAfter(".menu-cat-parent");
  //       $(".sliding-menu-wrapper").css("transform", "translate(-295px, 0px)");
  //       $(this).attr('id', null);
  //     }else{
  //       $(this).css("opacity", "0");
  //       $(".sliding-menu-wrapper").css("transform", "translate(0px, 0px)");
  //       $(".mobileCategory").animate(
  //         {
  //           scrollTop: backTop + 82 + "px"
  //         },
  //         0
  //       );
  //     }
  //   });
  //
  //   var backTop;
  //   $(".mobileCategory .sub-cats-third").each(function() {
  //     var $this = $(this);
  //     $this.parent().append('<i class="far fa-chevron-right"></i>');
  //     var dataHrefAttr = $this.parent().find("i");
  //     var perentLink = $this.parent().children('a').clone();
  //
  //     var id = Math.random().toString(36).substring(3, 8);
  //
  //     var dataHref = "#sub-cat-third-id-" + id;
  //     // $this.closest("ul").addClass("menu-cat-parent");
  //     $this.attr("id", "sub-cat-third-id-" + id);
  //     $this.prepend(perentLink);
  //     dataHrefAttr.attr("data-href", dataHref);
  //     //$this.find('i').attr("data-href", dataHref);
  //     $this.detach();
  //
  //     $(".mobileCategory .sliding-menu-wrapper").append($this);
  //
  //     $(".mobileCategory .sideMenu--wrapper").css(
  //       "height",
  //       $(".menu-cat-parent").height()
  //     );
  //     $(".sliding-menu-wrapper").css(
  //       "width",
  //       $(".sub-cats").length * $(".menu-cat-parent").width()
  //     );
  //
  //     dataHrefAttr.on("click", function() {
  //       backTop = $(this)
  //         .parent()
  //         .position().top;
  //       // $(".mobileCategory .sideMenu--wrapper").css(
  //       //   "height",
  //       //   $("#cat-id-" + id + " ul").height() + 60
  //       // );
  //       $("#sub-cat-third-id-" + id).insertAfter(".menu-cat-parent");
  //       $(".sliding-menu-wrapper").css("transform", "translate(-590px, 0px)");
  //
  //
  //       $(".back-to-cat-in-nav").attr('id', $(this).closest('.sub-cats').attr('id'));
  //     });
  //
  //
  //   });
  // }




    /*===============================================
     Новое меню с top categories и all categories
  	===============================================*/




    $(document).on('click', '.all-categories--toggle, .m-category-toggle', function() {
        $('body').addClass('bodyHide');
        $('#all-categories--nav-row').show('slide', 300);
        $('.nav_overlay').fadeIn();
    });

    $(document).on('click', '.nav_overlay, .all-categories--nav-row--close', function() {
        $('.col-md-3.alist').removeClass('sort-active');
        $('body').removeClass('bodyHide');
        $('#all-categories--nav-row').hide('slide', 300);
        $('.nav_overlay').fadeOut();
        $('.close-sort').fadeOut();
    });
    
    if(!$('#all-categories--nav-row').length) {
        $('.all-categories--toggle').parent().remove();
    }



    $('div[id^="child_"]').each(function() {
        $(this).css('opacity', '0');
        $(this).css('display', 'block');
        var thisUl = $(this).children('ul').first();
        if(thisUl.children().length) {
            if (!thisUl.hasClass('widthRendered')) {
                thisUl.width(thisUl.children().last().position().left + 200);
                thisUl.addClass('widthRendered');
            }
            $(this).css('display', 'none');
            $(this).css('opacity', '1');
        } else {
            $(this).remove();
        }

    });

    $('.nav-row--category-list li a.hasSubcats').hover(
      function() {
          if (window.matchMedia("(min-width: 1069px)").matches) {

              var thisLink = $(this);
              var thisId = thisLink.data('child');


              $('#child_' + thisId)
                  .stop(true, true)
                  .delay(500)
                  .show('slide', 300);
          }


      },
      function() {

          if (window.matchMedia("(min-width: 1069px)").matches) {

              var thisLink = $(this);
              var thisId = thisLink.data('child');

              $('#child_' + thisId)
                  .stop(true, true)
                  .delay(500)
                  .hide('slide', 300);
          }

      }
    );

    $(document).on('click', '.nav-row--category-list li a.hasSubcats', function(e) {
        if (window.matchMedia("(max-width: 1069px)").matches) {
            e.preventDefault();
            var thisLink = $(this);
            var thisId = thisLink.data('child');

            $('#all-categories--nav-row').effect('slide', { direction: 'left', mode: 'hide' }, 300);

            $('#child_' + thisId).effect('slide', { direction: 'right', mode: 'show' }, 300);
        }


    });




    $('div[id^="child_"]').hover(
        function() {

            if (window.matchMedia("(min-width: 1069px)").matches) {
                var thisLink = $(this);
                var thisId = thisLink.data('child');
                $(this)
                    .stop(true, true)
                    .delay(500)
                    .show('slide', 300);
            }


        },
        function() {
            if (window.matchMedia("(min-width: 1069px)").matches) {
                $(this)
                    .stop(true, true)
                    .delay(500)
                    .hide('slide', 300);
            }

        }
    );



    $(document).on('click', '.all-categories--child--close', function() {
        $('body').removeClass('bodyHide');
        $(this).parent().effect('slide', { direction: 'left', mode: 'hide' }, 300);
        $('.nav_overlay').fadeOut();
    });

    $(document).on('click', '.all-categories--child--back', function() {
        $('#all-categories--nav-row').effect('slide', { direction: 'left', mode: 'show' }, 300);
        $(this).parent().effect('slide', { direction: 'right', mode: 'hide' }, 300);

    });


    if (window.matchMedia("(max-width: 767px)").matches) {//
        $('#itemTabs li a').each(function () {
            $(this).after($($(this).attr('href')).clone().removeAttr('id'));
            $(this).on("click", function () {

                $(this).toggleClass("mobile-active");
                $(this)
                    .parent()
                    .find(".tab-pane")
                    .slideToggle(200);

            });
        });
    }






    /*===============================================
      Делаем квадратные картинки подкатегорий
        ===============================================*/
  function squareImagesCat(curSubCat) {
    var tempStyle = $(".nav-row--category-list").attr("style");
    $(".nav-row--category-list").css({
      visibility: "hidden",
      display: "block"
    });
    curSubCat.css({
      visibility: "hidden",
      display: "block"
    });
    var subCat = curSubCat.find("li a .imageWrapper");
    subCat.each(function() {
      $(this).height($(this).width());
      $(this)
        .find("img")
        .css({
          maxHeight: $(this).width()
        });
    });
    curSubCat.css({
      visibility: "",
      display: ""
    });
    $(".nav-row--category-list").attr("style", tempStyle);
  }

//   if (window.matchMedia("(min-width: 992px)").matches) {
//     setSubmenuSize();

//     function setSubmenuSize() {
//       var submenuWidth =
//         $("#nav-row .container").width() - $("#nav-row .col-lg-3").width();
//       $(".sub-cats").each(function() {
//         $(this).width(submenuWidth);
//         if (!isMobile.any()) {
// //          squareImagesCat($(this));
//         }
//       });
//     }
//   }//

    if ($('.player-box').length || $('.player-row').length) {
        var $source = 'https://api.alpaca.t62a.com/hls/9103/index.m3u8';//
        if($('.languages-menu li.active a').attr('hreflang') == 'ru') {
            $source = 'https://api.alpaca.t62a.com/hls/9112/index.m3u8';
        }
      var player = new Clappr.Player( {
        source: $source,
        parentId: "#player",
        autoPlay: false,
        width: '100%',
        height: '100%',
        hlsMinimumDvrSize: 999999,
        plugins: [LevelSelector],
        levelSelectorConfig: {
          labelCallback: function(playbackLevel, customLabel) {
            return playbackLevel.level.height + 'p';
          }
        },
      });
    }


    if ($('.slider-container').length) {
      // var owl = $('.banner-slider');
      // owl.owlCarousel({
      //     loop: true,
      //     dots: false,
      //     nav: true,
      //     items: 1,
      //     margin:0,
      //     navText: ['<i class="fal fa-arrow-circle-left"></i>', '<i class="fal fa-arrow-circle-right"></i>'],
      // })//
      var swiper = new Swiper('.slider-container', {
        spaceBetween: 30,
          preloadImages: false,
          lazy: true,
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },
          loop: true,
          autoplay: {
              delay: 8000,
              // disableOnInteraction: false,
          },
          pagination: {
              el: ".swiper-pagination",
              clickable: true,
          },
      });

        $(".slider-container").hover(function() {
            swiper.autoplay.stop();
        }, function() {
            swiper.autoplay.start();
        });
    }
  /*===============================================
    Accordion footer title in mobile
  	===============================================*/
  if (window.matchMedia("(max-width: 767px)").matches || isMobile.any()) {
    $(".footer-box-title").each(function() {
      $(this).on("click", function() {
        $(this).toggleClass("active");
        $(this)
          .parent()
          .find(".footer-box-content")
          .slideToggle(200);
      });
    });
  }

  /*===============================================
    Заменяем ссылки вo всех видео
  	===============================================*/
  if ($("object").length) {
    $("object").each(function() {
      $(this)
        .find("embed")
        .attr(
          "src",
          $(this)
            .find("embed")
            .attr("src")
            .replace(
              "https://www.youtube-nocookie.com",
              "https://www.youtube.com"
            )
        );
      $(this)
        .find('param[name="movie"]')
        .attr(
          "value",
          $(this)
            .find('param[name="movie"]')
            .attr("value")
            .replace(
              "https://www.youtube-nocookie.com",
              "https://www.youtube.com"
            )
        );
      $(this)
        .find("embed")
        .attr(
          "src",
          $(this)
            .find("embed")
            .attr("src")
            .replace("http://", "https://")
        );
    });
  }

  /*===============================================
    Оборочиваем все видео в container
  	===============================================*/
  // $('iframe[src*="youtube.com"], object')
  //   .not(".noresize")
  //   .wrap(
  //     '<div id="video" class="block-videocontainer"><div class="videocontainer-wrapper"><div class="videocontainer"></div></div></div>'
  //   );

  /*===============================================
    Кнопка "Video" scroll and autoplay
  	===============================================*/
  if ($("#video").length) {
    $(".detailsInfo .picture").append(
      '<a id="play-video" href="#video"><i class="fa fa-play-circle" aria-hidden="true"></i> Video</a>'
    );
  }

  $(document).on("click", "#play-video", function(e) {
    if ($("#video embed").length) {
      $("#video embed")[0].src += "&autoplay=1";
    }
    if ($("#video iframe").length) {
      $("#video iframe")[0].src += "?rel=0&autoplay=1";
    }
    if ($('#video object[type="application/x-shockwave-flash"]').length) {
      $("#video object")[0].data += "&autoplay=1";
    }
    e.preventDefault();
    var idHref = $(this).attr("href"),
      topHref = $(idHref).offset().top;
    $("body,html").animate(
      {
        scrollTop: topHref - 5
      },
      800
    );
  });


    $(document).on("click", ".form-from-bem-media", function(e) {

        e.preventDefault();

        var lang = $('html').attr('lang');
        var formSrc = $(this).attr('data-src-'+lang);
        $.fancybox.open({
            src  : formSrc + '?showorderform=1',
            type : 'iframe',
            toolbar  : false,
            smallBtn : true,

            opts : {
                afterShow : function( instance, current ) {
                    console.info( 'done!' );
                    console.log(instance);
                    console.log(current);
                },
                iframe: {

                    // preload: true,

                    css: {
                        width: 600
                    },

                    //
                    // attr: {
                    //     scrolling: "auto"
                    // }
                },
            }
        });
    });
    //




  /*===============================================
    Делаем квадратной гл.картинку в карточке товара
  	===============================================*/
//   function squareImagesDetails(parrentContainerImg) {
//     var heightPicture = $(".detailsInfo .picture img");
//     heightPicture.height(heightPicture.width());
// //    heightPicture.find("img").css("max-height", heightPicture.width() + "px");
//   }
  // squareImagesDetails(".detailsInfo");

  /*===============================================
    Плавный scroll к комментариям
  	===============================================*/
  $(document).on("click", ".scroll-review", function(event) {
    event.preventDefault();
    var idHref = $(this).attr("href"),
      topHref = $(idHref).offset().top;
    $("body,html").animate(
      {
        scrollTop: topHref - 5
      },
      800
    );
  });

  /*===============================================
    Price Counter
  	===============================================*/
    document.constructor.prototype.counterPrice = function() {
//        console.log('counterPrice');
    if ($(".finalSum").length) {
      $(".finalSum").each(function() {

		  if($(this).closest('.information').length){
			  var container = $(this).closest("form");
			  // console.log(container);
		  }else{
			  var container = $(this).closest(".listDetails");
		  }
          // console.log('container');
          // console.log(container);
        var finalSum = container.find(".priceDefault").html();
        var reg = new RegExp("[ ]+", "g");
        container
          .find(".finalSum")
          .html(
            finalSum.split(",")[0] +
              '<span class="sup-price">' +
              finalSum.split(",")[1].replace(/\s/g, "") +
              "</span>"
          );
      });
    }

    $(".js-oxProductForm #amountToBasket").each(function() {
      $(this).on("change", function() {
        // if (/\D/g.test(this.value)) {
        //   this.value = this.value.replace(/\D/g, "");
        // }
//        console.log($(this).val());
        printSum($(this));
        printOldSum($(this));
      });
    });

    // $(".js-oxProductForm .number.down").on("click", function() {
    //   var numberInput = $(this)
    //     .parent()
    //     .find("input");
    //   if ($(numberInput).val() > 1) {
    //     $(numberInput).val(+$(numberInput).val() - 1);
    //   }
    //   $(this)
    //     .closest(".js-oxProductForm")
    //     .find('.hidden input[name="am"]')
    //     .val(numberInput.val());
    //   printSum($(this));
    //   printOldSum($(this));
    // });

    // $(".js-oxProductForm .number.up").on("click", function() {
    //   var numberInput = $(this)
    //     .parent()
    //     .find("input");
    //   $(numberInput).val(+$(numberInput).val() + 1);
    //   $(this)
    //     .closest(".js-oxProductForm")
    //     .find('.hidden input[name="am"]')
    //     .val(numberInput.val());
    //   printSum($(this));
    //   printOldSum($(this));
    // });

    function printSum(clickedObject) {
      var container = $(clickedObject).closest(".information");
      var numberInput = container.find("#amountToBasket");
      if (container.find(".priceDefault").length) {
        var finalSum = (
          parseFloat(
            container
              .find(".priceDefault")
              .html()
              .replace(",", ".")
          ) * +$(numberInput).val()
        ).toFixed(2);
        var finalSumSup = finalSum.split(".")[1];
        if (finalSum.split(".")[1] == "00") {
          finalSum = finalSum.split(".")[0];
        } else {
          finalSum = finalSum.replace(".", ",");
        }
        container
          .find(".finalSum")
          .html(
            finalSum.split(",")[0] +
              '<span class="sup-price">' +
              finalSumSup +
              "</span>"
          );
      }
    }

    function printOldSum(clickedObject) {
      var container = $(clickedObject).closest(".information");
//      console.log(container);
      var numberInput = container.find("#amountToBasket");
      if (container.find(".oldPrice del").length) {
        var finalOldSum = (
          parseFloat(
              container.find(".oldPrice del")
              .data("oldprice")
              .split(" €")[0]
              .replace(",", ".")
          ) * +$(numberInput).val()
        ).toFixed(2);
        var finalOldSumSup = finalOldSum.split(".")[1];
        if (finalOldSum.split(".")[1] == "00") {
          finalOldSum = finalOldSum.split(".")[0];
        } else {
          finalOldSum = finalOldSum.replace(".", ",");
        }
        container
          .find(".oldPrice del")
          .html(finalOldSum.split(",")[0] + "," + finalOldSumSup + " €");
      }
    }
  }

  // document.counterPrice();




  // $(".page-header--description").on("click", function() {
  //   $(this).toggleClass('close-tab');
  //   $(this).next().slideToggle();
  // });


  $(".btn-hide-filter").on("click", function() {
    $(this).toggleClass('filter-close');
    $(this).parent().next().slideToggle();
  });
  /*===============================================
    Owl Carousel for Other Pictures
  	===============================================*/

    if (window.matchMedia("(max-width: 991px)").matches) {
      var morePicsMargin = 5;
    } else {
      var morePicsMargin = 12;
    }



    // var mySwiper = new Swiper ('.swiper-container-more-pics', {
    //   slidesPerView: 6,
    //   spaceBetween: morePicsMargin,
    //   // pagination: {
    //   //   el: '.swiper-pagination',
    //   //   clickable: true,
    //   // },
    //   navigation: {
    //     nextEl: '.swiper-button-next',
    //     prevEl: '.swiper-button-prev',
    //   },
    //   loop: false
    // });

    // owlPics.owlCarousel({
    //   loop: false,
    //   margin: morePicsMargin,
    //   nav: true,
    //   navText: [
    //     '<i class="far fa-long-arrow-left"></i>',
    //     '<i class="far fa-long-arrow-right"></i>'
    //   ],
    //   responsive: {
    //     0: {
    //       items: 4
    //     },
    //     700: {
    //       items: 6
    //     }
    //   }
    // });


  /*===============================================
    Делаем кватдратными Other Pictuers
  	===============================================*/
//  function squareOtherPictures() {
//    var heightOtherPicture = $(".otherPictures li a");
//    if ($(".owl-morePics img").length > 4) {
//      heightOtherPicture.height($(".owl-item").width());
//    } else {
//      //            heightOtherPicture.height(heightOtherPicture.find('img').height() - 2);
//      //            heightOtherPicture.find('img').css('max-height', (heightOtherPicture.find('img').height() + 'px'));
//      heightOtherPicture.height(heightOtherPicture.width());
//      heightOtherPicture
//        .find("img")
//        .css("max-height", heightOtherPicture.width() + "px");
//    }
//    $(".otherPictures").css("opacity", "1");
//  }
//
//  squareOtherPictures();

  /*===============================================
    Profile - Fancybox popup
  	===============================================*/

    $(document).on("click", ".top-row--profile", function() {
      $.fancybox.open({
        src: ".profile-box--container",
        type: "inline",
        autoFocus: false,
        touch: {
            vertical: false,
            momentum: false
        },
      });
    });


    /*===============================================
    Credit - Fancybox popup
  	===============================================*/

    $(document).on("click", "#filter_credit_popup", function() {
        $.fancybox.open({
            src: "#filter_credit_popup_content",
            type: "inline",
            autoFocus: false,
            touch: {
                vertical: false,
                momentum: false
            },
        });//
    });

  /*===============================================
    Log In - Fancybox popup
  	===============================================*/

    $(document).on("click", ".sideMenu .top-row--login, .top-row--tooltip--inner .btn-primary", function() {
        $.fancybox.open({
            src: ".login-box--container",
            type: "inline",
            opts: {
                afterLoad: function() {
                    inputInt($(".form-group input, .form-group textarea"));
                }
            },
            autoFocus: false,
            touch: {
                vertical: false,
                momentum: false
            },
        });
    });

    $(document).on("click", ".header-box .top-row--login", function() {
        $('.top-row--tooltip').fadeToggle();//
    });

    $(document).on("click", ".top-row--tooltip--close", function() {
        $('.top-row--tooltip').fadeOut();
        $.cookie('login_tooltip', true, { expires: 30, path: '/' });
    });

    setTimeout(function() {
        if(!$.cookie('login_tooltip')) {
            $.cookie('login_tooltip', true, {expires: 7, path: '/'});
            $('.top-row--tooltip').fadeIn();
        }
    },2000);


  /*===============================================
    Callback - Fancybox popup
  	===============================================*/
  if (!isMobile.any()) {
    $(".phone-col--callback").on("click", function() {
      $.fancybox.open({
        src: ".callback-box--container",
        type: "inline",
        opts: {
          afterLoad: function() {
            inputInt($(".form-group input, .form-group textarea"));
          }
        },
        autoFocus: false,
        touch: {
            vertical: false,
            momentum: false
        },
      });
    });
  }

  /*===============================================
    Настройка Sly Carousel
  	===============================================*/
  $(".sly-wrapper").each(function() {
    if (window.matchMedia("(max-width: 767px)").matches) {
      var productDataLength = 2;
    } else {
      if ($("body").hasClass("cl-start")) {
        var productDataLength = 4;
      } else {
        var productDataLength = 5;
      }
    }

    if ($(this).find(".productData").length < productDataLength) {
      $(this)
        .find(".controls,.scrollbar")
        .hide();
    }

    if (window.matchMedia("(min-width: 992px)").matches) {
      if ($(this).find(".category--type").length < 7) {
        $(this)
          .closest(".subcatList")
          .find(".controls,.scrollbar")
          .hide();
      }
    }
  });

  /*===============================================
    Checkval form label
  	===============================================*/
  function inputInt(inputs) {
    var showClass = "show";
    inputs.each(function() {
      $(this)
        .on("checkval", function() {
          var label = $(this)
            .parent()
            .find("label");

          if (this.value !== "") {
            label.addClass(showClass);
            $(this).addClass(showClass);
          } else {
            label.removeClass(showClass);
            $(this).removeClass(showClass);
          }
        })
        .on("keyup", function() {
          $(this).trigger("checkval");
        });
    });
  }

  /*===============================================
    Callback form validation
  	===============================================*/
  $(".callback-box--container")
    .find("form")
    .submit(function(e) {
      var countField = $(this).find(".required");
      countField.each(function() {
        if (countField.val() !== "") {
          return true;
        }
        if (countField.val() === "") {
          $(this)
            .parent()
            .find("label")
            .addClass("show")
            .text("Pflichtfeld.")
            .css("color", "#FF4139");
          setTimeout(function() {
            $("label.show")
              .text("Telefon")
              .css("color", "#2e2e2e");
          }, 3000);
          e.preventDefault();
        }
      });
    });

  /*===============================================
    Magnify script initialize - Zoom
  	===============================================*/
  if (!isMobile.any()) {
    var $zoom = $(".zoom").magnify();

    $(document).on("click", ".otherPictures a", function() {
      $zoom.destroy();
      $zoom = $(".zoom").magnify();
    });
  }

  /*===============================================
    Галерея при клике на картинку товара - Fancybox
  	===============================================*/
  // $(document).on("click", "#zoom1", function(e) {
  //   e.preventDefault();
  //   var fancyStart;
  //   if ($(".otherPictures").length) {
  //     var galleryObject = [];
  //
  //     $(".otherPictures--container li a").each(function(i) {
  //       var productsImg = $(this).data("zoom-url");
  //       galleryObject[i] = {
  //         src: productsImg,
  //         opts: {}
  //       };
  //       if ($(this).hasClass("selected")) {
  //         fancyStart = i;
  //       }
  //     });
  //
  //     $.fancybox.open(galleryObject, {
  //       loop: true
  //     });
  //
  //     $.fancybox.getInstance().jumpTo(fancyStart);
  //   } else {
  //     fancyStart = $("#zoom1").attr("href");
  //     $.fancybox.open({
  //       src: fancyStart,
  //       type: "image",
  //       autoFocus: false,
  //       touch: {
  //           vertical: false,
  //           momentum: false
  //       },
  //     });
  //   }
  // });

  /*===============================================
    Вызов Fancybox при отправки формы Callback
  	===============================================*/
  function get(name) {
    if (
      (name = new RegExp("[?&]" + encodeURIComponent(name) + "=([^&]*)").exec(
        location.search
      ))
    )
      return decodeURIComponent(name[1]);
  }
  if (get("emaildone")) showModal();
  if (get("orderdone")) showModalOrder();

  function showModal() {
    $.fancybox.open({
      src:
        '<div style="display: inline-block; background: #fff; max-width: 420px; width: 100%;"><div style="width: 100%; max-width: 420px; "><div style="text-align: center;">Danke! Wir werden uns in Kürze mit Ihnen in Verbindung setzen!</div></div><button data-fancybox-close="" class="fancybox-close-small"></button></div>',
      type: "inline",
      autoFocus: false,
      touch: {
          vertical: false,
          momentum: false
      },
    });
    setTimeout(function() {
      $.fancybox.close();
    }, 7000);
  }

  /*===============================================
    Скрываем список категорий на странице Thankyou
  	===============================================*/
  if ($("body").hasClass("cl-thankyou")) {
    $(".nav-row--nav-toggle").addClass("nav-row--nav-toggle-clickable");
    $(".nav-row--category-list").hide();
  }

  /*===============================================
    Меняем .png на .svg в Paypal
   	===============================================*/
  var paypalInput = $('input[name="paypalExpressCheckoutButton"]');
  if (paypalInput.length) {
    var paypalImg = paypalInput.attr("src").replace(".png", ".svg");
    paypalInput.attr("src", paypalImg);
    paypalInput.parent().css("opacity", "1");
  }

  /*===============================================
    При клике на вариант товара отправка формы
  	===============================================*/
  $(document).on("click", ".selectVariantPopup a", function(e) {
    e.preventDefault();
    var targetId = $(this)
      .closest(".selectVariantPopup--container")
      .attr("data-target-id");
    var varId = $(this).attr("data-selection-id");
    $("body")
      .find('#detailsMain a[data-selection-id="' + varId + '"]')
      .trigger("click");
    if (targetId === "toBasket") {
      $("body").addClass("add-variation-to-cart");
    }
    if (targetId === "paypalVarintOverlay") {
      $("body").addClass("add-variation-to-paypal");
    }

    $.fancybox.close();
  });

  /*===============================================
    Варианты товаров Fancybox если есть варанты
  	===============================================*/
  if ($("#variants").length) {
    // $('#detailsMain #paypalExpressCheckoutDetailsButton').removeAttr('disabled');

    $(document).on("click", "#toBasket, #paypalVarintOverlay", function() {
        $("#variants input").each(function() {
            console.log('var rest');
            if ($(this).val() == "") {
                var currentId = $(this).attr("id");
                var selectVariant =
                    $(this).closest('.selectbox').find(".variant-label").html() +
                    "<ul>" +
                    $(this).closest('.selectbox').find(".vardrop").html() +
                    "</ul>";
                $.fancybox.open({
                    src:
                        '<div class="selectVariantPopup--container" data-target-id="' +
                        currentId +
                        '"><div class="selectVariantPopup--container-inner"><div class="selectVariantPopup">' +
                        selectVariant +
                        '</div></div><button data-fancybox-close="" class="fancybox-close-small"></button></div>',
                    type: "inline",
                    autoFocus: false,
                    touch: {
                        vertical: false,
                        momentum: false
                    },
                });

                return false;
            }
        });


    });
  }

  /*===============================================
    В Select, "Германия" на 1-е место ставим
  	===============================================*/
  if ($("#invCountrySelect").length) {
    $("#invCountrySelect")
      .parent()
      .find('.dropdown-menu li[data-original-index="1"]')
      .before($('.dropdown-menu li[data-original-index="46"]'));
    if ($(".dropdown-menu li.selected")) {
      $('.dropdown-menu li[data-original-index="46"]:first')
        .next()
        .remove();
    }
  }

  /*===============================================
    Google Analitics Click
  	===============================================*/

  function cartAjaxClick() {
    $(document).on("click", ".cart-ajax", function() {
      ga("send", "event", "In den Warenkorb", "Add to cart");
    });

    $(document).on(
      "click",
      "#userNextStepTop, #userNextStepBottom, #paymentStep",
      function() {
        ga("send", "event", "Button", "Zum Zahlungsart");
      }
    );

    $(document).on("click", "#paymentNextStepBottom, #orderStep", function() {
      ga("send", "event", "Button", "Überprüfen");
    });

    $(document).on("click", "#orderConfirmAgbBottom .submitButton", function() {
      ga("send", "event", "Button", "Bestellung abgeschlossen");
        fbq('track', 'Purchase', {
            content_ids: fbq_items,
            content_type: 'product',
            value: fbq_price,
            currency: 'EUR'
        });
        console.log('fbq_items');
        console.log(fbq_items);
        console.log('fbq_price');
        console.log(fbq_price);
        //
    });

    $('input[name="paymentid"]').each(function() {
      $(this).on("click", function() {
        var paymentName = $(this).attr("id");

        if (paymentName === "payment_oxidpaypal") {
          ga("send", "event", "Payment Methods", "PayPal");
        } else if (paymentName === "payment_trosofortgateway_su") {
          ga("send", "event", "Payment Methods", "SOFORTÜberweisung");
        } else if (paymentName === "payment_oxidcashondel") {
          ga("send", "event", "Payment Methods", "Nachnahme");
        } else if (paymentName === "payment_klarna_part") {
          ga("send", "event", "Payment Methods", "Ratenkauf");
        } else if (paymentName === "payment_klarna_invoice") {
          ga("send", "event", "Payment Methods", "Rechnung");
        } else {
          ga("send", "event", "Payment Methods", "Vorauskasse");
        }
      });
    });
  }

  cartAjaxClick();

  /*===============================================
    Submit reviews to Email
  	===============================================*/
  $(document).on("click", "#reviewSave", function(e) {
    e.preventDefault();
    if ($('textarea[name="rvw_txt"]').val() !== "") {
      var title = "&titleProduct=" + $("#productTitle").text();
      var article =
        "&articleProduct=" + $(".details--top-info .small.text-muted").text();
      var email = "&emailUser=" + $('input[name="emailUser"]').val();
      var URL =
        "https://www.kaufbei.tv/comments.php?" +
        $("#rating").serialize() +
        title +
        article +
        email;
      $.ajax({
        url: URL,
        type: "get",
        dataType: "html",
        success: function(data) {
          $("#rating").submit();
        }
      });
    } else {
      $('textarea[name="rvw_txt"]').focus();
    }
  });

  /*===============================================
    Search Ajax
  	===============================================*/
  if (window.location.href === "https://www.kaufbei.tv/AGB/") {
    //		$('#searchParam').keyup(function() {
    //			var search = this.value;
    //			var URL = $(this).closest('form').attr('action') + $(this).closest('form').serialize();
    //			console.log(URL);
    //			if(search.length > 2) {
    //				$.ajax({
    //					url: URL,
    //					type: 'post',
    //					dataType: 'html',
    //					success: function(data){
    //						var $response = $(data);
    ////						$(".search_result").html(data).fadeIn();
    //						console.log($response.find('.service-menu-box').html());
    //						$('.ui-autocomplete').fadeIn();
    //						$('form.search').find('.form-control').css('border-radius', '20px 20px 0 0');
    //
    //
    //				   }
    //			   })
    //			} else{
    //				$('.ui-autocomplete').fadeOut();
    //				$('form.search').find('.form-control').css('border-radius', '20px');
    //
    //			}
    //		});
  }

  //	$('.ui-autocomplete').wrap('<div class="search--result"></div>');

  $("form.search").after($(".ui-autocomplete"));
  $(".ui-autocomplete").width($("form.search .form-control").width() + 24);
  $(".ui-autocomplete").css(
    "max-width",
    $("form.search .form-control").width() + 24
  );

  if ($(".ui-autocomplete").is(":visible")) {
    $("form.search")
      .find(".form-control")
      .css("border-radius", "20px 20px 0 0");
  } else {
    $("form.search")
      .find(".form-control")
      .css("border-radius", "20px");
  }

  $(document).on("click", ".search--result-f-all", function() {
    $(".form.search").submit();
  });

  if (window.location.href === "https://www.kaufbei.tv/index.php?news=1") {
    $("#newsBox").show();
  }

  $.getQuery = function(query) {
    query = query.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var expr = "[\\?&]" + query + "=([^&#]*)";
    var regex = new RegExp(expr);
    var results = regex.exec(window.location.href);
    if (results !== null) {
      return results[1];
      return decodeURIComponent(results[1].replace(/\+/g, " "));
    } else {
      return false;
    }
  };

  if ($.getQuery("ny")) {
    $(".wrapp-site").css("background-image", "url(" + $.getQuery("ny") + ")");
  }


  showPopUpAdvejts();

  function showPopUpAdvejts(){
    var dateCurent = new Date();
    //Sun Dec 01 2019
    var date1 = new Date('Sun Dec 01 2019');
    console.log(dateCurent);

    if(dateCurent >= date1 && false){
      var contentPopUp = $('body').find('#pop-up-advejts');
      if(contentPopUp.length){
        var allCook = document.cookie;
        var separeteCook = allCook.split(';');
        var showPopUp = true;
        for (var i = 0; i < separeteCook.length; i++) {
          var item = separeteCook[i].split('=');
          if(item[0] == ' popUpAdvejts' && item[1] == 1){
            console.log('pupUp Showed');
            showPopUp = false;
          }
        }

        if(showPopUp){
          $.fancybox.open({
            src: '#pop-up-advejts',
            type: "inline",
            toolbar  : true,
            smallBtn : true,
            autoFocus: false,
            touch: {
                vertical: false,
                momentum: false
            },
            buttons : [
              'close',
            ]
          });

          var date = new Date();
          date.setDate(date.getDate() + 1);
          document.cookie = "popUpAdvejts=1;  expires="+date;
        }

      }
    }
  }
}); // End Document


$(document).ready(function() {
    // var gridContainer = document.createElement('div');
    //
    // var out = `
    //
    // <div id="grid-layout">
    //     <div class="container">
    //         <div class="row">
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //             <div class="col-xs-1"><div></div></div>
    //         </div>
    //     </div>
    // </div>
    // <button id="grid-layout--toggle" type="button">Grid</button>
    // <style>
    // #grid-layout--toggle {
    //     position: fixed;
    //     bottom: 0;
    //     right: 0;
    //     z-index: 9999999999;
    //      }
    //
    //   #grid-layout {
    //     position: fixed;
    //     width: 100%;
    //     top: 0;
    //     bottom: 0;
    //     left: 0;
    //     right: 0;
    //      z-index: 9999999998; }
    //     #grid-layout .container {
    //       height: 100vh; }
    //       #grid-layout .container .col-xs-1 {
    //         background: rgba(255, 0, 0, 0.2); }
    //         #grid-layout .container .col-xs-1 > div {
    //           background: rgba(0, 255, 0, 0.2);
    //           height: 100vh; }
    //
    // </style>`;
    // gridContainer.innerHTML = out;
    // console.log(out);
    // url = new URL(window.location.href);
    //
    // if (url.searchParams.get('show_grid')) {
    //     document.querySelector('footer').after(gridContainer);
    // }



    // $(function() {
  //   $("#myCounter").mbComingsoon({
  //     expiryDate: new Date(2018, 6, 0, 0, 0),
  //     speed: 100
  //   });
  // });
  //$("#promo-carousel").after($("#article-timer-container").clone());

  // if($('#noStockCrossPopUp').length) {
  //       $.fancybox.open({
  //           src: "#noStockCrossPopUp",
  //           type: "inline",
  //           autoFocus: false,
  //           touch: {
  //               vertical: false,
  //               momentum: false
  //           },
  //         });
  // }
//

  $(document).on("click", ".btn-close-sub-nav", function() {
    $(this).closest('.sub-cats').slideUp();
    $('.nav_overlay').fadeOut(200);
  });

    $(document).on("click", ".open-review-tab", function(e) {

        $('#itemTabs a[href="#reviews"]').click();

        $( 'html, body' ).animate(
            {
                scrollTop: $('#itemTabs').offset().top - 150//
            },
            300,

        );
    });



  if ($("#article-timer-container").length) {
    var parseDate = $("#article-timer-container").data("date").split(/[- :]/);
    var endMbComingsoon = new Date(parseDate[0], parseDate[1]-1, parseDate[2], parseDate[3], parseDate[4], parseDate[5]);
    var nowDate = new Date();
    // console.log(endMbComingsoon);
    // console.log(nowDate);
    if (nowDate < endMbComingsoon) {
      $("#article-timer, #article-timer-mob").mbComingsoon({
        expiryDate: endMbComingsoon,
        speed: 100,
        localization: {
          days: "Tage", //Localize labels of counter
          hours: "Stunden",
          minutes: "Minuten",
          seconds: "Sekunden"
        }
      });
    } else {
      $("#article-timer-container").remove();
    }
  }


    $('#userPevName').on('cut copy paste', function(e) {
        e.preventDefault();
    });

    $('#userPevName').on('keyup', function(e) {
        $(this).jqBootstrapValidation('destroy');
        $(this).jqBootstrapValidation('init');
        $(this).trigger('click');
    });

    $(document).on("click", ".box-faq .item-slide .title-slide", function () {
        $(this).parent().toggleClass("active");
        $(this).next().slideToggle();
    });


    $(document).on("click", "#show-all-product-parts", function () {
        $('.product-set-items .productData.toggledProduct').toggle();
        $(this).toggleClass('showed');
    });


    $(document).on("click", ".share-popup-button", function(e) {
        e.preventDefault();
        $.fancybox.open({
            src: '#share-popup',
            type: "inline",
            autoFocus: false,
            touch: {
                vertical: false,
                momentum: false
            },
        });//
    });

    $(document).on("click", ".share-popup--copy-url", function(e) {
        var currentThis = $(this);

        currentThis.addClass('share-popup--copied');

        var temp = $('<input>');
        var textlink = $(this).find('input').val();

        temp.val(textlink);
        $(this).after(temp);
        temp.select();
        document.execCommand("copy");
        temp.remove();

        currentThis.find('input').blur();

        setTimeout(function() {
            currentThis.removeClass('share-popup--copied');
        },2000);

    });



    if($('#variants').length) {
        $('.custom-variants').show();

        $('#variants .selectbox').each(function() {
            var thisSelectbox = $(this);
            $('.custom-variants').append('<div class="custom-variants--label">'+thisSelectbox.find('.variant-label').html()+'</div><div class="custom-variants--list"><ul>'+thisSelectbox.find('ul').html()+'</ul></div>');
        });



        $('.custom-variants').find('.custom-variants--list a').each(function() {
            if(!$(this).attr('data-selection-id')) {
                $(this).parent().remove();
            }
        });


        $(document).on("click", ".custom-variants--list a", function(e) {
            e.preventDefault();
            if(!$(this).parent().hasClass('disabled')) {
                var curId = $(this).attr('data-selection-id');
                if ($(this).hasClass('active')) {
                    $('#variants ul li a').each(function () {
                        if ($(this).attr('data-selection-id') == curId) {
                            $(this).closest('.dropdown-menu').find('a').each(function () {
                                if (!$(this).attr('data-selection-id')) {
                                    $(this)[0].click();
                                    $('.custom-variants').append('<div class="custom-variants--overlay"></div>');
                                }
                            });
                        }
                    });

                } else {
                    $('#variants ul li a').each(function () {
                        if ($(this).attr('data-selection-id') == curId) {
                            $(this)[0].click();
                            $('.custom-variants').append('<div class="custom-variants--overlay"></div>');
                        }
                    });
                }
            }
        });

    }




    if ($('.fsk-18').length) showFskPopup();

    function showFskPopup() {
        $.fancybox.open({
            src: '<div class="fsk-18--popup">' + $('.fsk-18--wrapper').html() + '</div>',
            type: "html",
            autoFocus: false,
            smallBtn: false,
            buttons: [

            ],
            touch: {
                vertical: false,
                momentum: false
            },
        });
    }









});

function getMeta(url, id){
    var img = new Image();
    img.addEventListener("load", function(){
        if(this.naturalWidth < 600) {
            var thumbUrl = 'https://i.ytimg.com/vi/' + id + '/hqdefault.jpg';

            document.getElementById(id).style.backgroundImage = 'url(' + thumbUrl + ')';

        }
    });
    img.src = url;
}

'use strict';
function r(f){/in/.test(document.readyState)?setTimeout('r('+f+')',9):f()}
r(function(){



    if (!document.getElementsByClassName) {
        // Поддержка IE8
        var getElementsByClassName = function(node, classname) {
            var a = [];
            var re = new RegExp('(^| )'+classname+'( |$)');
            var els = node.getElementsByTagName("*");
            for(var i=0,j=els.length; i < j; i++)
                if(re.test(els[i].className))a.push(els[i]);
            return a;
        }
        var videos = getElementsByClassName(document.body,"youtube-iframe");
    } else {
        var videos = document.getElementsByClassName("youtube-iframe");
    }

    var nb_videos = videos.length;
    for (var i=0; i < nb_videos; i++) {
        // Находим постер для видео, зная ID нашего видео
        var thumbUrl = 'https://i.ytimg.com/vi/' + videos[i].id.replaceAll(' ', '') + '/hqdefault.jpg';
        getMeta(thumbUrl, videos[i].id);
        videos[i].style.backgroundImage = 'url(' + thumbUrl + ')';

        // Размещаем над постером кнопку Play, чтобы создать эффект плеера
        var play = document.createElement("div");
        play.setAttribute("class","play");
        videos[i].appendChild(play);

        videos[i].onclick = function() {
            // Создаем iFrame и сразу начинаем проигрывать видео, т.е. атрибут autoplay у видео в значении 1
            var iframe = document.createElement("iframe");
            var iframe_url = "https://www.youtube.com/embed/" + this.id + "?autoplay=1&autohide=1";
            if (this.getAttribute("data-params")) iframe_url+='&'+this.getAttribute("data-params");
            iframe.setAttribute("src",iframe_url);
            iframe.setAttribute("frameborder",'0');

            // Высота и ширина iFrame будет как у элемента-родителя
            iframe.style.width  = this.style.width;
            iframe.style.height = this.style.height;

            // Заменяем начальное изображение (постер) на iFrame
            this.parentNode.replaceChild(iframe, this);


        }
    }
});