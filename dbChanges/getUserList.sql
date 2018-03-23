DELIMITER //
DROP PROCEDURE IF EXISTS `getUserList`//
CREATE PROCEDURE `getUserList`(
_userRole INT(11),
_filterBy TINYINT(1),
_userId INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_roleFilter INT(11),
_formFilter TINYINT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpUser;
	
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(user.user_created_on) =", Quote(_FromDate) );
	ELSEIF(_FromDate ) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(user.user_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
    ELSEIF(_roleFilter > 0 && _filterBy = 2) THEN
	 SET QryCond = CONCAT(QryCond, " AND user.user_role_id = ", _roleFilter );
	ELSEIF(_filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND user.user_form_completed = ", _formFilter );
	ELSEIF(_filterBy = 4) THEN
		SET QryCond = CONCAT(QryCond, " AND user.user_role_id = ", _roleFilter , " AND user.user_form_completed = ", _formFilter);
	END IF;
	
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY user.user_fname ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND user.user_role_id = ", _userRole , " AND user.user_id = ", _userId);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpUser engine=memory SELECT SQL_CALC_FOUND_ROWS  user_id 
		FROM user 
		INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
		', QryCond, QryOrder, QryLimit);
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,  user_role.user_role_created_by,  user_role.user_role_created_on,  user_role.user_role_modified_by,  user_role.user_role_modified_on, user.user_form_completed
	FROM user 
	INNER JOIN tmpUser ON tmpUser.user_id = user.user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id ', QryOrder);

	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpUser;
	
END