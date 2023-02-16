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
 * - в админе в заказе можно сохранять персонизированные переменные от клиента
 * - случайное число для счета и номера клиента
 * - поиск артиклей по номеру exact!
 *
 *
 *
 * ALTER TABLE `oxdocumentsrechnungen` ADD `oxdocumentnummerserial` INT NOT NULL AFTER `oxdocumentnummer`
 *
 *
 *CREATE TRIGGER `oxdocumentnummerserial` BEFORE INSERT ON `oxdocumentsrechnungen` FOR EACH ROW SET NEW.oxdocumentnummerserial = (select if(count(*)=0,100001,max(oxdocumentnummerserial)+1) from oxdocumentsrechnungen where oxdocumenttype=NEW.oxdocumenttype)
 *
 *
 * в таблице oxuser убрать autoincriment
 *
 */
$aModule = array(
    'id'           => 'exonn_order',
    'title'        => 'EXONN Order Module',
    'description'  => 'Module Order.',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',
    'events'       => array(
        'onActivate' 	=> 'exonn_order_event::onActivate',
        'onDeactivate' 	=> 'exonn_order_event::onDeactivate',
    ),
    'files' => array(
        'exonn_order_event'                 => 'exonn_order/models/exonn_order_event.php',
        'exonn_fnccron' => 'exonn_order/controllers/exonn_fnccron.php',

    ),
    'extend'       => array(
        'oxemail' => 'exonn_order/core/exonn_order_oxemail',
        'oxorder' => 'exonn_order/models/exonn_order_oxorder',
        'oxuser' => 'exonn_order/models/exonn_order_oxuser',
        'oxdocumentsrechnungen' => 'exonn_order/models/exonn_order_oxdocumentsrechnungen',
        'oxsearch' => 'exonn_order/models/exonn_order_oxsearch',
        'order_article' => 'exonn_order/controllers/exonn_order_order_article',
        'order_list' => 'exonn_order/controllers/exonn_order_order_list',
        'article_list' => 'exonn_order/controllers/exonn_order_articlelist',
    ),
    'blocks' => array(
        array('template' => 'shop_main.tpl',    'block' => 'admin_shop_main_leftform',  	'file' => 'admin_shop_main_leftform.tpl'),
        array('template' => 'order_list.tpl', 'block'=>'admin_order_list_filter', 'file'=>'admin_order_list_filter.tpl'),
    ),
    );