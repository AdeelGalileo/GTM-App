DELIMITER //
DROP PROCEDURE IF EXISTS addTaskManagerKeyword//
CREATE PROCEDURE `addTaskManagerKeyword`(
	IN `_userId` INT(11),
	IN `_taskKeywordUpdateId` INT(11),
	IN `_marshaCodeData` INT(11),
	IN `_noPagesData` VARCHAR(255),
	IN `_notesData` TEXT,
	IN `_tireData` VARCHAR(255),
	IN `_boxAddedDateData` date,
	IN `_setupDueData` date,
	IN `_setupCompleteData` TINYINT(1),
	IN `_dueData` date,
	IN `_submittedData` TINYINT(1),
	IN `_userIdData` INT(11),
	IN `_linkDbFileData` VARCHAR(255),
	IN `_taskDateData` date,
	IN `_priorityData` TINYINT(1),
	IN `_clientId` INT(11),
	IN `_dateTime` datetime,
	IN `_isSubTask` TINYINT(1),
	IN `_taskServiceTypeId` INT(11)

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update task_keyword'
BEGIN

	DECLARE serviceTypeId INT(11);


	IF(_taskServiceTypeId = 0)	THEN
		SET serviceTypeId = 6;
	ELSE 
		SET serviceTypeId = _taskServiceTypeId;
	END IF;

		IF(_taskKeywordUpdateId > 0) THEN
		
		UPDATE task_keyword SET task_keyword_marsha_code = _marshaCodeData,task_keyword_no_of_pages = _noPagesData, task_keyword_notes = _notesData, task_keyword_tire = _tireData ,task_keyword_added_box_date = _boxAddedDateData, task_keyword_setup_due_date = _setupDueData, task_keyword_setup_complete = _setupCompleteData,  task_keyword_user_id = _userIdData, task_keyword_link_db_file = _linkDbFileData,  task_keyword_date = _taskDateData ,  task_keyword_modified_by = _userId, task_keyword_modified_on = _dateTime, task_keyword_client_id = _clientId , task_keyword_priority = _priorityData,task_keyword_service_type_id=serviceTypeId WHERE task_keyword_id = _taskKeywordUpdateId;
		SELECT _taskKeywordUpdateId AS taskRecordId;
		ELSE
			INSERT INTO task_keyword(task_keyword_marsha_code,task_keyword_no_of_pages,task_keyword_notes, task_keyword_tire, task_keyword_added_box_date,task_keyword_setup_due_date,task_keyword_setup_complete,task_keyword_user_id,task_keyword_link_db_file,task_keyword_date,task_keyword_client_id,task_keyword_record_status,task_keyword_created_by,task_keyword_created_on,task_keyword_modified_by,task_keyword_modified_on,task_keyword_priority,task_is_sub_task,task_keyword_service_type_id)
			VALUES (_marshaCodeData, _noPagesData,_notesData , _tireData, _boxAddedDateData, _setupDueData, _setupCompleteData
			,_userIdData,_linkDbFileData,_taskDateData,_clientId,0,_userId,_dateTime,_userId,_dateTime,_priorityData,_isSubTask,serviceTypeId);
			SELECT LAST_INSERT_ID() AS taskRecordId;
		END IF;
END