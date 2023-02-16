<?php
namespace exonn\seoAdaptations\Model;
/**
 * Created by PhpStorm.
 * User: Ben
 * Date: 17.11.2021
 * Time: 15:46
 */
class ExSeoArticleModel extends ExSeoArticleModel_parent
{
	/**
	 * Returns formatted delivery date. If the date is past or not set ('0000-00-00') returns false.
	 *
	 * @return string | bool
	 */
//	public function getDeliveryDate()
//	{
//
//
//		$deliveryDate = $this->getFieldData("oxdelivery");
//
//
//
//		if ($deliveryDate >= date('Y-m-d')) {
//			if($this->getLanguage() !== 0)
//			{
//				return $deliveryDate;
//			}
//			else
//			{
//				return date('d.m.Y', strtotime($deliveryDate));
//			}
//
//
//
//		}
//
//		return false;
//	}
}