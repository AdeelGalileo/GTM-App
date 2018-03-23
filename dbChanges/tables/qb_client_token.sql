CREATE TABLE `qb_client_token` (
	`qb_client_token_id` INT(11) NOT NULL AUTO_INCREMENT,
	`qb_client_token_auth_mode` VARCHAR(100) NOT NULL DEFAULT '',
	`qb_client_token_client_id` VARCHAR(255) NOT NULL DEFAULT '',
	`qb_client_token_client_secret` VARCHAR(255) NOT NULL DEFAULT '',
	`qb_client_token_refresh_token` VARCHAR(255) NOT NULL DEFAULT '',
	`qb_client_token_access_token` TEXT NOT NULL,
	`qb_client_token_qbo_real_id` VARCHAR(255) NOT NULL DEFAULT '',
	`qb_client_token_base_url` VARCHAR(255) NOT NULL DEFAULT '',
	`qb_client_token_current_refresh_token` VARCHAR(255) NOT NULL DEFAULT '',
	`qb_client_token_app_client_id` INT(11) NOT NULL DEFAULT '0',
	`qb_client_token_record_status` TINYINT(1) NOT NULL DEFAULT '0',
	`qb_client_token_created_by` INT(11) NOT NULL DEFAULT '0',
	`qb_client_token_created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	`qb_client_token_modified_by` INT(11) NOT NULL DEFAULT '0',
	`qb_client_token_modified_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`qb_client_token_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
