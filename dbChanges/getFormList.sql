DELIMITER //
DROP PROCEDURE IF EXISTS `getFormList`//
CREATE PROCEDURE `getFormList`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_writerId INT(11),
_clientId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpForm;
	
	SET QryCond = CONCAT(' WHERE form.form_record_status=0 AND user.user_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(form.form_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(form.form_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND form.form_user_id = ", _writerId );
    ELSEIF(_userRole > 0 && _filterBy = 4) THEN
	 SET QryCond = CONCAT(QryCond, " AND user_role.user_role_id = ", _userRole );
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND form.form_client_id = ", _clientId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY form.form_first_name ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpForm engine=memory SELECT SQL_CALC_FOUND_ROWS  form_id 
		FROM form 
		INNER JOIN user ON user.user_id = form.form_user_id
		INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT form.form_id,form_user_id,form_client_id,form_first_name,form_last_name,form_email,form_contact_no,form_street,form_city,form_state,form_zipcode,form_country,form_w_nine,form_resume,form_ach,form_consultant_agree,form_notes,form_needed,form_record_status,form_created_by,form_created_on,form_modified_by,form_modified_on,user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status FROM form  
	INNER JOIN tmpForm ON tmpForm.form_id = form.form_id
	INNER JOIN user ON user.user_id = form.form_user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpForm;
	
END