[{if $edit->dgottoerrorurls__oxproduct->value}]
  [{assign var="oErrorList" value=$oView->getErrorList($edit->dgottoerrorurls__oxproduct->value)}]
  [{if $oErrorList}]
    <div class="errorbox">
      <p>
        [{foreach from=$oErrorList item=oError name=errorlist}]
          [{$oError.title}]<br />
          [{if !$smarty.foreach.errorlist.last}]
            <hr />
          [{/if}]
        [{/foreach}]
      </p>
    </div>
  [{/if}]
[{/if}]
[{if !$oCategory}]
<div class="errorbox">
      <p>
        Artikel ist keiner OXID Kategorie zugeordnet!
      </p>
    </div>
[{/if}]

[{if $pingAfter}]
<div class="errorbox">
      <p>
       [{$pingAfter}]
      </p>
    </div>
[{/if}]
