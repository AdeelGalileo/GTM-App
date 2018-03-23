CREATE TABLE `client_qb_reference` (
	`client_qb_ref_id` INT(11) NOT NULL AUTO_INCREMENT,
	`client_qb_ref_client_id` INT(11) NOT NULL DEFAULT '0',
	`client_qb_ref_division_id` INT(11) NOT NULL DEFAULT '0',
	`client_qb_ref_qb_id` INT(11) NOT NULL DEFAULT '0',
	`client_qb_ref_qb_class` VARCHAR(100) NOT NULL DEFAULT '',
	`client_qb_ref_record_status` INT(11) NOT NULL DEFAULT '0',
	`client_qb_ref_created_by` INT(11) NOT NULL DEFAULT '0',
	`client_qb_ref_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`client_qb_ref_modified_by` INT(11) NOT NULL DEFAULT '0',
	`client_qb_ref_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`client_qb_ref_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
