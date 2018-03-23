CREATE TABLE `invoice` (
	`invoice_id` INT(11) NOT NULL AUTO_INCREMENT,
	`invoice_user_id` INT(11) NOT NULL DEFAULT '0',
	`invoice_client_id` INT(11) NOT NULL DEFAULT '0',
	`invoice_invoice_id` INT(11) NOT NULL DEFAULT '0',
	`invoice_total` DECIMAL(15,2) NOT NULL DEFAULT '0.00',
	`invoice_date` DATE NOT NULL DEFAULT '0000-00-00',
	`invoice_is_qbprocessed` TINYINT(1) NOT NULL DEFAULT '0',
	`invoice_qbreference_no` VARCHAR(100) NOT NULL DEFAULT '',
	`invoice_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`invoice_created_by` INT(11) NOT NULL DEFAULT '0',
	`invoice_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`invoice_modified_by` INT(11) NOT NULL DEFAULT '0',
	`invoice_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`invoice_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `invoice_task_reference` (
	`invoice_reference_id` INT(11) NOT NULL AUTO_INCREMENT,
	`invoice_reference_invoice_id` INT(11) NOT NULL DEFAULT '0',
	`invoice_reference_client_name` VARCHAR(255) NOT NULL DEFAULT '0',
	`invoice_reference_user_fname` VARCHAR(155) NOT NULL DEFAULT '',
	`invoice_reference_user_lname` VARCHAR(155) NOT NULL DEFAULT '',
	`invoice_reference_task_id` INT(11) NOT NULL DEFAULT '0',
	`invoice_reference_task_user_id` INT(11) NOT NULL DEFAULT '0',
	`invoice_reference_task_client_id` INT(11) NOT NULL DEFAULT '0',
	`invoice_reference_task_type` TINYINT(1) NOT NULL DEFAULT '0',
	`invoice_reference_marsha_code` VARCHAR(200) NOT NULL DEFAULT '',
	`invoice_reference_division_code` VARCHAR(50) NOT NULL DEFAULT '',
	`invoice_reference_service_type_name` VARCHAR(255) NOT NULL DEFAULT '',
	`invoice_reference_rate_per_unit` DECIMAL(15,2) NOT NULL DEFAULT '0.00',
	`invoice_reference_no_of_units` INT(11) NOT NULL DEFAULT '0',
	`invoice_reference_tire` VARCHAR(255) NOT NULL DEFAULT '',
	`invoice_reference_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`invoice_reference_created_by` INT(11) NOT NULL DEFAULT '0',
	`invoice_reference_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`invoice_reference_modified_by` INT(11) NOT NULL DEFAULT '0',
	`invoice_reference_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`invoice_reference_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

ALTER TABLE `invoice_task_reference`
	ADD COLUMN `invoice_reference_doc_number` BIGINT(11) NOT NULL DEFAULT '0' AFTER `invoice_reference_modified_on`;
	
	
	

ALTER TABLE `billing_task_reference`
	ADD COLUMN `billing_reference_doc_number` BIGINT(11) NOT NULL DEFAULT '0' AFTER `billing_reference_modified_on`;