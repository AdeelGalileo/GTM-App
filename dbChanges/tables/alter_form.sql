ALTER TABLE `form`
	ADD COLUMN `form_street` VARCHAR(255) NOT NULL DEFAULT '' AFTER `form_contact_no`;
	
ALTER TABLE `form`
	CHANGE COLUMN `form_w_nine` `form_w_nine` VARCHAR(255) NOT NULL DEFAULT '' AFTER `form_country`;
	
ALTER TABLE `form`
	ADD COLUMN `form_client_id` INT(11) NOT NULL DEFAULT '0' AFTER `form_user_id`;
	
ALTER TABLE `form`
	ADD COLUMN `form_notes` TEXT NOT NULL DEFAULT '' AFTER `form_consultant_agree`;
	
ALTER TABLE `form`
	ADD COLUMN `form_needed` TEXT NOT NULL DEFAULT '' AFTER `form_notes`;