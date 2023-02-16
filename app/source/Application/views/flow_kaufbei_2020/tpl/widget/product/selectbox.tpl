[{assign var="oSelections" value=$oSelectionList->getSelections()}]

[{if $oSelections}]
    [{capture assign="sTmp"}]
        <script>
            [{capture assign="sSelectionsScript"}]
                (function($, root) {$(function() {
                    $('#details_container', root).on('changeVariantUri.exonn', function () {
                        $("#toBasket").closest("form").find("input[type=\"hidden\"][name=\"cl\"]").val("");
                        $.ajax({
                            url: "/index.php",
                            data: {
                                cl: "ExonnAsumAjaxController",
                                fnc: "getVariantUri",
                                oxid: "[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]",
                                selid: $("input[name=\"varselid[0]\"]").val(),
                            },
                        }).done(function (response) {
                            if (response.status === "ok") {
                                const url = new URL(root.location);
                                url.pathname = response.data.currentUri;
                                window.history.pushState({}, "", url);
                                $("[rel=\"canonical\"]", root).attr("href", url);
                                $(".share-popup--copy-url--input input[type=\"text\"]", root).eq(0).val(url);
                                $(".languages-menu a.flag", root).each(function() {
                                    const $link = $(this);
                                    url.pathname = response.data.uniqueUris[$link.attr('hreflang')]
                                    $link.attr('href', url)
                                });
                            }
                        });
                    });
                })})(jQuery, document)
            [{/capture}]
        </script>
    [{/capture}]
    [{oxscript add=$sSelectionsScript}]
    <div class="selectbox dropDown">
        [{if !$blHideLabel}]
            <p class="variant-label"><strong>[{$oSelectionList->getLabel()}][{oxmultilang ident="COLON"}]</strong></p>
        [{/if}]
        <div class="dropdown-wrapper">
            <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
                [{assign var="oActiveSelection" value=$oSelectionList->getActiveSelection()}]
                [{if $oActiveSelection}]
                    <span class="pull-left">[{$oActiveSelection->getName()}]</span>
                [{elseif !$blHideDefault}]
                    <span class="pull-left">
                        [{if $sFieldName == "sel"}]
                            [{oxmultilang ident="PLEASE_CHOOSE"}]
                        [{else}]
                            [{$oSelectionList->getLabel()}] [{oxmultilang ident="CHOOSE_VARIANT"}]
                        [{/if}]
                    </span>
                [{/if}]

                <i class="fa fa-angle-down pull-right"></i>
            </button>
            [{if $editable !== false}]
                <input type="hidden" name="[{$sFieldName|default:"varselid"}][[{$iKey}]]" value="[{if $oActiveSelection}][{$oActiveSelection->getValue()}][{/if}]">
                <ul class="dropdown-menu [{$sJsAction}][{if $sFieldName != "sel"}] vardrop[{/if}]" role="menu">
                    [{if $oActiveSelection && !$blHideDefault}]
                        <li>
                            <a href="#" rel="">
                                [{if $sFieldName == "sel"}]
                                    [{oxmultilang ident="PLEASE_CHOOSE"}]
                                [{else}]
                                    [{oxmultilang ident="CHOOSE_VARIANT"}]
                                [{/if}]
                            </a>
                        </li>
                    [{/if}]
                    [{foreach from=$oSelections item=oSelection}]
                        <li class="[{if $oSelection->isDisabled()}]disabled js-disabled[{/if}]">
                            <a href="[{$oSelection->getLink()}]" data-selection-id="[{$oSelection->getValue()}]" class="[{if $oSelection->isActive()}]active[{/if}]">[{$oSelection->getName()}]</a>
                        </li>
                    [{/foreach}]
                </ul>
            [{/if}]
        </div>
    </div>
[{/if}]