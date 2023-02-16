[{$smarty.block.parent}]


[{if $oxcmp_user->oxuser__oxrights->value == 'malladmin' && method_exists($oView, 'getActContentIDForCB')}]


[{oxscript include=$oViewConf->getModuleUrl('exonn_cb', 'cb/scripts/jquery-ui.min.js') priority=1}]
[{oxscript include=$oViewConf->getModuleUrl('exonn_cb', 'cb/scripts/contentbuilder.js') priority=1}]
[{oxscript include=$oViewConf->getModuleUrl('exonn_cb', 'cb/scripts/saveimages.js') priority=1}]



[{capture name="contentbuilderarea"}]

    jQuery(document).ready(function ($) {

    $('.contentarea').contentbuilder({
    snippetFile: '[{$oViewConf->getBaseDir()|cat:"index.php?cl=exonn_cb_main"}]',
    toolbar: 'left',
    snippetCategories: [
        [0,"[{oxmultilang ident='CAT_DEFAULT'}]"],
        [-1,"[{oxmultilang ident='CAT_ALL'}]"],
        [1,"[{oxmultilang ident='CAT_TITLE'}]"],
        [2,"[{oxmultilang ident='CAT_TITLE_SUBTITLE'}]"],
        [3,"[{oxmultilang ident='CAT_INFO_TITLE'}]"],
        [4,"[{oxmultilang ident='CAT_INFO_TITLE_SUBTITLE'}]"],
        [5,"[{oxmultilang ident='CAT_HEADING_PARAGRAPH'}]"],
        [6,"[{oxmultilang ident='CAT_PARAGRAPH'}]"],
        [7,"[{oxmultilang ident='CAT_PARAGRAPH_IMAGES_CAPTION'}]"],
        [8,"[{oxmultilang ident='CAT_HEADING_PARAGRAPH_IMAGES_CAPTION'}]"],
        [9,"[{oxmultilang ident='CAT_IMAGES_CAPTION'}]"],
        [10,"[{oxmultilang ident='CAT_IMAGES_LONG_CAPTION'}]"],
        [11,"[{oxmultilang ident='CAT_IMAGES'}]"],
        [12,"[{oxmultilang ident='CAT_SINGLE_IMAGES'}]"],
        [13,"[{oxmultilang ident='CAT_CALL_TO_ACTION'}]"],
        [14,"[{oxmultilang ident='CAT_LIST'}]"],
        [15,"[{oxmultilang ident='CAT_QUOTES'}]"],
        [16,"[{oxmultilang ident='CAT_PROFILE'}]"],
        [17,"[{oxmultilang ident='CAT_MAP'}]"],
        [20,"[{oxmultilang ident='CAT_VIDEO'}]"],
        [18,"[{oxmultilang ident='CAT_SOCIAL_LINKS'}]"],
        [19,"[{oxmultilang ident='CAT_SEPERATOR'}]"]
        ]
    });

    $('.row-copy').each( function(index, value) {
    $(this).after('<div class=\'row-hide\'><i class=\'cb-icon-off\'></i></div>');
    });

    $('.row-hide').on( 'click',(function() {
    var row = $(this).parent().prev();
    if (row.hasClass('exonn-hide')) {
    row.removeClass('exonn-hide')
    } else {
    row.addClass('exonn-hide');
    }
    }));
    });


    function save(cbplace) {

    //Save Images
    var conarea = '#contentarea_' + cbplace;
    jQuery(conarea).saveimages({
    handler: '[{$oViewConf->getBaseDir()}]index.php?cl=exonn_cb_main&fnc=saveimage',
    onComplete: function () {

    //Get Content
    var sHTML = jQuery(conarea).data('contentbuilder').html();
    //Save Content
    jQuery.ajax({
    url: '[{$oViewConf->getBaseDir()}]index.php?cl=exonn_cb_main&fnc=save',
    type: 'post',
    data: {
    cb_place: cbplace,
    cb_content: sHTML,
    cmsid:'[{$oView->getActContentIDForCB()}]'
    },
    success: function (result) {
    console.log(result);
    alert('Success');
    },
    error: function () {
    alert('Failure');
    }
    });

    }
    });

    jQuery(conarea).data('saveimages').save();
    }

    [{/capture}]


[{oxscript add=$smarty.capture.contentbuilderarea}]

    [{if $actCategory}]
        [{oxscript add="function saveCat() {

                //Save Images
                var conarea = '#contentarea_cat';
                jQuery(conarea).saveimages({
                    handler: '"|cat:$oViewConf->getBaseDir()|cat:"index.php?cl=exonn_cb_main&fnc=saveimage',
                    onComplete: function () {

                        //Get Content
                        var sHTML = jQuery(conarea).data('contentbuilder').html();

                        //Save Content
                        jQuery.ajax({
                            url: '"|cat:$oViewConf->getBaseDir()|cat:"index.php?cl=exonn_cb_main&fnc=saveCat',
                            type: 'post',
                            data: {
                                cb_content: sHTML,
                                cmsid:'"|cat:$actCategory->getId()|cat:"'
                            },
                            success: function (result) {
                                alert('Success');
                            },
                            error: function () {
                                alert('Failure');
                            }
                        });
                    }
                });

                jQuery(conarea).data('saveimages').save();
           }
        "}]
    [{/if}]

[{/if}]