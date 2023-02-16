<?php

namespace Exonn\LiveSearch\Core;

use Exonn\Connector\Framework\BaseModule;
use Exonn\Connector\Framework\Database\Schema;

/**
 * Basismodul für das LiveSearch-Modul
 */
class LiveSearchModule extends BaseModule
{
    /** @var string */
    public const MODULE_ID     = 'exonn_livesearch';

    /** @var string */
    public const MODULE_NAME   = 'livesearch';

    /**
     * @inheritDoc
     */
    protected static function getSchema(
        Schema $oSchema,
        Schema $oCurSchema
    ): Schema {
        $oTable = $oSchema->createTable('exonn_livesearch');
        $oTable->addColumn(
            'id',
            'integer',
            ['autoincrement' => true]
        );
        $oTable->addColumn(
            'insertdate',
            'datetime',
            ['default' => 'CURRENT_TIMESTAMP']
        );
        $oTable->addColumn('ip_address', 'string', ['length' => 39]);
        $oTable->addColumn('searchparam', 'string', ['length' => 100]);
        $oTable->setPrimaryKey(['id']);

        return $oSchema;
    }
}
