<?php

$sMetadataVersion = '1.0';

/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_contact',
    'title'        => 'EXONN Kontaktformular Erweiterung',
    'description'  => '',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',

    'extend'       => array(
        'contact' => 'exonn_contact/Controller/exonn_contact_contact',
    ),

    'files'        => array(
    ),

    'events'       => array(
    ),

    'templates'    => array(
    ),
    'blocks' => array(
    )
);