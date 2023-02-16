<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_order_order_list extends exonn_order_order_list_parent
{
// Первая показывается "все заказы"



    protected function _prepareWhereQuery( $aWhere, $sqlFull )
    {

        $sQ = parent::_prepareWhereQuery( $aWhere, $sqlFull );

        $oConfig = $this->getConfig();
        $aMyfilter = $oConfig->getRequestParameter( "myfilter" );

        if (class_exists('exonn_callcenter_orderinput')) {
            $sQ.=exonn_callcenter_orderinput::getHerkunftWhere($aMyfilter["herkunft"]);
        }


        $sFolder = $oConfig->getRequestParameter('folder');

        if ($sFolder<>-1 || !$sFolder) {
            $sQ.=" AND oxorder.oxstorno='0' ";
        }



        return $sQ;
    }


    protected function _buildSelectString( $oListObject = null )
    {
        $sSql = parent::_buildSelectString( $oListObject );
        $oDb = oxDb::getDb();

        $oConfig = $this->getConfig();
        $sSearch      = $oConfig->getRequestParameter( 'addsearch' );
        $sSearch      = trim( $sSearch );
        $sSearchField = $oConfig->getRequestParameter( 'addsearchfld' );

        if ( $sSearch && $sSearchField=='oxorderarticles') {
            $sSql = str_replace( "oxorderarticles.oxartnum like ".$oDb->quote( "%{$sSearch}%" ) ." or oxorderarticles.oxtitle like ".$oDb->quote( "%{$sSearch}%" ), "oxorderarticles.oxartnum like ".$oDb->quote( "{$sSearch}" ), $sSql);
        }

        return $sSql;
    }



}
