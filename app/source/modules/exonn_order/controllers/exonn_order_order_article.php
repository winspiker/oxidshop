<?


class exonn_order_order_article extends exonn_order_order_article_parent
{

    public function updateOrder()
    {
        parent::updateOrder();


        $aPersparam = $this->getConfig()->getRequestParameter( 'aPersparam' );

        $oOrder = oxNew( 'oxorder' );
        if ( is_array( $aPersparam ) && $oOrder->load( $this->getEditObjectId() ) ) {

            $oOrderArticles = $oOrder->getOrderArticles( true );

            foreach ( $oOrderArticles as $oOrderArticle ) {
                $sItemId = $oOrderArticle->getId();
                if ( is_array( $aPersparam[$sItemId] ) ) {

                    $aParams = array();
                    foreach($aPersparam[$sItemId] as $key => $value)
                    {
                        $aParams[$key] = trim($value);
                    }
                    $oOrderArticle->setPersParams( $aParams );
                    $oOrderArticle->save();
                }
            }
        }


    }



    public function isSelected($sVar, $sStr)
    {
        $pos = strpos($sVar,'_');
        if ($pos)
            $s = substr($sVar,0,$pos);
        else
            $s=$sVar;

        if ($s==$sStr)
            return true;
        else
            return false;
    }

}