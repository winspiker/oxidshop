<?php
/**
 *    This file is part of OXID eShop Community Edition.
 *
 *    OXID eShop Community Edition is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    OXID eShop Community Edition is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with OXID eShop Community Edition.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @package   admin
 * @copyright (C) OXID eSales AG 2003-2013
 * @version OXID eShop CE
 */

/**
 * Admin article list manager.
 * Collects base article information (according to filtering rules), performs sorting,
 * deletion of articles, etc.
 * Admin Menu: Manage Products -> Articles.
 * @package admin
 */
class exonn_order_articlelist extends exonn_order_articlelist_parent
{


    public function buildWhere()
    {
        // we override this to select only parent articles
        $this->_aWhere = parent::buildWhere();
        $sTable = getViewName( "oxarticles" );

        // adding folder check
        if ( $this->_aWhere[$sTable.".oxartnum"] ) {
            $this->_aWhere[$sTable.".oxartnum"]=str_replace("%","",$this->_aWhere[$sTable.".oxartnum"]);
        }
        return $this->_aWhere;
    }


   // поиск по номеру варианта
    protected function _prepareWhereQuery( $aWhere, $sqlFull )
    {
        $sQ = parent::_prepareWhereQuery( $aWhere, $sqlFull );

        if ($aWhere["oxv_oxarticles_de.oxartnum"]) {
            $sQ = str_replace("oxv_oxarticles_de.oxartnum  = ".oxDb::getDb()->quote($aWhere["oxv_oxarticles_de.oxartnum"]),
                "( oxv_oxarticles_de.oxartnum  = ".oxDb::getDb()->quote($aWhere["oxv_oxarticles_de.oxartnum"])."  || oxv_oxarticles_de.oxid in (select oxparentid
                from oxv_oxarticles_de where oxartnum=".oxDb::getDb()->quote($aWhere["oxv_oxarticles_de.oxartnum"])."))", $sQ);
        }

        return $sQ;
    }




}
