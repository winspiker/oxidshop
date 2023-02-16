<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_manufacturerlist extends exonn_kaufbei_manufacturerlist_parent
{

    public function render()
    {

        $res = parent::render();

        if (!$this->getActiveCategory()) {
            \OxidEsales\Eshop\Core\Registry::getUtils()->redirect($this->getConfig()->getShopURL() . 'index.php', true, 302);
        }

        return $res;
    }
}