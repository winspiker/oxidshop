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
class exonn_activecampaign_cronjob extends oxUBase
{

    //todo: добавить авторизацию для крона!


//dev1.dev.wawi.exonn.de/index.php?cl=exonn_activecampaign_cronjob&fnc=getcustomers&wawi_id=f519b48a05fabedbbf90c0f5a8b4d161

    public function getcustomers()
    {

        echo "<pre>";


        $oApi = oxNew("exonnactivecampaign_api");
        $res = $oApi->getCustomers();



        print_r($res);

        exit();



   }

    public function createcustomer()
    {

        echo "<pre>";

        $oUser = oxNew("oxuser");
        $oUser->load("9b6b9760c77cc030bee8d402ef12a3ce");

        $oApi = oxNew("exonnactivecampaign_api");
        $res = $oApi->createCustomer($oUser);



        print_r($res);

        exit();



    }



    public function createcontact()
    {

        echo "<pre>";

        $oUser = oxNew("oxuser");
        $oUser->load("9b6b9760c77cc030bee8d402ef12a3ce");

        $oApi = oxNew("exonnactivecampaign_api");
        $res = $oApi->createContact($oUser);



        print_r($res);

        exit();



    }



    public function createorder()
    {

        echo "<pre>";

        $oUser = oxNew("oxorder");
        $oUser->load("3cf28bc5053a2e407712797144724f62");

        $oApi = oxNew("exonnactivecampaign_api");
        $res = $oApi->createOrder($oUser);



        print_r($res);

        exit();



    }


    public function createcomplettorder()
    {

        echo "<pre>";

        $ConnectionId = 2;
        $aUserIds = oxDb::getDb()->getCol("
            SELECT 
                   oxuserid 
            FROM 
                  `oxorder` join
                   oxuser on oxorder.oxuserid=oxuser.oxid
            WHERE 
                  oxorderdate>=now() - interval 2 hour &&
                  oxusername not like '%@nomail.de' && 
                  oxusername not like '%@tvrus-shop.de' && 
                  oxusername not like '%amazon%' && 
                  oxusername like '%@%' && 
                  oxordernr not like '81%' &&
                  oxstorno=0 &&
                  `OXTOTALORDERSUM`>1 
            group by oxuserid
            order by oxuserid
"
        );

        foreach($aUserIds as $sUserId) {
echo "!".$sUserId."!";
            $oUser = oxNew("oxuser");
            $oUser->load($sUserId);

            $oApi = oxNew("exonnactivecampaign_api");
            $res = $oApi->createContact($oUser);
            print_r($res);

            if ($res->errors[0]->code=="duplicate") {
                continue;
            }

            $res = $oApi->createCustomer($oUser, $ConnectionId);
            print_r($res);

            $customerid = $res->ecomCustomer->id;
            echo "!" . $customerid . "!";

            $aorderIds = oxDb::getDb()->getCol("
            SELECT 
                   oxid 
            FROM 
                  `oxorder`
            WHERE 
                  oxuserid=".oxDb::getDb()->quote($sUserId)." &&
                  oxorderdate>='2017-04-05 00:00:00' && 
                  oxordernr not like '81%' &&
                  oxstorno=0 &&
                  `OXTOTALORDERSUM`>1 
                  "
            );

            foreach ($aorderIds as $aorderId) {
                $oOrder = oxNew("oxorder");
                $oOrder->load($aorderId);
                $res = $oApi->createOrder($oOrder, $customerid, $oUser, $ConnectionId);
//                print_r($res);

            }
        }

        exit();



    }




    public function listconnections()
    {

        echo "<pre>";


        $oApi = oxNew("exonnactivecampaign_api");
        $res = $oApi->listConnections();



        print_r($res);

        exit();



    }
/*

[connection] => stdClass Object
        (
            [isInternal] => 0
            [service] => Kaufbei.tv
            [externalid] => kaufbeitv
            [name] => Kaufbei.tv
            [logoUrl] => https://www.kaufbei.tv/out/flow/img/logo.svg
            [linkUrl] => https://www.kaufbei.tv/
            [cdate] => 2019-11-07T07:21:41-06:00
            [udate] => 2019-11-07T07:21:41-06:00
            [links] => stdClass Object
                (
                    [options] => https://bem-media.api-us1.com/api/3/connections/2/options
                    [customers] => https://bem-media.api-us1.com/api/3/connections/2/customers
                )

            [connectionType] => ecommerce
            [id] => 2
            [serviceName] => Kaufbei.tv
        )

*/
    public function createconnections()
    {

        echo "<pre>";


        $oApi = oxNew("exonnactivecampaign_api");
        $res = $oApi->createConnections();



        print_r($res);

        exit();



    }

}