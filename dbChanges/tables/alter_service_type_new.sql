ALTER TABLE `service_type`
	ADD COLUMN `serv_type_qb_id` INT(11) NOT NULL DEFAULT '0' AFTER `serv_type_id`;
	
ALTER TABLE `invoice_task_reference`
	ADD COLUMN `invoice_reference_service_qb_ref_id` INT(11) NOT NULL DEFAULT '0' AFTER `invoice_reference_task_client_id`;
	
ALTER TABLE `billing_task_reference`
	ADD COLUMN `billing_reference_service_qb_ref_id` INT(11) NOT NULL DEFAULT '0' AFTER `billing_reference_task_client_id`;
	
	
ALTER TABLE `user`
	ADD COLUMN `user_qb_ref_id` INT(11) NOT NULL DEFAULT '0' AFTER `user_modified_by`;