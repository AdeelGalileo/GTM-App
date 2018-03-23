CREATE TABLE `refresh_token_error` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`error_message` TEXT NOT NULL,
	`created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
;
