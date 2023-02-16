<ul>
    [{foreach from=$oView->getAttributes() item=oAttr name=attribute}]
        <li>
            <span>[{$oAttr->title}]</span>
            <p>[{$oAttr->value}]</p>
        </li>
    [{/foreach}]
</ul>

