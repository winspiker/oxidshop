<?php
namespace dgModule\dgIdealoModul\Application\Controller\Admin;

use OxidEsales\Eshop\Core\Registry as Registry;
use OxidEsales\Eshop\Core\Request as Request;
use dgModule\dgIdealoModul\Application\Model\dgIdealo as dgIdealo;
use dgModule\dgIdealoModul\Application\Model\dgIdealoApi as dgIdealoApi;



class dgIdealo_Test extends \dgModule\dgIdealoModul\Application\Controller\Admin\dgIdealo_Main
{
	protected $_sThisTemplate = 'dgidealo/dgidealo_main.tpl';

	public function render()
	{
		parent::render();

		$myConfig = Registry::getConfig();
        $myRequest = Registry::get(Request::class);
		$oxUtils = Registry::getUtils();

		ob_start();

		echo "<pre>";

		$oIdealo = Registry::get(dgIdealo::class);
		var_dump( $oIdealo, true );
        print_r( $oIdealo );

		$oIdealoApi = Registry::get(dgIdealoApi::class);
		var_dump( $oIdealoApi );
        print_r( $oIdealoApi );

		$oClient = $oIdealoApi->getApi();
		var_dump( $oClient );
        print_r( $oClient );

		$oTest = $oClient->dgIdealoIsTokenCorrect(true);
		var_dump( $oTest );
        print_r( $oTest );

		echo "</pre>";
        
		$out = ob_get_contents();
		ob_end_clean();

		$oxUtils->showMessageAndExit( $out );
	}
}
