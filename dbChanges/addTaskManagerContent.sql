DELIMITER //
DROP PROCEDURE IF EXISTS addTaskManagerContent//
CREATE PROCEDURE `addTaskManagerContent`(
	IN `_userId` INT(11),
	IN `_taskContentUpdateId` INT(11),
	IN `_marshaCodeData` INT(11),
	IN `_serviceTypeIdData` INT(11),
	IN `_tireData` VARCHAR(255),
	IN `_priorityData` TINYINT(1),
	IN `_addedBoxData` date,
	IN `_dueData` date,
	IN `_revReqData` date,
	IN `_revComData` TINYINT(1),
	IN `_isCompleteData` TINYINT(1),
	IN `_completedDate` date,
	IN `_writerIdData` INT(11),
	IN `_noUnitsData` INT(11),
	IN `_linkToFileData` TEXT,
	IN `_notesData` TEXT,
	IN `_dateTime` datetime,
	IN `_clientId` INT(11),
	IN `_uploadLink` TEXT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update task_content'
BEGIN


		IF(_taskContentUpdateId > 0) THEN
		
		UPDATE task_content SET task_content_marsha_code = _marshaCodeData,task_content_service_type_id = _serviceTypeIdData,task_content_tire = _tireData, task_content_priority = _priorityData, task_content_added_box_date = _addedBoxData, task_content_due_date = _dueData,  task_content_rev_req = _revReqData, task_content_rev_com = _revComData, task_content_is_complete = _isCompleteData,
		task_content_user_id = _writerIdData, task_content_no_of_units = _noUnitsData, task_content_link_to_file = _linkToFileData, task_content_notes = _notesData, task_content_modified_by = _userId, task_content_modified_on = _dateTime , task_content_client_id = _clientId , task_content_upload_link = _uploadLink,task_content_proj_com_date = _completedDate WHERE task_content_id = _taskContentUpdateId;
		
		SELECT _taskContentUpdateId AS taskContentId;
		
		ELSE
		
			INSERT INTO task_content(task_content_marsha_code,task_content_service_type_id,task_content_tire,task_content_priority,task_content_added_box_date,task_content_due_date,task_content_rev_req,task_content_rev_com,task_content_is_complete,task_content_user_id,task_content_no_of_units,task_content_link_to_file,task_content_notes,task_content_record_status,task_content_created_by,task_content_created_on,task_content_modified_by,task_content_modified_on,task_content_client_id,task_content_upload_link,task_content_proj_com_date)
			VALUES (_marshaCodeData, _serviceTypeIdData, _tireData,_priorityData,_addedBoxData,_dueData, _revReqData,_revComData,_isCompleteData,_writerIdData,_noUnitsData,_linkToFileData,_notesData,0,_userId,_dateTime,_userId,_dateTime,_clientId,_uploadLink, _completedDate);
			
			SELECT LAST_INSERT_ID() AS taskContentId;
			
		END IF;
END