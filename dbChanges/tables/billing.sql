CREATE TABLE `billing` (
	`billing_id` INT(11) NOT NULL AUTO_INCREMENT,
	`billing_user_id` INT(11) NOT NULL DEFAULT '0',
	`billing_client_id` INT(11) NOT NULL DEFAULT '0',
	`billing_invoice_id` INT(11) NOT NULL DEFAULT '0',
	`billing_total` DECIMAL(15,2) NOT NULL DEFAULT '0.00',
	`billing_date` DATE NOT NULL DEFAULT '0000-00-00',
	`billing_is_qbprocessed` TINYINT(1) NOT NULL DEFAULT '0',
	`billing_qbreference_no` VARCHAR(100) NOT NULL DEFAULT '',
	`billing_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`billing_created_by` INT(11) NOT NULL DEFAULT '0',
	`billing_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`billing_modified_by` INT(11) NOT NULL DEFAULT '0',
	`billing_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`billing_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
