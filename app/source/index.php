<?php

/**
 * Copyright © OXID eSales AG. All rights reserved.
 * See LICENSE file for license details.
 */

require_once __DIR__ . "/bootstrap.php";

/**
 * Redirect to Setup, if shop is not configured
 */

redirectIfShopNotConfigured();

//Starts the shop
OxidEsales\EshopCommunity\Core\Oxid::run();
