<?php

namespace Exonn\LiveSearch\Core;

use Exonn\Connector\Framework\Database;
use Exonn\Connector\Framework\ModuleEvents;

class Events extends ModuleEvents
{
    /**
     * @inheritDoc
     *
     * @throws \Throwable
     */
    public static function onActivate(): void
    {
        self::setActive(LiveSearchModule::MODULE_ID);
        Database::modifyExistingSchema(LiveSearchModule::getModifiedSchema());
    }

    /**
     * @inheritDoc
     */
    public static function onDeactivate(): void
    {
        self::setInactive(LiveSearchModule::MODULE_ID);
    }
}
