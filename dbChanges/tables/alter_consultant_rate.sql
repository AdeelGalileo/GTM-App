ALTER TABLE `consultant_rate`
	ADD COLUMN `cons_rate_service_type_id` INT(11) NOT NULL DEFAULT '0' AFTER `cons_rate_client_id`;