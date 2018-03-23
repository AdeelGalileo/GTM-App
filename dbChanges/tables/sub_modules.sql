CREATE TABLE `sub_modules` (
	`sub_modules_id` INT(11) NOT NULL AUTO_INCREMENT,
	`sub_modules_module_id` INT(11) NOT NULL,
	`sub_modules_module_type` TINYINT(1) NOT NULL,
	`sub_modules_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`sub_modules_created_by` INT(11) NOT NULL DEFAULT '0',
	`sub_modules_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`sub_modules_modified_by` INT(11) NOT NULL DEFAULT '0',
	`sub_modules_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`sub_modules_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
