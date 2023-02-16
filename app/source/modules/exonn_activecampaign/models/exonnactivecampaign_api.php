<?php

class exonnactivecampaign_api extends oxBase
{


    public function getCustomers()
    {
        $res = $this->_requestSend('ecomCustomers', '');

        return $res;
    }


    public function listConnections()
    {
        $res = $this->_requestSend('connections', '');

        return $res;
    }

    public function createCustomer($oUser, $ConnectionId) {

        $request = array('ecomCustomer' =>
            array(
                'connectionid' => $ConnectionId,
                'externalid' => $oUser->oxuser__oxcustnr->value,
                'email' => $oUser->oxuser__oxusername->value,
            ),
        );

        $res = $this->_requestSend('ecomCustomers', json_encode($request), "POST");

        return $res;

    }


    public function createContact($oUser) {

        $request = array('contact' =>
            array(
                'firstName' => $oUser->oxuser__oxfname->value,
                'lastName' => $oUser->oxuser__oxlname->value,
                'email' => $oUser->oxuser__oxusername->value,
                'phone' => $oUser->oxuser__oxfon->value,
            ),
        );

        $res = $this->_requestSend('contacts', json_encode($request), "POST");

        return $res;

    }


    public function createOrder($oOrder, $customerid, $oUser, $ConnectionId) {


        $oOrderProducts = $oOrder->getOrderArticles(true);
        $aProducts = array();
        foreach ($oOrderProducts as $oOrderProduct) {
            $aProducts[]=array(
                'name' => $oOrderProduct->oxorderarticles__oxtitle->value,
                'price' => round($oOrderProduct->oxorderarticles__oxbprice->value*100),
                'quantity' => $oOrderProduct->oxorderarticles__oxamount->value,
                'externalid' => $oOrderProduct->oxorderarticles__oxartnum->value,
                'sku' => $oOrderProduct->oxorderarticles__oxartnum->value,

            );
        }



        $request = array('ecomOrder' =>
            array(
                'externalid' => $oOrder->oxorder__oxordernr->value,
                'externalcheckoutid' => $oOrder->oxorder__oxordernr->value,
                'source' => 1,
                'email' => $oUser->oxuser__oxusername->value,
                'orderProducts' => $aProducts,
                'totalPrice' => round($oOrder->oxorder__oxtotalordersum->value*100),
                'shippingAmount' => round($oOrder->oxorder__oxdelcost->value*100),
                'discountAmount' => round(($oOrder->oxorder__oxdiscount->value+$oOrder->oxorder__oxvoucherdiscount->value)*100),
                'currency' => $oOrder->oxorder__oxcurrency->value,
                'connectionid' => $ConnectionId,
                'customerid' => $customerid,
                'externalCreatedDate' => oxRegistry::get("oxUtilsDate")->convertDBDateTime($oOrder->oxorder__oxorderdate, true),
                'orderNumber' => $oOrder->oxorder__oxordernr->value,


            ),
        );


        $res = $this->_requestSend('ecomOrders', json_encode($request), "POST");

        return $res;

    }

    public function createConnections() {

        $request = array('connection' =>
            array(
                'service' => 'Kaufbei.tv',
                'externalid' => 'kaufbeitv',
                'name' => 'Kaufbei.tv',
                'logoUrl' => 'https://www.kaufbei.tv/out/flow/img/logo.svg',
                'linkUrl' => 'https://www.kaufbei.tv/',
            ),
        );

        $res = $this->_requestSend('connections', json_encode($request), "POST");

        return $res;

    }

    protected function _requestSend($operation, $request, $sMethod = 'GET')
    {

        $oConfig = $this->getConfig();

        $sURL = 'https://bem-media.api-us1.com';// $oConfig->getConfigParam('activecampaign_url');
        $sToken = '6b07a17b1d4ef62c850b358d0c5f5dc0dc04ba396ab1b34e0fea0870c6906fdd90d7462a'; //$oConfig->getConfigParam('activecampaign_token');

        $curl = curl_init($sURL.'/api/3/'.$operation.(($sMethod=="GET") ? "?".$request : ""));
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array(
                'Content-type: application/json',
                "Api-Token: ".$sToken,
            ));

        if ($sMethod=="POST") {
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $request);
            echo $request;
        } elseif ($sMethod=="PUT") {
            $fp = fopen('php://temp', 'w');
            fwrite($fp, $request);
            fseek($fp, 0);
            curl_setopt($curl, CURLOPT_PUT, true);
            curl_setopt($curl, CURLOPT_INFILE, $fp); // file pointer
            curl_setopt($curl, CURLOPT_INFILESIZE, strlen($request));
        }

        //curl_setopt($curl,  CURLINFO_HEADER_OUT, true);
        $res = curl_exec($curl);
        //print_r(curl_getinfo($curl));
        curl_close($curl);


        $oRes = json_decode($res);

        return $oRes;

    }




}