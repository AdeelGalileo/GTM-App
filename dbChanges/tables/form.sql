CREATE TABLE `form` (
	`form_id` INT(11) NOT NULL AUTO_INCREMENT,
	`form_user_id` INT(11) NOT NULL DEFAULT '0',
	`form_client_id` INT(11) NOT NULL DEFAULT '0',
	`form_first_name` VARCHAR(255) NOT NULL DEFAULT '',
	`form_last_name` VARCHAR(255) NOT NULL DEFAULT '',
	`form_email` VARCHAR(100) NOT NULL DEFAULT '',
	`form_contact_no` VARCHAR(50) NOT NULL DEFAULT '',
	`form_street` VARCHAR(255) NOT NULL DEFAULT '',
	`form_city` VARCHAR(255) NOT NULL DEFAULT '',
	`form_state` VARCHAR(255) NOT NULL DEFAULT '',
	`form_zipcode` VARCHAR(100) NOT NULL DEFAULT '',
	`form_country` VARCHAR(255) NOT NULL DEFAULT '',
	`form_w_nine` VARCHAR(255) NOT NULL DEFAULT '',
	`form_resume` VARCHAR(255) NOT NULL DEFAULT '',
	`form_ach` VARCHAR(255) NOT NULL DEFAULT '',
	`form_consultant_agree` VARCHAR(255) NOT NULL DEFAULT '',
	`form_notes` TEXT NOT NULL,
	`form_needed` TEXT NOT NULL,
	`form_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`form_created_by` INT(11) NOT NULL DEFAULT '0',
	`form_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`form_modified_by` INT(11) NOT NULL DEFAULT '0',
	`form_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`form_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
