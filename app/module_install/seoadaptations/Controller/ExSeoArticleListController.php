<?php

namespace exonn\seoAdaptations\Controller;

class ExSeoArticleListController extends \OxidEsales\Eshop\Application\Controller\ArticleListController
{

//	protected $_sThisTemplate = 'listseo.tpl';
//
//	public function render()
//	{
//
//		$sReturn = parent::render();
//
//		$category = $this->getCategoryId();
//
//		$catQuery =
//		'
//				SELECT
//							oxparentid
//				FROM
//							oxcategories
//				WHERE
//							oxid = ?
//		';
//
//		$catResult = \OxidEsales\EshopCommunity\Core\DatabaseProvider::getDb()->getOne($catQuery, [$category]);
//
//		// wenn es sich nicht um eine root kategorie handelt, darüberliegend kategorie auslesen
//		if($catResult != 'oxrootid')
//		{
//			$subcatQuery =
//			'
//				SELECT
//							oxtitle, oxid
//				FROM
//							oxcategories
//				WHERE
//							oxid = ?
//			';
//
//			$subcatResult = \OxidEsales\EshopCommunity\Core\DatabaseProvider::getDb()->getAll($subcatQuery, [$catResult]);
//		}
//
//
//
//		if($subcatResult)
//		{
//			// für Ersatzteile kein SXT präfix, weil sonst doppelt...
//			if($subcatResult[0][1] != "e17213433cf8b8fc07bf8d8320c7e0d4")
//			{
//				$this->_aViewData['categoryPrefix'] = "SXT ".$subcatResult[0][0];
//			}
//			else
//			{
//				$this->_aViewData['categoryPrefix'] = $subcatResult[0][0];
//			}
//			//mail('alert@exonn.de', 'dalert mail' . __FILE__ . __LINE__, print_r($subcatResult,1)." ".print_r($sReturn,1));
//		}
//		else
//		{
//			$this->_aViewData['categoryPrefix'] = "SXT";
//		}
//
//
//
//
//
//		return $sReturn;
//	}
//
//
//	public function getSubcategoriesByParentId($parentId)
//	{
//		$subcategoriesQuery =
//		'
//			SELECT
//						oxid
//			FROM
//						oxcategories
//			WHERE
//						oxparentid = ?
//		';
//
//		$subcatResult = \OxidEsales\EshopCommunity\Core\DatabaseProvider::getDb()->getAll($subcategoriesQuery, [$parentId]);
//
//		echo __FILE__ . " : " . __LINE__ ."\n";
//		echo "<pre>";
//		print_r($subcatResult);
//		echo "</pre>";
//		die();
//
//	}


	/**
	 * Returns view canonical url
	 *
	 * @return string
	 */
	public function getCanonicalUrl()
	{

		if (($category = $this->getActiveCategory())) {
			$utilsUrl = \OxidEsales\Eshop\Core\Registry::getUtilsUrl();
			if (\OxidEsales\Eshop\Core\Registry::getUtils()->seoIsActive())
			{
				$url = $utilsUrl->prepareCanonicalUrl(
					$category->getBaseSeoLink($category->getLanguage() )
				);
			}
			else
			{
				$url = $utilsUrl->prepareCanonicalUrl(
					$category->getBaseStdLink($category->getLanguage() )
				);
			}

			return $url;
		}
	}

}