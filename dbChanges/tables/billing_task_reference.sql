CREATE TABLE `billing_task_reference` (
	`billing_reference_id` INT(11) NOT NULL AUTO_INCREMENT,
	`billing_reference_billing_id` INT(11) NOT NULL DEFAULT '0',
	`billing_reference_client_name` VARCHAR(255) NOT NULL DEFAULT '0',
	`billing_reference_user_fname` VARCHAR(155) NOT NULL DEFAULT '',
	`billing_reference_user_lname` VARCHAR(155) NOT NULL DEFAULT '',
	`billing_reference_task_id` INT(11) NOT NULL DEFAULT '0',
	`billing_reference_task_type` TINYINT(1) NOT NULL DEFAULT '0',
	`billing_reference_marsha_code` VARCHAR(200) NOT NULL DEFAULT '',
	`billing_reference_division_code` VARCHAR(50) NOT NULL DEFAULT '',
	`billing_reference_service_type_name` VARCHAR(255) NOT NULL DEFAULT '',
	`billing_reference_rate_per_unit` DECIMAL(15,2) NOT NULL DEFAULT '0.00',
	`billing_reference_no_of_units` INT(11) NOT NULL DEFAULT '0',
	`billing_reference_tire` VARCHAR(255) NOT NULL DEFAULT '',
	`billing_reference_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`billing_reference_created_by` INT(11) NOT NULL DEFAULT '0',
	`billing_reference_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`billing_reference_modified_by` INT(11) NOT NULL DEFAULT '0',
	`billing_reference_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`billing_reference_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
