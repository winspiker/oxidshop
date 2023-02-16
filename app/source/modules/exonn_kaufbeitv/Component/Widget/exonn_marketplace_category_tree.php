<?php
/**
 * Created by PhpStorm.
 * User: Ben
 * Date: 01.09.2021
 * Time: 10:49
 */

class exonn_marketplace_category_tree extends exonn_marketplace_category_tree_parent
{


	public function render()
	{



		parent::render();

		$this->_aViewData["topCategories"] = $this->getTopMenuCategories();


		return $this->_sThisTemplate;
	}

	public function getTopMenuCategories()
	{
		$db = oxdb::getDb(2);

		$topMenuCategoriesQuery =
			'
	        SELECT 
            		oxid 
	        from
	        		oxcategories
			where 
					oxtopmenu = 1
	    ';


		$topMenuCategoriesResult = $db->getAll($topMenuCategoriesQuery);


		$topMenuItems = [];

		foreach($topMenuCategoriesResult as $topMenuCategory)
		{
			$categoryItem = oxNew('oxcategory');
			$categoryItem->load($topMenuCategory['oxid']);
			$topMenuItems[] = $categoryItem;
		}


		return $topMenuItems;

	}



}