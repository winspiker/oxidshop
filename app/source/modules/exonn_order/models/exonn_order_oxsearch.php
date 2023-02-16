<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_order_oxsearch extends exonn_order_oxsearch_parent
{


    protected function _getWhere( $sSearchString )
    {
        $oDb = oxDb::getDb();
        $myConfig = $this->getConfig();
        $blSep    = false;
        $sArticleTable = getViewName( 'oxarticles', $this->_iLanguage );

        $aSearchCols = $myConfig->getConfigParam( 'aSearchCols' );
        if ( !(is_array( $aSearchCols ) && count( $aSearchCols ) ) ) {
            return '';
        }

        $oTempArticle = oxNew( 'oxarticle' );
        $sSearchSep   = $myConfig->getConfigParam( 'blSearchUseAND' )?'and ':'or ';
        $aSearch  = explode( ' ', $sSearchString );
        $sSearch  = ' and ( ';
        $myUtilsString = oxRegistry::get("oxUtilsString");
        $oLang = oxRegistry::getLang();

        foreach ( $aSearch as $sSearchString ) {

            if ( !strlen( $sSearchString ) ) {
                continue;
            }

            if ( $blSep ) {
                $sSearch .= $sSearchSep;
            }

            $blSep2 = false;
            $sSearch  .= '( ';

            foreach ( $aSearchCols as $sField ) {

                if ( $blSep2 ) {
                    $sSearch  .= ' or ';
                }

                // as long description now is on different table table must differ
                if ( $sField == 'oxlongdesc' || $sField == 'oxtags' ) {
                    $sSearchField = getViewName( 'oxartextends', $this->_iLanguage ).".{$sField}";
                } else {
                    $sSearchField = "{$sArticleTable}.{$sField}";
                }

                if ($sSearchField=='oxv_oxarticles_de.oxartnum')
                    $sSearch .= " {$sSearchField} like ".$oDb->quote( "$sSearchString" );
                else
                    $sSearch .= " {$sSearchField} like ".$oDb->quote( "%$sSearchString%" );

                // special chars ?
                if ( ( $sUml = $myUtilsString->prepareStrForSearch( $sSearchString ) ) ) {
                    $sSearch  .= " or {$sSearchField} like ".$oDb->quote( "%$sUml%" );
                }

                $blSep2 = true;
            }
            $sSearch  .= ' ) ';

            $blSep = true;
        }

        $sSearch .= ' ) ';

        return $sSearch;
    }
}