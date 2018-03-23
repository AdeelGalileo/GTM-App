-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 12, 2017 at 06:37 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `galileo`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addAdminPersonnel` (IN `_userId` INT(11), IN `_userUpdateId` INT(11), IN `_userFirstName` VARCHAR(155), IN `_userLastName` VARCHAR(155), IN `_userRole` INT(11), IN `_userEmail` VARCHAR(200), IN `_userPassword` VARCHAR(100), IN `_userDateTime` DATETIME)  BEGIN
		IF(_userUpdateId > 0) THEN
		
		UPDATE user SET user_fname = _userFirstName,user_lname = _userLastName,user_password = _userPassword, user_role_id = _userRole, user_modified_by = _userId, user_modified_on = _userDateTime WHERE user_id = _userUpdateId;
		ELSE
			INSERT INTO user(user_fname,user_lname,user_role_id,user_email,user_password,user_record_status,user_created_by,user_created_on,user_modified_by,user_modified_on)
			VALUES (_userFirstName, _userLastName, _userRole,_userEmail,_userPassword,0,_userId,_userDateTime,_userId,_userDateTime);
		END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addCsvImport` (IN `_csvFileName` VARCHAR(500), IN `_importOpt` TINYINT(1), IN `_importType` TINYINT(1), IN `_importKeywordDate` DATE, IN `_importStatus` TINYINT(1), IN `_userId` INT(11), IN `_clientId` INT(11), IN `_sysDate` DATETIME)  BEGIN
	INSERT INTO import_csv_file (ic_file_name,ic_import_opt,ic_import_type,ic_import_keyword_date,ic_status,ic_record_status,ic_user_id,ic_client_id,created_by, created_date,updated_date) 
	VALUES (_csvFileName,_importOpt,_importType,_importKeywordDate,_importStatus,0,_userId,_clientId,_userId,_sysDate,_sysDate);
	SELECT LAST_INSERT_ID() AS importCsvID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addCsvImportFields` (IN `_csvImportId` INT(11), IN `_fieldId` INT(11), IN `_fieldName` VARCHAR(500), IN `_userId` INT(11), IN `_clientId` INT(11), IN `_isUnique` TINYINT(1))  BEGIN
	INSERT INTO import_csv_fields(icf_ic_id, icf_field_id, icf_field_name,icf_user_id, icf_client_id, icf_is_unique)
		VALUES (_csvImportId, _fieldId, _fieldName,_userId, _clientId, _isUnique);
	SELECT LAST_INSERT_ID() as csvFieldId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addTaskManagerContent` (IN `_userId` INT(11), IN `_taskContentUpdateId` INT(11), IN `_marshaCodeData` INT(11), IN `_serviceTypeIdData` INT(11), IN `_tireData` VARCHAR(255), IN `_priorityData` TINYINT(1), IN `_addedBoxData` DATE, IN `_dueData` DATE, IN `_addedBoxDueData` DATE, IN `_revReqData` DATE, IN `_revComData` DATE, IN `_revSecReqData` DATE, IN `_revComSecData` DATE, IN `_assWriterData` DATE, IN `_isCompleteData` TINYINT(1), IN `_projComData` DATE, IN `_writerIdData` INT(11), IN `_noUnitsData` INT(11), IN `_linkToFileData` VARCHAR(255), IN `_notesData` TEXT, IN `_dateTime` DATETIME, IN `_clientId` INT(11))  BEGIN
DECLARE _duePlusData VARCHAR(100) DEFAULT '0000-00-00';

IF(_dueData > 0) THEN
	SET _duePlusData = DATE_ADD(_dueData, INTERVAL +5 DAY);
END IF;

		IF(_taskContentUpdateId > 0) THEN
		
		UPDATE task_content SET task_content_marsha_code = _marshaCodeData,task_content_service_type_id = _serviceTypeIdData,task_content_tire = _tireData, task_content_priority = _priorityData, task_content_added_box_date = _addedBoxData, task_content_due_date = _dueData, task_content_due_plus_date = _duePlusData, task_content_added_box_due_date = _addedBoxDueData, task_content_rev_req = _revReqData, task_content_rev_com = _revComData, task_content_rev_sec_req = _revSecReqData, task_content_rev_sec_com = _revComSecData, task_content_rev_sec_req = _revSecReqData, task_content_ass_writer_date = _assWriterData, task_content_is_complete = _isCompleteData, task_content_proj_com_date = _projComData, 
		task_content_user_id = _writerIdData, task_content_no_of_units = _noUnitsData, task_content_link_to_file = _linkToFileData, task_content_notes = _notesData, task_content_modified_by = _userId, task_content_modified_on = _dateTime , task_content_client_id = _clientId WHERE task_content_id = _taskContentUpdateId;
		
		SELECT _taskContentUpdateId AS taskContentId;
		
		ELSE
		
			INSERT INTO task_content(task_content_marsha_code,task_content_service_type_id,task_content_tire,task_content_priority,task_content_added_box_date,task_content_due_date,task_content_due_plus_date,task_content_added_box_due_date,task_content_rev_req,task_content_rev_com,task_content_rev_sec_req,task_content_rev_sec_com,task_content_ass_writer_date,task_content_is_complete,task_content_proj_com_date,task_content_user_id,task_content_no_of_units,task_content_link_to_file,task_content_notes,task_content_record_status,task_content_created_by,task_content_created_on,task_content_modified_by,task_content_modified_on,task_content_client_id)
			VALUES (_marshaCodeData, _serviceTypeIdData, _tireData,_priorityData,_addedBoxData,_dueData,_duePlusData,_addedBoxDueData,_revReqData,_revComData,_revSecReqData,_revComSecData,_assWriterData,_isCompleteData,_projComData,_writerIdData,_noUnitsData,_linkToFileData,_notesData,0,_userId,_dateTime,_userId,_dateTime,_clientId);
			
			SELECT LAST_INSERT_ID() AS taskContentId;
			
		END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addTaskManagerKeyword` (IN `_userId` INT(11), IN `_taskKeywordUpdateId` INT(11), IN `_marshaCodeData` INT(11), IN `_noPagesData` VARCHAR(255), IN `_notesData` TEXT, IN `_boxLocationData` VARCHAR(255), IN `_boxAddedDateData` DATE, IN `_setupDueData` DATE, IN `_setupCompleteData` TINYINT(1), IN `_dueData` DATE, IN `_submittedData` TINYINT(1), IN `_userIdData` INT(11), IN `_linkDbFileData` VARCHAR(255), IN `_taskDateData` DATE, IN `_clientId` INT(11), IN `_dateTime` DATETIME)  BEGIN
		IF(_taskKeywordUpdateId > 0) THEN
		
		UPDATE task_keyword SET task_keyword_marsha_code = _marshaCodeData,task_keyword_no_of_pages = _noPagesData, task_keyword_notes = _notesData,
		task_keyword_box_location = _boxLocationData,task_keyword_added_box_date = _boxAddedDateData, task_keyword_setup_due_date = _setupDueData, task_keyword_setup_complete = _setupCompleteData, task_keyword_due =  _dueData, task_keyword_submitted = _submittedData, task_keyword_user_id = _userIdData, task_keyword_link_db_file = _linkDbFileData,  task_keyword_date = _taskDateData ,  task_keyword_modified_by = _userId, task_keyword_modified_on = _dateTime, task_keyword_client_id = _clientId WHERE task_keyword_id = _taskKeywordUpdateId;
		ELSE
			INSERT INTO task_keyword(task_keyword_marsha_code,task_keyword_no_of_pages,task_keyword_notes,task_keyword_box_location,task_keyword_added_box_date,task_keyword_setup_due_date,task_keyword_setup_complete,task_keyword_due,task_keyword_submitted,task_keyword_user_id,task_keyword_link_db_file,task_keyword_date,task_keyword_client_id,task_keyword_record_status,task_keyword_created_by,task_keyword_created_on,task_keyword_modified_by,task_keyword_modified_on)
			VALUES (_marshaCodeData, _noPagesData,_notesData, _boxLocationData, _boxAddedDateData, _setupDueData, _setupCompleteData, _dueData,
			_submittedData,_userIdData,_linkDbFileData,_taskDateData,_clientId,0,_userId,_dateTime,_userId,_dateTime);
		END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addTaskManagerKeywordForCsv` (IN `_userId` INT(11), IN `_taskKeywordUpdateId` INT(11), IN `_marshaCodeData` INT(11), IN `_noPagesData` VARCHAR(255), IN `_notesData` TEXT, IN `_boxLocationData` VARCHAR(255), IN `_boxAddedDateData` DATE, IN `_setupDueData` DATE, IN `_setupCompleteData` TINYINT(1), IN `_dueData` DATE, IN `_submittedData` TINYINT(1), IN `_userIdData` INT(11), IN `_linkDbFileData` VARCHAR(255), IN `_taskDateData` DATE, IN `_clientId` INT(11), IN `_dateTime` DATETIME)  BEGIN

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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUserEmailExist` (IN `_userEmail` VARCHAR(200))  BEGIN
DECLARE _existId INT DEFAULT 0;
DECLARE _userExist INT DEFAULT 0;
	SELECT user_id INTO _existId FROM user WHERE lower(user_email) = lower(_userEmail);
	SET _existId = IFNULL(_existId, 0);
	IF(_existId > 0) THEN 
		SET _userExist = 1;
	END IF;
	SELECT _userExist as userExist;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkUserNameExist` (IN `_userName` VARCHAR(155))  BEGIN
DECLARE _existId INT DEFAULT 0;
DECLARE _userExist INT DEFAULT 0;
	SELECT user_id INTO _existId FROM user WHERE lower(user_name) = lower(_userName);
	SET _existId = IFNULL(_existId, 0);
	IF(_existId > 0) THEN 
		SET _userExist = 1;
	END IF;
	SELECT _userExist as userExist;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAdminPersonnel` (`_userId` INT(11), `_userDeleteId` INT(11), `_dateTime` DATETIME)  BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE user.user_id = ',_userDeleteId);
	
	SET @IdQry1 = CONCAT(' UPDATE user SET user_record_status = 1 , user_modified_on = ',Quote(_dateTime), ', user_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteTaskManagerContent` (`_userId` INT(11), `_taskContentId` INT(11), `_dateTime` DATETIME)  BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_content SET task_content_record_status = 1 , task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteTaskManagerKeyword` (`_userId` INT(11), `_taskKeywordId` INT(11), `_dateTime` DATETIME)  BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_record_status = 1 , task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `geMarshaIdByMarshaCode` (IN `_marshaCode` VARCHAR(100))  BEGIN
	SELECT client_entity_id
	FROM client_entity 
	WHERE client_entity.client_entity_marsha_code=_marshaCode LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllClients` ()  BEGIN
	SELECT client_id,client_user_id,client_name,client_street,client_city,client_state,client_zipcode,client_country
	client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on
	FROM client 
	WHERE client_record_status = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllServiceTypes` ()  BEGIN
	SELECT serv_type_id,serv_type_name,serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on FROM service_type WHERE serv_type_record_status = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUserRoles` ()  BEGIN
	SELECT user_role_id,user_role_name,user_role_record_status,user_role_created_by,user_role_created_on,user_role_modified_by,user_role_modified_on FROM user_role WHERE user_role_record_status = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getClientsByUserId` (`_userId` INT(11))  BEGIN
	SELECT client_id,client_user_id,client_name,client_street,client_city,client_state,client_zipcode,client_country
	client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on
	FROM client WHERE client_record_status = 0 AND client_user_id = _userId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCsvExistingKeywordByFieldName` (IN `_fieldName` VARCHAR(255), IN `_userId` INT(11), IN `_clientId` INT(11))  BEGIN
	SET @Query = CONCAT('SELECT task_keyword_id, client_entity_marsha_code,  ', _fieldName ,' 
	FROM task_keyword 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	WHERE task_keyword_client_id = ',_clientId, ' AND task_keyword_created_by =', _userId);
	PREPARE stmnt FROM @Query;
	EXECUTE stmnt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCsvImportFields` (IN `_csvImportId` INT)  BEGIN
	SELECT ic_id,  ic_file_name,  ic_skip_header, ic_status,ic_user_id, ic_client_id, icf_ic_id, 
	icf_field_id, icf_field_name,  icf_client_id, icf_is_unique, ic_import_opt
	FROM import_csv_file 
	INNER JOIN import_csv_fields ON ic_id = icf_ic_id 
	WHERE ic_id = _csvImportId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCsvImportFiles` (IN `_status` INT)  BEGIN
	IF(_status = 0)THEN
		SELECT ic_id,  ic_file_name, 
		ic_skip_header, ic_status, ic_user_id, ic_client_id,  ic_import_opt, ic_import_type, ic_import_keyword_date, ic_est_time, import_csv_file.created_date, 
		user.user_id, user_fname, user_lname, user_email
		FROM import_csv_file 
		INNER JOIN user ON user.user_id = import_csv_file.created_by
		WHERE ic_status > 0; 
	ELSE
		SELECT ic_id,  ic_file_name, 
		ic_skip_header, ic_status, ic_user_id, ic_client_id, ic_import_opt, ic_import_type, ic_import_keyword_date, ic_est_time, import_csv_file.created_date, 
		user.user_id, user_fname, user_lname, user_email
		FROM import_csv_file 
		INNER JOIN user ON user.user_id = import_csv_file.created_by
		WHERE ic_status = _status; 
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCsvImportFilesForUser` (IN `_userId` INT)  BEGIN
	SELECT ic_id,  ic_file_name, 
	ic_skip_header, ic_status, ic_user_id, ic_import_opt, ic_import_type, ic_import_keyword_date ic_est_time, import_csv_file.created_date, 
	user.user_id, user_fname, user_lname, user_email
	FROM import_csv_file 
	INNER JOIN user ON user.user_id = import_csv_file.created_by
	WHERE ic_status > 0 AND ic_user_id = _userId ORDER BY ic_id DESC LIMIT 5; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCsvImportUniqueField` (IN `_importId` INT)  BEGIN
	SELECT icf_id, icf_ic_id, icf_field_id, icf_field_name,  icf_user_id, icf_client_id, icf_is_unique 
	FROM import_csv_fields 
	WHERE icf_is_unique = 1 AND icf_ic_id = _importId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDivisionByMarshaCode` (IN `_userId` INT(11), IN `_marshaCode` INT(11))  BEGIN
	SELECT client_entity_id,client_entity_marsha_code,division_id,division_code,division_name
	FROM client_entity 
	INNER JOIN division ON division_id = client_entity_division_id
	WHERE client_entity.client_entity_id=_marshaCode LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getMarshaCodes` (IN `_userId` INT(11))  BEGIN
	SELECT client_entity_id,client_entity_marsha_code,division_id,division_code,division_name
	FROM client_entity 
	INNER JOIN division ON division_id = client_entity_division_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTaskManagerContentById` (`_userId` INT(11), `_taskContentId` INT(11))  BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_content.task_content_id,task_content.task_content_marsha_code,task_content.task_content_service_type_id,task_content.task_content_tire,task_content.task_content_priority,task_content.task_content_added_box_date,task_content.task_content_due_date,task_content.task_content_due_plus_date,task_content.task_content_added_box_due_date,task_content.task_content_rev_req,task_content.task_content_rev_com,task_content.task_content_rev_sec_req,task_content.task_content_rev_sec_com,task_content.task_content_ass_writer_date,task_content.task_content_is_complete,task_content.task_content_proj_com_date,task_content.task_content_user_id,task_content.task_content_no_of_units,task_content.task_content_link_to_file,task_content.task_content_notes,task_content.task_content_record_status,task_content.task_content_created_by,task_content.task_content_created_on,task_content.task_content_modified_by,task_content.task_content_modified_on,service_type.serv_type_id,service_type.serv_type_name
	FROM task_content 
	INNER JOIN user ON user.user_id = task_content.task_content_user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTaskManagerContentList` (`_userId` INT(11), `_filterBy` TINYINT(1), `_userRole` INT(11), `_FromDate` DATE, `_ToDate` DATE, `_Start` INT, `_Limit` INT, `_SortOrder` VARCHAR(100), `_writerId` INT(11), `_clientId` INT(11))  BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskContentManager;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_content.task_content_due_date) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_content.task_content_due_date) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND task_content.task_content_user_id = ", _writerId );
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
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpTaskContentManager engine=memory SELECT SQL_CALC_FOUND_ROWS  task_content_id 
		FROM task_content 
		INNER JOIN user ON user.user_id = task_content.task_content_user_id
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
		LEFT JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_content.task_content_id,task_content.task_content_marsha_code,task_content.task_content_service_type_id,task_content.task_content_tire,task_content.task_content_priority,task_content.task_content_added_box_date,task_content.task_content_due_date,task_content.task_content_due_plus_date,task_content.task_content_added_box_due_date,task_content.task_content_rev_req,task_content.task_content_rev_com,task_content.task_content_rev_sec_req,task_content.task_content_rev_sec_com,task_content.task_content_ass_writer_date,task_content.task_content_is_complete,task_content.task_content_proj_com_date,task_content.task_content_user_id,task_content.task_content_no_of_units,task_content.task_content_link_to_file,task_content.task_content_notes,task_content.task_content_record_status,task_content.task_content_created_by,task_content.task_content_created_on,task_content.task_content_modified_by,task_content.task_content_modified_on,service_type.serv_type_id,service_type.serv_type_name
	FROM task_content 
	INNER JOIN tmpTaskContentManager ON tmpTaskContentManager.task_content_id = task_content.task_content_id
	INNER JOIN user ON user.user_id = task_content.task_content_user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT  JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskContentManager;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTaskManagerKeywordById` (`_userId` INT(11), `_taskKeywordId` INT(11))  BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name, user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_keyword.task_keyword_id,task_keyword.task_keyword_marsha_code,task_keyword.task_keyword_no_of_pages,task_keyword.task_keyword_notes,task_keyword.task_keyword_box_location,task_keyword.task_keyword_added_box_date,task_keyword.task_keyword_setup_due_date,task_keyword.task_keyword_setup_complete,task_keyword.task_keyword_due,task_keyword.task_keyword_submitted,task_keyword.task_keyword_user_id,task_keyword.task_keyword_link_db_file,task_keyword.task_keyword_date,task_keyword.task_keyword_admin_complete,task_keyword.task_keyword_client_id,task_keyword.task_keyword_admin_notes,task_keyword.task_keyword_record_status,task_keyword.task_keyword_created_by,task_keyword.task_keyword_created_on,task_keyword.task_keyword_modified_by,task_keyword.task_keyword_modified_on
	FROM task_keyword 
	INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTaskManagerKeywordList` (`_userId` INT(11), `_filterBy` TINYINT(1), `_userRole` INT(11), `_FromDate` DATE, `_ToDate` DATE, `_Start` INT, `_Limit` INT, `_SortOrder` VARCHAR(100), `_clientId` INT(11))  BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskManager;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_keyword.task_keyword_date) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_keyword.task_keyword_date) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_FromDate && _FromDate = _ToDate && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND DATE(task_keyword.task_keyword_setup_due_date) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 3) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(task_keyword.task_keyword_setup_due_date) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
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
		INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
		INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_keyword.task_keyword_id,task_keyword.task_keyword_marsha_code,task_keyword.task_keyword_no_of_pages,task_keyword.task_keyword_notes,task_keyword.task_keyword_box_location,task_keyword.task_keyword_added_box_date,task_keyword.task_keyword_setup_due_date,task_keyword.task_keyword_setup_complete,task_keyword.task_keyword_due,task_keyword.task_keyword_submitted,task_keyword.task_keyword_user_id,task_keyword.task_keyword_link_db_file,task_keyword.task_keyword_date,task_keyword.task_keyword_admin_complete,task_keyword.task_keyword_client_id,task_keyword.task_keyword_admin_notes,task_keyword.task_keyword_record_status,task_keyword.task_keyword_created_by,task_keyword.task_keyword_created_on,task_keyword.task_keyword_modified_by,task_keyword.task_keyword_modified_on
	FROM task_keyword 
	INNER JOIN tmpTaskManager ON tmpTaskManager.task_keyword_id = task_keyword.task_keyword_id
	INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id ', QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskManager;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserById` (IN `_userId` INT(11))  BEGIN
	SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status
	FROM user 
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	WHERE user.user_id = _userId AND user.user_record_status = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserList` (`_userRole` INT(11), `_userId` INT(11), `_FromDate` DATE, `_ToDate` DATE, `_Start` INT, `_Limit` INT, `_SortOrder` VARCHAR(100))  BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpUser;
	
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(user.user_created_on) =", Quote(_FromDate) );
	ELSEIF(_FromDate ) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(user.user_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
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
	
	SET @IdQry2 = CONCAT(' SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,  user_role.user_role_created_by,  user_role.user_role_created_on,  user_role.user_role_modified_by,  user_role.user_role_modified_on
	FROM user 
	INNER JOIN tmpUser ON tmpUser.user_id = user.user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id ', QryOrder);

	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpUser;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUsersByRole` (IN `_roleId` INT(11))  BEGIN

	DECLARE QryCond TEXT;
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 ');
	IF(_roleId > 0) THEN
		SET QryCond = CONCAT(' AND user_role.user_role_id =  ',_roleId);
	END IF;
	
	SET @IdQry = CONCAT(' SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status 
	FROM user 
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id ', QryCond );
	
	PREPARE stmt1 FROM @IdQry;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCsvImport` (IN `_csvImportId` INT, IN `_hasHeader` TINYINT, IN `_status` INT, IN `_importOpt` INT)  BEGIN
	UPDATE import_csv_file SET ic_skip_header = _hasHeader, ic_status = _status, ic_import_opt =_importOpt  WHERE ic_id = _csvImportId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCsvStatus` (IN `_csvImportId` INT, IN `_status` INT, IN `_sysTime` DATETIME)  BEGIN
	UPDATE import_csv_file SET ic_status = _status, updated_date = _sysTime WHERE ic_id = _csvImportId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateTaskKeywordAdminComplete` (`_userId` INT(11), `_taskKeywordId` INT(11), `_taskKeywordCompleteVal` TINYINT(1), `_dateTime` DATETIME, `_notes` TEXT)  BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	IF(_taskKeywordCompleteVal = 2) THEN
		SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_admin_complete = ',_taskKeywordCompleteVal, ', task_keyword_admin_notes = ',Quote(_notes), ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	ELSE
		SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_admin_complete = ',_taskKeywordCompleteVal, ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	END IF;
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	INSERT INTO task_keyword_admin_complete(tkac_task_keyword_id,tkac_comp_status,tkac_record_status,tkac_created_by,tkac_created_on,tkac_modified_by,tkac_modified_on)
	VALUES (_taskKeywordId,_taskKeywordCompleteVal, 0 ,_userId, _dateTime, _userId, _dateTime);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateTaskKeywordComplete` (`_userId` INT(11), `_taskKeywordId` INT(11), `_taskKeywordCompleteVal` TINYINT(1), `_dateTime` DATETIME)  BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_setup_complete = ',_taskKeywordCompleteVal, ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

CREATE TABLE `billing` (
  `billing_id` int(11) NOT NULL,
  `billing_client_id` int(11) NOT NULL DEFAULT '0',
  `billing_marsha_code` int(11) NOT NULL DEFAULT '0',
  `billing_division_id` int(11) NOT NULL DEFAULT '0',
  `billing_service_type_id` int(11) NOT NULL DEFAULT '0',
  `billing_rate_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `billing_no_of_units` int(11) NOT NULL DEFAULT '0',
  `billing_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `billing_tire` varchar(255) NOT NULL DEFAULT '',
  `billing_user_id` int(11) NOT NULL DEFAULT '0',
  `billing_task_id` int(11) NOT NULL DEFAULT '0',
  `billing_invoice_id` int(11) NOT NULL DEFAULT '0',
  `billing_date` date NOT NULL DEFAULT '0000-00-00',
  `billing_is_qbprocessed` tinyint(1) NOT NULL DEFAULT '0',
  `billing_qbreference_no` varchar(100) NOT NULL DEFAULT '',
  `billing_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `billing_created_by` int(11) NOT NULL DEFAULT '0',
  `billing_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `billing_modified_by` int(11) NOT NULL DEFAULT '0',
  `billing_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `billing_consultant_rate`
--

CREATE TABLE `billing_consultant_rate` (
  `cons_rate_id` int(11) NOT NULL,
  `cons_rate_user_id` int(11) NOT NULL DEFAULT '0',
  `cons_rate_service_type_id` int(11) NOT NULL DEFAULT '0',
  `cons_rate_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `cons_rate_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `cons_rate_created_by` int(11) NOT NULL DEFAULT '0',
  `cons_rate_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cons_rate_modified_by` int(11) NOT NULL DEFAULT '0',
  `cons_rate_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `billing_rate`
--

CREATE TABLE `billing_rate` (
  `rates_id` int(11) NOT NULL,
  `rates_service_type_id` int(11) NOT NULL DEFAULT '0',
  `rates_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `rates_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `rates_created_by` int(11) NOT NULL DEFAULT '0',
  `rates_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rates_modified_by` int(11) NOT NULL DEFAULT '0',
  `rates_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `client_id` int(11) NOT NULL,
  `client_user_id` int(11) NOT NULL DEFAULT '0',
  `client_name` varchar(255) NOT NULL DEFAULT '',
  `client_street` varchar(255) NOT NULL DEFAULT '',
  `client_city` varchar(255) NOT NULL DEFAULT '',
  `client_state` varchar(255) NOT NULL DEFAULT '',
  `client_zipcode` varchar(50) NOT NULL DEFAULT '',
  `client_country` varchar(255) NOT NULL DEFAULT '',
  `client_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `client_created_by` int(11) NOT NULL DEFAULT '0',
  `client_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `client_modified_by` int(11) NOT NULL DEFAULT '0',
  `client_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`client_id`, `client_user_id`, `client_name`, `client_street`, `client_city`, `client_state`, `client_zipcode`, `client_country`, `client_record_status`, `client_created_by`, `client_created_on`, `client_modified_by`, `client_modified_on`) VALUES
(1, 1, 'Marriott ', 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
(2, 1, 'Starwood', 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
(3, 1, 'Better Homes & Gardens', 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
(4, 1, 'Booyah', 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
(5, 1, 'Amplio', 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 0, '2017-11-16 06:19:52', 0, '2017-11-16 06:19:52'),
(6, 1, 'Mattress Merchants', 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 0, '2017-11-16 06:19:52', 0, '2017-11-16 06:19:52'),
(7, 1, 'American Queen Steamboat', 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 0, '2017-11-16 06:19:52', 0, '2017-11-16 06:19:52'),
(8, 1, 'BlueOrange Travel', 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 0, '2017-11-16 06:19:52', 0, '2017-11-16 06:19:52');

-- --------------------------------------------------------

--
-- Table structure for table `client_entity`
--

CREATE TABLE `client_entity` (
  `client_entity_id` int(11) NOT NULL,
  `client_entity_marsha_code` varchar(100) NOT NULL DEFAULT '',
  `client_entity_hotel_name` varchar(255) NOT NULL DEFAULT '',
  `client_entity_street` varchar(255) NOT NULL DEFAULT '',
  `client_entity_city` varchar(255) NOT NULL DEFAULT '',
  `client_entity_state` varchar(255) NOT NULL DEFAULT '',
  `client_entity_zipcode` varchar(50) NOT NULL DEFAULT '',
  `client_entity_country` varchar(255) NOT NULL DEFAULT '',
  `client_entity_client_id` int(11) NOT NULL DEFAULT '0',
  `client_entity_user_id` int(11) NOT NULL DEFAULT '0',
  `client_entity_division_id` int(11) NOT NULL DEFAULT '0',
  `client_entity_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `client_entity_created_by` int(11) NOT NULL DEFAULT '0',
  `client_entity_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `client_entity_modified_by` int(11) NOT NULL DEFAULT '0',
  `client_entity_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_entity`
--

INSERT INTO `client_entity` (`client_entity_id`, `client_entity_marsha_code`, `client_entity_hotel_name`, `client_entity_street`, `client_entity_city`, `client_entity_state`, `client_entity_zipcode`, `client_entity_country`, `client_entity_client_id`, `client_entity_user_id`, `client_entity_division_id`, `client_entity_record_status`, `client_entity_created_by`, `client_entity_created_on`, `client_entity_modified_by`, `client_entity_modified_on`) VALUES
(2, 'EVNMC', 'MH Yerevan', '', '', '', '', 'Armenia', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(3, 'LNZCY', 'CY Linz', '', '', '', '', 'Austria', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(4, 'VIEAT', 'MH Vienna', '', '', '', '', 'Austria', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(5, 'VIECY', 'CY Vienna Schoenbrunn', '', '', '', '', 'Austria', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(6, 'VIEFG', 'CY Vienna Messe', '', '', '', '', 'Austria', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(7, 'VIEHW', 'RH Vienna', '', '', '', '', 'Austria', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(8, 'VIEOX', 'OX Vienna', '', '', '', '', 'Austria', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(9, 'VIESE', 'RH Vienna Imperial Riding School', '', '', '', '', 'Austria', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(10, 'GYDJW', 'JW Baku', '', '', '', '', 'Azerbaijan', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(11, 'MHPBR', 'RH Minsk', '', '', '', '', 'Belarus', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(12, 'BRUBR', 'RH Brussels', '', '', '', '', 'Belgium', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(13, 'BRUCY', 'CY Brussels', '', '', '', '', 'Belgium', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(14, 'BRUDT', 'MH Brussels', '', '', '', '', 'Belgium', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(15, 'GNEMC', 'MH Ghent', '', '', '', '', 'Belgium', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(16, 'BRQCY', 'CY Brno', '', '', '', '', 'Czech republic', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(17, 'PRGAK', 'AK Boscolo Prague', '', '', '', '', 'Czech republic', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(18, 'PRGCY', 'CY Prague City', '', '', '', '', 'Czech republic', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(19, 'PRGDT', 'MH Prague', '', '', '', '', 'Czech republic', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(20, 'PRGPA', 'CY Prague Airport', '', '', '', '', 'Czech republic', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(21, 'PRGPZ', 'CY Pilzen', '', '', '', '', 'Czech republic', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(22, 'CPHAC', 'AC Bella Sky Copenhagen', '', '', '', '', 'Denmark', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(23, 'CPHDK', 'MH Copenhagen', '', '', '', '', 'Denmark', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(24, 'MCMCD', 'MH Cap D\'Ail', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(25, 'MRSAR', 'AC Marseille', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(26, 'NCEAC', 'AC Nice', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(27, 'NCEAK', 'AK Boscolo Exedra Nice', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(28, 'NCEJW', 'JW Cannes', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(29, 'PARAL', 'AC Paris le Bourget', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(30, 'PARAR', 'AC Paris Porte Maillot', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(31, 'PARBB', 'CY Paris Boulogne', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(32, 'PARCF', 'CY Paris Colombes', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(33, 'PARDT', 'MH Paris Champs-Elysees', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(34, 'PARLD', 'RH Paris La Defense', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(35, 'PARMC', 'MH Paris Charles de Gaulle Airport', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(36, 'PAROA', 'MH Paris Opera Ambassador', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(37, 'PARPR', 'RH Paris Republique', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(38, 'PARSD', 'CY Paris Saint Denis', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(39, 'PARSP', 'RH Paris Le Parc Trocad?ro', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(40, 'PARST', 'MH Paris Rive Gauche', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(41, 'PARVD', 'RH Paris Vendome', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(42, 'PARWG', 'RH Paris Arc de Triomphe', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(43, 'PARXA', 'Courtyard Paris Charles de Gaulle Airport', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(44, 'TLSCY', 'CY Toulouse Airport', '', '', '', '', 'France', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(45, 'TBSMC', 'MH Tbilisi', '', '', '', '', 'Georgia', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(46, 'BERAK', 'AK Berlin', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(47, 'BERMC', 'MH Berlin', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(48, 'BERMT', 'CY Berlin City Center', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(49, 'CGNCY', 'CY Cologne', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(50, 'CGNMC', 'MH Cologne', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(51, 'DUSCY', 'CY Duesseldorf Seestern', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(52, 'DUSHF', 'CY Duesseldorf Hafen', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(53, 'DUSRN', 'RH Duesseldorf', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(54, 'FRADT', 'MH Frankfurt', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(55, 'FRAOH', 'OX Frankfurt City East', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(56, 'FRAWB', 'CY Wiesbaden-Nordenstadt', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(57, 'HAMDT', 'MH Hamburg', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(58, 'HAMRN', 'RH Hamburg', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(59, 'HDBMC', 'MH Heidelberg', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(60, 'LEJDT', 'MH Leipzig', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(61, 'MUCCY', 'CY Munich City Center', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(62, 'MUCFR', 'MH Munich Airport', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(63, 'MUCNO', 'MH Munich', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(64, 'ZPZDE', 'MH Stuttgart Sindelfingen', '', '', '', '', 'Germany', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(65, 'BUDAK', 'AK Boscolo Budapest', '', '', '', '', 'Hungary', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(66, 'BUDCY', 'CY Budapest', '', '', '', '', 'Hungary', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(67, 'BUDHU', 'MH Budapest', '', '', '', '', 'Hungary', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(68, 'DUBAK', 'AK Powerscourt', '', '', '', '', 'Ireland', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(69, 'DUBBR', 'RH The Shelbourne', '', '', '', '', 'Ireland', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(70, 'LCVBR', 'RH Tuscany Il Ciocco Resort & Spa', '', '', '', '', 'Italy', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(71, 'MILEX', 'AK Boscolo Milano', '', '', '', '', 'Italy', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(72, 'MILIT', 'Milan Marriott Hotel', '', '', '', '', 'Italy', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(73, 'ROMCP', 'CY Rome Central Park', '', '', '', '', 'Italy', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(74, 'ROMEX', 'AK Boscolo Exedra Roma', '', '', '', '', 'Italy', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(75, 'VCEJW', 'JW Venice', '', '', '', '', 'Italy', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(76, 'TSEMC', 'MH Astana', '', '', '', '', 'Kazakhstan', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(77, 'SKPMC', 'MH Skopje', '', '', '', '', 'Macedonia', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(78, 'AMSCY', 'CY Amsterdam Airport', '', '', '', '', 'Netherlands', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(79, 'AMSNT', 'MH Amsterdam', '', '', '', '', 'Netherlands', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(80, 'AMSRD', 'RH Amsterdam', '', '', '', '', 'Netherlands', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(81, 'RTMMC', 'MH The Hague', '', '', '', '', 'Netherlands', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(82, 'WAWCY', 'CY Warsaw Airport', '', '', '', '', 'Poland', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(83, 'WAWPL', 'MH Warsaw', '', '', '', '', 'Poland', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(84, 'LISAK', 'AK Fontecruz Lisboa', '', '', '', '', 'Portugal', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(85, 'LISPT', 'MH Lisbon', '', '', '', '', 'Portugal', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(86, 'BUHRO', 'JW Bucharest', '', '', '', '', 'Romania', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(87, 'AERMC', 'MH Sochi Krasnaya Polyana', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(88, 'KUFBR', 'RH Samara', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(89, 'LEDBR', 'RH St. Petersburg', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(90, 'LEDCY', 'CY St. Petersburg Vasiliewsky', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(91, 'MOWBR', 'RH Moscow Monarch Centre', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(92, 'MOWCY', 'CY Moscow City Centre', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(93, 'MOWDT', 'MH Moscow Royal Aurora', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(94, 'MOWGR', 'MH Moscow Grand', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(95, 'MOWNA', 'MH Moscow Novy Arbat', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(96, 'MOWPV', 'CY Moscow Paveletskaya', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(97, 'MOWTV', 'MH Moscow Tverskaya', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(98, 'OVBMC', 'MH Novosibirsk', '', '', '', '', 'Russian federation', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(99, 'BEGCY', 'CY Belgrade', '', '', '', '', 'Serbia', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(100, 'CPTBR', 'Protea Hotel Cape Town Waterfront Breakwater Lodge', '', '', '', '', 'South africa', 1, 0, 2, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(101, 'CPTCF', 'Protea Hotel Fire & Ice Cape Town', '', '', '', '', 'South africa', 1, 0, 2, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(102, 'CPTST', 'Protea Hotel Stellenbosch', '', '', '', '', 'South africa', 1, 0, 2, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(103, 'DURED', 'Protea Hotel Durban Edward', '', '', '', '', 'South africa', 1, 0, 2, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(104, 'JNBMG', 'African Pride Mount Grace Country House & Spa', '', '', '', '', 'South africa', 1, 0, 2, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(105, 'JNBOR', 'Protea Hotel O.R. Tambo Airport', '', '', '', '', 'South africa', 1, 0, 2, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(106, 'PRYWA', 'Protea Hotel Pretoria Centurion', '', '', '', '', 'South africa', 1, 0, 2, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(107, 'BCNDM', 'RH Barcelona', '', '', '', '', 'Spain', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(108, 'STOCY', 'CY Stockholm Kungsholmen', '', '', '', '', 'Sweden', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(109, 'ZRHDT', 'MH Zurich', '', '', '', '', 'Switzerland', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(110, 'ADBBR', 'RH Izmir', '', '', '', '', 'Turkey', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(111, 'ESBJW', 'JW Ankara', '', '', '', '', 'Turkey', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(112, 'ISTCY', 'CY Istanbul Airport', '', '', '', '', 'Turkey', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(113, 'ISTDT', 'MH Istanbul Sisli', '', '', '', '', 'Turkey', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(114, 'ABZAP', 'MH Aberdeen', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(115, 'ABZCY', 'CY Aberdeen', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(116, 'ABZRI', 'RI Aberdeen', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(117, 'BHXAC', 'AC Birmingham', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(118, 'BHXBH', 'MH Birmingham', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(119, 'BLKBP', 'MH Preston', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(120, 'BOHBM', 'MH Bournemouth', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(121, 'BRSDT', 'MH Bristol City Centre', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(122, 'BRSRY', 'MH Bristol Royal', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(123, 'CBGHD', 'MH Huntingdon', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(124, 'CVTGS', 'MH Forest of Arden', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(125, 'CWLDT', 'MH Cardiff', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(126, 'CWLGS', 'MH St Pierre', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(127, 'EDIEB', 'MH Edinburgh', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(128, 'EDIHW', 'CY Edinburgh West', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(129, 'EDIRI', 'RI Edinburgh', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(130, 'EMAGS', 'MH Breadsall Priory', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(131, 'EMALM', 'MH Leicester', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(132, 'GLACA', 'CY Glasgow Airport', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(133, 'GLADT', 'MH Glasgow', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(134, 'LBADT', 'MH Leeds', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(135, 'LBAGS', 'MH Hollins Hall', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(136, 'LGWCY', 'CY London Gatwick Airport', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(137, 'LGWGS', 'MH Lingfield Park', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(138, 'LHRBR', 'RH London Heathrow', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(139, 'LHRHR', 'MH Heathrow', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(140, 'LHRSL', 'MH Heathrow Windsor', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(141, 'LONAK', 'AK Threadneedles', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(142, 'LONBH', 'MH Bexleyheath', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(143, 'LONCH', 'MH London County Hall', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(144, 'LONCW', 'MH London West India Quay', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(145, 'LONDT', 'MH London Grosvenor Square', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(146, 'LONER', 'MEA London', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(147, 'LONGH', 'JW London Grosvenor House', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(148, 'LONLM', 'MH London Kensington', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(149, 'LONMA', 'MH London Marble Arch', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(150, 'LONPL', 'MH London Park Lane', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(151, 'LONPR', 'RH London St. Pancras', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(152, 'LONRP', 'MH London Regents Park', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(153, 'LONSE', 'AK St. Ermin\'s', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(154, 'LONTW', 'MH London Twickenham', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(155, 'LONWA', 'MH Waltham Abbey', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(156, 'LONWH', 'MH London Maida Vale', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(157, 'LONXE', 'AK London Xenia', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(158, 'LPLLP', 'MH Liverpool', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(159, 'MANAC', 'AC Manchester', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(160, 'MANAP', 'MH Manchester Airport', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(161, 'MANBR', 'RH Manchester', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(162, 'MANGS', 'MH Worsley Park', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(163, 'MANVA', 'MH Manchester Victoria & Albert', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(164, 'NCLGF', 'MH Newcastle Gosforth Park', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(165, 'NCLGH', 'MH Newcastle MetroCentre', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(166, 'NCLSL', 'MH Sunderland', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(167, 'NWIGS', 'MH Sprowston Manor', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(168, 'ORMNH', 'MH Northampton', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(169, 'PMEHA', 'MH Portsmouth', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(170, 'QQYYK', 'MH York', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(171, 'SOUGS', 'MH Meon Valley', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(172, 'STNCH', 'MH Cheshunt', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(173, 'STNGS', 'MH Hanbury Manor', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(174, 'SWIDT', 'MH Swindon', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(175, 'SWSDT', 'MH Swansea', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(176, 'TDMGS', 'MH Tudor Park', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(177, 'XVHPB', 'MH Peterborough', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(178, 'XVUDM', 'MH Durham', '', '', '', '', 'United kingdom', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(179, 'LUNLS', 'Protea Hotel Lusaka', '', '', '', '', 'Zambia', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(180, 'LVILI', 'Protea Hotel Livingstone', '', '', '', '', 'Zambia', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(181, 'BUSAK', 'Paragraph Resort & Spa Shekvetili, Autograph Collection', '', '', '', '', '', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(182, 'FLRAK', 'Sina Villa Medici, Autograph Collection', '', '', '', '', '', 1, 0, 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48');

-- --------------------------------------------------------

--
-- Table structure for table `consultant_skill`
--

CREATE TABLE `consultant_skill` (
  `cons_skill_id` int(11) NOT NULL,
  `cons_service_type_id` int(11) NOT NULL DEFAULT '0',
  `cons_user_id` int(11) NOT NULL DEFAULT '0',
  `cons_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `cons_created_by` int(11) NOT NULL DEFAULT '0',
  `cons_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cons_modified_by` int(11) NOT NULL DEFAULT '0',
  `cons_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cron_jobs`
--

CREATE TABLE `cron_jobs` (
  `cronId` int(11) NOT NULL,
  `cronFile` varchar(256) NOT NULL,
  `cronDescription` mediumtext NOT NULL,
  `cronIsRun` int(11) NOT NULL COMMENT '0=>Not Run the File, 1=> Run the File'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cron_jobs`
--

INSERT INTO `cron_jobs` (`cronId`, `cronFile`, `cronDescription`, `cronIsRun`) VALUES
(1, 'importCsvKeyword.php', 'Import Csv Task keyword in cron', 0);

-- --------------------------------------------------------

--
-- Table structure for table `division`
--

CREATE TABLE `division` (
  `division_id` int(11) NOT NULL,
  `division_code` varchar(50) NOT NULL DEFAULT '',
  `division_name` varchar(255) NOT NULL DEFAULT '',
  `division_client_id` int(11) NOT NULL DEFAULT '0',
  `division_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `division_created_by` int(11) NOT NULL DEFAULT '0',
  `division_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `division_modified_by` int(11) NOT NULL DEFAULT '0',
  `division_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `division`
--

INSERT INTO `division` (`division_id`, `division_code`, `division_name`, `division_client_id`, `division_record_status`, `division_created_by`, `division_created_on`, `division_modified_by`, `division_modified_on`) VALUES
(1, 'EU', 'European Union hotels', 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(2, 'NON EU', 'Non European Union hotels', 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48');

-- --------------------------------------------------------

--
-- Table structure for table `form`
--

CREATE TABLE `form` (
  `form_id` int(11) NOT NULL,
  `form_user_id` int(11) NOT NULL DEFAULT '0',
  `form_w_nine` varchar(255) NOT NULL DEFAULT '',
  `form_first_name` varchar(255) NOT NULL DEFAULT '',
  `form_last_name` varchar(255) NOT NULL DEFAULT '',
  `form_email` varchar(100) NOT NULL DEFAULT '',
  `form_contact_no` varchar(50) NOT NULL DEFAULT '',
  `form_city` varchar(255) NOT NULL DEFAULT '',
  `form_state` varchar(255) NOT NULL DEFAULT '',
  `form_zipcode` varchar(100) NOT NULL DEFAULT '',
  `form_country` varchar(255) NOT NULL DEFAULT '',
  `form_resume` varchar(255) NOT NULL DEFAULT '',
  `form_ach` varchar(255) NOT NULL DEFAULT '',
  `form_consultant_agree` varchar(255) NOT NULL DEFAULT '',
  `form_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `form_created_by` int(11) NOT NULL DEFAULT '0',
  `form_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `form_modified_by` int(11) NOT NULL DEFAULT '0',
  `form_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `import_csv_fields`
--

CREATE TABLE `import_csv_fields` (
  `icf_id` int(11) NOT NULL,
  `icf_ic_id` int(11) NOT NULL DEFAULT '0',
  `icf_field_id` int(11) NOT NULL DEFAULT '0',
  `icf_field_name` varchar(250) NOT NULL DEFAULT '',
  `icf_user_id` int(11) NOT NULL DEFAULT '0',
  `icf_client_id` int(11) NOT NULL DEFAULT '0',
  `icf_is_unique` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `import_csv_fields`
--

INSERT INTO `import_csv_fields` (`icf_id`, `icf_ic_id`, `icf_field_id`, `icf_field_name`, `icf_user_id`, `icf_client_id`, `icf_is_unique`) VALUES
(1, 2, 0, 'MARSHA', 1, 1, 0),
(2, 2, 1, 'Number of Pages', 1, 1, 0),
(3, 2, 2, 'Notes', 1, 1, 0),
(4, 2, 3, 'BOX Link', 1, 1, 0),
(5, 2, 4, 'Date Added to BOX', 1, 1, 0),
(6, 2, 5, 'Keyword File Set Up Due', 1, 1, 0),
(7, 2, 6, 'Keywords Due', 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `import_csv_file`
--

CREATE TABLE `import_csv_file` (
  `ic_id` int(11) NOT NULL,
  `ic_file_name` varchar(500) NOT NULL DEFAULT '',
  `ic_skip_header` tinyint(1) NOT NULL DEFAULT '0',
  `ic_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=>incomplete, 1=>queue, 2=>in process,3=>complete',
  `ic_user_id` int(11) NOT NULL DEFAULT '0',
  `ic_client_id` int(11) NOT NULL DEFAULT '0',
  `ic_unique_field` int(11) NOT NULL DEFAULT '0',
  `ic_import_opt` int(11) NOT NULL DEFAULT '0',
  `ic_import_type` tinyint(1) NOT NULL DEFAULT '0',
  `ic_import_keyword_date` date NOT NULL DEFAULT '0000-00-00',
  `ic_est_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ic_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `import_csv_file`
--

INSERT INTO `import_csv_file` (`ic_id`, `ic_file_name`, `ic_skip_header`, `ic_status`, `ic_user_id`, `ic_client_id`, `ic_unique_field`, `ic_import_opt`, `ic_import_type`, `ic_import_keyword_date`, `ic_est_time`, `ic_record_status`, `created_by`, `created_date`, `updated_date`) VALUES
(1, '2017_12_11_09_31_Keyword_Delivery_Schedule.csv', 0, 0, 1, 1, 0, 0, 1, '2017-11-01', '0000-00-00 00:00:00', 0, 1, '2017-12-11 09:31:16', '2017-12-11 09:31:16'),
(2, '2017_12_11_09_33_Keyword_Delivery_Schedule.csv', 1, 3, 1, 1, 0, 0, 1, '2017-11-01', '0000-00-00 00:00:00', 0, 1, '2017-12-11 09:33:45', '2017-12-11 09:34:03');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL,
  `invoice_client_id` int(11) NOT NULL DEFAULT '0',
  `invoice_marsha_code` int(11) NOT NULL DEFAULT '0',
  `invoice_division_id` int(11) NOT NULL DEFAULT '0',
  `invoice_service_type_id` int(11) NOT NULL DEFAULT '0',
  `invoice_no_of_units` int(11) NOT NULL DEFAULT '0',
  `invoice_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `invoice_tire` varchar(255) NOT NULL DEFAULT '',
  `invoice_user_id` int(11) NOT NULL DEFAULT '0',
  `invoice_task_id` int(11) NOT NULL DEFAULT '0',
  `invoice_date` date NOT NULL DEFAULT '0000-00-00',
  `invoice_is_qbprocessed` tinyint(1) NOT NULL DEFAULT '0',
  `invoice_qbreference_no` varchar(100) NOT NULL DEFAULT '',
  `invoice_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `invoice_created_by` int(11) NOT NULL DEFAULT '0',
  `invoice_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoice_modified_by` int(11) NOT NULL DEFAULT '0',
  `invoice_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_rate`
--

CREATE TABLE `invoice_rate` (
  `invoice_rate_id` int(11) NOT NULL,
  `invoice_rate_client_id` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_service_type_id` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_division_id` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `invoice_rate_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `invoice_rate_created_by` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoice_rate_modified_by` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `modules_id` int(11) NOT NULL,
  `modules_name` varchar(255) NOT NULL DEFAULT '',
  `modules_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `modules_created_by` int(11) NOT NULL DEFAULT '0',
  `modules_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modules_modified_by` int(11) NOT NULL DEFAULT '0',
  `modules_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `notification_user_id` int(11) NOT NULL DEFAULT '0',
  `notification_module` varchar(255) NOT NULL DEFAULT '',
  `notification_email` varchar(100) NOT NULL DEFAULT '',
  `notification_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `notification_created_by` int(11) NOT NULL DEFAULT '0',
  `notification_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `notification_modified_by` int(11) NOT NULL DEFAULT '0',
  `notification_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `service_type`
--

CREATE TABLE `service_type` (
  `serv_type_id` int(11) NOT NULL,
  `serv_type_name` text NOT NULL,
  `serv_type_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `serv_type_created_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `serv_type_modified_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service_type`
--

INSERT INTO `service_type` (`serv_type_id`, `serv_type_name`, `serv_type_record_status`, `serv_type_created_by`, `serv_type_created_on`, `serv_type_modified_by`, `serv_type_modified_on`) VALUES
(1, 'Meta + Content', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
(2, 'Photo Gallery Optimization', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
(3, 'Refersh + Content + Meta', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
(4, 'Meta', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20');

-- --------------------------------------------------------

--
-- Table structure for table `task_content`
--

CREATE TABLE `task_content` (
  `task_content_id` int(11) NOT NULL,
  `task_content_marsha_code` int(11) NOT NULL DEFAULT '0',
  `task_content_service_type_id` int(11) NOT NULL DEFAULT '0',
  `task_content_tire` varchar(255) NOT NULL DEFAULT '',
  `task_content_priority` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_added_box_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_due_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_due_plus_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_added_box_due_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_rev_req` date NOT NULL DEFAULT '0000-00-00',
  `task_content_rev_com` date NOT NULL DEFAULT '0000-00-00',
  `task_content_rev_sec_req` date NOT NULL DEFAULT '0000-00-00',
  `task_content_rev_sec_com` date NOT NULL DEFAULT '0000-00-00',
  `task_content_ass_writer_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_is_complete` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_proj_com_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_user_id` int(11) NOT NULL DEFAULT '0',
  `task_content_client_id` int(11) NOT NULL DEFAULT '0',
  `task_content_no_of_units` int(11) NOT NULL DEFAULT '0',
  `task_content_link_to_file` varchar(255) NOT NULL DEFAULT '',
  `task_content_notes` text NOT NULL,
  `task_content_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_created_by` int(11) NOT NULL DEFAULT '0',
  `task_content_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `task_content_modified_by` int(11) NOT NULL DEFAULT '0',
  `task_content_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_content`
--

INSERT INTO `task_content` (`task_content_id`, `task_content_marsha_code`, `task_content_service_type_id`, `task_content_tire`, `task_content_priority`, `task_content_added_box_date`, `task_content_due_date`, `task_content_due_plus_date`, `task_content_added_box_due_date`, `task_content_rev_req`, `task_content_rev_com`, `task_content_rev_sec_req`, `task_content_rev_sec_com`, `task_content_ass_writer_date`, `task_content_is_complete`, `task_content_proj_com_date`, `task_content_user_id`, `task_content_client_id`, `task_content_no_of_units`, `task_content_link_to_file`, `task_content_notes`, `task_content_record_status`, `task_content_created_by`, `task_content_created_on`, `task_content_modified_by`, `task_content_modified_on`) VALUES
(1, 8, 1, 'NOV BATCH', 0, '2017-11-10', '2017-11-10', '2017-11-15', '2017-11-10', '2017-11-15', '2017-11-15', '2017-11-15', '2017-11-15', '2017-11-16', 1, '2017-11-23', 4, 1, 11, 'test', 'test', 0, 1, '2017-11-22 10:04:57', 1, '2017-11-23 06:11:10'),
(2, 9, 2, 'NOV BATCH', 1, '2017-11-10', '2017-11-20', '2017-11-25', '2017-11-20', '2017-11-20', '2017-11-20', '2017-11-20', '2017-11-20', '2017-11-21', 0, '2017-11-23', 6, 1, 11, 'test', 'test jalal', 0, 1, '2017-11-22 10:05:36', 1, '2017-11-23 06:11:21'),
(5, 24, 3, 'Aug Batch', 0, '2017-11-10', '2017-11-11', '2017-11-16', '2017-11-12', '2017-11-13', '2017-11-14', '2017-11-15', '2017-11-16', '2017-11-17', 1, '2017-11-18', 5, 1, 11, 'test', 'test', 1, 1, '2017-11-23 06:19:23', 1, '2017-11-23 06:19:23'),
(6, 2, 2, '', 1, '0000-00-00', '2017-11-08', '2017-11-13', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', 1, '0000-00-00', 3, 1, 0, '', '', 0, 1, '2017-11-28 10:27:13', 1, '2017-12-12 11:49:50'),
(7, 2, 4, '', 0, '0000-00-00', '2017-11-08', '2017-11-13', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', 0, '0000-00-00', 3, 1, 0, '', '', 0, 1, '2017-11-28 10:27:27', 1, '2017-11-28 10:27:27'),
(8, 2, 1, '', 0, '0000-00-00', '2017-11-16', '2017-11-21', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', 0, '0000-00-00', 3, 1, 0, '', 'test', 0, 1, '2017-11-28 10:41:07', 1, '2017-12-12 09:39:20'),
(9, 9, 0, '', 0, '2017-11-09', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', 0, '0000-00-00', 5, 1, 0, '', '', 0, 1, '2017-11-28 13:14:28', 1, '2017-11-28 13:14:28'),
(10, 9, 1, '', 0, '2017-11-09', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', 0, '0000-00-00', 5, 1, 0, '', '', 0, 1, '2017-11-28 13:18:17', 1, '2017-11-28 13:21:11'),
(11, 2, 0, '', 0, '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', '0000-00-00', 0, '0000-00-00', 6, 1, 0, '', '', 1, 1, '2017-11-28 13:22:07', 1, '2017-12-01 05:12:51'),
(12, 2, 1, 'test', 1, '2017-12-01', '2017-12-02', '2017-12-07', '0000-00-00', '2017-12-03', '2017-12-06', '2017-12-13', '2017-12-20', '2017-12-21', 1, '0000-00-00', 3, 1, 2, 'test', 'test', 0, 1, '2017-12-12 11:50:34', 1, '2017-12-12 11:50:34'),
(13, 2, 1, 'test', 1, '2017-12-07', '2017-12-08', '2017-12-13', '0000-00-00', '2017-12-09', '2017-12-09', '2017-12-11', '2017-12-21', '2017-12-15', 1, '0000-00-00', 3, 1, 2, 'ts', 'test', 0, 1, '2017-12-12 11:52:13', 1, '2017-12-12 11:52:13'),
(14, 5, 2, 'test', 1, '2017-12-21', '2017-12-23', '2017-12-28', '2017-12-12', '2017-12-20', '2017-12-27', '2017-12-29', '2017-12-28', '2017-12-30', 1, '0000-00-00', 4, 1, 3, 'test', 'test', 0, 1, '2017-12-12 11:53:20', 1, '2017-12-12 11:53:20');

-- --------------------------------------------------------

--
-- Table structure for table `task_keyword`
--

CREATE TABLE `task_keyword` (
  `task_keyword_id` int(11) NOT NULL,
  `task_keyword_marsha_code` int(11) NOT NULL DEFAULT '0',
  `task_keyword_no_of_pages` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_notes` text NOT NULL,
  `task_keyword_box_location` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_added_box_date` date NOT NULL DEFAULT '0000-00-00',
  `task_keyword_setup_due_date` date NOT NULL DEFAULT '0000-00-00',
  `task_keyword_setup_complete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=Incomplete,1=Completed',
  `task_keyword_due` date NOT NULL DEFAULT '0000-00-00',
  `task_keyword_submitted` tinyint(1) NOT NULL DEFAULT '0',
  `task_keyword_user_id` int(11) NOT NULL DEFAULT '0',
  `task_keyword_link_db_file` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_date` date NOT NULL DEFAULT '0000-00-00',
  `task_keyword_admin_complete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=Incompleted, 1=Completed,2=Reassigned',
  `task_keyword_client_id` int(11) NOT NULL DEFAULT '0',
  `task_keyword_admin_notes` text NOT NULL,
  `task_keyword_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `task_keyword_created_by` int(11) NOT NULL DEFAULT '0',
  `task_keyword_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `task_keyword_modified_by` int(11) NOT NULL DEFAULT '0',
  `task_keyword_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_keyword`
--

INSERT INTO `task_keyword` (`task_keyword_id`, `task_keyword_marsha_code`, `task_keyword_no_of_pages`, `task_keyword_notes`, `task_keyword_box_location`, `task_keyword_added_box_date`, `task_keyword_setup_due_date`, `task_keyword_setup_complete`, `task_keyword_due`, `task_keyword_submitted`, `task_keyword_user_id`, `task_keyword_link_db_file`, `task_keyword_date`, `task_keyword_admin_complete`, `task_keyword_client_id`, `task_keyword_admin_notes`, `task_keyword_record_status`, `task_keyword_created_by`, `task_keyword_created_on`, `task_keyword_modified_by`, `task_keyword_modified_on`) VALUES
(1, 2, '1', 'Global Client Services', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-02', '2017-11-07', 1, '2017-11-07', 0, 8, 'test', '2017-11-01', 1, 1, 'test', 0, 1, '2017-12-11 09:34:03', 8, '2017-12-11 11:21:33'),
(2, 3, '2', 'Global Client Services', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-02', '2017-11-07', 0, '2017-11-07', 0, 8, '', '2017-11-01', 2, 1, 'test reassign', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 11:25:15'),
(3, 4, '3', 'Global Client Services', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-02', '2017-11-07', 0, '2017-11-07', 0, 8, '', '2017-11-01', 0, 1, '', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
(4, 5, '2', 'Global Client Services', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-10', '2017-11-15', 0, '2017-11-15', 0, 8, '', '2017-11-01', 0, 1, '', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
(5, 6, '3', 'EU', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-10', '2017-11-15', 0, '2017-11-15', 0, 8, '', '2017-11-01', 0, 1, '', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
(6, 7, '4', 'Global Client Services', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-13', '2017-11-18', 0, '2017-11-18', 0, 8, '', '2017-11-01', 0, 1, '', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
(7, 8, '5', 'Global Client Services', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-13', '2017-11-18', 0, '2017-11-18', 0, 8, '', '2017-11-01', 0, 1, '', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
(8, 9, '3', 'Global Client Services', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-15', '2017-11-20', 0, '2017-11-20', 0, 8, '', '2017-11-01', 0, 1, '', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
(9, 10, '6', 'EU', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-16', '2017-11-21', 1, '2017-11-21', 0, 8, '', '2017-11-01', 2, 1, 'reassign test', 0, 1, '2017-12-11 09:34:03', 8, '2017-12-11 11:22:06'),
(10, 11, '7', 'EU', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-17', '2017-11-22', 0, '2017-11-22', 0, 8, '', '2017-11-01', 0, 1, '', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
(11, 2, '', '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 3, '', '0000-00-00', 0, 1, '', 1, 1, '2017-12-11 10:56:29', 1, '2017-12-11 10:56:45');

-- --------------------------------------------------------

--
-- Table structure for table `task_keyword_admin_complete`
--

CREATE TABLE `task_keyword_admin_complete` (
  `tkac_id` int(11) NOT NULL,
  `tkac_task_keyword_id` int(11) NOT NULL DEFAULT '0',
  `tkac_comp_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=Completed, 2=Reassigned',
  `tkac_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `tkac_created_by` int(11) NOT NULL DEFAULT '0',
  `tkac_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tkac_modified_by` int(11) NOT NULL DEFAULT '0',
  `tkac_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_keyword_admin_complete`
--

INSERT INTO `task_keyword_admin_complete` (`tkac_id`, `tkac_task_keyword_id`, `tkac_comp_status`, `tkac_record_status`, `tkac_created_by`, `tkac_created_on`, `tkac_modified_by`, `tkac_modified_on`) VALUES
(1, 1, 1, 0, 1, '2017-12-11 10:48:11', 1, '2017-12-11 10:48:11'),
(2, 1, 2, 0, 1, '2017-12-11 10:55:20', 1, '2017-12-11 10:55:20'),
(3, 1, 1, 0, 1, '2017-12-11 10:55:24', 1, '2017-12-11 10:55:24'),
(4, 9, 2, 0, 1, '2017-12-11 11:12:39', 1, '2017-12-11 11:12:39'),
(5, 2, 2, 0, 1, '2017-12-11 11:25:15', 1, '2017-12-11 11:25:15');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_salutation` varchar(5) NOT NULL DEFAULT '',
  `user_fname` varchar(155) NOT NULL DEFAULT '',
  `user_lname` varchar(155) NOT NULL DEFAULT '',
  `user_image` varchar(250) NOT NULL DEFAULT '',
  `user_email` varchar(150) NOT NULL DEFAULT '',
  `user_password` varchar(32) NOT NULL DEFAULT '',
  `user_address` text NOT NULL,
  `user_notes` text NOT NULL,
  `user_city` varchar(155) NOT NULL DEFAULT '',
  `user_state` varchar(155) NOT NULL DEFAULT '',
  `user_country` varchar(155) NOT NULL DEFAULT '',
  `user_zip` varchar(20) NOT NULL DEFAULT '',
  `user_role_id` int(11) NOT NULL DEFAULT '0',
  `user_job_title` varchar(155) NOT NULL DEFAULT '',
  `user_record_status` tinyint(2) NOT NULL DEFAULT '0',
  `user_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_created_by` int(11) NOT NULL DEFAULT '0',
  `user_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_modified_by` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_salutation`, `user_fname`, `user_lname`, `user_image`, `user_email`, `user_password`, `user_address`, `user_notes`, `user_city`, `user_state`, `user_country`, `user_zip`, `user_role_id`, `user_job_title`, `user_record_status`, `user_created_on`, `user_created_by`, `user_modified_on`, `user_modified_by`) VALUES
(1, 'Mr', 'Vasanthraj', 'Kirubanandhan', '', 'vasanth@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 0, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48', 1),
(2, '', 'Sekki', 'Kumaravel', '', 'sekki@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 0, '2017-11-16 06:15:44', 1, '2017-11-16 06:15:44', 1),
(3, '', 'Bala', 'Krishana', '', 'bala@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 0, '2017-11-16 06:16:20', 1, '2017-11-16 06:19:52', 1),
(4, '', 'Vignesh', 'John', '', 'vignesh@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 0, '2017-11-16 06:16:20', 1, '2017-11-16 06:19:52', 1),
(5, '', 'Karthi', 'Kumar', '', 'karthi@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 0, '2017-11-16 06:16:20', 1, '2017-11-16 06:19:52', 1),
(6, '', 'Jalal', 'Moulabi', '', 'jalal@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 0, '2017-11-16 06:16:20', 1, '2017-11-16 06:19:52', 1),
(7, '', 'Sathish', 'Test', '', 'ak@usaweb.net', '9ddc44f3f7f78da5781d6cab571b2fc5', '', '', '', '', '', '', 1, '', 1, '2017-11-23 08:19:46', 1, '2017-11-23 08:19:46', 1),
(8, '', 'Jill', 'Jill', '', 'jill@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 0, '2017-11-29 08:19:47', 1, '2017-11-29 08:19:47', 1),
(9, '', 'sugan', 'raj', '', 'sugan@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2017-12-01 05:17:14', 1, '2017-12-01 05:17:22', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_permission`
--

CREATE TABLE `user_permission` (
  `user_permission` int(11) NOT NULL,
  `user_permission_user_id` int(11) NOT NULL DEFAULT '0',
  `user_permission_mod_id` int(11) NOT NULL DEFAULT '0',
  `user_permission_is_access` tinyint(1) NOT NULL DEFAULT '0',
  `user_permission_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `user_permission_created_by` int(11) NOT NULL DEFAULT '0',
  `user_permission_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_permission_modified_by` int(11) NOT NULL DEFAULT '0',
  `user_permission_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `user_role_id` int(11) NOT NULL,
  `user_role_name` varchar(100) NOT NULL DEFAULT '',
  `user_role_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `user_role_created_by` int(11) NOT NULL DEFAULT '0',
  `user_role_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_role_modified_by` int(11) NOT NULL DEFAULT '0',
  `user_role_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`user_role_id`, `user_role_name`, `user_role_record_status`, `user_role_created_by`, `user_role_created_on`, `user_role_modified_by`, `user_role_modified_on`) VALUES
(1, 'Full Access', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(2, 'Billing', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(3, 'Project Manager', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
(4, 'Consultant', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48');

-- --------------------------------------------------------

--
-- Table structure for table `user_session`
--

CREATE TABLE `user_session` (
  `session_id` int(11) NOT NULL,
  `session_key` varchar(150) NOT NULL DEFAULT '',
  `session_user_id` int(11) NOT NULL DEFAULT '0',
  `session_login_ip` varchar(50) NOT NULL DEFAULT '',
  `session_login_status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '0-Logout, 1 - login, 2 - login in another system',
  `session_login_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0-User, 1-Admin',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_session`
--

INSERT INTO `user_session` (`session_id`, `session_key`, `session_user_id`, `session_login_ip`, `session_login_status`, `session_login_type`, `created_on`, `modified_on`) VALUES
(1, '57a1c9cb7fdcb1861b2361496ff0c0de', 1, '::1', 0, 0, '2017-11-16 11:08:55', '2017-11-16 17:36:47'),
(2, 'c817cbfc7651f362fa57bfd9dab1d14b', 1, '::1', 2, 0, '2017-11-17 09:18:11', '2017-11-18 07:59:30'),
(3, '1987746cf0803f6baf4d53b49f9c6439', 1, '::1', 2, 0, '2017-11-18 07:59:30', '2017-11-20 08:43:51'),
(4, 'a27ef678a315cc55b795287423d2c900', 1, '::1', 2, 0, '2017-11-20 08:43:51', '2017-11-20 14:33:23'),
(5, '26e85c9c2a8685d256176265c24f28f8', 1, '::1', 2, 0, '2017-11-20 14:33:23', '2017-11-20 18:17:46'),
(6, '96b8d496e2a6fdcc7cafbdd9deb37d39', 1, '::1', 2, 0, '2017-11-20 18:17:46', '2017-11-20 18:18:08'),
(7, 'dc9688b8bae9ebf13a42afe0a88ba4f3', 1, '::1', 0, 0, '2017-11-20 18:18:08', '2017-11-20 18:18:08'),
(8, '12a4ad14cbfdae7892b86c87080a3323', 1, '::1', 0, 0, '2017-11-20 18:18:14', '2017-11-20 18:19:13'),
(9, 'c67075386161fabd604a1823ba54ec95', 1, '::1', 0, 0, '2017-11-20 18:38:06', '2017-11-20 18:49:35'),
(10, 'fb2e85890d98c3f8efa4cb1aec6baf1a', 1, '::1', 2, 0, '2017-11-21 09:11:12', '2017-11-22 10:22:30'),
(11, 'ba8ceacce26a18fb1fa87bf4b51258e7', 1, '::1', 2, 0, '2017-11-22 10:22:30', '2017-11-23 08:53:08'),
(12, 'cd9006a67008c403714d8803e054a166', 1, '::1', 0, 0, '2017-11-23 08:53:08', '2017-11-23 13:27:40'),
(13, '3b89915c2e30971eddc179ea700334b4', 4, '::1', 0, 0, '2017-11-23 13:27:47', '2017-11-23 13:39:50'),
(14, 'f1739f800f4d10406873d907dfd5b57d', 1, '::1', 0, 0, '2017-11-23 13:39:57', '2017-11-23 13:40:03'),
(15, '9763011e6f572e1ccb8165187fddcaee', 4, '::1', 0, 0, '2017-11-23 13:40:10', '2017-11-23 16:20:48'),
(16, '1ae511622442205960c78c576b4fc02f', 3, '::1', 0, 0, '2017-11-23 16:21:01', '2017-11-23 16:22:36'),
(17, '96946fcbf79941ca4d58ff51d32bc8eb', 6, '::1', 0, 0, '2017-11-23 16:22:50', '2017-11-23 16:23:03'),
(18, 'a37dd65156a19e152c02b3a8c7949864', 2, '::1', 0, 0, '2017-11-23 16:23:10', '2017-11-23 16:23:48'),
(19, '5b6a9c5b20d0ed312d6342062f8220bb', 5, '::1', 0, 0, '2017-11-23 16:24:00', '2017-11-23 16:25:40'),
(20, '79462774697875ecaf0c61e8497cde9a', 4, '::1', 0, 0, '2017-11-23 16:25:48', '2017-11-23 16:26:05'),
(21, 'a7afbf1acbe1e6e792705a158e53a70f', 1, '::1', 0, 0, '2017-11-23 16:26:12', '2017-11-23 16:26:18'),
(22, '770f913e86f24de5da2af5890afe62d4', 4, '::1', 0, 0, '2017-11-23 16:26:24', '2017-11-23 16:30:07'),
(23, 'e93fb2873523db65467d65e00ab4561f', 6, '::1', 1, 0, '2017-11-23 16:30:14', '2017-11-23 16:30:30'),
(24, 'a3bb0f984f972381479c17a1f0d0a913', 1, '::1', 0, 0, '2017-11-27 08:42:34', '2017-11-27 17:48:29'),
(25, '4ceea9eee168c9b27104291499d6cb99', 1, '::1', 0, 0, '2017-11-28 09:07:49', '2017-11-28 17:23:51'),
(26, '025f7d56f3e6771b3578048c5b37e1ef', 2, '::1', 0, 0, '2017-11-28 17:24:23', '2017-11-28 17:24:26'),
(27, 'e7670811e10acf5b02aa2d96964719f6', 4, '::1', 0, 0, '2017-11-28 17:24:35', '2017-11-28 17:24:37'),
(28, '2de29dae00b1f91cda487a8d39c61c59', 1, '::1', 0, 0, '2017-11-28 17:24:43', '2017-11-28 17:50:41'),
(29, '79c26c1c443e55117a8c74496808ce23', 1, '::1', 0, 0, '2017-11-28 17:50:49', '2017-11-28 17:50:58'),
(30, 'a4882f8ec79cc54eeb9184781433c4f2', 1, '::1', 0, 0, '2017-11-28 17:51:03', '2017-11-28 17:51:05'),
(31, '1d058a3f0ed7627f693d93c4ac3181a4', 1, '::1', 0, 0, '2017-11-28 17:51:15', '2017-11-28 17:52:33'),
(32, '9d8c3f5d4081a231908467a830fcc2ed', 1, '::1', 0, 0, '2017-11-28 17:52:39', '2017-11-28 17:52:53'),
(33, 'aa5f3a2e11272cf96b30953332e87c1d', 1, '::1', 0, 0, '2017-11-28 17:52:58', '2017-11-28 19:32:05'),
(34, '4138113b0d6ea8c20517b0dad9a77359', 1, '::1', 2, 0, '2017-11-29 10:18:54', '2017-11-30 09:09:43'),
(35, 'a90ec04125509c0effb3f4ab6567132a', 1, '::1', 2, 0, '2017-11-30 09:09:43', '2017-12-01 09:17:14'),
(36, 'b5b5bc7ef06e36d08b9863c8d241ac15', 1, '::1', 2, 0, '2017-12-01 09:17:14', '2017-12-04 08:51:05'),
(37, '791bfd9789eef80d287161736307dc2b', 1, '::1', 0, 0, '2017-12-04 08:51:05', '2017-12-04 13:06:45'),
(38, '21fc08b44ac33cfa3058201bec186c0b', 1, '::1', 2, 0, '2017-12-05 10:23:02', '2017-12-05 16:32:43'),
(39, '48ccb65bc080df5d3e0c13a3e452bbc7', 1, '::1', 2, 0, '2017-12-05 16:32:43', '2017-12-07 11:54:28'),
(40, '042dfa66ef109d53ff766882f6f53e9c', 1, '::1', 0, 0, '2017-12-07 11:54:28', '2017-12-07 18:39:26'),
(41, '08827cb8699a303cbd39511946c166d6', 1, '::1', 0, 0, '2017-12-08 09:12:55', '2017-12-08 12:39:11'),
(42, '40d39445de55faddfd1c6e77cf2c5e57', 3, '::1', 0, 0, '2017-12-08 12:39:20', '2017-12-08 12:39:57'),
(43, '47930ba2889eb062899078e9003694b4', 8, '::1', 0, 0, '2017-12-08 12:40:04', '2017-12-08 12:57:24'),
(44, 'f4a92a342a71c89e6afda0555ffdd226', 1, '::1', 0, 0, '2017-12-08 12:57:35', '2017-12-08 13:39:53'),
(45, 'c925b642acbdc8e32df5f97a6effbddd', 3, '::1', 0, 0, '2017-12-08 13:40:02', '2017-12-08 13:40:06'),
(46, '5b9f83b0aa564a0423ae95851f7b6eb8', 8, '::1', 0, 0, '2017-12-08 13:40:12', '2017-12-08 13:40:17'),
(47, '324f7e40933b40ec8ce82626130383f7', 1, '::1', 0, 0, '2017-12-08 13:40:23', '2017-12-08 16:57:16'),
(48, '7d5f7a23d5f97ca40384fa241441a249', 8, '::1', 0, 0, '2017-12-08 16:57:23', '2017-12-08 16:57:38'),
(49, 'da11a3340a4374ebfa2c7146c4ae780b', 1, '::1', 0, 0, '2017-12-08 16:57:45', '2017-12-08 17:38:13'),
(50, 'd8fc7b4d7c2c281324369f2d65cbc82c', 8, '::1', 0, 0, '2017-12-08 17:38:23', '2017-12-08 17:39:32'),
(51, '6d57f3af262ac6b82fa179637e1b6423', 1, '::1', 0, 0, '2017-12-08 17:39:38', '2017-12-08 18:14:35'),
(52, '63117f110e1dd9d3521314eac562c5e4', 8, '::1', 0, 0, '2017-12-08 18:14:43', '2017-12-08 18:18:05'),
(53, '17055eb520135b495e8526237645b25a', 1, '::1', 0, 0, '2017-12-08 18:18:11', '2017-12-08 18:18:29'),
(54, 'c7791fa62342638813602df3721d7122', 8, '::1', 0, 0, '2017-12-08 18:18:38', '2017-12-08 18:19:19'),
(55, '41d5e2b9a125a91b0e1edab8497a3e83', 8, '::1', 0, 0, '2017-12-08 18:19:27', '2017-12-08 18:34:18'),
(56, '2307e6056636431071ae8b9872f02a1e', 1, '::1', 0, 0, '2017-12-11 08:52:40', '2017-12-11 14:25:29'),
(57, '50ed6a1791919a75221c4b7e01a7d213', 8, '::1', 0, 0, '2017-12-11 14:25:35', '2017-12-11 14:25:45'),
(58, 'dd4464a224c093a659d8cf1239c9e5cd', 1, '::1', 0, 0, '2017-12-11 14:25:51', '2017-12-11 15:58:03'),
(59, 'a46b46d05c1ff9eb58f658e905d0b012', 8, '::1', 0, 0, '2017-12-11 15:58:09', '2017-12-11 16:07:40'),
(60, '517336316ef0f8c7942f5995935a9126', 1, '::1', 0, 0, '2017-12-11 16:07:47', '2017-12-11 16:11:54'),
(61, 'a6d9aed9fa2259b64bc4d723c4f0312c', 8, '::1', 0, 0, '2017-12-11 16:12:00', '2017-12-11 16:12:17'),
(62, '2d60e171795947d669fd589c8eda4917', 1, '::1', 0, 0, '2017-12-11 16:12:23', '2017-12-11 16:12:46'),
(63, '54ef0fd5b959777648f42c99bf497420', 8, '::1', 0, 0, '2017-12-11 16:12:54', '2017-12-11 16:13:02'),
(64, 'd894c11cf3a7f346cd9ae842d09abac5', 8, '::1', 0, 0, '2017-12-11 16:13:14', '2017-12-11 16:22:09'),
(65, 'd6d4024f5c2edac757c57c8bdc775300', 8, '::1', 0, 0, '2017-12-11 16:22:33', '2017-12-11 16:24:16'),
(66, 'a5fbb9a2583bb758064c4679a396c266', 1, '::1', 0, 0, '2017-12-11 16:24:22', '2017-12-11 16:24:32'),
(67, 'fb04e0697f0a2b7d83b80a0e0b71c5eb', 8, '::1', 0, 0, '2017-12-11 16:24:41', '2017-12-11 16:24:47'),
(68, '012b47d63dfd5701de381e3ccd22c74e', 1, '::1', 0, 0, '2017-12-11 16:24:53', '2017-12-11 16:25:17'),
(69, '6a8ca9c1b6de2e35ceff5b29b551e44e', 8, '::1', 0, 0, '2017-12-11 16:25:25', '2017-12-11 16:27:11'),
(70, '45bc27e51f5a566299313bedd0dc8766', 1, '::1', 1, 0, '2017-12-12 14:06:41', '2017-12-12 17:03:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`billing_id`);

--
-- Indexes for table `billing_consultant_rate`
--
ALTER TABLE `billing_consultant_rate`
  ADD PRIMARY KEY (`cons_rate_id`);

--
-- Indexes for table `billing_rate`
--
ALTER TABLE `billing_rate`
  ADD PRIMARY KEY (`rates_id`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `client_entity`
--
ALTER TABLE `client_entity`
  ADD PRIMARY KEY (`client_entity_id`);

--
-- Indexes for table `consultant_skill`
--
ALTER TABLE `consultant_skill`
  ADD PRIMARY KEY (`cons_skill_id`);

--
-- Indexes for table `cron_jobs`
--
ALTER TABLE `cron_jobs`
  ADD PRIMARY KEY (`cronId`);

--
-- Indexes for table `division`
--
ALTER TABLE `division`
  ADD PRIMARY KEY (`division_id`);

--
-- Indexes for table `form`
--
ALTER TABLE `form`
  ADD PRIMARY KEY (`form_id`);

--
-- Indexes for table `import_csv_fields`
--
ALTER TABLE `import_csv_fields`
  ADD PRIMARY KEY (`icf_id`);

--
-- Indexes for table `import_csv_file`
--
ALTER TABLE `import_csv_file`
  ADD PRIMARY KEY (`ic_id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_id`);

--
-- Indexes for table `invoice_rate`
--
ALTER TABLE `invoice_rate`
  ADD PRIMARY KEY (`invoice_rate_id`);

--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`modules_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`);

--
-- Indexes for table `service_type`
--
ALTER TABLE `service_type`
  ADD PRIMARY KEY (`serv_type_id`);

--
-- Indexes for table `task_content`
--
ALTER TABLE `task_content`
  ADD PRIMARY KEY (`task_content_id`);

--
-- Indexes for table `task_keyword`
--
ALTER TABLE `task_keyword`
  ADD PRIMARY KEY (`task_keyword_id`);

--
-- Indexes for table `task_keyword_admin_complete`
--
ALTER TABLE `task_keyword_admin_complete`
  ADD PRIMARY KEY (`tkac_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_permission`
--
ALTER TABLE `user_permission`
  ADD PRIMARY KEY (`user_permission`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_role_id`);

--
-- Indexes for table `user_session`
--
ALTER TABLE `user_session`
  ADD PRIMARY KEY (`session_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billing`
--
ALTER TABLE `billing`
  MODIFY `billing_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `billing_consultant_rate`
--
ALTER TABLE `billing_consultant_rate`
  MODIFY `cons_rate_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `billing_rate`
--
ALTER TABLE `billing_rate`
  MODIFY `rates_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `client_entity`
--
ALTER TABLE `client_entity`
  MODIFY `client_entity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;
--
-- AUTO_INCREMENT for table `consultant_skill`
--
ALTER TABLE `consultant_skill`
  MODIFY `cons_skill_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cron_jobs`
--
ALTER TABLE `cron_jobs`
  MODIFY `cronId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `division`
--
ALTER TABLE `division`
  MODIFY `division_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `form`
--
ALTER TABLE `form`
  MODIFY `form_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `import_csv_fields`
--
ALTER TABLE `import_csv_fields`
  MODIFY `icf_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `import_csv_file`
--
ALTER TABLE `import_csv_file`
  MODIFY `ic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invoice_rate`
--
ALTER TABLE `invoice_rate`
  MODIFY `invoice_rate_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `modules_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `service_type`
--
ALTER TABLE `service_type`
  MODIFY `serv_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `task_content`
--
ALTER TABLE `task_content`
  MODIFY `task_content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `task_keyword`
--
ALTER TABLE `task_keyword`
  MODIFY `task_keyword_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `task_keyword_admin_complete`
--
ALTER TABLE `task_keyword_admin_complete`
  MODIFY `tkac_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `user_permission`
--
ALTER TABLE `user_permission`
  MODIFY `user_permission` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `user_role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `user_session`
--
ALTER TABLE `user_session`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
