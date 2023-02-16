aA_temp = document.getElementsByClassName('pagination');
if (aA_temp[0]) {
    aA = aA_temp[0].getElementsByTagName('a');
    for(i=0; i<aA.length; i++) {
        if (aA[i].href.indexOf('&art_category=')) {
            aA[i].href = aA[i].href.replace('&art_category=','&searchpopup=[{$searchpopup}][{$myfilterparam }]&art_category=');
        }
        if (aA[i].href.indexOf('&amp;art_category=')) {
            aA[i].href = aA[i].href.replace('&amp;art_category=','&searchpopup=[{$searchpopup}][{$myfilterparam }]&art_category=');
        }
    }
}