<?php


class exonnkaufbei_cron extends oxUBase
{


    /*public function createCategoryCache()
    {
        $oCategoryTree = oxNew(\OxidEsales\Eshop\Application\Model\CategoryList::class);
        $oCategoryTree->loadForCache = true;
        $oCategoryTree->buildTreeForCache();
    }*/


    public function ottosend()
    {

        $aOrders = oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->getAll("select a.oxid, a.oxtrackcode, a.OXRETOURENID, b.OXDELIVERYCARRIER 
                from 
                     oxorder a join
                     dgottoordermarge b on (a.oxid=b.oxorderid)    
                where 
                      b.oxtrackingcodesent='0000-00-00 00:00:00' &&
                      a.oxtrackcode<>'' &&
                      a.OXRETOURENID<>'' &&
                      b.OXDELIVERYCARRIER<>''
                      ");
        foreach ($aOrders as $aO) {
            $_POST["oxid"] = $aO["oxid"];
            $_POST["editval"] = $aO["oxorder_oxid"];
            $_POST["TrackingCode"] = $aO["oxtrackcode"];
            $_POST["ReturnCode"] = $aO["OXRETOURENID"];
            $_POST["Carrier"] = $aO["OXDELIVERYCARRIER"];
            $oController = new \dgModule\dgOttoModul\Application\Controller\Admin\dgOtto_Order;
            $oController->sendFulfillmentStatus();
        }
    }


    public function stockSend()
    {

        $aArticle = oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->getCol("select a.oxid 
                from 
                     oxarticles a    
                where 
                      a.oxid in (select oxobjectid from dgotto2attribute) &&
                      a.connectortimestamp>now()-interval 10 hour
                      ");
        foreach ($aArticle as $sArt) {
            $_POST["aStep"] = 'hook';
            $_POST["workid"] = $sArt;
            $_POST["workid"] = $sArt;
            $_POST["oxid"] = $sArt;
            $oController = new \dgModule\dgOttoModul\Application\Controller\Admin\dgOtto_Article;
            $oController->sendStock();
        }
    }

    public function priceSend()
    {

        $aArticle = oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->getCol("select a.oxid 
                from 
                     oxarticles a    
                where 
                      a.oxid in (select oxobjectid from dgotto2attribute) &&
                      a.connectortimestamp>now()-interval 10 hour
                      ");
        foreach ($aArticle as $sArt) {
            $_POST["aStep"] = 'hook';
            $_POST["workid"] = $sArt;
            $_POST["workid"] = $sArt;
            $_POST["oxid"] = $sArt;
            $oController = new \dgModule\dgOttoModul\Application\Controller\Admin\dgOtto_Article;
            $oController->sendPrice();
        }
    }


}
