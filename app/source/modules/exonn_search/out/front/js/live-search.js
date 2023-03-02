$(document).ready(function(){
    $('#searchParam').keyup(function() {
        var input = $(this).val()
        if (input.length > 2) {
            search(input)
        }
    });
})

function search (input) {
    $.ajax({
        methode: 'POST',
        url: 'index.php',
        data: {
            cl: 'exonn_search_livecontroller',
            fn: 'test',
            type: 'JSON',
            searchparam: input,
            maxRows: 10
        },
        success: function (data) {
            console.log(data)
        }
    })
}