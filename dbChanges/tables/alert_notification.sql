CREATE TABLE `alert_notification` (
	`alert_notification_id` INT(11) NOT NULL AUTO_INCREMENT,
	`alert_notification_is_read` TINYINT(1) NOT NULL DEFAULT '0',
	`alert_notification_module_user_id` INT(11) NOT NULL DEFAULT '0',
	`alert_notification_client_id` INT(11) NOT NULL DEFAULT '0',
	`alert_notification_module_id` INT(11) NOT NULL DEFAULT '0',
	`alert_notification_task_id` INT(11) NOT NULL DEFAULT '0',
	`alert_notification_invoice_id` INT(11) NOT NULL DEFAULT '0',
	`alert_notification_billing_id` INT(11) NOT NULL DEFAULT '0',
	`alert_notification_email` VARCHAR(100) NOT NULL DEFAULT '',
	`alert_notification_message` TEXT NOT NULL,
	`alert_notification_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`alert_notification_created_by` INT(11) NOT NULL DEFAULT '0',
	`alert_notification_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`alert_notification_modified_by` INT(11) NOT NULL DEFAULT '0',
	`alert_notification_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`alert_notification_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
