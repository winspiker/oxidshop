<?php

class csv_export extends oxUBase
{

    /** @var oxConfig */
    private $config;
    /** @var string  */
    private $stockCSVFilePath;


	public function exportCheck24Articles()
	{
		ini_set('display_errors', 1);
		ini_set('max_execution_time', 0);
		ini_set("memory_limit","900M");

		//		echo "geht los...<br>";

		$articles_filename =  $this->config->getConfigParam( 'sShopDir' )."/export/check24.csv";

		//        mail('alert@exonn.de', 'dalert mail' . __FILE__ . __LINE__, $this->stockCSVFilePath);
		//mail('alert@exonn.de', 'dalert mail' . __FILE__ . __LINE__, $articles_filename);

		//        $file = fopen($this->stockCSVFilePath,"w");
		$file = fopen($articles_filename,"w");
		$ids = $this->getArticleIdsCheck24();

		//	    echo "geht weiter...<br>";


		$devider = ";";
		// spaltennamen
		fwrite($file, "EAN;Eindeutige ID;Lieferzeit/Verfügbarkeit;Preis in Euro (inkl. MwSt);Versandkosten in Euro;Bestand;Hersteller;Kategorie im Shop;Link Produktdetailseite;Produktname;Produktbeschreibung;URL Produktbild;\n");
		$count = 1;
		foreach ($ids as $id) {
			//echo $id."<br>";
			$line = $this->getArticleDataForCsv($id);
			fputcsv($file, $line, $devider);
			$count++;
			$vars = $this->getVariantsIdsCheck24($id);
			if (count($vars)) {
				foreach ($vars as $idv) {
					$line = $this->getArticleDataForCsv($idv, $line);
					fputcsv($file, $line, $devider);
					$count++;
				}
			}
		}
		fclose($file);
		//        return $this->stockCSVFilePath;



		exit(0);
	}




	protected function getArticleDataForCsv($id, $parent = array())
	{
		echo "articleId: ".$id."<br>";

		$oArticle = oxNew("oxarticle");
		$oArticle->load($id);
		$data = array();

		echo "articleTitle: ".$oArticle->oxarticles__oxtitle->value."<br>";

		$data["productEan"] = $oArticle->oxarticles__oxean->value;
		$data["productId"] = $oArticle->oxarticles__oxartnum->value;
		$data["shippingTime"] = "sofort lieferbar";
		$data["productPrice"] = round($oArticle->oxarticles__oxprice->value*1.07, 2);
		$data["productShippingCost"] = 5.90;
		$data["productStock"] = $oArticle->oxarticles__oxstock->value;

		$manufacturer = oxNew('oxmanufacturer');
		$manufacturer->load($oArticle->oxarticles__oxmanufacturerid->value);

		echo "manufacturerId: ".$oArticle->oxarticles__oxmanufacturerid->value."<br>";

		$data["productManufacturer"] = $manufacturer->oxmanufacturers__oxtitle->value;

		$categoryQuery =
		'
			SELECT oxcatnid FROM
				oxobject2category
			WHERE
				oxobjectid = ?
		';

		$categoryId = oxDb::getDb()->getOne($categoryQuery, [$oArticle->oxarticles__oxid->value]);

		$category = oxNew('oxcategory');
		$category->load($categoryId);

		$data["productShopCategory"] = str_replace([";","\""], "", html_entity_decode($category->oxcategories__oxtitle->value));

		$data["productDetailPage"] = $oArticle->getLink();;
		$data["productName"] = str_replace([";","\""], "",html_entity_decode($oArticle->oxarticles__oxtitle->value));
		$data["productDescription"] = str_replace([";","\""], "",html_entity_decode($oArticle->oxarticles__oxtitle->value));

//		$data["productDescription"] = str_replace(";", "",$oArticle->oxarticles__oxshortdesc->value);
		$data["productImageUrl"] = $oArticle->getMasterZoomPictureUrl(1);;

		return $data;

//
//
//
//
//		$result["foreign_id"] = $oArticle->oxarticles__oxid->value;
//		$result["article_nr"] = $oArticle->oxarticles__oxartnum->value;
//		//$result["ean"] = $oArticle->oxarticles__oxean->value;
//		$result["title"] = $this->convert($oArticle->oxarticles__oxtitle->value);
//		$result["tax"] = $oArticle->getPrice()->getVat();
//		$result["price"] = $oArticle->oxarticles__oxprice->value;
//		$result["units"] = $oArticle->getUnitName();
//		$result["short_desc"] = $this->convert($oArticle->oxarticles__oxshortdesc->value);
//
//		if(method_exists($oArticle,"setSkipCb"))
//		{
//			$oArticle->setSkipCB();
//		}
//
//
//		if (method_exists($oArticle, "getLongDescription")) {
//			$result["long_desc"] = $this->convert($oArticle->getLongDescription());
//		} else {
//			$result["long_desc"] = $this->convert($oArticle->getArticleLongDesc());
//		}
//		$result["url"] = $oArticle->getLink();
//		if (method_exists($oArticle, "getMasterZoomPictureUrl")) {
//			$result["picture"] = $oArticle->getMasterZoomPictureUrl(1);
//			$result["picture2"] = $oArticle->getMasterZoomPictureUrl(2);
//			$result["picture3"] = $oArticle->getMasterZoomPictureUrl(3);
//			$result["picture4"] = $oArticle->getMasterZoomPictureUrl(4);
//			$result["picture5"] = $oArticle->getMasterZoomPictureUrl(5);
//		} else {
//			$result["picture"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic1->value;
//			$result["picture2"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic2->value;
//			$result["picture3"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic3->value;
//			$result["picture4"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic4->value;
//			$result["picture5"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic5->value;
//		}
//		if (strpos($result["picture"], "nopic") !== false) $result["picture"] = "";
//		if (strpos($result["picture2"], "nopic") !== false) $result["picture2"] = "";
//		if (strpos($result["picture3"], "nopic") !== false) $result["picture3"] = "";
//		if (strpos($result["picture4"], "nopic") !== false) $result["picture4"] = "";
//		if (strpos($result["picture5"], "nopic") !== false) $result["picture5"] = "";
//
//		$result["categories"] = $this->getCategoriesTree($oArticle->getCategory());
//		$result["stock"] = $oArticle->oxarticles__oxstock->value > 0 ? $oArticle->oxarticles__oxstock->value : 0;
//		$result["delivery_date"] = $oArticle->getDeliveryDate();
//		$result["quantity_unit"] = $oArticle->oxarticles__oxunitquantity->value;
//		$result["package_size"] = $oArticle->oxarticles__oxunitquantity->value;
//		$result["manufacturer"] = $oArticle->getManufacturer()->oxmanufacturers__oxtitle->value;
//		$result["mpn"] = $oArticle->oxarticles__oxmpn->value;
//		$result["status"] = 1;
//		$result["top_offer"] = "";
//		$result["ean"] = $oArticle->oxarticles__oxean->value;
//		$result["master_flag"] = $oArticle->isParentNotBuyable();
//		$result["master_article_id"] = $oArticle->oxarticles__oxparentid->value;
//
//		$varset = $oArticle->oxarticles__oxvarname->value;
//		$varsets = explode("|", $varset);
//		$varname = $oArticle->oxarticles__oxvarselect->value;
//		$varnames = explode("|", $varname);
//		$result["variant_set_name"] = $parent ? $parent["variant_set_name"] : $varsets[0];
//		$result["variant_title"] = $varnames[0];
//		$result["variant_set_name2"] = $parent ? $parent["variant_set_name2"] : $varsets[1];
//		$result["variant_title2"] = $varnames[1];
//		$result["variant_set_name3"] = $parent ? $parent["variant_set_name3"] : $varsets[2];
//		$result["variant_title3"] = $varnames[2];
//
//		$oArticle = oxNew("oxarticle");
//		$oArticle->loadInLang(2, $id);
//		$result["title_fr"] = $oArticle->oxarticles__oxtitle->value;
//		$result["short_desc_fr"] = $this->convert($oArticle->oxarticles__oxshortdesc->value);
//
//		if(method_exists($oArticle,"setSkipCb"))
//		{
//			$oArticle->setSkipCB();
//		}
//
//		if (method_exists($oArticle, "getLongDescription")) {
//			$result["long_desc_fr"] = $this->convert($oArticle->getLongDescription());
//		} else {
//			$result["long_desc_fr"] = $this->convert($oArticle->getArticleLongDesc());
//		}
//		$result["url_fr"] = $oArticle->getLink();
//		$varset = $oArticle->oxarticles__oxvarname->value;
//		$varsets = explode("|", $varset);
//		$varname = $oArticle->oxarticles__oxvarselect->value;
//		$varnames = explode("|", $varname);
//
//		$result["variant_set_name_fr"] = $parent ? $parent["variant_set_name_fr"] : $varsets[0];
//		$result["variant_title_fr"] = $varnames[0];
//
//		$oArticle = oxNew("oxarticle");
//		$oArticle->loadInLang(1, $id);
//		$result["title_en"] = $oArticle->oxarticles__oxtitle->value;
//		$result["short_desc_en"] = $this->convert($oArticle->oxarticles__oxshortdesc->value);
//
//		if(method_exists($oArticle,"setSkipCb"))
//		{
//			$oArticle->setSkipCB();
//		}
//
//		if (method_exists($oArticle, "getLongDescription")) {
//			$result["long_desc_en"] = $this->convert($oArticle->getLongDescription());
//		} else {
//			$result["long_desc_en"] = $this->convert($oArticle->getArticleLongDesc());
//		}
//
//		if(method_exists($oArticle,"setSkipCb"))
//		{
//			$oArticle->setSkipCB(false);
//		}
//
//		$result["url_en"] = $oArticle->getLink();
//		$varset = $oArticle->oxarticles__oxvarname->value;
//		$varsets = explode("|", $varset);
//		$varname = $oArticle->oxarticles__oxvarselect->value;
//		$varnames = explode("|", $varname);
//
//		$result["variant_set_name_en"] = $parent ? $parent["variant_set_name_en"] : $varsets[0];
//		$result["variant_title_en"] = $varnames[0];
//		$result["length"] = $oArticle->oxarticles__oxlength->value;
//		$result["width"] = $oArticle->oxarticles__oxwidth->value;
//		$result["height"] = $oArticle->oxarticles__oxheight->value;

		return $result;
	}








    protected function convert($str)
    {
        //return iconv("ISO-8859-1", "UTF-8",html_entity_decode(stripslashes($str)));
        //$str = str_replace('"', '""',$str);
        $str = str_replace('|', '&#124;', $str);
        $str = str_replace("\r\n", '', $str);
        return $str;
    }

    protected function getArticlesIds() {
        $oDb = oxDb::getDb();
        $rs = $oDb->getAll("select oxid from oxarticles where oxparentid='' and oxactive=1 order by oxartnum");
        $result = array();
        if ($rs != false && count($rs) > 0)
        foreach($rs as $r) {
            $result[] = $r[0];
        }

        return $result;
    }

	protected function getArticleIdsCheck24() {
		$oDb = oxDb::getDb();

		// Artikel aus bestimmten Kategorien ausschließen
		// # Autoreifen, Schmuck, Lebensmittel, B-Ware
		$excludeCategoryResult = $oDb->getAll("select oxid from oxcategories where oxtitle like '%reifen%' or oxtitle like '%schmuck%' or oxtitle like '%b-ware%' or oxtitle like '%lebensmittel%'");


		$excludeCategories = [];

		foreach($excludeCategoryResult as $res)
		{
			$excludeCategories[] = $res[0];
		}




		$exclude = join("','",$excludeCategories);

		$exclude = "'".$exclude."'";


		$resultExclude = $oDb->getAll("select distinct oa.oxid from oxobject2category o2c left join oxarticles oa on oa.oxid = o2c.oxobjectid where o2c.oxcatnid in (".$exclude.") and oa.oxparentid='' and oa.oxactive=1 and oa.oxstock>0 and oa.oxean != '' and oa.oxean != 'None' order by oxartnum");


		$excludeCategories = [];

		foreach($resultExclude as $res)
		{
			$excludeCategories[] = $res[0];
		}

		$resultExclude = join("','",$excludeCategories);

		$resultExclude = "'".$resultExclude."'";

		$resultExclude = '\'asb\'';


		$rs = $oDb->getAll("select oxid from oxarticles where oxid not in (".$resultExclude.") and oxparentid='' and oxactive=1 and oxstock>0 and oxean != '' and oxean != 'None' order by oxartnum");


//		$rs = $oDb->getAll("select oxid from oxarticles where oxparentid='' and oxactive=1 and oxstock>0 and oxean != '' and oxean != null order by oxartnum");
		$result = array();
		if ($rs != false && count($rs) > 0)
			foreach($rs as $r) {
				$result[] = $r[0];
			}

		return $result;
	}


    protected function getArticlesGermesIds() {
        $oDb = oxDb::getDb();
        $rs = $oDb->getAll("select oxid from oxarticles where oxottoartnumnew!='' and oxactive=1");
        $result = array();
        if ($rs != false && count($rs) > 0)
	        foreach($rs as $r) {
            $result[] = $r[0];
        }

        return $result;
    }


    protected function getVariantsIds($parentId) {
        $oDb = oxDb::getDb();
        $rs = $oDb->getAll($q = "select oxid from oxarticles where oxparentid='".$parentId."' and oxactive=1 order by oxartnum");
        $result = array();
        if ($rs != false && count($rs) > 0)
        foreach($rs as $r) {
            $result[] = $r[0];
        }
        return $result;
    }

	protected function getVariantsIdsCheck24($parentId) {
		$oDb = oxDb::getDb();
		$rs = $oDb->getAll($q = "select oxid from oxarticles where oxparentid='".$parentId."' and oxactive=1 and oxstock>0 and oxean != '' and oxean != 'None' order by oxartnum");
		$result = array();
		if ($rs != false && count($rs) > 0)
			foreach($rs as $r) {
				$result[] = $r[0];
			}
		return $result;
	}

    protected function getCategoriesTree($cat) {
       $kategory = $cat->oxcategories__oxtitle->value;

        if ($cat)
            while ($cat && $cat->oxcategories__oxparentid->value != 'oxrootid')
            {
                $cat = $cat->getParentCategory();
                $kategory = $cat->oxcategories__oxtitle->value . ' > ' . $kategory;

            }

        return $this->convert($kategory);
    }

    protected function articleToArray($id, $parent = array()) {
        $oArticle = oxNew("oxarticle");
        $oArticle->load($id);
        $result = array();
        $result["foreign_id"] = $oArticle->oxarticles__oxid->value;
        $result["article_nr"] = $oArticle->oxarticles__oxartnum->value;
        //$result["ean"] = $oArticle->oxarticles__oxean->value;
        $result["title"] = $this->convert($oArticle->oxarticles__oxtitle->value);
        $result["tax"] = $oArticle->getPrice()->getVat();
        $result["price"] = $oArticle->oxarticles__oxprice->value;
        $result["units"] = $oArticle->getUnitName();
        $result["short_desc"] = $this->convert($oArticle->oxarticles__oxshortdesc->value);

		if(method_exists($oArticle,"setSkipCb"))
		{
			$oArticle->setSkipCB();
		}


        if (method_exists($oArticle, "getLongDescription")) {
            $result["long_desc"] = $this->convert($oArticle->getLongDescription());
        } else {
            $result["long_desc"] = $this->convert($oArticle->getArticleLongDesc());
        }
        $result["url"] = $oArticle->getLink();
        if (method_exists($oArticle, "getMasterZoomPictureUrl")) {
            $result["picture"] = $oArticle->getMasterZoomPictureUrl(1);
            $result["picture2"] = $oArticle->getMasterZoomPictureUrl(2);
            $result["picture3"] = $oArticle->getMasterZoomPictureUrl(3);
            $result["picture4"] = $oArticle->getMasterZoomPictureUrl(4);
            $result["picture5"] = $oArticle->getMasterZoomPictureUrl(5);
        } else {
             $result["picture"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic1->value;
            $result["picture2"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic2->value;
            $result["picture3"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic3->value;
            $result["picture4"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic4->value;
            $result["picture5"] = $this->config->getConfigParam('sShopURL') . "out/pictures/" . $oArticle->oxarticles__oxpic5->value;
        }
        if (strpos($result["picture"], "nopic") !== false) $result["picture"] = "";
        if (strpos($result["picture2"], "nopic") !== false) $result["picture2"] = "";
        if (strpos($result["picture3"], "nopic") !== false) $result["picture3"] = "";
        if (strpos($result["picture4"], "nopic") !== false) $result["picture4"] = "";
        if (strpos($result["picture5"], "nopic") !== false) $result["picture5"] = "";

        $result["categories"] = $this->getCategoriesTree($oArticle->getCategory());
        $result["stock"] = $oArticle->oxarticles__oxstock->value > 0 ? $oArticle->oxarticles__oxstock->value : 0;
        $result["delivery_date"] = $oArticle->getDeliveryDate();
        $result["quantity_unit"] = $oArticle->oxarticles__oxunitquantity->value;
        $result["package_size"] = $oArticle->oxarticles__oxunitquantity->value;
        $result["manufacturer"] = $oArticle->getManufacturer()->oxmanufacturers__oxtitle->value;
        $result["mpn"] = $oArticle->oxarticles__oxmpn->value;
        $result["status"] = 1;
        $result["top_offer"] = "";
        $result["ean"] = $oArticle->oxarticles__oxean->value;
        $result["master_flag"] = $oArticle->isParentNotBuyable();
        $result["master_article_id"] = $oArticle->oxarticles__oxparentid->value;
        
        $varset = $oArticle->oxarticles__oxvarname->value;
        $varsets = explode("|", $varset);
        $varname = $oArticle->oxarticles__oxvarselect->value;
        $varnames = explode("|", $varname);
        $result["variant_set_name"] = $parent ? $parent["variant_set_name"] : $varsets[0];
        $result["variant_title"] = $varnames[0];
        $result["variant_set_name2"] = $parent ? $parent["variant_set_name2"] : $varsets[1];
        $result["variant_title2"] = $varnames[1];
        $result["variant_set_name3"] = $parent ? $parent["variant_set_name3"] : $varsets[2];
        $result["variant_title3"] = $varnames[2];

        $oArticle = oxNew("oxarticle");
        $oArticle->loadInLang(2, $id);
        $result["title_fr"] = $oArticle->oxarticles__oxtitle->value;
        $result["short_desc_fr"] = $this->convert($oArticle->oxarticles__oxshortdesc->value);

	    if(method_exists($oArticle,"setSkipCb"))
	    {
		    $oArticle->setSkipCB();
	    }

        if (method_exists($oArticle, "getLongDescription")) {
            $result["long_desc_fr"] = $this->convert($oArticle->getLongDescription());
        } else {
            $result["long_desc_fr"] = $this->convert($oArticle->getArticleLongDesc());
        }
        $result["url_fr"] = $oArticle->getLink();
        $varset = $oArticle->oxarticles__oxvarname->value;
        $varsets = explode("|", $varset);
        $varname = $oArticle->oxarticles__oxvarselect->value;
        $varnames = explode("|", $varname);
        
        $result["variant_set_name_fr"] = $parent ? $parent["variant_set_name_fr"] : $varsets[0];
        $result["variant_title_fr"] = $varnames[0];

        $oArticle = oxNew("oxarticle");
        $oArticle->loadInLang(1, $id);
        $result["title_en"] = $oArticle->oxarticles__oxtitle->value;
        $result["short_desc_en"] = $this->convert($oArticle->oxarticles__oxshortdesc->value);

	    if(method_exists($oArticle,"setSkipCb"))
	    {
		    $oArticle->setSkipCB();
	    }

        if (method_exists($oArticle, "getLongDescription")) {
            $result["long_desc_en"] = $this->convert($oArticle->getLongDescription());
        } else {
            $result["long_desc_en"] = $this->convert($oArticle->getArticleLongDesc());
        }

	    if(method_exists($oArticle,"setSkipCb"))
	    {
		    $oArticle->setSkipCB(false);
	    }

        $result["url_en"] = $oArticle->getLink();
        $varset = $oArticle->oxarticles__oxvarname->value;
        $varsets = explode("|", $varset);
        $varname = $oArticle->oxarticles__oxvarselect->value;
        $varnames = explode("|", $varname);
        
        $result["variant_set_name_en"] = $parent ? $parent["variant_set_name_en"] : $varsets[0];
        $result["variant_title_en"] = $varnames[0];
        $result["length"] = $oArticle->oxarticles__oxlength->value;
        $result["width"] = $oArticle->oxarticles__oxwidth->value;
        $result["height"] = $oArticle->oxarticles__oxheight->value;

        return $result;
    }

    protected function getDiscountPrice($priceField, $oArticle, $brutto = false) {
        $sVarName = "oxarticles__" . $priceField;
        $dPrice = $oArticle->$sVarName->value;
        $oPrice = oxNew("oxPrice");
        $oPrice->setPrice($dPrice);
        $oArticle->applyDiscountsForVariant($oPrice);
        return $brutto ? $oPrice->getBruttoPrice() : $oPrice->getNettoPrice();
    }

    protected function articlePricesToArray($id, $parent = array()) {
        $oArticle = oxNew("oxarticle");
        $oArticle->load($id);
        $result = array();
        $result["article_nr"] = $oArticle->oxarticles__oxartnum->value;
        $result["title"] = $this->convert($oArticle->oxarticles__oxtitle->value);
        $result["ean"] = $oArticle->oxarticles__oxean->value;

        $price = "";
        if ($dPrice = $oArticle->oxarticles__oxprice->value) {
            $oPrice = oxNew("oxPrice");
            $oPrice->setPrice($dPrice);
            $price = $oPrice->getNettoPrice();
        }

        $result["pricec"] = $this->getDiscountPrice("oxpricec", $oArticle);
        $result["priceuvp"] = $price;

        return $result;
    }

    protected function articleToGermesArray($id, $parent = array()) {
        $oArticle = oxNew("oxarticle");
        $oArticle->load($id);
        $result = array();
        $result["HDR1"] = "DATA";
        $result["01 LIEF_NR"] = "082067";
        $result["02 LIEF_UNTER_NR_KZ"] = "53";
        $result["03 BDF_KZ"] = "0";
        $result["04 ARTIKEL_NR"] = $oArticle->oxarticles__oxottoartnumnew->value;
        $result["05 GROESSE"] = "0";
        $result["07 ITEM_OPT_SUP_COM_KEY"] = $oArticle->oxarticles__oxottoartnumkey->value;
        $parentTitle = oxDb::getDb()->getOne("select oxtitle from oxarticles where oxid = '" . $oArticle->oxarticles__oxparentid->value . "'");


        $result["06 BEZEICHNUNG"] = str_replace("&amp;", "und", str_replace("|", "/", $parentTitle
                ? $this->convert($parentTitle) . " - " . $oArticle->oxarticles__oxvarselect->value
                : $this->convert($oArticle->oxarticles__oxtitle->value)));
        $result["08 LIEFERBARER_BESTAND"] = 0;
        $result["09 VERARBEITET_AM"] = date("YmdHis");
        $result["10 ERFASSTER_BESTAND"] = 0;
        $result["11 ERFASST_AM"] = date("YmdHis");
        $stock = $oArticle->oxarticles__oxstock->value - $oArticle->oxarticles__oxstock_reserve->value - 3;
        $result["13 BESTAND_UPLOAD"] = $stock > 0 ? $stock : 0;
        $result["12 BEDARF"] = 0;

        return $result;
    }

    /**
     * Generate Articvles.csv and return this file
     *
     * @return /export/Haendlernetzwerk/CSV/articles.csv
     */
    public function csv_do_export()
    {   //oxUtils::getInstance()->writeToLog("csv_do_export", 'EXPORT_LOG.txt');
        ini_set('display_errors', 1);
        ini_set('max_execution_time', 0);
        ini_set("memory_limit","900M");

//		echo "geht los...<br>";

        $articles_filename =  $this->config->getConfigParam( 'sShopDir' )."/export/Haendlernetzwerk/CSV/articles.csv";

//        mail('alert@exonn.de', 'dalert mail' . __FILE__ . __LINE__, $this->stockCSVFilePath);
        //mail('alert@exonn.de', 'dalert mail' . __FILE__ . __LINE__, $articles_filename);

//        $file = fopen($this->stockCSVFilePath,"w");
        $file = fopen($articles_filename,"w");
        $ids = $this->getArticlesIds();

//	    echo "geht weiter...<br>";


        $devider = "|";
        fwrite($file, 'foreign_id|"article_nr"|"title"|"tax"|"price"|"units"|"short_desc"|"long_desc"|"url"|"picture"|"picture2"|"picture3"|"picture4"|"picture5"|"categories"|"stock"|"delivery_date"|"quantity_unit"|"package_size"|"manufacturer"|"mpn"|"status"|"top_offer"|"ean"|"master_flag"|"master_article_id"|"variant_set_name"|"variant_title"|"variant_set_name2"|"variant_title2"|"variant_set_name3"|"variant_title3"|"title_fr"|"short_desc_fr"|"long_desc_fr"|"url_fr"|"variant_set_name_fr"|"variant_title_fr"|"title_en"|"short_desc_en"|"long_desc_en"|"url_en"|"variant_set_name_en"|"variant_title_en"|"length"|"width"|"height"'."\r\n");
        //fwrite($file, 'foreign_id|"article_nr"|"ean"|"title"|"tax"|"price"|"units"|"short_desc"|"long_desc"|"url"|"picture"|"picture2"|"picture3"|"picture4"|"picture5"|"categories"|"stock"|"delivery_date"|"quantity_unit"|"package_size"|"manufacturer"|"mpn"|"status"|"top_offer"|"ean"|"master_flag"|"master_article_id"|"variant_set_name"|"variant_title"|"variant_set_name2"|"variant_title2"|"variant_set_name3"|"variant_title3"'."\r\n");
        $count = 1;
        foreach ($ids as $id) {
            //echo $id."<br>";
            $line = $this->articleToArray($id);
            fputcsv($file, $line, $devider);
            $count++;
            $vars = $this->getVariantsIds($id);
            if (count($vars)) {
               foreach ($vars as $idv) {
                   $line = $this->articleToArray($idv, $line);
                   fputcsv($file, $line, $devider);
                   $count++;
               }
            }
        }
        fclose($file);
//        return $this->stockCSVFilePath;



		exit(0);

        return $articles_filename;
    }

    public function csv_do_export_handler_prices($userId, $xls)
    {   //oxUtils::getInstance()->writeToLog("csv_do_export", 'EXPORT_LOG.txt');
        ini_set('display_errors', 1);
        ini_set('max_execution_time', 0);
        ini_set("memory_limit","900M");


         $dir = $this->config->getConfigParam( 'sShopDir' )."/export/Haendlernetzwerk/CSV/" . $userId;
        if (!file_exists($dir)) {
            mkdir($dir, 0777, true);
        }

        $result = $dir . "/prices.csv";

        $file = fopen($result,"w");
        $ids = $this->getArticlesIds();
        $devider = "|";
        fwrite($file, 'Art. No.|Titel|EAN|HEK|UVP'."\r\n");
        $count = 1;
        foreach ($ids as $id) {
            //echo $id."<br>";
            $line = $this->articlePricesToArray($id);

            $vars = $this->getVariantsIds($id);
            if (count($vars)) {
               foreach ($vars as $idv) {
                   $line = $this->articlePricesToArray($idv, $line);
                   fputcsv($file, $line, $devider);
                   $count++;
               }
            } else {
                fputcsv($file, $line, $devider);
                $count++;
            }
        }
        fclose($file);

        if($xls) {
            require_once dirname(__FILE__) . '/../PHPExcel/Classes/PHPExcel/IOFactory.php';

            $objReader = PHPExcel_IOFactory::createReader('CSV');

            // If the files uses a delimiter other than a comma (e.g. a tab), then tell the reader
            $objReader->setDelimiter("|");
            // If the files uses an encoding other than UTF-8 or ASCII, then tell the reader
            //$objReader->setInputEncoding('ISO-8859-1');

            $objPHPExcel = $objReader->load($result);
            $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
            $objWriter->save($result = $dir . "/prices.xls");
        }

        //echo $count;
        return $result;
    }

    public function csv_do_export_germes()
    {
        ini_set('display_errors', 1);
        ini_set('max_execution_time', 0);
        ini_set("memory_limit","900M");


        $file = fopen($fpath = $this->config->getConfigParam( 'sShopDir' )."/export/UPLOAD_BESTAENDE.csv","w");
        $ids = $this->getArticlesGermesIds();
        $devider = "|";
        $columns = 'HDR1|01 LIEF_NR|02 LIEF_UNTER_NR_KZ|03 BDF_KZ|04 ARTIKEL_NR|05 GROESSE|06 BEZEICHNUNG|07 ITEM_OPT_SUP_COM_KEY|08 LIEFERBARER_BESTAND|09 VERARBEITET_AM|10 ERFASSTER_BESTAND|11 ERFASST_AM|12 BEDARF|13 BESTAND_UPLOAD';
        $carr = explode("|", $columns);

        fwrite($file, "HDR0|UPLOAD_BESTAENDE.txt|" . date("d.m.Y H:i") ."\r\n");
        fwrite($file, $columns ."\r\n");
        $count = 0;
        foreach ($ids as $id) {
            $count++;

            $line = $this->articleToGermesArray($id);
            $trueLine = array();
            foreach ($carr as $key => $field) {
               $trueLine[$field] = $line[$field];
            }
            fputcsv($file, $trueLine, $devider);
            $eol = "\r\n";
            if("\n" != $eol && 0 === fseek($file, -1, SEEK_CUR)) {
                fwrite($file, $eol);
            }
        }
        fwrite($file, "TRL0|$count");
        fclose($file);
        //echo $count;

        $this->uploadGermesFile($fpath);
        return 1;
    }

    private  function uploadGermesFile($fpath) {
        //username and password of account
        $username = "082067";
        $password = "3xrI@Z6Xd4";
        $param1 = "LOGIN=&#187;&nbsp;Login";

        //set the directory for the cookie using defined document root var
        $dir = $this->config->getConfigParam( 'sCompileDir' );

        //build a unique path with every request to store
        //the info per user with custom func.
        $path = $dir;

        //login form action url
        $url = "https://b2b.otto.de/wsi/login.do";
        $postinfo = "liefNr=".$username."&password=".$password."&".$param1;

        $cookie_file_path = $path."/cookie.txt";

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_NOBODY, false);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);

        curl_setopt($ch, CURLOPT_COOKIEJAR, $cookie_file_path);
        //set the cookie the site has for certain features, this is optional
        curl_setopt($ch, CURLOPT_COOKIE, "cookiename=0");
        curl_setopt($ch, CURLOPT_USERAGENT,
            "Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, $_SERVER['REQUEST_URI']);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 0);

        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postinfo);
        $html = curl_exec($ch);
        //print_r($html);

        //page with the content I want to grab
        curl_setopt($ch, CURLOPT_URL, "https://b2b.otto.de/wsi/Upload.do");
        //do stuff with the info with DomDocument() etc
        $html = curl_exec($ch);
        //print_r($html);
        $this->postFile($ch, $fpath);
        curl_close($ch);
    }

    private function postFile($ch, $fpath) {

        curl_setopt($ch, CURLOPT_URL, "https://b2b.otto.de/wsi/Upload.do");
        // send a file
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_SAFE_UPLOAD, false);
        curl_setopt(
            $ch,
            CURLOPT_POSTFIELDS,
            array(
              'submitBIUpload' => 'Load data',
              'uploadBIFile' => '@' . realpath($fpath) . ';filename=UPLOAD_BESTAENDE.csv'
            ));

        // output the response
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $html = curl_exec($ch);
        //print_r($html);
    }

    /*
    private function postFile($ch) {
        $myConfig = $this->getConfig();

        $file_url = $myConfig->getConfigParam( 'sShopDir' )."/export/UPLOAD_BESTAENDE.csv";  //here is the file route, in this case is on same directory but you can set URL too like "http://examplewebsite.com/test.txt"

        $eol = "\r\n"; //default line-break for mime type
        $BOUNDARY = md5(time()); //random boundaryid, is a separator for each param on my post curl function
        $BODY=""; //init my curl body
        $BODY.= '--'.$BOUNDARY. $eol; //start param header
        $BODY .= 'Content-Disposition: form-data; name="sometext"' . $eol . $eol; // last Content with 2 $eol, in this case is only 1 content.
        $BODY .= "Some Data" . $eol;//param data in this case is a simple post data and 1 $eol for the end of the data
        $BODY.= '--'.$BOUNDARY. $eol; // start 2nd param,
        $BODY.= 'Content-Disposition: form-data; name="uploadBIFile"; filename="test.txt"'. $eol ; //first Content data for post file, remember you only put 1 when you are going to add more Contents, and 2 on the last, to close the Content Instance
        $BODY.= 'Content-Type: application/octet-stream' . $eol; //Same before row
        $BODY.= 'Content-Transfer-Encoding: base64' . $eol . $eol; // we put the last Content and 2 $eol,
        $BODY.= chunk_split(base64_encode(file_get_contents($file_url))) . $eol; // we write the Base64 File Content and the $eol to finish the data,
        $BODY.= '--'.$BOUNDARY .'--' . $eol. $eol; // we close the param and the post width "--" and 2 $eol at the end of our boundary header.



        //$ch = curl_init(); //init curl
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                         'X_PARAM_TOKEN : 71e2cb8b-42b7-4bf0-b2e8-53fbd2f578f9' //custom header for my api validation you can get it from $_SERVER["HTTP_X_PARAM_TOKEN"] variable
                         ,"Content-Type: multipart/form-data; boundary=".$BOUNDARY) //setting our mime type for make it work on $_FILE variable
                    );
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/1.0 (Windows NT 6.1; WOW64; rv:28.0) Gecko/20100101 Firefox/28.0'); //setting our user agent
        curl_setopt($ch, CURLOPT_URL, "api.endpoint.post"); //setting our api post url
        curl_setopt($ch, CURLOPT_COOKIEJAR, $BOUNDARY.'.txt'); //saving cookies just in case we want
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1); // call return content
        curl_setopt ($ch, CURLOPT_FOLLOWLOCATION, 1); //navigate the endpoint
        curl_setopt($ch, CURLOPT_POST, true); //set as post
        curl_setopt($ch, CURLOPT_POSTFIELDS, $BODY); // set our $BODY


        $response = curl_exec($ch); // start curl navigation

        print_r($response); //print response

    }
    */

    /**
     * Generate stock.csv and return this file
     *
     * @return /export/Haendlernetzwerk/CSV/stock.csv
     */
    public function csv_do_export_stock()
    {   //oxUtils::getInstance()->writeToLog("csv_do_export", 'EXPORT_LOG.txt');
        ini_set('display_errors', 1);
        ini_set('max_execution_time', 0);
        ini_set("memory_limit","900M");


         $file = fopen($result = $this->config->getConfigParam( 'sShopDir' )."/export/Haendlernetzwerk/CSV/stock.csv","w");
        $ids = $this->getArticlesIds();
        $devider = "|";
        $columns = '"article_nr"|"title"|"stock"|"delivery_date"|"title_fr"|"title_en"|"ean"';
        $carr = explode("|", $columns);

        foreach ($carr as $key => $field) {
            $carr[$key] = str_replace('"', '', $field);
        }
        fwrite($file, $columns ."\r\n");
        $count = 1;
        foreach ($ids as $id) {
            $line = $this->articleToArray($id);
            $trueLine = array();
           foreach ($carr as $key => $field) {
               $trueLine[$field] = $line[$field];
           }
            fputcsv($file, $trueLine, $devider);
            $count++;
            $vars = $this->getVariantsIds($id);
            if (count($vars)) {
               foreach ($vars as $idv) {
                   $line = $this->articleToArray($idv, $line);
                   $trueLine = array();
                   foreach ($carr as $key => $field) {
                       $trueLine[$field] = $line[$field];
                   }

                   fputcsv($file, $trueLine, $devider);
                   $count++;
               }
            }
        }

        try{
            fclose($file);
            return $file;
            exit();
        }catch (\Exception $e){
            echo $e->getMessage();
        }

    }

    public function Basket_addItems($oBasket, $aProducts) {
        foreach ($aProducts as $product) {
            $sProductId = $product->getId();
            $dAmount = 1;
            try {
                $oBasket->addToBasket($sProductId, $dAmount);
            } catch (oxException $oEx) {
                return $oEx->getMessage();
            }
        }
    }

    protected function articleShippingPricesToArray($id, $countryKeys) {
        $oArticle = oxNew("oxarticle");
        $oArticle->load($id);

        $result = array();
        $result["Art.Nr."] = $oArticle->oxarticles__oxartnum->value;
        $result["EAN"] = $oArticle->oxarticles__oxean->value;
        $result["Price (rbp)"] = number_format((float)$oArticle->oxarticles__oxpricec->value, 2);
        $result["Titel"] = '';

        $fakeBasket = oxNew('oxbasket');
        if ($this->Basket_addItems($fakeBasket, array($oArticle)) == "ERROR_MESSAGE_ARTICLE_ARTICLE_NOT_BUYABLE") {
            return null;
        }

        $oDb = oxDb::getDb();
        $delList = oxRegistry::get("oxDeliveryList");
        $delList->setNoUserMode(true);

        foreach($countryKeys as $key => $country) {
            $oxcountryId = $oDb->getOne("select oxid from oxcountry where OXISOALPHA2='$country'");
            $addPrice = $delList->findDeliveryPrice($fakeBasket, null, $oxcountryId);
            //echo "$country price " . $oxcountryId . " - " . $addPrice ."<br/>";
            $result[$key] = number_format((float)$addPrice, 2);
        }
        //exit;
        return $result;
    }

    public function csv_do_export_shippingprice($xls)
    {   //oxUtils::getInstance()->writeToLog("csv_do_export", 'EXPORT_LOG.txt');
        ini_set('display_errors', 1);
        ini_set('max_execution_time', 0);
        ini_set("memory_limit","900M");

         $result = $this->config->getConfigParam( 'sShopDir' )."/export/Haendlernetzwerk/CSV/deliveryprices.csv";



        $file = fopen($result,"w");
        $ids = $this->getArticlesIds();
        $devider = "|";

        //             0        1         2          3
        $columns = '"Art.Nr."|"EAN"|"Price (rbp)"|"Titel"|"Belgium (BE)"|"France (FR)"|"Germany (DE)"|" Italy (IT) "|"Luxembourg (LU)"|"Netherlands (NL)"|"Denmark (DK)"|"Ireland (IE)"|"United Kingdom (UK)"|"Greece (GR)"|"Portugal (PT)"|"Spain (ES)"|"Austria (AT)"|"Finland (FI)"|"Norway (NO)"|"Sweden (SE)"|"Czech (CZ)"|"Estonia (EE)"|"Hungary (HU)"|"Latvia (LV)"|"Lithuania (LT)"|"Poland (PL)"|"Slovakia (SK)"|"Slovenia (SI)"|"Bulgaria (BG)"|"Romania (RO)"|"Croatia (HR)"|"Lichtenstein (LI)"|"Switzerland (CH)"|"San Marino (SM)"|"Monaco (MC)"|"Cyprus (CY)"|"Malta (MT)"';
        $carr = explode("|", $columns);

        $countries = array();
        foreach ($carr as $key => $field) {
            $carr[$key] = $fname = str_replace('"', '', $field);
            $country = array();
            preg_match('/(?<=\().+?(?=\))/',$fname, $country);
            if($key > 3) {
                $countries[$fname] = $country[0];
            }
        }
        fwrite($file, $columns . "\r\n");

        $oDb = oxDb::getDb();

        $count = 1;
        foreach ($ids as $id) {

            $vars = $this->getVariantsIds($id);
            if (count($vars)) {

                $title = $oDb->getOne("select oxtitle from oxarticles where oxid='$id'");
                if(!$oDb->getOne("SELECT 1 FROM `oxobject2category` WHERE `OXCATNID` = '7b4652328394606159f5f59382b15b33' && OXOBJECTID='$id'")) {
                    continue;
                }

                $trueLine = array();
                foreach ($carr as $key => $field) {
                    $trueLine[$field] = $field == "Titel" ? $title : "";
                }
                fputcsv($file, $trueLine, $devider);
                $count++;

                foreach ($vars as $idv) {
                    if(!$line = $this->articleShippingPricesToArray($idv,$countries)) {
                        continue;
                    }
                    //echo "$count" . "<br>";
                    $trueLine = array();
                    foreach ($carr as $key => $field) {
                        $trueLine[$field] = $line[$field];
                    }
                    //print_r($trueLine);
                    fputcsv($file, $trueLine, $devider);
                    $count++;
                }

            } else {
                if(!$oDb->getOne("SELECT 1 FROM `oxobject2category` WHERE `OXCATNID` = '7b4652328394606159f5f59382b15b33' && OXOBJECTID='$id'")) {
                    continue;
                }
                if(!$line = $this->articleShippingPricesToArray($id,$countries)) {
                    continue;
                }
                $trueLine = array();
                foreach ($carr as $key => $field) {
                    $trueLine[$field] = $line[$field];
                }
                fputcsv($file, $trueLine, $devider);
                $count++;
            }
        }
        fclose($file);

        if($xls) {
            require_once dirname(__FILE__) . '/../PHPExcel/Classes/PHPExcel/IOFactory.php';

            $objReader = PHPExcel_IOFactory::createReader('CSV');

            // If the files uses a delimiter other than a comma (e.g. a tab), then tell the reader
            $objReader->setDelimiter("|");
            // If the files uses an encoding other than UTF-8 or ASCII, then tell the reader
            //$objReader->setInputEncoding('ISO-8859-1');

            $objPHPExcel = $objReader->load($result);
            $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
            $objWriter->save($result = $this->config->getConfigParam('sShopDir') . "/export/Haendlernetzwerk/CSV/deliveryprices.xls");
        }
        //echo $count;
        return $result;
    }

    public function __construct()
    {
        $this->config = $this->getConfig();
        $this->stockCSVFilePath = $this->config->getConfigParam( 'sShopDir' )."export/Haendlernetzwerk/CSV/stock.csv";
    }

    public function getFilePath(){
         return $this->stockCSVFilePath;
    }
}
