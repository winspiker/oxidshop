<?php
/**
 *    This file is part of OXID eShop Community Edition.
 *
 *    OXID eShop Community Edition is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    OXID eShop Community Edition is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with OXID eShop Community Edition.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @package   main
 * @copyright (C) OXID eSales AG 2003-2012
 * @version OXID eShop CE
 * @version   SVN: $Id: theme.php 25466 2010-02-01 14:12:07Z alfonsas $
 */

/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_basketmix',
    'title'        => 'EXONN Warenkorb mischen sperren.',
    'description'  => 'EXONN Extra Module.',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0b',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',

    'extend'       => array(
        'oxbasket' => 'exonn_basketmix/core/ebm_oxbasket',
    ),

    'files'        => array(
        'exonn_basketmix_event' => 'exonn_basketmix/core/exonn_basketmix_event.php',
    ),

    'events'       => array(
    	'onActivate' 	=> 'exonn_basketmix_event::onActivate',
		'onDeactivate' 	=> 'exonn_basketmix_event::onDeactivate',
    ),

    'blocks' => array(
        array('template' => 'category_main.tpl', 'block'=>'admin_category_main_form', 'file'=>'admin_category_main_form.tpl'),

    ),
);