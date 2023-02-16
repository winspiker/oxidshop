<?php

class crefoPayApi
{
    private $cpConf;
    private $logger;
    private $privateKey;


    function __construct()
    {
        $config = oxRegistry::getConfig();

        $this->cpConf = oxNew('crefoPayConfig');
        $this->logger = oxNew('crefoPayLogger');
        $this->privateKey = $config->getConfigParam('CrefoPayPrivateKey');
    }

    /**
     * 
     */
    public function call($data, $function)
    {
        ksort($data);

        // calculate mac
        $mac = $this->calculateMac(implode("", $data));

        // build POST body
        $postData = http_build_query($data);

        // add calculated MAC to POST body
        $postData .= '&mac=' . $mac;

        try {
            return $this->post($postData, $function);

        } catch (Exception $e) {
            $this->logger->log(2, __FILE__, $e);
            throw $e;
        }
    }

   
    public function calculateMac($str)
    {
        return (hash_hmac('sha1', str_replace(array(
            " ",
            "\t",
            "\s",
            "\r",
            "\n",
            ' '
        ), "", $str), $this->privateKey));
    }    


    private function post($postData, $function)
    {
        $this->logger->log(0, __FILE__, "Try to post the following data to CrefoPay API:\n" . print_r($postData, true));
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->cpConf->getApiUrl() . $function);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
        $response = curl_exec($ch);

        return json_decode(substr($response, curl_getinfo($ch, CURLINFO_HEADER_SIZE)));
    }
}