<?php
/**
 * You are allowed to use this API in your web application.
 *
 * Copyright (C) 2018 by customweb GmbH
 *
 * This program is licenced under the customweb software licence. With the
 * purchase or the installation of the software in your application you
 * accept the licence agreement. The allowed usage is outlined in the
 * customweb software licence which can be found under
 * http://www.sellxed.com/en/software-license-agreement
 *
 * Any modification or distribution is strictly forbidden. The license
 * grants you the installation in one application. For multiuse you will need
 * to purchase further licences at http://www.sellxed.com/shop.
 *
 * See the customweb software licence agreement for more details.
 *
 *
 * @category	Customweb
 * @package		Customweb_PayPalPlusCw
 * @version		2.0.224
 */



class paypalpluscw_layout extends oxUBase
{
	protected $_sThisTemplate = 'paypalpluscw_layout.tpl';

	public function render()
	{
		parent::render();

		$this->_aViewData['mainContent'] = '____mainContent____';
		$this->_aViewData['cssFiles'] = PayPalPlusCwLayoutRenderer::getContext()->getCssFiles();
		$this->_aViewData['javascriptFiles'] = PayPalPlusCwLayoutRenderer::getContext()->getJavaScriptFiles();
		$this->_aViewData['template_title'] = '____templateTitle____';

		return $this->_sThisTemplate;
	}

	public function getCharSet()
	{
		return 'UTF-8';
	}
}