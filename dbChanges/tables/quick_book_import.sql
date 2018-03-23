CREATE TABLE `quick_book_import` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`billing_id` INT(11) NOT NULL DEFAULT '0',
	`order_xml` TEXT NOT NULL,
	`client_id` INT(11) NOT NULL DEFAULT '0',
	`user_id` INT(11) NOT NULL DEFAULT '0',
	`read_status` INT(11) NOT NULL DEFAULT '0',
	`order_response` TEXT NOT NULL,
	`status` INT(11) NULL DEFAULT '0',
	`created_on` DATETIME NOT NULL,
	`created_by` INT(11) NOT NULL DEFAULT '0',
	`modified_on` DATETIME NOT NULL,
	`modified_by` INT(11) NOT NULL DEFAULT '0',
	`error_code` TEXT NOT NULL,
	`qb_type` INT(11) NULL DEFAULT '1' COMMENT '1=>Order, 2 =>Customer',
	`qb_response_id` VARCHAR(150) NOT NULL DEFAULT '',
	`qb_sales_order_no` VARCHAR(150) NOT NULL DEFAULT '',
	`qb_customer_name` VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
