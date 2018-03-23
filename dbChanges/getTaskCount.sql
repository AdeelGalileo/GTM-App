DELIMITER //
DROP PROCEDURE IF EXISTS `getTaskCount`//
CREATE PROCEDURE `getTaskCount`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_writerId INT(11),
_clientId INT(11),
_isComplete TINYINT(1)
)

BEGIN
	DECLARE QryCondKeyword TEXT;
	DECLARE QryCondContent TEXT;
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskCount;

	
	SET QryCondKeyword = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND user.user_record_status=0 ');
	SET QryCondContent = CONCAT(' WHERE task_content.task_content_record_status=0 AND user.user_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCondKeyword = CONCAT(QryCondKeyword, " AND DATE(task_keyword.task_keyword_due) =", Quote(_FromDate) );
	  SET QryCondContent = CONCAT(QryCondContent, " AND DATE(task_content.task_content_due_date) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCondKeyword = CONCAT(QryCondKeyword, " AND DATE(task_keyword.task_keyword_due) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	  SET QryCondContent = CONCAT(QryCondContent, " AND DATE(task_content.task_content_due_date) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_user_id = ", _writerId );
	 SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_user_id = ", _writerId );
	END IF;
	
	
	 IF(_isComplete = 1) THEN
	    SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_setup_complete = 1");
		SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_is_complete = 1");
	 END IF;
	 
	IF(_isComplete = 2) THEN
		SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_setup_complete = 0");
		SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_is_complete = 0");
	END IF;

	IF(_clientId > 0) THEN
		SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_client_id = ", _clientId);
		SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_client_id = ", _clientId);
	END IF;
	
	IF(_userRole > 1) THEN
		SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_user_id = ", _userId);
		SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_user_id = ", _userId);
	END IF;
	
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpTaskCount engine=memory SELECT SQL_CALC_FOUND_ROWS task_keyword.task_keyword_id AS taskId
							FROM task_keyword
							INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
							INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
							INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code 
							INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
							LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id
							' ,QryCondKeyword, '
							UNION ALL
							SELECT task_content.task_content_id AS taskId
							FROM task_content
							INNER JOIN user ON user.user_id = task_content.task_content_user_id
							INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
							INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code 
							INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
							LEFT  JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id
							' ,QryCondContent);
							
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskCount;
	
END