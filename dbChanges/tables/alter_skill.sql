ALTER TABLE `consultant_skill`
	DROP COLUMN `cons_service_type_id`;
	
ALTER TABLE `consultant_skill`
	ADD COLUMN `cons_client_id` INT(11) NOT NULL DEFAULT '0' AFTER `cons_user_id`;
	
	
ALTER TABLE `consultant_skill`
	CHANGE COLUMN `cons_client_id` `cons_client_id` INT(11) NOT NULL DEFAULT '0' AFTER `cons_skill_id`;