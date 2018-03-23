CREATE TABLE `task_clone` (
	`task_clone_id` INT(11) NOT NULL AUTO_INCREMENT,
	`task_clone_task_id` INT(11) NOT NULL DEFAULT '0',
	`task_clone_is_main_task` TINYINT(1) NOT NULL DEFAULT '0',
	`task_clone_common_id` INT(11) NOT NULL DEFAULT '0',
	`task_clone_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`task_clone_created_by` INT(11) NOT NULL DEFAULT '0',
	`task_clone_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`task_clone_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
