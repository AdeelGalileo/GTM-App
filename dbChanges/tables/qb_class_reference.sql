CREATE TABLE `qb_class_reference` (
	`qb_cls_ref_id` INT(11) NOT NULL AUTO_INCREMENT,
	`qb_cls_ref_class_id` VARCHAR(100) NOT NULL DEFAULT '',
	`qb_cls_ref_class_name` VARCHAR(255) NOT NULL DEFAULT '',
	`qb_cls_ref_client_id` INT(11) NOT NULL DEFAULT '0',
	`qb_cls_ref_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`qb_cls_ref_created_by` INT(11) NOT NULL DEFAULT '0',
	`qb_cls_ref_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`qb_cls_ref_modified_by` INT(11) NOT NULL DEFAULT '0',
	`qb_cls_ref_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`qb_cls_ref_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
