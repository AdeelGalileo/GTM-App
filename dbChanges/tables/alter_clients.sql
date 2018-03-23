ALTER TABLE `client`
	ADD COLUMN `client_qb_associated_reference` INT(11) NOT NULL DEFAULT '0' AFTER `client_name`;