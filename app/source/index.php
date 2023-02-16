<?php
/**
 * Copyright © OXID eSales AG. All rights reserved.
 * See LICENSE file for license details.
 */

$timestart = microtime(true);
/*$logname = str_replace('/', '.',$_SERVER["REQUEST_URI"]).'.txt';
file_put_contents('logseo/'.$logname, date("H:i:s")."\n".$_SERVER['REMOTE_ADDR']."\n", FILE_APPEND);
file_put_contents('logseo/'.$logname, print_r($_COOKIE, true)."\n", FILE_APPEND);
file_put_contents('logseo/'.$logname, print_r($_REQUEST, true)."\n", FILE_APPEND);
*/


if(isset($_REQUEST['cl']) && ($_REQUEST['cl'] == "communication_cron" || $_REQUEST['cl'] == "tag"))
{
    exit(0);
}


$scharov_start = '';//178.202.211.132';
$ppRemoveInactiveCategories_scharov=1;
$totalstarttime_temp=microtime(true);
require_once dirname(__FILE__) . "/bootstrap.php";

/**
 * Redirect to Setup, if shop is not configured
 */
redirectIfShopNotConfigured();

//Starts the shop
$start = microtime(true);
OxidEsales\EshopCommunity\Core\Oxid::run();
$stop = microtime(true) - $start;
$i = 1;
//file_put_contents('logseo/'.$logname, print_r('time: '.(microtime(true)-$timestart), true)."\n\n\n\n", FILE_APPEND);
/*global $devel_ip;
if($_SERVER['REMOTE_ADDR'] == '178.202.210.41')
{
    echo 'time: '.(microtime(true)-$timestart);
}*/
