<?php


$aModule = array(
    'id'           => 'exonn_activecampaign',
    'title'        => 'EXONN activecampaign Module',
    'description'  => 'activecampaign.',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0.1',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',
    'files'        => array(
        'exonnactivecampaign_api' => 'exonn_activecampaign/models/exonnactivecampaign_api.php',
        'exonn_activecampaign_cronjob' => 'exonn_activecampaign/controllers/exonn_activecampaign_cronjob.php',

    ),
    'templates'    => array(
    ),
    'extend'       => array(
    ),

);


