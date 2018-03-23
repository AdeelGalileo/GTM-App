DELIMITER //
DROP PROCEDURE IF EXISTS addTaskManagerKeywordForCsv//
CREATE PROCEDURE `addTaskManagerKeywordForCsv`(
	IN `_userId` INT(11),
	IN `_taskKeywordUpdateId` INT(11),
	IN `_marshaCodeData` INT(11),
	IN `_noPagesData` VARCHAR(255),
	IN `_notesData` TEXT,
	IN `_boxLocationData` VARCHAR(255),
	IN `_boxAddedDateData` date,
	IN `_setupDueData` date,
	IN `_setupCompleteData` TINYINT(1),
	IN `_dueData` date,
	IN `_submittedData` TINYINT(1),
	IN `_userIdData` INT(11),
	IN `_linkDbFileData` VARCHAR(255),
	IN `_taskDateData` date,
	IN `_clientId` INT(11),
	IN `_dateTime` datetime
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update task_keyword'
BEGIN

  DECLARE QryTaskUpdate TEXT;
  SET QryTaskUpdate = CONCAT(' , task_keyword_user_id = ',_userIdData);
  

		IF(_taskKeywordUpdateId > 0) THEN
		
			IF(_marshaCodeData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_marsha_code = ', _marshaCodeData);
			END IF;
			
			IF(_noPagesData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_no_of_pages = ', Quote(_noPagesData));
			END IF;
			
			IF(_notesData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_notes = ', Quote(_notesData));
			END IF;
			
			IF(_boxLocationData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_box_location = ', Quote(_boxLocationData));
			END IF;
			
			IF(_boxAddedDateData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_added_box_date = ', Quote(_boxAddedDateData));
			END IF;
			
			IF(_setupDueData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_setup_due_date = ', Quote(_setupDueData));
			END IF;
			
			IF(_setupCompleteData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_setup_complete = ', _setupCompleteData);
			END IF;
			
			IF(_dueData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_due = ', Quote(_dueData));
			END IF;
			
			IF(_submittedData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_submitted = ', _submittedData);
			END IF;
			
			IF(_linkDbFileData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_link_db_file = ', Quote(_linkDbFileData));
			END IF;
			
			
			IF(_taskDateData!= '')THEN
				SET QryTaskUpdate = CONCAT(QryTaskUpdate, ', task_keyword_date = ', Quote(_taskDateData));
			END IF;
			
			SET @updateTaskQry = CONCAT('UPDATE task_keyword SET  task_keyword_modified_by = ' ,_userId, ', task_keyword_modified_on = '  ,Quote(_dateTime), ', task_keyword_client_id = '  ,_clientId , QryTaskUpdate , ' WHERE task_keyword_id = ', _taskKeywordUpdateId);
			
			PREPARE stmnt FROM @updateTaskQry;
			EXECUTE stmnt;
			DEALLOCATE PREPARE stmnt;
			
		ELSE
		
			INSERT INTO task_keyword(task_keyword_marsha_code,task_keyword_no_of_pages,task_keyword_notes,task_keyword_box_location,task_keyword_added_box_date,task_keyword_setup_due_date,task_keyword_setup_complete,task_keyword_due,task_keyword_submitted,task_keyword_user_id,task_keyword_link_db_file,task_keyword_date,task_keyword_client_id,task_keyword_record_status,task_keyword_created_by,task_keyword_created_on,task_keyword_modified_by,task_keyword_modified_on)
			VALUES (_marshaCodeData, _noPagesData,_notesData, _boxLocationData, _boxAddedDateData, _setupDueData, _setupCompleteData, _dueData,
			_submittedData,_userIdData,_linkDbFileData,_taskDateData,_clientId,0,_userId,_dateTime,_userId,_dateTime);
			
			
		END IF;
END