

function searchData(frame_id, input_id, click_funktion, getAjaxQuery_function, what)
{

    eval('ajaxQuery = '+getAjaxQuery_function+'();');

    if (!ajaxQuery)
        return;

    var inp =  document.getElementById(input_id);
    var frame = document.getElementById(frame_id);

    frame.innerHTML=' '+
        '<span class="ajaxLoad"><img src="/modules/exonn_useraddress/ajax_wait.gif" width="13" alt="Inhalt wird geladen..." /></span>';
    frame.style.display='';

    $.ajax({
        type: 'get',
        url: '/index.php',
        data: 'cl=exonn_useraddress_ajax&'+ajaxQuery,
        dataType: 'xml',
        async: true,
        success: function(xml) {

            switch (click_funktion)
            {

                case 'city_select_del':
                case 'city_select_bill':

                    count_city=0;
                    city_name="";
                    $(xml).find(what).each(function(){

                        var art_list = $(this);
                        count_city=count_city+1;
                        city_name=art_list.attr("key1");

                    });

                    if ( count_city<=1) {
                        if (click_funktion=='city_select_bill')
                            document.getElementById('city_bill').value=city_name;
                        else
                            document.getElementById('city_del').value=city_name;

                        searchblockHide(frame_id);
                    } else {

                        frame.innerHTML='' +
                            '<div>' +
                            '<div style="float: right; margin-right: 10px;"><a href="javascript:void(0)" title="Schlissen" onclick="searchblockHide(\''+frame_id+'\')"><img src="/modules/exonn_useraddress/cl.gif"></a></div> ' +
                            '<div style="text-align: center; padding-bottom: 10px; border-bottom: 1px solid #cccccc;">Alternative Orte mit der gleichen Postleitzahl:</div>' +
                            '<div style="clear: both;"></div> ' +
                            '</div>' +
                            '<div id="innerdata_'+frame_id+'" style="height: 250px; overflow: auto; padding-top: 8px"></div>';

                        frame_innerdata = document.getElementById('innerdata_'+frame_id);

                        var flag_found=0;

                        $(xml).find(what).each(function(){

                            var art_list = $(this);
                            flag_found++;

                            var art_div=document.createElement('DIV');
                            art_div.setAttribute('class', 'search_data_element');
                            if (flag_found==1)
                                art_div.setAttribute('style', 'width: 80%');

                            art_div.setAttribute('onclick', click_funktion+'(\''+art_list.attr("key1")+'\'); searchblockHide(\''+frame_id+'\') ');
                            art_div.innerHTML=art_list.attr("oxtitle");
                            frame_innerdata.appendChild(art_div);

                        });

                        frame.innerHTML=frame.innerHTML+'<div style="text-align: center; padding: 5px; border-top: 1px solid #cccccc; ">Leider können nicht alle Orte automatisch erkannt werden. Sollte Ihr Ort in der genannten Liste nicht enthalten sein, tippen Sie diesen bitte manuell in das entsprechende Feld.</div>';


                        if (!flag_found)
                            searchblockHide(frame_id);

                    }
                    break;

                default:
                    frame.innerHTML='' +
                        '<div>' +
                        '<div style="float: right; margin-right: 10px;"><a href="javascript:void(0)" title="Schlissen" onclick="searchblockHide(\''+frame_id+'\')"><img src="/modules/exonn_useraddress/cl.gif"></a></div> ' +
                        '<div style="text-align: center; ">Bitte die Strasse wählen!</div>' +
                        '<div style="clear: both;"></div> ' +
                        '</div>' +
                        '<div id="innerdata_'+frame_id+'" style="height: 250px; overflow: scroll; padding-top: 8px"></div>';

                    frame_innerdata = document.getElementById('innerdata_'+frame_id);

                    var flag_found=0;

                    $(xml).find(what).each(function(){

                        var art_list = $(this);
                        flag_found++;

                        var art_div=document.createElement('DIV');
                        art_div.setAttribute('class', 'search_data_element');
                        if (flag_found==1)
                            art_div.setAttribute('style', 'width: 80%');

                        art_div.setAttribute('onclick', click_funktion+'( \''+art_list.attr("key2")+'\'); searchblockHide(\''+frame_id+'\') ');
                        art_div.innerHTML=art_list.attr("oxtitle");
                        frame_innerdata.appendChild(art_div);

                    });

                    frame.innerHTML=frame.innerHTML+'<div style="text-align: center;">Leider können nicht alle Straßen automatisch erkannt werden. Sollte Ihre Straße in der genannten Liste nicht enthalten sein, tippen Sie diesen bitte manuell in das entsprechende Feld.</div>';

                    if (!flag_found)
                        searchblockHide(frame_id);

            }

        }

    });



}






function searchblockHide(frame_id)
{
    document.getElementById(frame_id).style.display='none';
}


function zip_select_bill(key1, key2)
{
    document.getElementById('street_bill').value=key1;
    document.getElementById('streetnr_bill').focus();

}

function city_select_del(key1, key2)
{
    document.getElementById('city_del').value=key1;
    document.getElementById('city_del').focus();

}

function city_select_bill(key1, key2)
{
    document.getElementById('city_bill').value=key1;
    document.getElementById('city_bill').focus();

}
function zip_select_del(key1, key2)
{
    document.getElementById('street_del').value=key1;
    document.getElementById('streetnr_del').focus();

}

function getAjaxQueryzip_bill()
{
    var inp =  document.getElementById('zip_bill');

    if (inp.value.length==5)
    {
        return 'fnc=zip_search&zip='+inp.value;
    }
    else
        return false;

}

function getAjaxQueryzipcity_bill()
{
    var inp =  document.getElementById('zip_bill');

    if (inp.value.length==5)
    {
        return 'fnc=zipcity_search&zip='+inp.value;
    }
    else
        return false;

}

function getAjaxQueryzipcity_del()
{
    var inp =  document.getElementById('zip_del');

    if (inp.value.length==5)
    {
        return 'fnc=zipcity_search&zip='+inp.value;
    }
    else
        return false;

}

function getAjaxQueryStreet_bill()
{
    var zip =  document.getElementById('zip_bill');
    var street =  document.getElementById('street_bill');

    if (zip.value.length==5 && street.value.length>=2)
    {
        return 'fnc=zip_search&zip='+zip.value+'&street='+street.value;

    }
    else
        return false;

}

function getAjaxQueryzip_del()
{
    var inp =  document.getElementById('zip_del');

    if (inp.value.length==5)
    {
        return 'fnc=zip_search&zip='+inp.value;
    }
    else
        return false;

}


function getAjaxQueryStreet_del()
{
    var zip =  document.getElementById('zip_del');
    var street =  document.getElementById('street_del');

    if (zip.value.length==5 && street.value.length>=2)
    {
        return 'fnc=zip_search&zip='+zip.value+'&street='+street.value;

    }
    else
        return false;

}



