<?php


class exonn_cb_main extends oxUBase
{
    public function render() {


        return "snippets.tpl";
    }

    public function saveimage() {

        //Specify url path
        $myConfig = $this->getConfig();
        $path =  $myConfig->getConfigParam( 'sShopDir' ) . 'out/pictures/promo/';

        //Read image
        $count = $_REQUEST['count'];
        $b64str = $_REQUEST['hidimg-' . $count];
        $imgname = $_REQUEST['hidname-' . $count];
        $imgtype = $_REQUEST['hidtype-' . $count];

        //Generate random file name here
        if($imgtype == 'png'){
            $image = $imgname . '-' . base_convert(rand(),10,36) . '.png';
        } else {
            $image = $imgname . '-' . base_convert(rand(),10,36) . '.jpg';
        }

        //Save image

        $success = file_put_contents($path . $image, base64_decode($b64str));

        if ($success === FALSE) {
          if (!file_exists($path)) {
            echo "<html><body onload=\"alert('Saving image to folder failed. Folder ".$path." not exists.')\"></body></html>";
          } else {
            echo "<html><body onload=\"alert('Saving image to folder failed. Please check write permission on " .$path. "')\"></body></html>";
          }

        } else {
            $path =  $myConfig->getConfigParam( 'sShopURL' ) . '/out/pictures/promo/';
          //Replace image src with the new saved file
          echo "<html><body onload=\"parent.document.getElementById('img-" . $count . "').setAttribute('src','" . $path . $image . "');  parent.document.getElementById('img-" . $count . "').removeAttribute('id'); parent.document.getElementById('aimg-" . $count . "').setAttribute('href','" . $path . $image . "');  parent.document.getElementById('aimg-" . $count . "').removeAttribute('id') \"></body></html>";
        }
        exit;
    }

    public function save() {
        /**
         * @var $content oxcontent
         */
        $oUser = $this->getUser();
        if ($oUser && $oUser->oxuser__oxrights->value == 'malladmin') {
            $html = stripcslashes($_POST['cb_content']);
            $place = $_POST['cb_place'];
            $cmsid = $_POST["cmsid"];

            $myConfig = $this->getConfig();
            if (!$myConfig->isUtf()) {
                $html = mb_convert_encoding($html, "ISO-8859-1", "UTF-8");
            }
            $db = oxDb::getDb();
            $cbid = ($cmsid ? $cmsid : "start") . "_" . $place;

            $oShopId=$this->getConfig()->getShopId();
            $oxid = $db->getOne("select oxid from cb_contents where oxshopid=".oxDb::getDb()->quote($oShopId)." && cbid = '".$cbid."'");
            $cb_content = oxNew("exonn_cb_content");

            $oLang = oxRegistry::getLang();
            $langId = $oLang->getEditLanguage();

            if ($oxid) {
                $cb_content->load($oxid);
            }
            $cb_content->cb_contents__cbid = new oxField($cbid);

            if ($langId == 0 || $langId == -1) {
                $cb_content->cb_contents__content = new oxField($html,1);
            } elseif ($langId == 1) {
                $cb_content->cb_contents__content_1 = new oxField($html, 1);
            } elseif ($langId == 2) {
                $cb_content->cb_contents__content_2 = new oxField($html, 1);
            } elseif ($langId == 3) {
                $cb_content->cb_contents__content_3 = new oxField($html, 1);
            }

            $cb_content->save();
        }
        echo "saved";
        exit();
    }

    public function saveCat() {
        /**
         * @var $content oxcontent
         */
        $oUser = $this->getUser();
        oxRegistry::getUtils()->writeToLog( '-----------', 'EXCEPTION_LOG.txt' );
        if ($oUser && $oUser->oxuser__oxrights->value == 'malladmin') {
            $html = $_POST['cb_content'];
            $cmsid = $_POST["cmsid"];

            oxRegistry::getUtils()->writeToLog( $cmsid, 'EXCEPTION_LOG.txt' );
            $myConfig = $this->getConfig();
            if (!$myConfig->isUtf()) {
                $html = mb_convert_encoding($html, "ISO-8859-1", "UTF-8");
            }
            $cat = oxNew("oxcategory");
            if ($cat->load($cmsid)) {
                $cat->oxcategories__oxlongdesc = new oxField($html);
                $cat->save();
            }
        }
    }
}