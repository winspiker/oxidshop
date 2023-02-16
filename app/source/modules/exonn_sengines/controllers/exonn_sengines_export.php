<?php
error_reporting(E_ALL ^ E_NOTICE);
ini_set('display_errors', 1);

//require_once $_SERVER['DOCUMENT_ROOT']."/modules/exonn_sengines/exonn_sengines_license.php";

function testCallback($object)
{
    $object->setLoadParentData(true);
}

class exonn_sengines_export extends oxView
{
    public function makeTaxonomy() {
        $tax = file_get_contents("http://www.google.com/basepages/producttype/taxonomy.de-DE.txt");
        $txarr = explode("\n", $tax);
        $newtax = 'var tree = {t:{n:""';
        $key = array();
        foreach ($txarr as $st) {
            if (strpos($st, "#") !== false) continue;
            $newkey = explode(">", $st);
            if (count($newkey) > count($key)) {
                $newtax .= ',c:[{n:"' . $st . '"';
            } elseif (count($newkey) == count($key)) {
                $newtax .= '},{n:"' . $st . '"';
            } elseif (($step = count($key) - count($newkey)) > 0 ) {
                $newtax .= '}';
                $i = 0;
                while ($i < $step) {
                    $newtax .= ']}';
                    $i++;
                }
                if ($st) {
                    $newtax .= ',{n:"' . $st . '"';
                }
            }
            $key = $newkey;
        }
        $newtax .= ']}};';
        $myConfig = $this->getConfig();
        file_put_contents($myConfig->getConfigParam( 'sShopDir' ) . "/modules/exonn_sengines/views/js/taxonomy-utf.js", $newtax );
        $newtax = mb_convert_encoding($newtax, "ISO-8859-15", "UTF-8");
        file_put_contents($myConfig->getConfigParam( 'sShopDir' ) . "/modules/exonn_sengines/views/js/taxonomy.js", $newtax );
        exit;
    }



    protected function getBuyableArticleList($rfrom, $rto, $testartid = "", $langId)
    {
        // wenn sprache angegeben, view entsprechend ermitteln
        if($langId)
        {
            $sArticleTable = getViewName('oxarticles', $langId);
        }
        else
        {
            $sArticleTable = getViewName('oxarticles');
        }

        $iShopId = oxRegistry::getConfig()->getShopId();

        $oDB = oxDb::getDb();

        $where = " and a.oxshopid='".$iShopId."'";


        if ($testartid)
        {
            $where .= " and a.oxid='".addslashes($testartid)."'";
        }

        $sSelect = "select a.* from $sArticleTable a ";
        $sSelect .= "where (a.oxstock > 0 OR a.oxstockflag = 4) AND a.`OXACTIVE`=1 AND `OXARTNUM` !='' ".$where." LIMIT " . addslashes($rfrom) . "," . addslashes($rto);

        $rows = $oDB->getAll($sSelect);
        $result = array();
        foreach($rows as $row)
        {
            $result[] = $row[0];
        }
        return $result;
    }


    protected function getArticleList($field, $rfrom, $rto, $testartid = "", $langId)
    {
        // wenn sprache angegeben, view entsprechend ermitteln
        if($langId)
        {
            $sArticleTable = getViewName('oxarticles', $langId);
        }
        else
        {
            $sArticleTable = getViewName('oxarticles');
        }

        $iShopId = oxRegistry::getConfig()->getShopId();

        $oDB = oxDb::getDb();

        $where = " and a.oxshopid='".$iShopId."'";

        if (class_exists('article_multishop'))
        {
            $where.=" AND a.oxid in (select bb1.oxid from oxarticle2shop aa1 join oxarticles bb1 on (aa1.oxobjectid = bb1.oxid || aa1.oxobjectid = bb1.oxparentid) where aa1.oxshopid=".oxDb::getDb()->quote($iShopId).") ";
        }

        if ($testartid)
        {
            $where .= " and a.oxid='".addslashes($testartid)."'";
        }

        $sSelect = "select a.* from $sArticleTable a inner join exonn_googlem s on a.oxid=s.oxid ";
        $sSelect .= "where s.active=1 AND a.`OXACTIVE`=1 AND `OXARTNUM` !='' ".$where." LIMIT " . addslashes($rfrom) . "," . addslashes($rto);

        $rows = $oDB->getAll($sSelect);
        $result = array();
        foreach($rows as $row)
        {
                $result[] = $row[0];
        }
        return $result;
    }



    protected function encode($str, $cut = 0) {
        $myConfig = $this->getConfig();

        //echo "---------- " . mb_detect_encoding ($str) ." -------------<br>";
        //echo "$str<br>";
        //echo "-----------------------<br>";

        // todo: was wird hier gefiltert?
        $str = preg_replace('/[\x00-\x1F\x7F]/', '', $str);

        $utf = mb_detect_encoding ($str, 'UTF-8', true);
//        echo "is utf: " . $utf ."<br/>";
        if (!$myConfig->isUtf() && ($utf != 'UTF-8' || $utf == false)) {
            //echo "iso";

            if($cut)
            {
                $str = substr($str, 0, $cut);
            }
            //echo "convert" . "<br>";

            //$str = strtr($str, $map);
            //
            $str = mb_convert_encoding($str, "UTF-8", "ISO-8859-15");
            //
        } else {
            //$str = html_entity_decode($str, ENT_COMPAT, 'UTF-8');

            if($cut)
            {
                $str = iconv_substr($str, 0, $cut, "UTF-8");
            }
        }
        $str = $this->legacy_html_entity_decode($str);
        //$str = htmlentities($str);
        $str = htmlspecialchars($str);

        //echo "$str<br>";
        //echo "-----------------------<br>";

        return $str;
    }

    function legacy_html_entity_decode($str, $quotes = ENT_QUOTES, $charset = 'UTF-8') {
        return preg_replace_callback('/&#(\d+);/', function ($m) use ($quotes, $charset)
        {
            if (0x80 <= $m[1] && $m[1] <= 0x9F)
            {
                return iconv('cp1252', $charset, html_entity_decode($m[0], $quotes, 'cp1252'));
            }

            return html_entity_decode($m[0], $quotes, $charset);
        }, $str);
    }

    protected function getTitle($oCurarticle)
    {

        $arttitle = "";
        $myConfig = $this->getConfig();
        $alttitle = strtolower($myConfig->getConfigParam("EXONN_SENGINES_ALTITLE"));
        if ($alttitle) {
            $alttitle = "oxarticles__".strtolower($alttitle);
            if ($oCurarticle->$alttitle->value) {
                $arttitle = $oCurarticle->$alttitle->value;
            }
        }
        if (!$arttitle) {
            $arttitle = $oCurarticle->oxarticles__oxtitle->value;
            if ((!$myConfig->getConfigParam("EXONN_SENGINES_VARTITLE") || !$arttitle) && trim($parentId = $oCurarticle->oxarticles__oxparentid->value)) {
                $arttitle = oxDb::getDb()->getOne("select oxtitle from oxarticles where oxid='".$parentId."'");
                $arttitle .= " - " . $oCurarticle->oxarticles__oxvarselect->value;
            }

            $ct = $this->getGoogleCatTitle2($oCurarticle);
            $arttitle = $ct ? $ct . " " . $arttitle : $arttitle;
        }

        return $this->encode($arttitle);

        /*return $this->encode($alttitleval . ($oCurarticle->oxarticles__oxtitle->value . ($oCurarticle->oxarticles__oxvarselect->value
                                        ? ' ' . $oCurarticle->oxarticles__oxvarselect->value : '')));*/
    }

    protected function getGoogleCatTitle2($oCurarticle)
    {
        $cat = $oCurarticle->getCategory();
        if (!$cat) return "";
        $googlem = oxNew("exonn_googlem");
        $googlem->load($cat->getId());
        return $googlem->exonn_googlem__title2->value;
    }

    protected function getGoogleCat($oCurarticle)
    {
        $cat = $oCurarticle->getCategory();
        if (!$cat) return "";
        $googlem = oxNew("exonn_googlem");
        $googlem->load($cat->getId());
        return $googlem->exonn_googlem__googlecategory->value;
    }

    protected function getCat($oCurarticle)
    {
        $cat = $oCurarticle->getCategory();
        $kategory = $cat->oxcategories__oxtitle->value;

        if ($cat)
            while ($cat->oxcategories__oxparentid->value != 'oxrootid')
            {
                $cat = $cat->getParentCategory();
                if (!$cat) break;
                $kategory = $cat->oxcategories__oxtitle->value . ' > ' . $kategory;

            }

        return $this->encode($kategory);
    }

    protected function getCatIds($oCurarticle)
    {
        $sO2CView = 'oxobject2category';
        $sCatView = 'oxcategories';

        $sArticleIdSql = 'oxobject2category.oxobjectid='.oxDb::getDb()->quote( $oCurarticle->getId() );
        if ( $oCurarticle->getParentId() ) {
            $sArticleIdSql = '('.$sArticleIdSql.' or oxobject2category.oxobjectid='.oxDb::getDb()->quote( $oCurarticle->getParentId() ).')';
        }

        $sSelect =  "select
                        oxobject2category.oxcatnid as oxcatnid
                     from $sO2CView as oxobject2category
                        left join $sCatView as oxcategories on oxcategories.oxid = oxobject2category.oxcatnid
                    where $sArticleIdSql and oxcategories.oxid is not null and oxcategories.oxactive = 1
                    order by oxobject2category.oxtime";

        $result = array();
        $cats = oxDb::getDb()->getAll($sSelect);
        foreach ($cats as $cat) {
            $result[] = $cat[0];
        }


        /*$cat = $oCurarticle->getCategory();
        $result = array();

        if ($cat) {
            $result[] = $cat->getId();
            while ($cat->oxcategories__oxparentid->value != 'oxrootid') {
                $cat = $cat->getParentCategory();
                $result[] = $cat->getId();

            }
        }*/
        return $result;
    }

    protected function getDeliv($oCurarticle, $country)
    {
        $deliv = array();
        $oDeliveriesList = oxNew( 'oxdeliverylist' );
        $oDeliveriesList = $this->loadDeliveryListForProduct($oDeliveriesList, $oCurarticle);


        $count = 0;
        $oDB = oxDB::getDb();
        foreach ( $oDeliveriesList as $key => $oDelivery ) {
            $del = array();
            $del['title'] = $oDelivery->oxdelivery__oxtitle->value; 
            $oxPrice =  $oDelivery->getDeliveryPrice();
            $oxPrice->setBruttoPriceMode(true);
            $oxPrice->setPrice($oDelivery->oxdelivery__oxaddsum->value);
            //$del['sum'] = $oxPrice->getNettoPrice();//oxdelivery__oxaddsum->value;
            $del['sum'] = $oDelivery->oxdelivery__oxaddsum->value;
            
            $sSelect = "SELECT c.OXISOALPHA2 from oxcountry c inner join `oxobject2delivery` o2d on c.oxid = o2d.OXOBJECTID
    WHERE o2d.OXDELIVERYID = '".$oDelivery->getId()."' and OXTYPE='oxcountry' and c.OXISOALPHA2 = '".$country."' and google_feed_active = '1'";




            $rows = $oDB->getAll($sSelect);

            if(count($rows))
            {
                $del['country'] = $rows[0][0];
                $deliv[] = $del;
            }
//            else
//            {
//                unset($oDeliveriesList[$key]);
//            }



//            echo __FILE__ . " : " . __LINE__ ."\n";
//            echo "<pre>";
//            print_r($del['title']);
//            print_r(count($rows));
//            echo "</pre>";


            $count++;
        }

        return $deliv;
    }

    public function getProductWeight($oProduct) {
        $dWeight = $oProduct->oxarticles__oxweight1->value ? $oProduct->oxarticles__oxweight1->value : $oProduct->oxarticles__oxweight->value;
        if ($dWeight > 31.5) $dWeight = 31.5;
        return $dWeight;
    }

    public function loadDeliveryListForProduct( $oDeliveriesList, $oProduct )
    {
        $oDb = oxDb::getDb();
        $dPrice  = $oDb->quote($oProduct->getPrice()->getBruttoPrice());
        $dSize   = $oDb->quote($oProduct->oxarticles__oxlength->value * $oProduct->oxarticles__oxwidth->value * $oProduct->oxarticles__oxheight->value);
        $dWeight = $this->getProductWeight($oProduct);

        $sTable  = getViewName( 'oxdelivery' );
        $sQ = "select $sTable.* from $sTable";
        $sQ .= " where ".$oDeliveriesList->getBaseObject()->getSqlActiveSnippet();
        $sQ .= " and ($sTable.oxdeltype != 'a' || ( $sTable.oxparam <= 1 && $sTable.oxparamend >= 1))";
        if ($dPrice) {
            $sQ .= " and ($sTable.oxdeltype != 'p' || ( $sTable.oxparam <= $dPrice && $sTable.oxparamend >= $dPrice))";
        }
        if ($dSize) {
            $sQ .= " and ($sTable.oxdeltype != 's' || ( $sTable.oxparam <= $dSize && $sTable.oxparamend >= $dSize))";
        }
        if ($dWeight) {
            $sQ .= " and ($sTable.oxdeltype != 'w' || ( $sTable.oxparam <= $dWeight && $sTable.oxparamend >= $dWeight))";
        }

        $catIds = $this->getCatIds($oProduct);
        $sQ .= " limit 50";

        $oDeliveriesList->selectString($sQ);
        $removeArr = array();
        foreach ( $oDeliveriesList as $key => $oDelivery ) {
            $rows = $oDb->getAll($q ="select oxid from oxobject2delivery where (oxtype = 'oxarticles' || oxtype = 'oxcategories') and OXDELIVERYID='" . $oDelivery->getId() . "'");
            if (count($rows)) {
                if (!$oDb->getOne($q = "select 1 from oxobject2delivery where OXDELIVERYID='" . $oDelivery->getId() . "' and oxobjectid in ('".$oProduct->getId()."', '" . ($oProduct->getParentId() ? $oProduct->getParentId() . "', '" : '') .implode("','", $catIds)."')" )) {
                    $removeArr[] = $key;
                }
            }
            if(count($oDb->getAll($q ="select 1 from oxdel2delset d2d inner join oxdeliveryset ds on d2d.OXDELSETID=ds.oxid where ds.skipgmerch=1 and d2d.OXDELID='" . $oDelivery->getId() . "'"))) {
                $removeArr[] = $key;
            }
        }

        foreach ($removeArr as $key) {
            $oDeliveriesList->offsetUnset($key);
        }
        return $oDeliveriesList;
    }

    protected function nPrice($price) {
       return round($price * 100) / 100;
    }

    protected function getPictureUrl($oCurarticle, $nr) {
        $myConfig = $this->getConfig();
        $dir = $myConfig->getConfigParam("EXONN_SENGINES_PICDIR");
        if ($dir) {
            if ( $picname = $oCurarticle->{"oxarticles__oxpic$nr"}->value ) {
                return $myConfig->getConfigParam( 'sShopURL' ) . "out/pictures/generated/product/$nr/$dir/$picname";
            }
            return false;
        } else {
            if (($url = $oCurarticle->getMasterZoomPictureUrl($nr)) !== false) {
                return $url;
            }
            return false;
        }
    }


    public function getVarValue($varparam, $oCurarticle, $varnamesStr) {
        $myConfig = $this->getConfig();
        $db = oxDb::getDb();
        $variantValues = $oCurarticle->oxarticles__oxvarselect->value;

        if ($attrsStr = $myConfig->getConfigParam($varparam)) {
            $attrs = explode(",", $attrsStr);
            $varnames = explode("|", $varnamesStr);
            if (is_array($attrs)) {
                foreach ($attrs as $attr) {
                    $i = 0;
                    if (is_array($varnames) && count($varnames)) {
                        foreach ($varnames as $varname) {
                            if (trim($attr) == trim($varname)) {
                                break;
                            }
                            $i++;
                        }
                        if ($i < count($varnames)) {
                            $values = explode("|", $variantValues);
                            return $values[$i];
                        }
                    }
                    if ($value = $db->getOne("select o.OXVALUE from oxattribute a inner join oxobject2attribute o on a.oxid = o.oxattrid where o.oxobjectid = '".$oCurarticle->getId()."' and a.oxtitle = '".trim($attr)."'")) {
                        return $value;
                    }
                }
            }

        }
        return "";
    }

    public function getArticleLink($art, $param = "") {
        $link = $art->getLink();
        if ($param) {
            $link .= (strpos($link, "?") === false ?  "?" : "&") . $param;
        }
        return $link;
    }

    public function getArticlePrice($oCurarticle, $netPrice = false) {
        $myConfig = $this->getConfig();
        $db = oxDb::getDb();
        if ($myConfig->getConfigParam("EXONN_SENGINES_USE_AMOUNT_PRICE") && count($rows = $db->getAll("SELECT OXADDABS FROM `oxprice2article` where OXADDABS != 0 and oxartid='" . $oCurarticle->getId()."' order by OXADDABS "))) {
            $oCurarticle->getPrice()->setPrice($rows[0][0]);
            return $this->nPrice($netPrice ? $oCurarticle->getPrice()->getNettoPrice() : $oCurarticle->getPrice()->getBruttoPrice());
        } else {
            return $this->nPrice($netPrice ? $oCurarticle->getPrice()->getNettoPrice() : $oCurarticle->getPrice()->getBruttoPrice());
        }
    }

    var $exportMode = "";

    public function getEntryValue($entryName, $value, $param = "", $paramValue = "") {
        if ($this->exportMode == "csv") {
            //return $entryName . ";" ;
            return '"' . ($paramValue ? $paramValue : $value) . '";';
        } else {
            if ($value || $param && $paramValue)
            {

                return '
                <' . $entryName . ($param ? ' ' . $param . '="' . $paramValue . '"' : '') . ($value ? ('>' . $value . '</' . $entryName . '>') : ('/>') );
            }
        }
        return "";
    }

    public function getListType()
    {
        parent::getListType();
    }

    public function google_xml()
    {
        // sprachparameter lesen
        $langId = 0;
        if($_REQUEST['lang'])
        {
            $langId = $_REQUEST['lang'];
        }

        // country parameter lesen
        if($_REQUEST["country"])
        {
            $google_countries[] = $_REQUEST['country'];
        }
        else
        {
            // alle für den Feed aktiven Länder aus Datenbank auslesen

            $merchantActiveCountriesQuery =
            '
                SELECT
                        oxisoalpha2
                FROM  
                        oxcountry
                WHERE
                        google_feed_active = 1 
            ';

            $merchantActiveCountriesResult = oxDb::getDb()->getAll($merchantActiveCountriesQuery);

            $google_countries = [];

            foreach($merchantActiveCountriesResult as $res)
            {
                  $google_countries[] = $res[0];
            }
        }


        foreach($google_countries as $countryIsoAlpha2)
        {


        if ($_REQUEST["debug"]) {
          echo "Start google_xml<br>";
          if ($_REQUEST["debug"] == "exit") exit; 
        }
        if ($_REQUEST["memory1024"]) {
            ini_set("memory_limit", "1024M");
        }

        if ($memory_limit = $_REQUEST["memory_limit"]) {
          ini_set("memory_limit", $memory_limit . "M");
        }

        if (!$_REQUEST["time_limit"]) {
          set_time_limit(0);
        }
        
        if ($_REQUEST["debug"]) {
            error_reporting(E_ALL ^ E_NOTICE);
            ini_set('display_errors', 1);
            register_shutdown_function(function(){echo "<pre>"; print_r(@error_get_last());});
        }


        $myConfig = $this->getConfig();
        $path = getShopBasePath(); // site path
        $url = $myConfig->getShopUrl();
        $this->exportMode = $_REQUEST["csv"] ? "csv" : "";

        $idx = $_REQUEST["idx"];

        //at for debug needs to begin from direct position
        if (!($at = intval($_REQUEST["at"]))) {
            $at = 0;
        }
        
        if (!($rfrom = intval($_REQUEST["rfrom"]))) {
            $rfrom = $at;
        }
           
        if (!($rto = intval($_REQUEST["rto"]))) {
            $rto = 1000;
        }

        if (!($maxRepeat = intval($_REQUEST["mr"]))) {
            $maxRepeat = 20;
        }
        //12249862
        $testartid = $_REQUEST["testid"];

        $shopName = "";
        if (oxDb::getDb()->getOne("select count(*) from oxshops") > 1) {
            $iShopId = oxRegistry::getConfig()->getShopId();
            $oxshop = oxNew("oxshop");
            $oxshop->load($iShopId);
            $shopName = preg_replace ("/[^0-9^a-z^_^.]/", "", strtolower($oxshop->oxshops__oxname->value)) . "_";
        }
        oxRegistry::getUtils()->writeToLog( "\r\n\r\n Start export $rfrom \r\n", 'EXONN_SENGINES_LOG.txt' );

        if($this->exportMode == "csv")
        {
            $fileName = $shopName . "google_{$countryIsoAlpha2}{$idx}.csv";
        }
        else
        {
            if($_REQUEST["allBuyableProducts"])
            {
                $fileName = $shopName . "google_{$countryIsoAlpha2}{$idx}_allBuyable.xml";
            }
            else
            {
                $fileName = $shopName . "google_{$countryIsoAlpha2}{$idx}.xml";
            }
        }

        $text = "";
        if ($continue = $_REQUEST["continue"]) {
            $f = fopen($path . "/export/" . $fileName, "a");
            if($this->exportMode != "csv") {
                $text = "
                <!-- Continue from $rfrom  -->";
            }
            $continue++;
        } else {
            $continue = 1;
            $f = fopen($path . "/export/" . $fileName, "w+");

            if($this->exportMode == "csv") {
                $text = "id;title;link;g:price;g:condition;g:availability;description;g:product_type;g:google_product_category;g:gtin;g:gmpn;g:brand;g:identifier_exists;g:image_link1;g:image_link2;g:image_link3;g:image_link4;g:country1;g:service1;g:price1;g:country2;g:service2;g:price2;g:country3;g:service3;g:price3;g:country4;g:service4;g:price4;g:country5;g:service5;g:price5;g:country6;g:service6;g:price6;g:country7;g:service7;g:price7;g:country8;g:service8;g:price8;g:shipping_weight;g:color;g:size;g:material;g:pattern;g:item_group_id;" . PHP_EOL;
            } else {
                $text = '<?xml version="1.0" encoding="UTF-8"?>
              <feed xmlns="http://www.w3.org/2005/Atom" xmlns:g="http://base.google.com/ns/1.0">
              <title>sengine_export.txt</title>
              <link href="' . $url . '" rel="alternate" type="text/html" />
              <updated>' . date("Y-m-d") . 'T' . date("G:i:s") . 'Z</updated>
              <author>
                <name>sengine_export</name>
              </author>
              <id>tag:sengine_export,' . date("Y-m-d") . ':/export</id>';
            }
        }

        /**
         * Anpassung für Kaufbei, zweite werbecampaign
         */
        // alternativ, über parameter, alle kaufbaren artikel exportieren
        if($_REQUEST["allBuyableProducts"])
        {
            $aArticles = $this->getBuyableArticleList($rfrom, $rto, $testartid, $langId);
        }
        else
        {
            $aArticles = $this->getArticleList('google', $rfrom, $rto, $testartid, $langId);
        }
        $count = count($aArticles);
        $i = 0;
        //echo "Export " . $count . " articles<br>";
        if ($_REQUEST["debug"]) {
            echo "Export " . $count . " articles<br>";
        }
        foreach ($aArticles as $k => $oCurarticleId)
        {   
            
            $oCurarticle = oxNew("oxarticle");
            $oCurarticle->load($oCurarticleId);
            
            if ($oCurarticle->oxarticles__oxprice->value && !$oCurarticle->isParentNotBuyable() && !$oCurarticle->isNotBuyable()) {
                
                $googlem = oxNew("exonn_googlem");
                $googlem->load($oCurarticle->getId());
                $netPrice = $myConfig->getConfigParam("EXONN_SENGINES_NETTOPRICE");
                $avail = "";
                $artstock = $oCurarticle->oxarticles__oxstock->value;
                if ($oCurarticle->oxarticles__oxstockflag->value == 4 || $artstock >= $myConfig->getConfigParam("EXONN_SENGINES_IN_STOCK")) {
                    $avail = 'in stock';
                } else {
                    if ($artstock > $myConfig->getConfigParam("EXONN_SENGINES_OUT_OF_STOCK") && $artstock < $myConfig->getConfigParam("EXONN_SENGINES_IN_STOCK")) {
                        $avail = 'preorder';
                    } else {
                        $avail = 'out of stock';
                    }
                }
                $addParam = $myConfig->getConfigParam("EXONN_SENGINES_ADDPARAM");
                if($this->exportMode != "csv") {
                    $text .= '
                            <entry>';
                }
                $text .= $this->getEntryValue("id", $this->encode($oCurarticle->oxarticles__oxartnum->value));

                // Titellänge einstellbar
                $titleLength = $myConfig->getConfigParam("iGoogleMerchantFeedProductTitleLength");

				$itemTitle = $this->getTitle($oCurarticle);

				$itemTitle = substr($itemTitle, 0, $titleLength);

				$lastPipeInTitlePosition = strripos($itemTitle, "|");

				if($lastPipeInTitlePosition !== false)
				{
					$itemTitle = substr($itemTitle, 0, ($lastPipeInTitlePosition-1));
				}

                if($titleLength)
                {
                    $text .= $this->getEntryValue("title", $itemTitle);
                }
                else
                {
                    $text .= $this->getEntryValue("title", $this->getTitle($oCurarticle));
                }


                $text .= $this->getEntryValue("link", "", "href", htmlspecialchars($this->getArticleLink($oCurarticle, $addParam)));
                $text .= $this->getEntryValue("g:price", $price = $this->getArticlePrice($oCurarticle, $netPrice) . " EUR");
                $text .= $this->getEntryValue("g:condition", ($googlem->exonn_googlem__acondition->value != "" ? $googlem->exonn_googlem__acondition->value : 'new' ));
                $text .= $this->getEntryValue("g:availability", $avail);


                /**
                 * Hier wird eine andere Beschreibung für den Kunden genutzt, je nach gesetzter Option...
                 */
                if($myConfig->getConfigParam("EXONN_SENGINES_METATAGS_DESCRIPTION"))
                {
                    // lese oxobject2seodata zum artikel...

                    $seoMetaTagsDescriptionQuery =
                        '
                        SELECT 
                                oxdescription
                        FROM
                                oxobject2seodata
                        WHERE
                                oxobjectid = '. oxDb::getDb()->quote($oCurarticle->oxarticles__oxid->value).'
                    
                        ';

                    $seoMetaTagsDescriptionResult = oxDb::getDB()->getAll($seoMetaTagsDescriptionQuery);

                    $value = $seoMetaTagsDescriptionResult[0][0];
                    $value = (strip_tags($value));
                    $value = str_replace("\t", "", $value);
                    $value = preg_replace('!\s+!', ' ', $value);
                }
                else
                {
                    $value = str_replace("&nbsp;", " ", $oCurarticle->getLongDesc());
                    $value = (strip_tags($value));
                    $value = str_replace("\t", "", $value);
                    $value = preg_replace('!\s+!', ' ', $value);
                }

                $value = $this->encode($value, 4000);

                $text .= $this->getEntryValue("description", $value);

                $text .= $this->getEntryValue("g:product_type", $this->getCat($oCurarticle));
                $text .= $this->getEntryValue("g:google_product_category", $this->encode(html_entity_decode($googlecat = $this->getGoogleCat($oCurarticle))));

                $identifier_exists = 3;
                if ($value = $oCurarticle->oxarticles__oxean->value) {
                    $text .= $this->getEntryValue("g:gtin", $value);
                } else {
                    if ($googlecat == "Medien" || $googlecat == "Software" || $googlecat == "Media" || $googlecat == "Médias" || $googlecat == "Logiciels") {
                      $identifier_exists = 0;
                    } else $identifier_exists--;

                    if ($this->exportMode == "csv") {
                        $text .= $this->getEntryValue("", "");
                    }
                }
                if ($value = $oCurarticle->oxarticles__oxmpn->value) {
                    $text .= $this->getEntryValue("g:mpn", $value);
                } else {
                    $identifier_exists--;

                    if ($this->exportMode == "csv") {
                        $text .= $this->getEntryValue("", "");
                    }
                }
                 
                $manufacturer = $oCurarticle->getManufacturer();
                if ($manufacturer && ($value = $this->encode($manufacturer->oxmanufacturers__oxtitle->value))) {
                    $text .= $this->getEntryValue("g:brand", $value);
                } else {
                    $identifier_exists--;

                    if ($this->exportMode == "csv") {
                        $text .= $this->getEntryValue("", "");
                    }
                }    
                      
                    
                if ($identifier_exists < 2) {
                    $text .= $this->getEntryValue("g:identifier_exists", 'FALSE');
                } elseif ($this->exportMode == "csv") {
                    $text .= $this->getEntryValue("", "");
                }


                $text .= $this->getEntryValue("g:image_link", $this->getPictureUrl($oCurarticle, 1));

                if($myConfig->getConfigParam("EXONN_SENGINES_ONE_IMAGE_ONLY") === false)
                {
                    $text .= $this->getEntryValue("g:image_link", $this->getPictureUrl($oCurarticle, 2));
                    $text .= $this->getEntryValue("g:image_link", $this->getPictureUrl($oCurarticle, 3));
                    $text .= $this->getEntryValue("g:image_link", $this->getPictureUrl($oCurarticle, 4));
                }

                if (!$myConfig->getConfigParam("EXONN_SENGINES_OFF_SHIPPING") || $googlem->exonn_googlem__useshipping->value) {
                    $j = 1;
                    if (is_array($items = $this->getDeliv($oCurarticle, $countryIsoAlpha2)))
                    {

//                        if($_SERVER['REMOTE_ADDR'] == "79.213.57.123")
//                        {
//                            echo __FILE__ . " : " . __LINE__ ."\n";
//                            echo "<pre>";
//                            print_r($items);
//                            echo "</pre>";
////                            die();
//                        }


                        foreach ($items as $inc)
                        {
                            if ($inc['country'])
                            {
                                if ($this->exportMode == "csv")
                                {
                                    if ($j < 9) {
                                        $text .= $this->getEntryValue("", $inc['country']);
                                        $text .= $this->getEntryValue("", $this->encode($inc['title']));
                                        $text .= $this->getEntryValue("", $inc['sum'] . ' EUR');
                                    }
                                    $j++;
                                }
                                else
                                {
                                    $text .= '
                                  <g:shipping>
                                    <g:country>' . $inc['country'] . '</g:country>
                                    <g:service>' . $this->encode($inc['title']) . '</g:service>
                                    <g:price>' . $inc['sum'] . ' EUR</g:price>
                                  </g:shipping>';
                                }

                            }
                        }
                    }
                }

                if($this->exportMode == "csv") {
                    while ($j < 9) {
                        $text .= $this->getEntryValue("g:country", "");
                        $text .= $this->getEntryValue("g:service", "");
                        $text .= $this->getEntryValue("g:price", "");
                        $j++;
                    }
                }

                $text .= $this->getEntryValue("g:shipping_weight", $this->getProductWeight($oCurarticle));
                $variantNames = "";
                $groupId = "";
                if (trim($parentId = $oCurarticle->oxarticles__oxparentid->value)) {
                    $variantNames = oxDb::getDb()->getOne("select oxvarname from oxarticles where oxid='".$parentId."'");
                    $groupId = oxDb::getDb()->getOne("select oxartnum from oxarticles where oxid='".$parentId."'");
                }

                if (!($value = $googlem->exonn_googlem__color->value)) {
                    $value = $this->getVarValue("EXONN_SENGINES_VARCOLOR", $oCurarticle, $variantNames);
                }
                $text .= $this->getEntryValue("g:color", $this->encode($value));

                if (!($value = $googlem->exonn_googlem__size->value)) {
                    $value = $this->getVarValue("EXONN_SENGINES_VARSIZE", $oCurarticle, $variantNames);
                }
                $text .= $this->getEntryValue("g:size", $this->encode($value));

                if (!($value = $googlem->exonn_googlem__material->value)) {
                    $value = $this->getVarValue("EXONN_SENGINES_VARMATERIAL", $oCurarticle, $variantNames);
                }
                $text .= $this->getEntryValue("g:material", $this->encode($value));

                if (!($value = $googlem->exonn_googlem__pattern->value)) {
                    $value = $this->getVarValue("EXONN_SENGINES_VARPATTERN", $oCurarticle, $variantNames);
                }
                $text .= $this->getEntryValue("g:pattern", $this->encode($value));

                if($this->exportMode != "csv") {

                    if ($value = $googlem->exonn_googlem__sale_price->value) {
                        $text .= '
                    <g:sale_price>' . $value . ' EUR</g:sale_price>';
                    }

                    if ($googlem->exonn_googlem__sale_price_effective_date1->value && $googlem->exonn_googlem__sale_price_effective_date2->value) {
                        if ($value = ($googlem->exonn_googlem__sale_price_effective_date1->value . "/" . $googlem->exonn_googlem__sale_price_effective_date2->value)) {
                            $text .= '
                        <g:sale_price_effective_date>' . $value . '</g:sale_price_effective_date>';
                        }
                    }

                    if ($value = $googlem->exonn_googlem__gender->value) {
                        $text .= '
                    <g:gender>' . $value . '</g:gender>';
                    }

                    if ($value = $googlem->exonn_googlem__age_group->value) {
                        $text .= '
                    <g:age_group>' . $this->encode($value) . '</g:age_group>';
                    }

                    if ($value = $googlem->exonn_googlem__adult->value) {
                        $text .= '
                    <g:adult>TRUE</g:adult>';
                    }
                    if ($value = $googlem->exonn_googlem__adwords_grouping->value) {
                        $text .= '
                    <g:adwords_grouping>' . $this->encode($value) . '</g:adwords_grouping>';
                    }
                    if ($value = $googlem->exonn_googlem__adwords_labels->value) {
                        $arr = explode(";", $value);
                        foreach ($arr as $word) {
                            $text .= '
                        <g:adwords_labels>' . $this->encode($word) . '</g:adwords_labels>';
                        }
                    }
                    if ($value = $googlem->exonn_googlem__adwords_redirect->value) {
                        $text .= '
                    <g:adwords_redirect>' . urlencode($value) . '</g:adwords_redirect>';
                    }

                    // Grundpreis aus Tab übernehmen
                    if ($value = $googlem->exonn_googlem__unit_pricing_measure->value)
                    {
                        $text .= '<g:unit_pricing_measure>' . $this->encode($value) . '</g:unit_pricing_measure>';
                    }
                    // Grundpreis über Shopfunktion ermitteln
                    else
                    {
                        if($oCurarticle->oxarticles__oxunitquantity->value && $oCurarticle->oxarticles__oxunitname->value)
                        {
                            // falls unitname standardwerte beinhaltete, muss es angepasst werden
                            if(substr($oCurarticle->oxarticles__oxunitname->value, 0, 1) == "_")
                            {
                                $measureUnit = \OxidEsales\Eshop\Core\Registry::getLang()->translateString($oCurarticle->oxarticles__oxunitname->value, $langId);

                                $measureUnitAmount = $oCurarticle->oxarticles__oxunitquantity->value;

                            }
                            else
                            {
                                $measureUnit = preg_replace("([0-9 ]+)", "", $oCurarticle->oxarticles__oxunitname->value);

                                $measureStringLength = strlen($oCurarticle->oxarticles__oxunitname->value);

                                $measureUnitLength = strlen($measureUnit);


                                $measureUnitAmount = (substr($oCurarticle->oxarticles__oxunitname->value, 0, ($measureStringLength-$measureUnitLength)) * $oCurarticle->oxarticles__oxunitquantity->value);



                            }


                            $unit_pricing_measure = '<g:unit_pricing_measure>' . $this->encode(($measureUnitAmount)."".$measureUnit) . '</g:unit_pricing_measure>';







//                            echo '$oCurarticle->oxarticles__oxunitname->value: '.$oCurarticle->oxarticles__oxunitname->value.'<br>';
//                            echo '$oCurarticle->oxarticles__oxunitquantity->value: '.$oCurarticle->oxarticles__oxunitquantity->value.'<br>';
//                            echo '$measureUnit: '.$measureUnit.'<br>';
//                            echo '$measureUnitAmount: '.$measureUnitAmount.'<br>';
//                            echo '$measureStringLength: '.$measureStringLength.'<br>';
//                            echo '$measureUnitLength: '.$measureUnitLength.'<br><br><br>';
//                            echo '$unit_pricing_measure: '.$unit_pricing_measure.'<br>';

                            $text .= $unit_pricing_measure;
                        }
                    }

                    // Grundpreis einheit über tab
                    if ($value = $googlem->exonn_googlem__unit_pricing_base_measure->value) {
                        $text .= '<g:unit_pricing_base_measure>' . $this->encode($value) . '</g:unit_pricing_base_measure>';
                    }
                    // Grundpreis einheit über shop funktion
                    else
                    {
                        if($oCurarticle->oxarticles__oxunitname->value)
                        {
                            $text .= '<g:unit_pricing_base_measure>' . $this->encode(str_replace(" ", "",$oCurarticle->oxarticles__oxunitname->value)) . '</g:unit_pricing_base_measure>';
                        }
                    }

                    if ($value = $googlem->exonn_googlem__energy_efficiency_class->value) {
                        $text .= '
                    <g:energy_efficiency_class>' . $this->encode($value) . '</g:energy_efficiency_class>';
                    }

                    if ($value = $googlem->exonn_googlem__multipack->value) {
                        $text .= '
                    <g:multipack>' . $this->encode($value) . '</g:multipack>';
                    }

                    if ($value = $googlem->exonn_googlem__custom_label_0->value) {
                        $text .= '
                    <g:custom_label_0>' . $this->encode($value) . '</g:custom_label_0>';
                    }

                    if ($value = $googlem->exonn_googlem__custom_label_1->value) {
                        $text .= '
                    <g:custom_label_1>' . $this->encode($value) . '</g:custom_label_1>';
                    }

                    if ($value = $googlem->exonn_googlem__custom_label_2->value) {
                        $text .= '
                    <g:custom_label_2>' . $this->encode($value) . '</g:custom_label_2>';
                    }

                    if ($value = $googlem->exonn_googlem__custom_label_3->value) {
                        $text .= '
                    <g:custom_label_3>' . $this->encode($value) . '</g:custom_label_3>';
                    }
                    if ($value = $googlem->exonn_googlem__custom_label_4->value) {
                        $text .= '
                    <g:custom_label_4>' . $this->encode($value) . '</g:custom_label_4>';
                    }
                }

                if (!($value = $googlem->exonn_googlem__item_group_id->value)) {
                    $value = $groupId;
                }
                $text .= $this->getEntryValue("g:item_group_id",$this->encode($value));

                $oCurarticle->exonncleanup();
                unset($oCurarticle);
                $googlem->cleanup();
                unset($googlem);
               
                
                if($this->exportMode != "csv") {
                    $text .= '
                </entry>';
                    $text .= "<!-- $rfrom: $i (" . memory_get_usage() . ")-->";
                } else {
                    $text .= PHP_EOL;
                }

                fwrite($f, $text);
                $text = '';
            }
            $i++;
            if ($i % 50 == 0) {
                oxRegistry::getUtils()->writeToLog( "exported article $i \r\n", 'EXONN_SENGINES_LOG.txt' );
                oxRegistry::getUtils()->writeToLog( number_format(memory_get_usage(), 0, '.', ' ') . " \r\n", 'EXONN_SENGINES_LOG.txt' );
            }

            if ($rfrom - $at + $i >= $rto * $maxRepeat) break;
            if ($i == $rto) {
                header("Location: ". $url."/index.php?cl=exonn_sengines_export  &fnc=google_xml&rfrom=".($rfrom + $rto)
                       ."&rto=".$rto."&at=".$at."&idx=".$idx."&continue=" . $continue
                       . ($_REQUEST["time_limit"] ? "&time_limit=1" : "")
                       . ($_REQUEST["memory_limit"] ? "&memory_limit=$memory_limit" : "")
                       . ($_REQUEST["csv"] ? "&csv=1" : ""));
                exit;
            }  
        }
        if($this->exportMode != "csv") {
            $text .= '
            </feed>';
        }
        fwrite($f, $text);
        echo 'Convert complete for: '.$countryIsoAlpha2 .' - '. ($rfrom + $i - $at) . ' articles. File: <a href="' . $url . '/export/'.$fileName.'">'.$fileName.'</a><br>';

        }


        die;
    }
}

