CREATE TABLE `consultant_skill_items` (
	`csi_id` INT(11) NOT NULL AUTO_INCREMENT,
	`csi_skill_id` INT(11) NOT NULL DEFAULT '0',
	`csi_service_type_id` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`csi_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
