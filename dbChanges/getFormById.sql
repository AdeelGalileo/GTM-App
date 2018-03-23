DELIMITER //
DROP PROCEDURE IF EXISTS `getFormById`//
CREATE PROCEDURE `getFormById`(_formId INT(11))
BEGIN
	SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,form_id,form_user_id,form_client_id,form_first_name,form_last_name,form_email,form_contact_no,form_street,form_city,form_state,form_zipcode,form_country,form_w_nine,form_resume,form_ach,form_consultant_agree,form_record_status,form_created_by,form_created_on,form_modified_by,form_modified_on
	FROM form 
	INNER JOIN user ON user.user_id = form.form_user_id 
	WHERE user_record_status= 0 AND form_record_status = 0 AND form_id = _formId;
END