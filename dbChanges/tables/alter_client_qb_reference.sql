ALTER TABLE `client_qb_reference`
	CHANGE COLUMN `client_qb_ref_qb_class` `client_qb_ref_qb_class` INT(11) NOT NULL DEFAULT '0' AFTER `client_qb_ref_qb_id`;