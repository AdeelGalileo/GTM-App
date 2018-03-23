DELIMITER //
DROP PROCEDURE IF EXISTS `getOutstandingInvoiceList`//
CREATE PROCEDURE `getOutstandingInvoiceList`(
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
_divisionId INT(11),
_serviceTypeName VARCHAR(255),
_marshaCode VARCHAR(200)
)

BEGIN
	DECLARE QryCondKeyword TEXT;
	DECLARE QryCondContent TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpAdminConsultantTaskList;
	DROP TEMPORARY TABLE IF EXISTS tmpAdminConsultantTaskList1;

	
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
	ELSEIF(_divisionId && _filterBy = 4) THEN
	  SET QryCondKeyword = CONCAT(QryCondKeyword, " AND client_entity.client_entity_division_id =", _divisionId );
	  SET QryCondContent = CONCAT(QryCondContent, " AND client_entity.client_entity_division_id =", _divisionId );
	ELSEIF(_serviceTypeName !='0' && _filterBy = 6) THEN
	  SET QryCondKeyword = CONCAT(QryCondKeyword, " AND service_type.serv_type_name =", Quote(_serviceTypeName) );  
	  SET QryCondContent = CONCAT(QryCondContent, " AND service_type.serv_type_name =", Quote(_serviceTypeName) );  
	ELSEIF(_marshaCode !='0' && _filterBy = 5) THEN
	  SET QryCondKeyword = CONCAT(QryCondKeyword, " AND client_entity.client_entity_marsha_code =", Quote(_marshaCode) );
	  SET QryCondContent = CONCAT(QryCondContent, " AND client_entity.client_entity_marsha_code =", Quote(_marshaCode) );
	END IF;
	
	 
	SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_admin_complete = 1 AND task_keyword.task_keyword_setup_complete = 1 ");
	SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_admin_complete = 1 AND task_content.task_content_is_complete = 1 ");
	
	SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_qb_inv_process = 0");
	SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_qb_inv_process = 0");

	IF(_clientId > 0) THEN
		SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_client_id = ", _clientId);
		SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_client_id = ", _clientId);
	END IF;
	
	IF(_userRole > 1) THEN
		SET QryCondKeyword = CONCAT(QryCondKeyword, " AND user.user_role_id = ", _userRole , " AND user.user_id = ", _userId);
		SET QryCondContent = CONCAT(QryCondContent, " AND user.user_role_id = ", _userRole , " AND user.user_id = ", _userId);
	END IF;

	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
		SET QryOrder = ' ORDER BY taskId ASC ';
	ELSE
		SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpAdminConsultantTaskList engine=memory SELECT  SQL_CALC_FOUND_ROWS task_keyword.task_keyword_id AS taskId,
							"Task Keyword" AS TaskTypeVal,1 AS TaskType,client_entity_marsha_code AS marshaCode,division_code AS divisionCode,service_type.serv_type_name AS servTypeName, service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate, task_keyword_added_box_date AS dateAddedToBox, task_keyword_due AS contentDue,task_keyword_priority AS priority, user.user_fname AS userName,user.user_lname AS userLName,task_keyword_setup_complete AS isCompleted,task_keyword_tire AS tire, task_keyword_no_of_pages AS unitNo
							FROM task_keyword
							INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
							INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
							INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code 
							INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
							LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id
							' ,QryCondKeyword, '
							UNION
							SELECT task_content.task_content_id AS taskId,
							"Task Content" AS TaskTypeVal,2 AS TaskType,client_entity_marsha_code AS marshaCode,division_code AS divisionCode,service_type.serv_type_name AS servTypeName, service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate,task_content_added_box_date AS dateAddedToBox,task_content_due_date AS contentDue,task_content_priority AS priority,  user.user_fname AS userName,user.user_lname AS userLName,task_content_is_complete AS isCompleted,task_content_tire AS tire ,task_content_no_of_units AS unitNo
							FROM task_content
							INNER JOIN user ON user.user_id = task_content.task_content_user_id
							INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
							INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code 
							INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
							LEFT  JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id
							' ,QryCondContent, '
							', QryOrder, QryLimit);
							
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	
	SET @IdQry2 = CONCAT('CREATE TEMPORARY TABLE tmpAdminConsultantTaskList1 engine=memory SELECT * from tmpAdminConsultantTaskList ', QryOrder);
							
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	SET @IdQry3 = CONCAT('  SELECT  user.user_id, user.user_fname AS userName, user.user_lname AS userLName,  user.user_email,  user.user_record_status,
							user_role.user_role_id,user_role.user_role_name,  user_role.user_role_record_status,task_keyword.task_keyword_id AS taskId,task_keyword_marsha_code AS marshaId,client_entity_marsha_code AS marshaCode,division_id,division_code AS divisionCode,division_name,task_keyword_link_db_file AS linkToFile, task_keyword_added_box_date AS dateAddedToBox, task_keyword_due AS contentDue,task_keyword_priority AS priority, service_type.serv_type_id,service_type.serv_type_name AS servTypeName,service_type.serv_type_gal_rate AS servTypeGalRate,service_type.serv_type_freel_rate AS servTypeFreeLRate,task_keyword_tire AS tire,task_keyword_date AS tireDate,
							task_keyword_setup_complete AS isCompleted,
							"Task Keyword" AS TaskTypeVal,1 AS TaskType,
							task_keyword.task_keyword_admin_complete AS adminComplete,task_keyword.task_keyword_client_id AS taskClientId,task_keyword.task_keyword_admin_notes AS adminNotes,task_keyword_qb_inv_process AS isQbProcess, task_keyword_no_of_pages AS unitNo
							FROM task_keyword
								INNER JOIN tmpAdminConsultantTaskList ON tmpAdminConsultantTaskList.taskId = task_keyword.task_keyword_id
								INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
								INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
								INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code 
								INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
								LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id
							' ,QryCondKeyword, '
							UNION
							SELECT user.user_id, user.user_fname AS userName, user.user_lname AS userLName,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,task_content.task_content_id AS taskId,task_content_marsha_code AS marshaId,client_entity_marsha_code AS marshaCode,division_id,division_code AS divisionCode,division_name ,task_content_link_to_file AS linkToFile, task_content_added_box_date AS dateAddedToBox, task_content_due_date AS contentDue, task_content_priority AS priority, service_type.serv_type_id,service_type.serv_type_name AS servTypeName,service_type.serv_type_gal_rate AS servTypeGalRate,service_type.serv_type_freel_rate AS servTypeFreeLRate,task_content_tire AS tire,task_content_ass_writer_date AS tireDate,
							task_content_is_complete AS isCompleted,
							"Task Content" AS TaskTypeVal,2 AS TaskType,
							task_content.task_content_admin_complete AS adminComplete,task_content.task_content_client_id AS taskClientId ,task_content.task_content_admin_notes AS adminNotes,task_content_qb_inv_process AS isQbProcess,task_content_no_of_units AS unitNo
							FROM task_content
								INNER JOIN tmpAdminConsultantTaskList1 ON tmpAdminConsultantTaskList1.taskId = task_content.task_content_id
								INNER JOIN user ON user.user_id = task_content.task_content_user_id
								INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
								INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code 
								INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
								LEFT  JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id
							' ,QryCondContent, '
							', QryOrder);
	
	PREPARE stmt3 FROM @IdQry3;
	EXECUTE stmt3;
	DEALLOCATE PREPARE stmt3;
	
	DROP TEMPORARY TABLE IF EXISTS tmpAdminConsultantTaskList;
	DROP TEMPORARY TABLE IF EXISTS tmpAdminConsultantTaskList1;
	
END