DELIMITER //
DROP PROCEDURE IF EXISTS `getTaskManagerKeywordList`//
CREATE PROCEDURE `getTaskManagerKeywordList`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_clientId INT(11),
_divisionId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskManager;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0  ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_keyword.task_keyword_added_box_date) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_keyword.task_keyword_added_box_date) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_FromDate && _FromDate = _ToDate && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND DATE(task_keyword.task_keyword_setup_due_date) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 3) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_keyword.task_keyword_setup_due_date) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_divisionId && _filterBy = 4) THEN
	  SET QryCond = CONCAT(QryCond, " AND client_entity.client_entity_division_id =", _divisionId );
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND task_keyword.task_keyword_client_id = ", _clientId);
	END IF;
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND user.user_role_id = ", _userRole , " AND user.user_id = ", _userId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY client_entity.client_entity_marsha_code ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpTaskManager engine=memory SELECT SQL_CALC_FOUND_ROWS  task_keyword_id 
		FROM task_keyword 
		LEFT JOIN user ON user.user_id = task_keyword.task_keyword_user_id AND user.user_record_status=0
		INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
		LEFT JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_keyword.task_keyword_id,task_keyword_tire,task_keyword.task_keyword_marsha_code,task_keyword.task_keyword_no_of_pages,task_keyword.task_keyword_notes,task_keyword.task_keyword_box_location,task_keyword.task_keyword_added_box_date,task_keyword.task_keyword_setup_due_date,task_keyword.task_keyword_setup_complete,task_keyword.task_keyword_due,task_keyword.task_keyword_submitted,task_keyword.task_keyword_user_id,task_keyword.task_keyword_link_db_file,task_keyword.task_keyword_date,task_keyword.task_keyword_admin_complete,task_keyword.task_keyword_client_id,task_keyword.task_keyword_admin_notes,task_keyword.task_keyword_record_status,task_keyword.task_keyword_created_by,task_keyword.task_keyword_created_on,task_keyword.task_keyword_modified_by,task_keyword.task_keyword_modified_on,
	task_keyword.task_keyword_priority,service_type.serv_type_id,service_type.serv_type_name,task_keyword.task_keyword_service_type_id,task_keyword.task_is_sub_task,task_keyword_qb_process,task_keyword_qb_inv_process
	FROM task_keyword 
	INNER JOIN tmpTaskManager ON tmpTaskManager.task_keyword_id = task_keyword.task_keyword_id
	LEFT JOIN user ON user.user_id = task_keyword.task_keyword_user_id AND user.user_record_status=0
	LEFT JOIN user_role ON user_role.user_role_id = user.user_role_id AND user.user_record_status=0
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id', QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskManager;
	
END