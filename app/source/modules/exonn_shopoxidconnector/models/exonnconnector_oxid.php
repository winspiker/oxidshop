<?php

class exonnconnector_oxid extends oxBase
{

    public function getExportTables()
    {
        $res = array(
            "oxarticles" => array(
                "export" => array(
                    "skip" => array(
                        "oxratingcnt",
                        "oxrating",
                    ),
                ),
            ),
            "oxarticleset" => array(),
            "oxaccessoire2article"  => array(),
            "oxartextends"  => array(),
            "oxattribute"  => array(),
            "oxcategories"  => array(),
            "oxcategory2attribute"  => array(),
            "oxdel2delset"  => array(),
            "oxdelivery"  => array(),
            "oxdeliveryset"  => array(),
            "oxdiscount"  => array(),
            //"oxfiles"  => array(),
            "oxgroups"  => array(),
            "oxlinks"  => array(),
            "oxmanufacturers"  => array(),
            "oxmediaurls"  => array(),
            "oxobject2article"  => array(),
            "oxobject2attribute"  => array(),
            "oxobject2category"  => array(),
            "oxobject2delivery"  => array(),
            "oxobject2discount"  => array(),
            "oxobject2list"  => array(),
            "oxobject2payment"  => array(),
            "oxpaymentamount2group" => array(),
            "oxobject2selectlist"  => array(),
            "oxobject2seodata"  => array(),
            "oxprice2article"  => array(),
            "oxrecommlists"  => array(),
            "oxselectlist"  => array(),
            "oxseo"  => array(),
            "oxseohistory" => array(),
            "oxvoucherseries"  => array(),
            "oxarticles2shop" => array(),
            "oxcategories2shop" => array(),
            "oxdelivery2shop" => array(),
            "oxdeliveryset2shop" => array(),
            "oxpayments2shop" => array(),
            "oxdiscount2shop" => array(),
            "oxvoucherseries2shop" => array(),
            "oxcountry" => array(),
            "oxpayments"  => array(),


            "oxdocumentsrechnungen" => array(),
            "oxdocumentsrechnungenpositions" => array(),
            "oxdocumentsrechnungenpositionsmwst" => array(),
            "oxdocumentsrechnungenpositionsrabatt" => array(),
            "oxdocumentsrechnungentemplate" => array(),
            "oxorderretourearticles" => array(),
            "oxorderretourenachlieferung" => array(),
            "oxarticlestock" => array(),
            "oxarticlestockekprice" => array(),
            "oxarticlestockmove" => array(),
            /*"oxarticlestockreserved" => array(),*/ // das ist jetzt view!
            "oxwarehouse" => array(),
            "oxwarehouseplace" => array(),


            "oxdeliverylabels" => array(),

            "oxvendorarticle_arrang" => array(), // необходима для smak bigbuy
            "exonn_schenker_bookings" => array(), //для шенкера

            "oxbankingkonten" => array(),

            "mstabs" => array(), //modul article_moretabs

        );

        return $res;

    }

    // !!! всегда редактировать в модуле для шопа !!!
    public function getImportTables()
    {
        $res = array(
            "oxdelivery2order" => array(),

            "kl_ack" => array(),
            "kl_delayed_emails" => array(),
            "kl_invoice" => array(),
            "kl_invoicearticles" => array(),
            "kl_logs" => array(),
            "kl_pclasses" => array(),
            "kl_returnamount" => array(),

            "paypalpluscw_transaction" => array(),

        );

        return $res;

    }


    // !!! всегда редактировать в модуле для шопа !!!
    /*
     * переносятся данные поля которые разрешены
     *
     */
    public function getImportExportTables()
    {
        $res = array(
            "oxuser" => array(
                "import" => array(
                    "skip" => array(
                        "oxactive",
                        "oxrights",
                        "oxcustnr",
                        "oxcreditlimit",
                    ),
                ),
                /*"export" => array( // первый раз необходимо перенести измененные номера клиентов
                    "skip" => array(
                        "oxcustnr",
                    ),
                ),*/
            ),
            "oxvouchers"  => array(), // oxorderid, oxuserid, oxreserved, oxdiscount wird übertragen wenn nicht leer!
            "oxaddress"  => array(),
            "oxobject2group"  => array(),
            //oxorderarticles soll vor dem oxorder stehen! weil oxorder wird erst importiert wenn oxorderarticles bereits importiert ist.
            "oxorderarticles" => array(
                "import" => array(
                    "onlyInsert" => true, // zeile nur hinzufügen aber danach nicht ändern
                ),
            ),
            "dgottoordermarge" => array(
                "import" => array(
                    "skip" => array(
                        'oxdeliverycarrier',
                    ),
                ),
                "export" => array(
                    "only" => array(
                        'oxdeliverycarrier',
                    ),
                ),
            ),

            "oxorder"  => array(
                "import" => array(
                    "only" => array(
                        "oxtransid",
                        "oxpayid",
                        "oxxid",
                        "oxpaid", /* переносится только не нулевая дата */
                        "oxtransstatus",
                        "klreservationno",
                        "klinvoiceno",
                        "oxpaymentid",
                        "oxpaymenttype",
                    )
                ),
                "export" => array(
                    "skip" => array(
                        "oxordernr",
                        "oxtransid",
                        "oxpayid",
                        "oxxid",
                        "oxtransstatus",
                        "klreservationno",
                        "klinvoiceno",

                    )
                )

            ),
            "oxorderretoure" => array(
                "import" => array(
                    "only" => array(
                        "oxbillcompany",
                        "oxbillemail",
                        "oxbillfname",
                        "oxbilllname",
                        "oxbillstreet",
                        "oxbillstreetnr",
                        "oxbilladdinfo",
                        "oxbillustid",
                        "oxbillcity",
                        "oxbillcountryid",
                        "oxbillstateid",
                        "oxbillzip",
                        "oxbillfon",
                        "oxbillfax",
                        "oxbillsal",
                        "oxdelcompany",
                        "oxdelfname",
                        "oxdellname",
                        "oxdelstreet",
                        "oxdelstreetnr",
                        "oxdeladdinfo",
                        "oxdelcity",
                        "oxdelcountryid",
                        "oxdelstateid",
                        "oxdelzip",
                        "oxdelfon",
                        "oxdelfax",
                        "oxdelsal",
                    )
                ),
            ),
            "oxuserpayments" => array(),
            //"oxorderfiles"  => array(),
            "oxremark"  => array(),

        );

        return $res;

    }

    public function getFirstInstallArticles()
    {
        $res = array(
            "oxarticles" => array(),
            "oxaccessoire2article"  => array(),
            "oxartextends"  => array(),
            "oxattribute"  => array(),
            "oxcategories"  => array(),
            "oxcategory2attribute"  => array(),
            "oxdiscount"  => array(),
            "oxfiles"  => array(),
            "oxlinks"  => array(),
            "oxmanufacturers"  => array(),
            "oxmediaurls"  => array(),
            "oxobject2article"  => array(),
            "oxobject2attribute"  => array(),
            "oxobject2category"  => array(),
            "oxobject2discount"  => array(),
            "oxobject2list"  => array(),
            "oxobject2selectlist"  => array(),
            "oxobject2seodata"  => array(),
            "oxprice2article"  => array(),
            "oxrecommlists"  => array(),
            "oxselectlist"  => array(),
            "oxseo"  => array(),

            "oxarticleset"  => array(),
            "oxarticlestock"  => array(),
            "oxarticlestockekprice"  => array(),
            "oxarticlestockmove"  => array(),
            /*"oxarticlestockreserved"  => array(), */ // das ist jetzt view!
            "oxwarehouse"  => array(),
            "oxwarehouseplace"  => array(),
            "oxactionfilters" => array(),
            "oxexonnactions" => array(),
            "oxexonnactions2group" => array(),
            "oxexonntask" => array(),
            "oxtelefoncalls" => array(),
            "oxcountry" => array(),
            "oxebayarticles" => array(),
            "ebay_shopcategory" => array(),
            "oxebayarticledelivery" => array(),
            "oxamazonarticles" => array(),
            "oxamazondel2article" => array(),
            "oxamazondescription" => array(),
            "oxamazondescriptionformulardata" => array(),

            "mstabs" => array(), //modul article_moretabs

        );

        return $res;

    }

    public function getFirstInstallOrder()
    {
        $res = array(
            "oxuser" => array(),
            "oxaddress" => array(),
            "oxdel2delset" => array(),
            "oxdelivery" => array(),
            "oxdeliveryset" => array(),
            "oxgroups" => array(),
            "oxobject2delivery" => array(),
            "oxobject2group" => array(),
            "oxobject2payment" => array(),
            //oxorderarticles muss vor oxorder stehen!
            "oxorderarticles" => array(),
            "oxorder" => array(),
            "oxorderfiles" => array(),
            "oxpayments" => array(),
            "oxremark" => array(),
            "oxuserpayments" => array(),
            "oxvouchers" => array(),
            "oxvoucherseries" => array(),
            "oxdelivery2order" => array(),


            "oxbankingdtaus" => array(),
            "oxbankingkonten" => array(),
            "oxbankingprocess" => array(),
            "oxbankingtransaktions" => array(),
            "oxbuchhaltungbelegen" => array(),
            "oxbuchhaltungbelegenzuordnung" => array(),
            "oxbuchhaltungbelegpositionen" => array(),
            "oxbuchhaltungkonten" => array(),
            "oxbuchhaltungkontokategories" => array(),
            "oxbuchhaltungvorlagen" => array(),
            "oxbuchhaltungvorlagenpositionen" => array(),
            "oxdocumentsrechnungen" => array(),
            "oxdocumentsrechnungenpositions" => array(),
            "oxdocumentsrechnungenpositionsmwst" => array(),
            "oxdocumentsrechnungenpositionsrabatt" => array(),
            "oxdocumentsrechnungentemplate" => array(),
            "oxorderretoure" => array(),
            "oxdocumentsrechnungen_firmadata" => array(),
            "oxorderretourearticles" => array(),
            "oxorderretourenachlieferung" => array(),

            "kl_ack" => array(),
            "kl_delayed_emails" => array(),
            "kl_invoice" => array(),
            "kl_invoicearticles" => array(),
            "kl_logs" => array(),
            "kl_pclasses" => array(),
            "kl_returnamount" => array(),
            "oxvendorarticle_arrang" => array(),
            "oxvendororderarticles" => array(),
            "oxvendororders" => array(),
            "oxexonnmessages" => array(),
            "oxexonnmessages_items" => array(),




        );

        return $res;

    }
}