ALTER TABLE `client_entity`
	ADD COLUMN `client_entity_region` varchar(255) NOT NULL DEFAULT '' AFTER `client_entity_division_id`;