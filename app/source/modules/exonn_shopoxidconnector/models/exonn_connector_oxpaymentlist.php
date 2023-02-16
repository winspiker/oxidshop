<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_connector_oxpaymentlist extends exonn_connector_oxpaymentlist_parent
{



    protected function _getFilterSelect($sShipSetId, $dPrice, $oUser)
    {
        $oDb = oxDb::getDb();
        $sBoni = ($oUser && $oUser->oxuser__oxboni->value) ? $oUser->oxuser__oxboni->value : 0;

        $sTable = getViewName('oxpayments');
        $sQ = "select {$sTable}.* from ( select distinct {$sTable}.* from {$sTable} ";
        $sQ .= "left join oxobject2group ON oxobject2group.oxobjectid = {$sTable}.oxid ";
        $sQ .= "inner join oxobject2payment ON oxobject2payment.oxobjectid = " . $oDb->quote($sShipSetId) . " and oxobject2payment.oxpaymentid = {$sTable}.oxid ";
        $sQ .= "where {$sTable}.oxactive='1' ";


        //EXONN START

        // defining initial filter parameters
        $sGroupIds = '';
        $sCountryId = $this->getCountryId($oUser);

        // checking for current session user which gives additional restrictions for user itself, users group and country
        if ($oUser) {
            // user groups ( maybe would be better to fetch by function \OxidEsales\Eshop\Application\Model\User::getUserGroups() ? )
            foreach ($oUser->getUserGroups() as $oGroup) {
                if ($sGroupIds) {
                    $sGroupIds .= ', ';
                }
                $sGroupIds .= "'" . $oGroup->getId() . "'";
            }
        }

        $sQ .= " and {$sTable}.oxfromboni <= ".$oDb->quote( $sBoni );



        $sQ .= " and (
            {$sTable}.oxfromamount <= ".$oDb->quote( $dPrice ) ." and {$sTable}.oxtoamount >= ".$oDb->quote( $dPrice );

        if ($sGroupIds) {

            $sGroupSql_amount = "( select 1 from oxpaymentamount2group as s4 where s4.oxtype='amount' and s4.OXOBJECTID={$sTable}.OXID and s4.OXGROUPSID in ( {$sGroupIds} ) limit 1 )";

            $sQ .= " and not exists ".$sGroupSql_amount." or ";
            $sQ .= " {$sTable}.oxfromamountusergroup <= ".$oDb->quote( $dPrice ) ." and {$sTable}.oxtoamountusergroup >= ".$oDb->quote( $dPrice );
            $sQ .= " and exists ".$sGroupSql_amount;
        }

        $sQ .= " ) ";
        //EXONN END



        $sGroupTable = getViewName('oxgroups');
        $sCountryTable = getViewName('oxcountry');

        $sCountrySql = $sCountryId ? "exists( select 1 from oxobject2payment as s1 where s1.oxpaymentid={$sTable}.OXID and s1.oxtype='oxcountry' and s1.OXOBJECTID=" . $oDb->quote($sCountryId) . " limit 1 )" : '0';
        $sGroupSql = $sGroupIds ? "exists( select 1 from oxobject2group as s3 where s3.OXOBJECTID={$sTable}.OXID and s3.OXGROUPSID in ( {$sGroupIds} ) limit 1 )" : '0';

        $sQ .= "  order by {$sTable}.oxsort asc ) as $sTable where (
            select
                if( exists( select 1 from oxobject2payment as ss1, $sCountryTable where $sCountryTable.oxid=ss1.oxobjectid and ss1.oxpaymentid={$sTable}.OXID and ss1.oxtype='oxcountry' limit 1 ),
                    {$sCountrySql},
                    1) &&
                if( exists( select 1 from oxobject2group as ss3, $sGroupTable where $sGroupTable.oxid=ss3.oxgroupsid and ss3.OXOBJECTID={$sTable}.OXID limit 1 ),
                    {$sGroupSql},
                    1)
                )  order by {$sTable}.oxsort asc ";

        return $sQ;
    }

   


}
