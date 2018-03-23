CREATE TABLE `task_content_admin_complete` (
	`tcac_id` INT(11) NOT NULL AUTO_INCREMENT,
	`tcac_task_content_id` INT(11) NOT NULL DEFAULT '0',
	`tcac_comp_status` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '1=Completed, 2=Reassigned',
	`tcac_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`tcac_created_by` INT(11) NOT NULL DEFAULT '0',
	`tcac_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`tcac_modified_by` INT(11) NOT NULL DEFAULT '0',
	`tcac_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`tcac_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB;
