ALTER TABLE `task_content`
	ADD COLUMN `task_content_admin_complete` TINYINT(1) NOT NULL DEFAULT '0' AFTER `task_content_is_complete`;
	
ALTER TABLE `task_content`
	ADD COLUMN `task_content_admin_notes` TEXT NOT NULL DEFAULT '' AFTER `task_content_admin_complete`;

ALTER TABLE `task_content`
	ADD COLUMN `task_content_qb_process` TINYINT(1) NOT NULL DEFAULT '0' AFTER `task_content_record_status`;
	
ALTER TABLE `task_content`
	ADD COLUMN `task_content_billing_complete` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0=Incompleted, 1=Completed' AFTER `task_content_admin_complete`;
	
ALTER TABLE `task_content`
	ADD COLUMN `task_content_invoice_complete` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0=Incompleted, 1=Completed' AFTER `task_content_billing_complete`;
	
ALTER TABLE `task_content`
	ADD COLUMN `task_content_qb_inv_process` TINYINT(1) NOT NULL DEFAULT '0' AFTER `task_content_qb_process`;
	
	
ALTER TABLE `task_content`
	CHANGE COLUMN `task_content_link_to_file` `task_content_link_to_file` TEXT NOT NULL DEFAULT '' AFTER `task_content_no_of_units`;	
	
ALTER TABLE `task_content`
	ADD COLUMN `task_content_upload_link` TEXT NOT NULL AFTER `task_content_link_to_file`;
	
ALTER TABLE `task_content`
	CHANGE COLUMN `task_content_rev_com` `task_content_rev_com` TINYINT(1) NOT NULL DEFAULT '0' AFTER `task_content_rev_req`;