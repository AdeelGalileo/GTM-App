ALTER TABLE `notification`
	CHANGE COLUMN `notification_module` `notification_module` INT(11) NOT NULL DEFAULT '0' AFTER `notification_user_id`;
	
ALTER TABLE `notification`
	CHANGE COLUMN `notification_module` `notification_module_id` INT(11) NOT NULL DEFAULT '0' AFTER `notification_user_id`;
	
	ALTER TABLE `notification`
	ADD COLUMN `notification_client_id` INT(11) NOT NULL DEFAULT '0' AFTER `notification_user_id`;