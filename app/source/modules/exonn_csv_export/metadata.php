<?php


/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_csv_export',
    'title'        => 'EXONN CSV Export Module',
    'description'  => '',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',
    'extend'       => array(

    ),
    'files'        => array(
        "csv_export_main" => "exonn_csv_export/controllers/admin/csv_export_main.php",
        "csv_export" => "exonn_csv_export/models/csv_export.php",
        "dw_export" => "exonn_csv_export/models/dw_export.php",
        ),
    'templates'    => array(
        "csv_export.tpl" => "exonn_csv_export/views/tpl/admin/csv_export.tpl",
        ),
);