<?php


class exonn_fnccron extends oxUBase
{

    public function createTaskNopaid()
    {
        // /index.php?cl=exonn_fnccron&fnc=createTaskNopaid&passw=secret_word


        $oConfig = $this->getConfig();

        require_once $oConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.'modules'.DIRECTORY_SEPARATOR."exonnutils".DIRECTORY_SEPARATOR."exonnutils.php";

        $sUserGroup = $oConfig->getConfigParam('orderpay_taskusergroup');


        $nc = oxDb::getDb()->getAll('select oxorder.oxid, oxorder.oxuserid  from oxorder left join oxpayments p on oxorder.OXPAYMENTTYPE = p.oxid
            where
                oxorder.oxorderdate<now() - interval 1 week &&
                oxorder.oxorderdate>now() - interval 7 week &&
                oxorder.oxpaid = "0000-00-00 00:00:00" &&
                oxorder.OXTOTALORDERSUM > 0.01 &&
                oxorder.oxfolder in ('.exonnutils::explodeWithApostrForMysql($oConfig->getConfigParam('sOrderprocessingFolders')).') AND
                oxorder.oxsenddate = "0000-00-00 00:00:00" AND
                p.orderprocessingpayed = 0 AND
                oxorder.oxstorno = "0" &&
                oxorder.paytaskstatus = 0
            ');

        $sAdminIdFrom = oxDb::getDb()->getOne('select oxid from oxuser where oxcustnr='.oxDb::getDb()->quote($oConfig->getConfigParam('oxexonntask__oxadminid')));

        if ( $nc !== false && $nc->recordCount() > 0) {
            while ( !$nc->EOF ) {



                if ($sUserGroup) {
                    $oTask = oxNew("oxexonntask");
                    $oTask->assign(array(
                        "oxexonntask__oxadmingroupid" => $sUserGroup,
                        "oxexonntask__oxuserid" => $nc->fields[1],
                        "oxexonntask__oxadmin_from" => $sAdminIdFrom,
                        "oxexonntask__oxtasktermin" => date('Y-m-d H:i:s', ceil(time()/15/60)*15*60),
                        "oxexonntask__oxsubject" => 'Не оплаченный заказ',
                        "oxexonntask__oxmessage" => 'Данный заказ не оплачен в течении недели. Уведомите клиента, что его заказ не оплачен.',
                    ));
                    $oTask->save();
                }



                oxDb::getDb()->execute("update oxorder set paytaskstatus = 1 where oxid=".oxDb::getDb()->quote($nc->fields[0]));

                $nc->moveNext();


            }
        }

        exit();
    }



    protected function doTrackcode($aTracknummer)
    {
        $oAPI = oxNew("exonn_dhlstatusapi");
        $responce = $oAPI->getStatus($aTracknummer);

        print_r($responce);

        $this->statusSave($responce);


    }


    /*
        protected function doTrackcode($aTracknummer)
        {
            $oAPI = oxNew("exonn_dhlstatusapi");
            $responce = $oAPI->getStatus($aTracknummer);
    print_r($responce);
            exit();
            if (!$responce)
                echo "ERROR";


            if (!$this->statusSave($responce)) {
                foreach($aTracknummer as $sTracknummer) {
                    $responce = $oAPI->getStatus(array($sTracknummer));
                    if (!$responce)
                        echo "ERROR";

                    $this->statusSave($responce, true);

                }

            }

        }
    */

    protected function statusSave($responce)
    {
        $oConfig = oxRegistry::getConfig();
        require_once $oConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.'modules'.DIRECTORY_SEPARATOR."exonnutils".DIRECTORY_SEPARATOR."exonnutils.php";



        $oDb = oxDb::getDb();
        $error=false;
        foreach($responce->data as $data) {
            if (!trim($data["short-status"]) || trim($data["short-status"])=="Keine Daten gefunden." ) {
                $error=true;
                break;
            }

            if ($error) {
                $oDb->execute("update oxorder set
                    dhlstatusnextrequest = now() + interval 12 hour
                 where
                    oxtrackcode=".oxDb::getDb()->quote($data["piece-code"]));

            } else {

                 $oDb->execute("update oxorder set
                    oxdhlstatus=".$oDb->quote($data["short-status"]).",
                    oxdhlstatusdescr=".$oDb->quote($data["status"]).",
                    dhlstatusevent=".$oDb->quote($data["delivery-event-flag"]).",
                    oxdhlstatusdate=".$oDb->quote(date('Y-m-d H:i:s', exonnutils::mktimeFromMysqlDate($data["status-timestamp"]))).",
                    dhlstatusnextrequest = now() + interval 12 hour,
                    dhl_ruecksendung=".(($data["ruecksendung"]=="false") ? 0 : 1)."
                 where
                    oxtrackcode=".oxDb::getDb()->quote($data["piece-code"]));


            }
        }

        return !$error;

    }


}
