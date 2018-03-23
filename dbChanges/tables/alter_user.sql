ALTER TABLE `user`
	ADD COLUMN `user_form_completed` TINYINT(1) NOT NULL DEFAULT '0' AFTER `user_qb_ref_id`;
	
ALTER TABLE `user`
	ADD COLUMN `user_activation_link` TEXT NOT NULL DEFAULT '' AFTER `user_form_completed`;

ALTER TABLE `user`
	ADD COLUMN `user_activation_link_expire` DATE NOT NULL DEFAULT '0000-00-00' AFTER `user_activation_link`;