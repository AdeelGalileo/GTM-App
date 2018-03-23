CREATE TABLE `consultant_rate` (
	`cons_rate_id` INT(11) NOT NULL AUTO_INCREMENT,
	`cons_rate_user_id` INT(11) NOT NULL DEFAULT '0',
	`cons_rate_client_id` INT(11) NOT NULL DEFAULT '0',
	`cons_rate_per_unit` DECIMAL(15,2) NOT NULL DEFAULT '0.00',
	`cons_rate_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`cons_rate_created_by` INT(11) NOT NULL DEFAULT '0',
	`cons_rate_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`cons_rate_modified_by` INT(11) NOT NULL DEFAULT '0',
	`cons_rate_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`cons_rate_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
