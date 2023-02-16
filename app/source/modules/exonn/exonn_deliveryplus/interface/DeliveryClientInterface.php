<?php


/**
 * Interface DeliveryClientInterface
 *
 * setShipper       - address of seller, mandatory
 * setSendToAddr    - address of buyer, mandatory
 *
 * setSendFromAddr  - seller pickup addres, optional
 * setReceiver      - buyer info, optional
 *
 */
interface DeliveryClientInterface
{

    /**
     * Init delivery-service Client.
     *
     * If $user and $password false then take settings from oxid
     *
     * @param $accessKey
     * @param $user
     * @param $password
     */
    public function initClient($accessKey = false, $user = false, $password = false, $testMode = false, $addInfo = array());

    /**
     * Return true if service can work with numerous pacges.
     *
     * @return mixed
     */
    public function isManyPackagesSupported();

    /**
     * Set shipper data.
     *
     * @param $name
     * @param $street
     * @param $streetNr
     * @param $city
     * @param $zip
     * @param $country
     * @param $countryCode
     * @param $email
     * @param $phone
     * @param $company
     * @param $addInfo array
     */
    public function setShipper( $name, $street, $streetNr, $city, $zip, $country,
                                $countryCode, $email, $phone, $company, $addInfo = array());
    /**
     * Set buyer contact address.
     *
     * @param $name
     * @param $street
     * @param $streetNr
     * @param $city
     * @param $zip
     * @param $country
     * @param $countryCode
     * @param $email
     * @param $phone
     * @param $company
     * @param array $addInfo
     */
    public function setReceiver( $name, $street, $streetNr, $city, $zip, $country,
                                 $countryCode, $email, $phone, $company, $addInfo = array());

    /**
     * Set delivery addrees.
     *
     * @param $name
     * @param $street
     * @param $streetNr
     * @param $city
     * @param $zip
     * @param $country
     * @param $countryCode
     * @param $email
     * @param $phone
     * @param $company
     * @param array $addInfo
     */
    public function setSendToAddr($name, $street, $streetNr, $city, $zip, $country,
                                  $countryCode, $email, $phone, $company, $addInfo = array());

    /**
     * Set pickup address.
     *
     * @param $name
     * @param $street
     * @param $streetNr
     * @param $city
     * @param $zip
     * @param $country
     * @param $countryCode
     * @param $email
     * @param $phone
     * @param $company
     * @param array $addInfo
     */
    public function setSendFromAddr($name, $street, $streetNr, $city, $zip, $country,
                                    $countryCode,  $email, $phone, $company, $addInfo = array());
    /**
     * Add package for label.
     *
     * @param $id
     * @param $weight
     * @param string $desc
     * @param int $width
     * @param int $height
     * @param int $length
     * @param array two keys array (exportinfo, positions) exportinfo not empty for orders to not EU country;
     *                                  positions for export documents need complete info for package: title, weight, price, amount etc
     * @param array $addInfo Ex. ['prodcode', 'teilnahmen', 'issperrgut', 'istransportver']
     */
    public function addPackage($id, $weight, $desc = "", $width = 0, $height = 0, $length = 0, $positions = array(),  $addInfo = array());

    /**
     * Clear all added packages.
     *
     * @return mixed
     */
    public function clearPackages();

    /**
     * Configure delivery notifications on email.
     *
     * @param $shipperEmail
     * @param $receiverEmail
     * @throws Exception
     */
    public function setNotificationOptions($shipperEmail, $receiverEmail);

    /**
     * Set cache on delivery mode.
     *
     * @param $amount
     * @param int $codAdditionalCost
     */
    public function setCODOptions($amount, $codAdditionalCost = 0);



    /**
     * Return array of docs usrl.
     */
    public function getExportDocuments($labelNumber, $mainLabelNumber);

    /**
     * Generate delivery label.
     *
     * Return array of array of packages tracking info:
     *   [
     *     [url]        - url of label (if not http, then just filename)   (!)
     *     [urltype]    - type of data - gif/jpeg/pdf                      (!)
     *     [number]     - package/label id/number                          (!)
     *     [trackcode]  - package trackcode / empty if number used as trackcode
     *     [labelid]    - label main id (if no label id then empty)
     *   ]
     *
     *   if error the array with one key [err] => err message
     *
     * @param $invoiceNumber - order number
     * @param $desc
     * @param $labelsDir - local directora to story labels
     * @param bool $returnLabel - not used yet
     * @return array
     */
    public function getLabel($invoiceNumber, $desc, $labelsDir, $returnLabel = false);

    /**
     * Cancel full label or some packages.
     *
     * Return array:
     *   "ok" => 1 - if label canceled
     *   "err" => message - if label notcanceled
     *
     * @param $labelId - id of label
     * @param $mainLabelId - main label id if exsist
     * @return array
     */
    public function cancelLabel($labelId, $mainLabelId = "");

    /**
     * Return tracking url for specific trackcode.
     *
     * @param $trackcode
     * @return mixed
     */
    public function getTrackingUrl($trackcode);

    /**
     * @param $accountOwner, mandatory
     * @param $bankName, mandatory
     * @param $iban, mandatory
     * @param null $note1
     * @param null $note2
     * @param null $bic
     * @param null $accountreference
     * @return void
     */
    public function setBankData($accountOwner, $bankName, $iban, $note1 = null, $note2 = null, $bic = null, $accountreference = null);

    /**
     * If impossible to remove label, send email to service for label removeing.
     *
     * @return mixed
     */
    public function getEmailAddrForDeleteLabel();
}
