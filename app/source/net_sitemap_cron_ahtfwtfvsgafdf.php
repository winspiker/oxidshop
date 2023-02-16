<?php
require_once dirname(__FILE__) . "/bootstrap.php";

$oSitemapExport = oxNew(\Netensio\Sitemap\Model\SitemapExport::class);
$oSitemapExport->genExport();