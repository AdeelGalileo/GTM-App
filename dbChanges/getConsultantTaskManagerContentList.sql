DELIMITER //
DROP PROCEDURE IF EXISTS `getConsultantTaskManagerContentList`//
CREATE PROCEDURE `getConsultantTaskManagerContentList`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_writerId INT(11),
_clientId INT(11),
_isComplete TINYINT(1)
)

BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskContentConsultantManager;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_content.task_content_due_date) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_content.task_content_due_date) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND task_content.task_content_user_id = ", _writerId );
	END IF;
	
	 IF(_isComplete = 1) THEN
		SET QryCond = CONCAT(QryCond, " AND task_content.task_content_is_complete = 1");
	 END IF;
	 
	IF(_isComplete = 2) THEN
		SET QryCond = CONCAT(QryCond, " AND task_content.task_content_is_complete = 0");
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND task_content.task_content_client_id = ", _clientId);
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
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpTaskContentConsultantManager engine=memory SELECT SQL_CALC_FOUND_ROWS  task_content_id 
		FROM task_content 
		INNER JOIN user ON user.user_id = task_content.task_content_user_id
		INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
		INNER JOIN client ON client.client_id = task_content.task_content_client_id
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
		LEFT JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	client.client_name,task_content.task_content_id,task_content.task_content_marsha_code,task_content.task_content_service_type_id,task_content.task_content_tire,task_content.task_content_priority,task_content.task_content_added_box_date,task_content.task_content_due_date,task_content.task_content_due_plus_date,task_content.task_content_added_box_due_date,task_content.task_content_rev_req,task_content.task_content_rev_com,task_content.task_content_rev_sec_req,task_content.task_content_rev_sec_com,task_content.task_content_ass_writer_date,task_content.task_content_is_complete,task_content.task_content_proj_com_date,task_content.task_content_user_id,task_content.task_content_no_of_units,task_content.task_content_link_to_file,task_content.task_content_notes,task_content.task_content_record_status,task_content.task_content_created_by,task_content.task_content_created_on,task_content.task_content_modified_by,task_content.task_content_modified_on,service_type.serv_type_id,service_type.serv_type_name
	FROM task_content 
	INNER JOIN tmpTaskContentConsultantManager ON tmpTaskContentConsultantManager.task_content_id = task_content.task_content_id
	INNER JOIN user ON user.user_id = task_content.task_content_user_id
	INNER JOIN client ON client.client_id = task_content.task_content_client_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT  JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskContentConsultantManager;
	
END