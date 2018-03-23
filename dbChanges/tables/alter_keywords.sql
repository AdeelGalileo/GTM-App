ALTER TABLE `task_keyword`
	ADD COLUMN `task_keyword_priority` TINYINT(1) NOT NULL DEFAULT '0' AFTER `task_keyword_admin_notes`;
	
ALTER TABLE `task_keyword`
	ADD COLUMN `task_keyword_service_type_id` INT(11) NOT NULL DEFAULT '6' AFTER `task_keyword_priority`;
	
ALTER TABLE `task_keyword`
	ADD COLUMN `task_keyword_tire` VARCHAR(255) NOT NULL DEFAULT '' AFTER `task_keyword_service_type_id`;
	
	
ALTER TABLE `task_keyword`
	ADD COLUMN `task_keyword_billing_complete` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0=Incompleted, 1=Completed' AFTER `task_keyword_admin_complete`;
	
ALTER TABLE `task_keyword`
	ADD COLUMN `task_keyword_invoice_complete` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0=Incompleted, 1=Completed' AFTER `task_keyword_billing_complete`;
	
ALTER TABLE `task_keyword`
	ADD COLUMN `task_keyword_qb_inv_process` TINYINT(1) NOT NULL DEFAULT '0' AFTER `task_keyword_qb_process`;