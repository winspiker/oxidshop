ALTER TABLE `paypalpluscw_transaction` ADD `versionNumber` int NOT NULL;
ALTER TABLE `paypalpluscw_transaction` ADD `liveTransaction` char(1);
ALTER TABLE `paypalpluscw_customer_context` ADD `versionNumber` int NOT NULL;
ALTER TABLE `paypalpluscw_external_checkout_context` ADD `versionNumber` int NOT NULL;