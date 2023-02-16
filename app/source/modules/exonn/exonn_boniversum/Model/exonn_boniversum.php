<?php



class exonn_boniversum extends oxBase {

    protected $_sClassName = 'exonn_boniversum';

    public function __construct()
    {
        parent::__construct();
        $this->init( 'exonn_boniversum' );
    }


    public function loadBoniversumData($oBasket)
    {
        if ($oUser = $oBasket->getUser()) {

            $oConfig = $this->getConfig();

            //suchen daten in unserem datenbank


            $sBirthDate = str_replace('-', "", $oUser->oxuser__oxbirthdate->value);

            $oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);

            $sBoniversumOxid = $oDb->getOne("select oxid from exonn_boniversum where 
                geschlecht = ".$oDb->quote((($oUser->oxuser__oxsal->value=='MR') ? '01' : '02'))." AND
                nachname = ".$oDb->quote($oUser->oxuser__oxlname->value)." AND
                vorname = ".$oDb->quote($oUser->oxuser__oxfname->value)." AND
                geburtsdatum = ".$oDb->quote($sBirthDate)." AND
                strasse_valide = ".$oDb->quote($oUser->oxuser__oxstreet->value)." AND
                hausnr_valide = ".$oDb->quote($oUser->oxuser__oxstreetnr->value)." AND
                plz_valide = ".$oDb->quote($oUser->oxuser__oxzip->value)." AND
                ort_valide = ".$oDb->quote($oUser->oxuser__oxcity->value)." AND
                
                
                errorcode='' AND
                produktergebnis='Produktgenerierung erfolgreich' AND
                create_date > now() - interval ".max(1, $oConfig->getConfigParam('EXONN_BONIVERSUM_SAVEPERIODE'))." DAY
                
                order by create_date desc 
                 
                
            ");



            if (!$sBoniversumOxid) {

                $sBoniversumOxid = $oDb->getOne("select oxid from exonn_boniversum where 
                    geschlecht = " . $oDb->quote((($oUser->oxuser__oxsal->value == 'MR') ? '01' : '02')) . " AND
                    nachname = " . $oDb->quote($oUser->oxuser__oxlname->value) . " AND
                    vorname = " . $oDb->quote($oUser->oxuser__oxfname->value) . " AND
                    geburtsdatum = " . $oDb->quote($sBirthDate) . " AND
                    strasse = " . $oDb->quote($oUser->oxuser__oxstreet->value) . " AND
                    hausnr = " . $oDb->quote($oUser->oxuser__oxstreetnr->value) . " AND
                    plz = " . $oDb->quote($oUser->oxuser__oxzip->value) . " AND
                    ort = " . $oDb->quote($oUser->oxuser__oxcity->value) . " AND
                    
                    errorcode='' AND
                    produktergebnis='Produktgenerierung erfolgreich' AND
                    create_date > now() - interval " . max(1, $oConfig->getConfigParam('EXONN_BONIVERSUM_SAVEPERIODE')) . " DAY
                    
                    order by create_date desc 
                     
                    
                ");


                if (!$sBoniversumOxid) {

                    $this->assign(array(
                        'exonn_boniversum__create_date' => date("Y-m-d H:i:s"),
                        'exonn_boniversum__oxuserid' => $oUser->getid(),
                        'exonn_boniversum__geschlecht' => (($oUser->oxuser__oxsal->value == 'MR') ? '01' : '02'),
                        'exonn_boniversum__nachname' => $oUser->oxuser__oxlname->value,
                        'exonn_boniversum__vorname' => $oUser->oxuser__oxfname->value,
                        'exonn_boniversum__geburtsdatum' => $sBirthDate,
                        'exonn_boniversum__strasse' => $oUser->oxuser__oxstreet->value,
                        'exonn_boniversum__hausnr' => $oUser->oxuser__oxstreetnr->value,
                        'exonn_boniversum__plz' => $oUser->oxuser__oxzip->value,
                        'exonn_boniversum__ort' => $oUser->oxuser__oxcity->value,
                    ));

                    $this->save();

                    $this->load($this->getId()); //hier laden um geschaeftszeichen zu bekommen


                    $aRequest = array(
                        'prodid' => $oConfig->getConfigParam('EXONN_BONIVERSUM_PRODID'),
                        'kennung' => $oConfig->getConfigParam('EXONN_BONIVERSUM_USERNAME'),
                        'passwort' => $oConfig->getConfigParam('EXONN_BONIVERSUM_PASSWORD'),
                        'berechtigtesinteresse' => '01',
                        'einwilligungsklausel' => 1,
                        'geschaeftszeichen' => $this->exonn_boniversum__geschaeftszeichen->value,
                        'geschlecht' => $this->exonn_boniversum__geschlecht->value,
                        'nachname' => $this->exonn_boniversum__nachname->value,
                        'vorname' => $this->exonn_boniversum__vorname->value,
                        'geburtsdatum' => $this->exonn_boniversum__geburtsdatum->value,
                        'strasse' => $this->exonn_boniversum__strasse->value,
                        'hausnr' => $this->exonn_boniversum__hausnr->value,
                        'plz' => $this->exonn_boniversum__plz->value,
                        'ort' => $this->exonn_boniversum__ort->value,

                    );

                    //echo "<pre>";
                    //print_r($aRequest);
                    $res = $this->requestSend($aRequest);

                    //print_r($res);

                    $boniversumAuftragsnummer = $res->Module->AuftragModul->auftragNummer;
                    if ($boniversumAuftragsnummer=="") {
                        $boniversumAuftragsnummer = $res->Module->FehlerModul->anfrageNummer;
                    }

                    $this->assign(array(
                        'exonn_boniversum__auftragerstellungsdatum' => $res->Module->AuftragModul->auftragErstellungsdatum,
                        'exonn_boniversum__auftragerstellungsuhrzeit' => $res->Module->AuftragModul->auftragErstellungsuhrzeit,
                        'exonn_boniversum__errorcode' => $res->Module->FehlerModul->fehlercode,
                        'exonn_boniversum__produktergebnis' => $res->Module->AuftragModul->produktergebnis,
                        'exonn_boniversum__boniversum_auftragsnummer' => $boniversumAuftragsnummer,
                        'exonn_boniversum__adressvalidierung' => $res->Module->AdresskontrollModul->Adresskontrollen->Adresskontrolle->adressvalidierungsstatusGrob,
                        'exonn_boniversum__strasse_valide' => $res->Module->AdresskontrollModul->Adresskontrollen->Adresskontrolle->Adresse->strasse,
                        'exonn_boniversum__hausnr_valide' => $res->Module->AdresskontrollModul->Adresskontrollen->Adresskontrolle->Adresse->hausnummer,
                        'exonn_boniversum__plz_valide' => $res->Module->AdresskontrollModul->Adresskontrollen->Adresskontrolle->Adresse->plz,
                        'exonn_boniversum__ort_valide' => $res->Module->AdresskontrollModul->Adresskontrollen->Adresskontrolle->Adresse->ort,
                        'exonn_boniversum__identifizierung' =>  $res->Module->IdentModul->identifizierung,
                        'exonn_boniversum__scoretyp' => $res->Module->ScoreModul->Scores->Score->scoreTyp,
                        'exonn_boniversum__wert' => $res->Module->ScoreModul->Scores->Score->wert,
                        'exonn_boniversum__ampel' => str_replace('grün', 'gruen', $res->Module->ScoreModul->Scores->Score->ampel),
                        'exonn_boniversum__scoreklasse' => $res->Module->ScoreModul->Scores->Score->scoreKlasse,

                    ));
                    $this->save();

                } else {
                    $this->load($sBoniversumOxid);

                }
            } else {

                $this->load($sBoniversumOxid);

                if ($this->exonn_boniversum__adressvalidierung->value=='Die angegebene Adresse wurde postalisch korrigiert und validiert.') {
                    //ändern, weil wir mit richtigen Daten gefunden
                    $this->assign(array('exonn_boniversum__adressvalidierung' => 'Die angegebene Adresse wurde postalisch validiert.'));
                }

            }


        }

    }


    public function hasError()
    {
        if ($this->exonn_boniversum__errorcode->value<>'' || $this->exonn_boniversum__produktergebnis->value<>'Produktgenerierung erfolgreich' || $this->exonn_boniversum__boniversum_auftragsnummer->value=='')
            return true;
        else
            return false;
    }



    public function getAllowPayment($dBasketPrice) {

        if ($this->hasError()) {
            return false;
        }

        switch ($this->exonn_boniversum__adressvalidierung->value) {
            case 'Die angegebene Adresse wurde postalisch validiert.':
                $oxadressvalidierung = '01';
                break;
            case 'Die angegebene Adresse wurde postalisch korrigiert und validiert.':
                $oxadressvalidierung = '02';
                break;
            case 'Die angegebene Adresse konnte postalisch nicht validiert werden.':
                $oxadressvalidierung = '03';
                break;
            default:
                return false;
        }

        switch ($this->exonn_boniversum__identifizierung->value) {
            case 'Vor- und Nachname sind bekannt.':
                $oxpersonidentifikation = '02';
                break;
            case 'Vor- und Nachname sind nicht bekannt.':
                $oxpersonidentifikation = '01';
                break;
            case 'Nachname ist bekannt.':
                $oxpersonidentifikation = '03';
                break;
            case 'Gebäude ist bekannt.':
                $oxpersonidentifikation = '04';
                break;
            default:
                return false;
        }



        $aPaymentAllow = oxdb::getDb()->getCol("select b.oxpaymentid from exonn_boniversumpayments a join exonn_boniversum2payments b on a.oxid=b.oxboniversumid
          where 
              a.oxadressvalidierung like '%".$oxadressvalidierung."%' and
              a.oxpersonidentifikation like '%".$oxpersonidentifikation."%' and
              (
                a.scorecalc='klasse' && 
                a.scoreklassefrom<='".$this->exonn_boniversum__scoreklasse->value."' && 
                a.scoreklasseto>='".$this->exonn_boniversum__scoreklasse->value."'
              ||  
                a.scorecalc='ampel' &&
                a.scoreampel like ".oxdb::getDb()->quote('%'.$this->exonn_boniversum__ampel->value.'%')."
              ||  
                a.scorecalc='wert' &&
                a.scorewertfrom<='".$this->exonn_boniversum__wert->value."' && 
                a.scorewertto>='".$this->exonn_boniversum__wert->value."'
              ) &&
              a.kreditlimit>".oxdb::getDb()->quote($dBasketPrice)."
            ");

        return $aPaymentAllow;

    }







    protected function requestSend($aRequest)
    {

        $curl = curl_init('https://api.boniversum.com/bonima/xml/v2/report');
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

        curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded;charset=utf-8'));
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($aRequest, null, "&"));

        //print_r($request);
        //curl_setopt($curl,  CURLINFO_HEADER_OUT, true);
        $res = curl_exec($curl);
        //print_r(curl_getinfo($curl));
        curl_close($curl);

        $oRes = simplexml_load_string($res);
        //echo "<pre>";
//print_r($oRes);
        return $oRes;

    }



}