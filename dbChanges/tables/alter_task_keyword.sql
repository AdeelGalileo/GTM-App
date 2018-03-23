ALTER TABLE `task_keyword`
	ADD COLUMN `task_keyword_admin_complete` TINYINT(1) NOT NULL DEFAULT '0' AFTER `task_keyword_complete`;
	
ALTER TABLE `task_keyword`
	ADD COLUMN `task_keyword_admin_notes` TEXT NOT NULL AFTER `task_keyword_notes`;
	
CREATE TABLE `task_keyword_admin_complete` (
	`tkac_id` INT(11) NOT NULL AUTO_INCREMENT,
	`tkac_task_keyword_id` INT(11) NOT NULL DEFAULT '0',
	`tkac_comp_status` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '1=Completed, 2=Reassigned',
	`tkac_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`tkac_created_by` INT(11) NOT NULL DEFAULT '0',
	`tkac_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`tkac_modified_by` INT(11) NOT NULL DEFAULT '0',
	`tkac_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`tkac_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;


ALTER TABLE `task_keyword`
	ADD COLUMN `task_keyword_qb_process` TINYINT(1) NOT NULL DEFAULT '0' AFTER `task_keyword_record_status`;
	
	
ALTER TABLE `task_keyword`
	ADD COLUMN `task_is_sub_task` TINYINT(1) NOT NULL DEFAULT '0' AFTER `task_keyword_id`;
	
ALTER TABLE `task_keyword`
	CHANGE COLUMN `task_keyword_no_of_pages` `task_keyword_no_of_pages` INT(11) NOT NULL DEFAULT '0' AFTER `task_keyword_marsha_code`;