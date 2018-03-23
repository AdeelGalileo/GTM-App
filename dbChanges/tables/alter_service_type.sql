ALTER TABLE `service_type`
	CHANGE COLUMN `serv_type_name` `serv_type_name` VARCHAR(255) NOT NULL DEFAULT '' AFTER `serv_type_id`;
	
ALTER TABLE `service_type`
	ADD COLUMN `serv_type_task_type` TINYINT(1) NOT NULL DEFAULT '0' AFTER `serv_type_qb_id`;