document.addEventListener("DOMContentLoaded", function(event) {
    document.querySelector('#add-row').addEventListener('click', e => {
        const table = e.target.closest('.reklamation-form--list').querySelector('table');
        const newRow = document.createElement('tr');
        newRow.innerHTML = table.querySelector('.reference-row').innerHTML;
        newRow.querySelector('button').removeAttribute('style');
        newRow.querySelector('button').disabled = false;
        table.querySelector('tbody').appendChild(newRow);
        changeRowNames();
    });

    document.querySelector('.reklamation-form--list table').addEventListener('click', e => {
        if(e.target.classList.contains('remove-row')) {
            e.target.closest('tr').remove();
            changeRowNames();
        }
    });
    

    function changeRowNames() {
        const table = document.querySelector('.reklamation-form--list table');
        [...table.querySelectorAll('tr')].forEach((tr, index) => {
            console.log(tr);
            if(index != 0) {
                const articleNumber = tr.querySelector('.list-artcle-number');
                const listMenge = tr.querySelector('.list-menge');
                const listDescription = tr.querySelector('.list-description');
                console.log(articleNumber);
                console.log(listMenge);
                console.log(listDescription);
                articleNumber.setAttribute('name', 'list-artcle-number-'+index);
                articleNumber.setAttribute('id', 'list-artcle-number-'+index);
                listMenge.setAttribute('name', 'list-menge-'+index);
                listMenge.setAttribute('id', 'list-menge-'+index);
                listDescription.setAttribute('name', 'list-description-'+index);
                listDescription.setAttribute('id', 'list-description-'+index);

                
            }
        });
    }
});