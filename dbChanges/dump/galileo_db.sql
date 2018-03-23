-- --------------------------------------------------------
-- Host:                         samdev.cajtllpanexw.us-east-2.rds.amazonaws.com
-- Server version:               5.6.35-log - MySQL Community Server (GPL)
-- Server OS:                    Linux
-- HeidiSQL Version:             9.5.0.5223
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for galileo
CREATE DATABASE IF NOT EXISTS `galileo` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `galileo`;

-- Dumping structure for procedure galileo.addAdminPersonnel
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addAdminPersonnel`(
	IN `_userId` INT(11),
	IN `_userUpdateId` INT(11),
	IN `_userFirstName` VARCHAR(155),
	IN `_userLastName` VARCHAR(155),
	IN `_userRole` INT(11),
	IN `_userEmail` VARCHAR(200),
	IN `_userPassword` VARCHAR(100),
	IN `_userDateTime` datetime,
	IN `_userQbId` INT(11)
)
    COMMENT 'Insert or Update User for admin personnel'
BEGIN
		IF(_userUpdateId > 0) THEN
		
		UPDATE user SET user_fname = _userFirstName,user_lname = _userLastName, user_email=_userEmail, user_role_id = _userRole, user_modified_by = _userId, user_modified_on = _userDateTime , user_qb_ref_id = _userQbId WHERE user_id = _userUpdateId;
		ELSE
			INSERT INTO user(user_fname,user_lname,user_role_id,user_email,user_password,user_record_status,user_created_by,user_created_on,user_modified_by,user_modified_on,user_qb_ref_id)
			VALUES (_userFirstName, _userLastName, _userRole,_userEmail,_userPassword,0,_userId,_userDateTime,_userId,_userDateTime,_userQbId);
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addAlert
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addAlert`(
	IN `_userId` INT(11),
	IN `_notificationUpdateId` INT(11),
	IN `_notificationUserId` INT(11),
	IN `_notificationModuleId` INT(11),
	IN `_notificationEmail` VARCHAR(100),
	IN `_clientId` INT(11),
	IN `_dateTime` datetime
)
    COMMENT 'Insert or Update task_keyword'
BEGIN

DECLARE _isExistId INT DEFAULT 0;

		IF(_notificationUpdateId > 0) THEN
		
		UPDATE notification SET notification_user_id = _notificationUserId,notification_client_id = _clientId, notification_module_id = _notificationModuleId,
		notification_email = _notificationEmail,notification_modified_by = _userId, notification_modified_on = _dateTime
		WHERE notification_id = _notificationUpdateId;
		ELSE
			
			SELECT  notification_id into _isExistId FROM notification WHERE notification_user_id = _notificationUserId AND notification_client_id = _clientId AND notification_module_id = _notificationModuleId AND notification_record_status=0;
			SET _isExistId = IFNULL(_isExistId,0);
			IF(_isExistId=0) THEN
				INSERT INTO notification(notification_user_id,notification_client_id,notification_module_id,notification_email,notification_record_status,notification_created_by,notification_created_on,notification_modified_by,notification_modified_on)
				VALUES (_notificationUserId, _clientId,_notificationModuleId, _notificationEmail,0,_userId,_dateTime,_userId,_dateTime);
			ELSE
				UPDATE notification SET notification_user_id = _notificationUserId,notification_client_id = _clientId, notification_module_id = _notificationModuleId,
				notification_email = _notificationEmail,notification_modified_by = _userId, notification_modified_on = _dateTime
			WHERE notification_id = _isExistId;
			END IF;
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addAlertNotification
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addAlertNotification`(
	IN `_userId` INT(11),
	IN `_notificationUpdateId` INT(11),
	IN `_notificationUserId` INT(11),
	IN `_notificationModuleId` INT(11),
	IN `_notificationEmail` VARCHAR(100),
	IN `_clientId` INT(11),
	IN `_dateTime` datetime,
	IN `_notificationTaskId` INT(11),
	IN `_notificationMsg` TEXT

)
    COMMENT 'Insert or Update alert notification'
BEGIN

	INSERT INTO alert_notification(alert_notification_module_user_id,alert_notification_client_id,alert_notification_module_id,alert_notification_email,alert_notification_record_status,alert_notification_created_by,alert_notification_created_on,alert_notification_modified_by,alert_notification_modified_on,alert_notification_task_id,alert_notification_message)
	VALUES (_notificationUserId, _clientId,_notificationModuleId, _notificationEmail,0,_userId,_dateTime,_userId,_dateTime,_notificationTaskId,_notificationMsg);
	
	SELECT LAST_INSERT_ID() AS alertNotificationId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addBilling
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addBilling`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_billingUpdateId` INT(11),
	IN `_invoiceId` INT(11),
	IN `_billingTotal` DECIMAL(15,2),
	IN `_billingDate` date,
	IN `_qbProcessed` TINYINT(1),
	IN `_qbReferenceNumber` VARCHAR(100),
	IN `_dateTime` datetime
)
    COMMENT 'Insert or Update billing'
BEGIN

		IF(_billingUpdateId > 0) THEN
		
			UPDATE billing SET billing_user_id = _userId,billing_client_id = _clientId, billing_invoice_id = _invoiceId,
			billing_total = _billingTotal, billing_is_qbprocessed = _qbProcessed, billing_qbreference_no = _qbReferenceNumber, billing_modified_by = _userId, billing_modified_on = _dateTime WHERE billing_id = _billingUpdateId;
			
			SELECT _billingUpdateId AS billingId;
		
		ELSE
		
			INSERT INTO billing(billing_user_id,billing_client_id,billing_invoice_id,billing_total,billing_date,billing_is_qbprocessed,billing_qbreference_no,billing_record_status,billing_created_by,billing_created_on,billing_modified_by,billing_modified_on)
			VALUES (_userId, _clientId,_invoiceId, _billingTotal, _billingDate, _qbProcessed, _qbReferenceNumber, 0, _userId,_dateTime,_userId,_dateTime);
			
			SELECT LAST_INSERT_ID() AS billingId;
		
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addBillingTaskReference
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addBillingTaskReference`(
	IN `_billingId` INT(11),
	IN `_clientName` VARCHAR(255),
	IN `_uFname` VARCHAR(155),
	IN `_uLname` VARCHAR(155),
	IN `_taskId` INT(11),
	IN `_taskUserId` INT(11),
	IN `_taskClientId` INT(11),
	IN `_taskType` TINYINT(1),
	IN `_marshaCode` VARCHAR(200),
	IN `_divisionCode` VARCHAR(50),
	IN `_serviceTypeName` VARCHAR(255),
	IN `_ratePerUnit` DECIMAL(15,2),
	IN `_noOfUnits` INT(11),
	IN `_tire` VARCHAR(255),
	IN `_userId` INT(11),
	IN `_dateTime` datetime,
	IN `_qbServiceRefId` INT(11)

)
    COMMENT 'Insert billing task reference'
BEGIN

	INSERT INTO billing_task_reference(billing_reference_billing_id,billing_reference_client_name,billing_reference_user_fname,billing_reference_user_lname,billing_reference_task_id,billing_reference_task_user_id,billing_reference_task_client_id,billing_reference_task_type,billing_reference_marsha_code,billing_reference_division_code,billing_reference_service_type_name,billing_reference_rate_per_unit,billing_reference_no_of_units,billing_reference_tire,billing_reference_record_status,billing_reference_created_by,billing_reference_created_on,billing_reference_modified_by,billing_reference_modified_on,billing_reference_service_qb_ref_id)
	VALUES (_billingId, _clientName,_uFname, _uLname, _taskId,_taskUserId,_taskClientId, _taskType, _marshaCode, _divisionCode, _serviceTypeName,_ratePerUnit,_noOfUnits,_tire,0,_userId,_dateTime,_userId,_dateTime,_qbServiceRefId);
	
	SELECT LAST_INSERT_ID() AS billingRefId;
	
	IF(_taskType = 1) THEN
	
		UPDATE task_keyword SET task_keyword_qb_process = 1 WHERE task_keyword_id = _taskId;
	
	ELSEIF(_taskType = 2) THEN
	
		UPDATE task_content SET task_content_qb_process = 1 WHERE task_content_id = _taskId;
	
	END IF;
		
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addClient
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addClient`(
	IN `_userId` INT(11),
	IN `_clientUpateId` INT(11),
	IN `_clientName` VARCHAR(255),
	IN `_clientStreet` VARCHAR(255),
	IN `_clientCity` VARCHAR(255),
	IN `_clientState` VARCHAR(255),
	IN `_clientZipcode` VARCHAR(50),
	IN `_clientCountry` VARCHAR(255),
	IN `_dateTime` datetime,
	IN `_recordStatus` TINYINT(1),
	IN `_clientQbRef` INT(11)

)
    COMMENT 'Insert or Update client'
BEGIN
		IF(_clientUpateId > 0) THEN
			UPDATE client SET client_name = _clientName,client_street = _clientStreet, client_city = _clientCity,
			client_state = _clientState,client_zipcode = _clientZipcode, client_country = _clientCountry, client_modified_by = _userId, client_modified_on =  _dateTime,client_record_status=_recordStatus, client_qb_associated_reference=_clientQbRef WHERE client_id = _clientUpateId;
		ELSE
			INSERT INTO client(client_user_id,client_name,client_street,client_city,client_state,client_zipcode,client_country,client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on,client_qb_associated_reference)
			VALUES (_userId, _clientName,_clientStreet, _clientCity, _clientState, _clientZipcode, _clientCountry, 0,
			_userId,_dateTime,_userId,_dateTime,_clientQbRef);
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addClientDivision
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addClientDivision`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_clientQbRefUpateId` INT(11),
	IN `_clientDivisionId` INT(11),
	IN `_clientQbId` INT(11),
	IN `_clientQbClass` INT(11),
	IN `_dateTime` datetime

)
    COMMENT 'Insert or Update client_qb_reference'
BEGIN

DECLARE _isExistId INT DEFAULT 0;

		IF(_clientQbRefUpateId > 0) THEN
			UPDATE client_qb_reference SET  client_qb_ref_division_id = _clientDivisionId,client_qb_ref_qb_id = _clientQbId,client_qb_ref_qb_class = _clientQbClass, client_qb_ref_modified_by= _userId,client_qb_ref_modified_on =  _dateTime WHERE client_qb_ref_id = _clientQbRefUpateId;
		ELSE
		
			SELECT  client_qb_ref_id into _isExistId FROM client_qb_reference WHERE client_qb_ref_client_id = _clientId AND client_qb_ref_division_id = _clientDivisionId AND client_qb_ref_record_status=0;
			SET _isExistId = IFNULL(_isExistId,0);
			
			IF(_isExistId=0) THEN
			
				INSERT INTO client_qb_reference(client_qb_ref_client_id,client_qb_ref_division_id,client_qb_ref_qb_id,client_qb_ref_qb_class,client_qb_ref_record_status,client_qb_ref_created_by,client_qb_ref_created_on,client_qb_ref_modified_by,client_qb_ref_modified_on)
			VALUES (_clientId, _clientDivisionId,_clientQbId, _clientQbClass, 0,_userId,_dateTime,_userId,_dateTime);
			
			ELSE
				UPDATE client_qb_reference SET  client_qb_ref_division_id = _clientDivisionId,client_qb_ref_qb_id = _clientQbId,client_qb_ref_qb_class = _clientQbClass, client_qb_ref_modified_by= _userId,client_qb_ref_modified_on =  _dateTime WHERE client_qb_ref_id = _isExistId;
			
			END IF;
			
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addClientEntity
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addClientEntity`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_clientEntityUpateId` INT(11),
	IN `_marshaCode` VARCHAR(100),
	IN `_hotelName` VARCHAR(255),
	IN `_streetName` VARCHAR(255),
	IN `_cityName` VARCHAR(255),
	IN `_stateName` VARCHAR(255),
	IN `_zipCode` VARCHAR(50),
	IN `_countryName` VARCHAR(255),
	IN `_clientDivisionId` INT(11),
	IN `_dateTime` datetime

)
    COMMENT 'Insert or Update client_entity'
BEGIN

DECLARE _isExistId INT DEFAULT 0;

		IF(_clientEntityUpateId > 0) THEN
			UPDATE client_entity SET  client_entity_marsha_code = _marshaCode,client_entity_hotel_name = _hotelName,client_entity_street = _streetName,client_entity_city = _cityName,client_entity_state = _stateName,client_entity_zipcode = _zipCode,client_entity_country = _countryName, client_entity_division_id= _clientDivisionId, client_entity_modified_by= _userId,client_entity_modified_on =  _dateTime WHERE client_entity_id = _clientEntityUpateId;
		ELSE
		
			SELECT  client_entity_id into _isExistId FROM client_entity WHERE client_entity_client_id = _clientId AND client_entity_marsha_code = _marshaCode AND client_entity_record_status=0;
			SET _isExistId = IFNULL(_isExistId,0);
			
			IF(_isExistId=0) THEN
			
				INSERT INTO client_entity(client_entity_marsha_code,client_entity_hotel_name,client_entity_street,client_entity_city,client_entity_state,client_entity_zipcode,client_entity_country,client_entity_client_id,client_entity_user_id,client_entity_division_id,client_entity_record_status,client_entity_created_by,client_entity_created_on,client_entity_modified_by,client_entity_modified_on)
			VALUES (_marshaCode, _hotelName,_streetName, _cityName, _stateName, _zipCode, _countryName,_clientId,_userId, _clientDivisionId, 0,_userId,_dateTime,_userId,_dateTime);
			
			ELSE
				UPDATE client_entity SET  client_entity_hotel_name = _hotelName,client_entity_street = _streetName,client_entity_city = _cityName,client_entity_state = _stateName,client_entity_zipcode = _zipCode,client_entity_country = _countryName, client_entity_division_id= _clientDivisionId, client_entity_modified_by= _userId,client_entity_modified_on =  _dateTime WHERE client_entity_id = _isExistId;
			
			END IF;
			
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addConsultantRate
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addConsultantRate`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_rateUpdateId` INT(11),
	IN `_rateUserId` INT(11),
	IN `_ratePerUnit` VARCHAR(255),
	IN `_serviceTypeId` INT(11),
	IN `_dateTime` DATETIME
)
    COMMENT 'Insert or Update consultant_rate'
BEGIN
	
	DECLARE _isExistRateId INT DEFAULT 0;

		IF(_rateUpdateId > 0) THEN
			UPDATE consultant_rate SET cons_rate_client_id = _clientId, cons_rate_per_unit = _ratePerUnit,
			cons_rate_modified_by = _userId,cons_rate_modified_on =  _dateTime WHERE cons_rate_id = _rateUpdateId;
		ELSE
		
			SELECT  cons_rate_id into _isExistRateId FROM consultant_rate WHERE cons_rate_user_id = _rateUserId AND cons_rate_client_id = _clientId AND cons_rate_service_type_id = _serviceTypeId AND consultant_rate.cons_rate_record_status=0;
			SET _isExistRateId = IFNULL(_isExistRateId,0);
			IF(_isExistRateId=0) THEN
				INSERT INTO consultant_rate(cons_rate_user_id,cons_rate_client_id,cons_rate_service_type_id,cons_rate_per_unit,cons_rate_record_status,cons_rate_created_by,cons_rate_created_on,cons_rate_modified_by,cons_rate_modified_on)
				VALUES (_rateUserId, _clientId,_serviceTypeId,_ratePerUnit,0,_userId,_dateTime,_userId,_dateTime);
			ELSE
				UPDATE consultant_rate SET cons_rate_client_id = _clientId,  cons_rate_per_unit = _ratePerUnit,
			cons_rate_modified_by = _userId,cons_rate_modified_on =  _dateTime WHERE cons_rate_id = _isExistRateId;
			END IF;
		
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addConsultantSkill
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addConsultantSkill`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_skillUpdateId` INT(11),
	IN `_skillUserId` INT(11),
	IN `_dateTime` DATETIME
)
    COMMENT 'Insert or Update consultant_skill'
BEGIN
DECLARE _isExistSkillId INT DEFAULT 0;

		IF(_skillUpdateId > 0) THEN
			UPDATE consultant_skill SET cons_user_id = _skillUserId,cons_client_id = _clientId,cons_modified_by = _userId,
			cons_modified_on =  _dateTime WHERE cons_skill_id = _skillUpdateId;
			SELECT _skillUpdateId AS skillId;
		ELSE
			SELECT  cons_skill_id into _isExistSkillId FROM consultant_skill WHERE cons_user_id = _skillUserId AND cons_client_id = _clientId AND consultant_skill.cons_record_status=0;
			SET _isExistSkillId = IFNULL(_isExistSkillId,0);
			IF(_isExistSkillId=0) THEN
				INSERT INTO consultant_skill(cons_client_id,cons_user_id,cons_record_status,cons_created_by,cons_created_on,cons_modified_by,cons_modified_on)
				VALUES (_clientId, _skillUserId,0, _userId, _dateTime, _userId, _dateTime);
				SELECT LAST_INSERT_ID() AS skillId;
			ELSE
				UPDATE consultant_skill SET cons_user_id = _skillUserId,cons_client_id = _clientId,cons_modified_by = _userId,
				cons_modified_on =  _dateTime WHERE cons_skill_id = _isExistSkillId;
				SELECT _isExistSkillId AS skillId;
			END IF;
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addConsultantSkillItems
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addConsultantSkillItems`(
	IN `_skillId` INT(11),
	IN `_serviceTypeIds` VARCHAR(255)
)
    COMMENT 'Insert or Update consultant_skill items'
BEGIN
		
		DECLARE splitId INT(11);
		
		DECLARE splitIds VARCHAR(255);
		
		SET splitIds =  _serviceTypeIds;
		
		DELETE FROM consultant_skill_items WHERE csi_skill_id = _skillId;

		WHILE splitIds != '' DO
	
		SET splitId = SUBSTRING_INDEX(splitIds, ',', 1); 
		
		INSERT INTO consultant_skill_items(csi_skill_id,csi_service_type_id)VALUES(_skillId,splitId);
		
		IF LOCATE(',', splitIds) > 0 THEN
			SET splitIds = SUBSTRING(splitIds, LOCATE(',', splitIds) + 1);
		ELSE
			SET splitIds = '';
		END IF;
	
		END WHILE;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.addCsvImport
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addCsvImport`(IN `_csvFileName` VARCHAR(500), IN `_importOpt` TINYINT(1), IN `_importType` TINYINT(1), IN `_importKeywordDate` DATE, IN `_importStatus` TINYINT(1), IN `_userId` INT(11), IN `_clientId` INT(11), IN `_sysDate` DATETIME)
BEGIN
	INSERT INTO import_csv_file (ic_file_name,ic_import_opt,ic_import_type,ic_import_keyword_date,ic_status,ic_record_status,ic_user_id,ic_client_id,created_by, created_date,updated_date) 
	VALUES (_csvFileName,_importOpt,_importType,_importKeywordDate,_importStatus,0,_userId,_clientId,_userId,_sysDate,_sysDate);
	SELECT LAST_INSERT_ID() AS importCsvID;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addCsvImportFields
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addCsvImportFields`(IN `_csvImportId` INT(11), IN `_fieldId` INT(11), IN `_fieldName` VARCHAR(500), IN `_userId` INT(11), IN `_clientId` INT(11), IN `_isUnique` TINYINT(1))
BEGIN
	INSERT INTO import_csv_fields(icf_ic_id, icf_field_id, icf_field_name,icf_user_id, icf_client_id, icf_is_unique)
		VALUES (_csvImportId, _fieldId, _fieldName,_userId, _clientId, _isUnique);
	SELECT LAST_INSERT_ID() as csvFieldId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addDivision
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addDivision`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_divisionUpdateId` INT(11),
	IN `_divisionCode` VARCHAR(50),
	IN `_divisionName` VARCHAR(255),
	IN `_dateTime` datetime

)
    COMMENT 'Insert or Update division'
BEGIN

DECLARE _isExistId INT DEFAULT 0;

		IF(_divisionUpdateId > 0) THEN
			UPDATE division SET  division_code = _divisionCode,division_name = _divisionName,division_modified_by= _userId,division_modified_on =  _dateTime WHERE division_id = _divisionUpdateId;
		ELSE
		
			SELECT  division_id into _isExistId FROM division WHERE LOWER(division_code) =  LOWER(_divisionCode) AND division_client_id = _clientId AND division_record_status=0;
			SET _isExistId = IFNULL(_isExistId,0);
			
			IF(_isExistId=0) THEN
			
				INSERT INTO division(division_code,division_name,division_client_id,division_record_status,division_created_by,division_created_on,division_modified_by,division_modified_on)
			VALUES (_divisionCode, _divisionName,_clientId, 0,_userId,_dateTime,_userId,_dateTime);
			
			ELSE
				UPDATE division SET  division_name = _divisionName, division_modified_by= _userId,division_modified_on =  _dateTime WHERE division_id = _isExistId;
			
			END IF;
			
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addForm
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addForm`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_formUpdateId` INT(11),
	IN `_formUserId` INT(11),
	IN `_formFirstName` VARCHAR(255),
	IN `_formLastName` VARCHAR(255),
	IN `_formEmail` VARCHAR(100),
	IN `_formContactNo` VARCHAR(50),
	IN `_formStreet` VARCHAR(255),
	IN `_formCity` VARCHAR(255),
	IN `_formState` VARCHAR(255),
	IN `_formZipcode` VARCHAR(100),
	IN `_formCountry` VARCHAR(255),
	IN `_formWNine` VARCHAR(255),
	IN `_formResume` VARCHAR(255),
	IN `_formAch` VARCHAR(255),
	IN `_formConsultantAgree` VARCHAR(255),
	IN `_formNotes` TEXT,
	IN `_formNeeded`  TEXT,
	IN `_dateTime` DATETIME
)
    COMMENT 'Insert or Update form'
BEGIN
		IF(_formUpdateId > 0) THEN
			UPDATE form SET form_user_id = _formUserId,form_client_id = _clientId, form_first_name = _formFirstName,
			form_last_name = _formLastName,form_email = _formEmail, form_contact_no = _formContactNo, form_street = _formStreet,
			form_city = _formCity,form_state = _formState,form_zipcode = _formZipcode,form_country = _formCountry,form_w_nine = _formWNine,form_resume = _formResume,form_ach = _formAch,form_consultant_agree = _formConsultantAgree,form_notes = _formNotes,form_needed = _formNeeded,form_modified_by = _userId,
			form_modified_on =  _dateTime WHERE form_id = _formUpdateId;
		ELSE
			INSERT INTO form(form_user_id,form_client_id,form_first_name,form_last_name,form_email,form_contact_no,form_street,form_city,form_state,form_zipcode,form_country,form_w_nine,form_resume,form_ach,form_consultant_agree,form_notes,form_needed,form_record_status,form_created_by,form_created_on,form_modified_by,form_modified_on)
			VALUES (_formUserId, _clientId,_formFirstName, _formLastName, _formEmail, _formContactNo, _formStreet, _formCity,_formState,_formZipcode,_formCountry,_formWNine,_formResume,_formAch,_formConsultantAgree,_formNotes,_formNeeded,0,_userId,_dateTime,_userId,_dateTime);
			
		END IF;
		
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addInvoice
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addInvoice`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_invoiceUpdateId` INT(11),
	IN `_invoiceTotal` DECIMAL(15,2),
	IN `_invoiceDate` date,
	IN `_qbProcessed` TINYINT(1),
	IN `_qbReferenceNumber` VARCHAR(100),
	IN `_dateTime` datetime
)
    COMMENT 'Insert or Update invoice'
BEGIN

		IF(_invoiceUpdateId > 0) THEN
		
			UPDATE invoice SET invoice_user_id = _userId,invoice_client_id = _clientId,invoice_total = _invoiceTotal, invoice_is_qbprocessed = _qbProcessed, invoice_qbreference_no = _qbReferenceNumber, invoice_modified_by = _userId, invoice_modified_on = _dateTime 
			WHERE invoice_id = _invoiceUpdateId;
			
			SELECT _invoiceUpdateId AS invoiceId;
		
		ELSE
		
			INSERT INTO invoice(invoice_user_id,invoice_client_id,invoice_total,invoice_date,invoice_is_qbprocessed,invoice_qbreference_no,invoice_record_status,invoice_created_by,invoice_created_on,invoice_modified_by,invoice_modified_on)
			VALUES (_userId, _clientId, _invoiceTotal, _invoiceDate, _qbProcessed, _qbReferenceNumber, 0, _userId,_dateTime,_userId,_dateTime);
			
			SELECT LAST_INSERT_ID() AS invoiceId;
		
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addInvoiceTaskReference
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addInvoiceTaskReference`(
	IN `_invoiceId` INT(11),
	IN `_clientName` VARCHAR(255),
	IN `_uFname` VARCHAR(155),
	IN `_uLname` VARCHAR(155),
	IN `_taskId` INT(11),
	IN `_taskUserId` INT(11),
	IN `_taskClientId` INT(11),
	IN `_taskType` TINYINT(1),
	IN `_marshaCode` VARCHAR(200),
	IN `_divisionCode` VARCHAR(50),
	IN `_serviceTypeName` VARCHAR(255),
	IN `_ratePerUnit` DECIMAL(15,2),
	IN `_noOfUnits` INT(11),
	IN `_tire` VARCHAR(255),
	IN `_userId` INT(11),
	IN `_dateTime` datetime,
	IN `_qbServiceRefId` INT(11)

)
    COMMENT 'Insert invoice task reference'
BEGIN

	INSERT INTO invoice_task_reference(invoice_reference_invoice_id,invoice_reference_client_name,invoice_reference_user_fname,invoice_reference_user_lname,invoice_reference_task_id,invoice_reference_task_user_id,invoice_reference_task_client_id,invoice_reference_task_type,invoice_reference_marsha_code,invoice_reference_division_code,invoice_reference_service_type_name,invoice_reference_rate_per_unit,invoice_reference_no_of_units,invoice_reference_tire,invoice_reference_record_status,invoice_reference_created_by,invoice_reference_created_on,invoice_reference_modified_by,invoice_reference_modified_on,invoice_reference_service_qb_ref_id)
	VALUES (_invoiceId, _clientName,_uFname, _uLname, _taskId,_taskUserId,_taskClientId, _taskType, _marshaCode, _divisionCode, _serviceTypeName,_ratePerUnit,_noOfUnits,_tire,0,_userId,_dateTime,_userId,_dateTime,_qbServiceRefId);
	
	SELECT LAST_INSERT_ID() AS invoiceRefId;
	
	IF(_taskType = 1) THEN
	
		UPDATE task_keyword SET task_keyword_qb_inv_process = 1 WHERE task_keyword_id = _taskId;
	
	ELSEIF(_taskType = 2) THEN
	
		UPDATE task_content SET task_content_qb_inv_process = 1 WHERE task_content_id = _taskId;
	
	END IF;
		
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addQbClassReference
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addQbClassReference`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_classQbRefUpateId` INT(11),
	IN `_classQbRefQbClassId` VARCHAR(100),
	IN `_classQbRefQbClassName` VARCHAR(255),
	IN `_dateTime` datetime

)
    COMMENT 'Insert or Update qb_class_reference'
BEGIN
		IF(_classQbRefUpateId > 0) THEN
			UPDATE qb_class_reference SET  qb_cls_ref_class_id = _classQbRefQbClassId,qb_cls_ref_class_name = _classQbRefQbClassName, qb_cls_ref_modified_by= _userId,qb_cls_ref_modified_on =  _dateTime WHERE qb_cls_ref_id = _classQbRefUpateId;
		ELSE
				INSERT INTO qb_class_reference(qb_cls_ref_client_id,qb_cls_ref_class_id,qb_cls_ref_class_name,qb_cls_ref_record_status,qb_cls_ref_created_by,qb_cls_ref_created_on,qb_cls_ref_modified_by,qb_cls_ref_modified_on)
			VALUES (_clientId, _classQbRefQbClassId,_classQbRefQbClassName, 0,_userId,_dateTime,_userId,_dateTime);
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addRefreshTokenError
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addRefreshTokenError`(
	IN `_errorMsg` VARCHAR(255),
	IN `_dateTime` datetime

)
    COMMENT 'Insert Error Message'
BEGIN
		
	INSERT INTO refresh_token_error(error_message,created_on)
	VALUES (_errorMsg, _dateTime);

END//
DELIMITER ;

-- Dumping structure for procedure galileo.addServiceType
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addServiceType`(
	IN `_userId` INT(11),
	IN `_serviceTypeUpdateId` INT(11),
	IN `_serviceTypeName` VARCHAR(255),
	IN `_galRatePerUnit` DECIMAL(15,2),
	IN `_freelRatePerUnit` DECIMAL(15,2),
	IN `_clientId` INT(11),
	IN `_dateTime` datetime,
	IN `_serviceQbId` INT(11),
	IN `_taskTypeId` TINYINT(11)

)
    COMMENT 'Insert or Update service_type'
BEGIN
		IF(_serviceTypeUpdateId > 0) THEN
		
		UPDATE service_type SET serv_type_client_id = _clientId, serv_type_name = _serviceTypeName,
		serv_type_gal_rate = _galRatePerUnit,serv_type_freel_rate = _freelRatePerUnit,serv_type_modified_by = _userId, serv_type_modified_on = _dateTime, serv_type_qb_id = _serviceQbId, serv_type_task_type = _taskTypeId
		WHERE serv_type_id = _serviceTypeUpdateId;
		ELSE
			INSERT INTO service_type(serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,
			serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on,serv_type_qb_id,serv_type_task_type)
			VALUES (_serviceTypeName, _clientId,_galRatePerUnit, _freelRatePerUnit,0,_userId,_dateTime,_userId,_dateTime,_serviceQbId,_taskTypeId);
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addTaskManagerContent
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addTaskManagerContent`(
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
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addTaskManagerKeyword
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addTaskManagerKeyword`(
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
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addTaskManagerKeywordClone
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addTaskManagerKeywordClone`(
	IN `_userId` INT(11),
	IN `_taskCloneTaskId` INT(11),
	IN `_taskCloneCommonId` INT(11),
	IN `_dateTime` datetime,
	IN `_isMainTask` INT(11)

)
    COMMENT 'Insert or Update task_clone'
BEGIN
DECLARE _isExistId INT DEFAULT 0;

SELECT  task_clone_id into _isExistId FROM task_clone WHERE task_clone_task_id = _taskCloneTaskId  AND task_clone_record_status=0;
SET _isExistId = IFNULL(_isExistId,0);
IF(_isExistId=0) THEN
	INSERT INTO task_clone(task_clone_task_id,task_clone_common_id,task_clone_record_status,task_clone_created_by,task_clone_created_on,task_clone_is_main_task)
	VALUES (_taskCloneTaskId, _taskCloneCommonId ,0,_userId,_dateTime,_isMainTask);
END IF;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.addTaskManagerKeywordForCsv
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `addTaskManagerKeywordForCsv`(
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
END//
DELIMITER ;

-- Dumping structure for table galileo.alert_notification
CREATE TABLE IF NOT EXISTS `alert_notification` (
  `alert_notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_notification_is_read` tinyint(1) NOT NULL DEFAULT '0',
  `alert_notification_module_user_id` int(11) NOT NULL DEFAULT '0',
  `alert_notification_client_id` int(11) NOT NULL DEFAULT '0',
  `alert_notification_module_id` int(11) NOT NULL DEFAULT '0',
  `alert_notification_task_id` int(11) NOT NULL DEFAULT '0',
  `alert_notification_invoice_id` int(11) NOT NULL DEFAULT '0',
  `alert_notification_billing_id` int(11) NOT NULL DEFAULT '0',
  `alert_notification_email` varchar(100) NOT NULL DEFAULT '',
  `alert_notification_message` text NOT NULL,
  `alert_notification_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `alert_notification_created_by` int(11) NOT NULL DEFAULT '0',
  `alert_notification_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `alert_notification_modified_by` int(11) NOT NULL DEFAULT '0',
  `alert_notification_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`alert_notification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.alert_notification: ~0 rows (approximately)
/*!40000 ALTER TABLE `alert_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_notification` ENABLE KEYS */;

-- Dumping structure for table galileo.billing
CREATE TABLE IF NOT EXISTS `billing` (
  `billing_id` int(11) NOT NULL AUTO_INCREMENT,
  `billing_user_id` int(11) NOT NULL DEFAULT '0',
  `billing_client_id` int(11) NOT NULL DEFAULT '0',
  `billing_invoice_id` int(11) NOT NULL DEFAULT '0',
  `billing_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `billing_date` date NOT NULL DEFAULT '0000-00-00',
  `billing_is_qbprocessed` tinyint(1) NOT NULL DEFAULT '0',
  `billing_qbreference_no` varchar(100) NOT NULL DEFAULT '',
  `billing_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `billing_created_by` int(11) NOT NULL DEFAULT '0',
  `billing_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `billing_modified_by` int(11) NOT NULL DEFAULT '0',
  `billing_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`billing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.billing: ~0 rows (approximately)
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;

-- Dumping structure for table galileo.billing_consultant_rate
CREATE TABLE IF NOT EXISTS `billing_consultant_rate` (
  `cons_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `cons_rate_user_id` int(11) NOT NULL DEFAULT '0',
  `cons_rate_service_type_id` int(11) NOT NULL DEFAULT '0',
  `cons_rate_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `cons_rate_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `cons_rate_created_by` int(11) NOT NULL DEFAULT '0',
  `cons_rate_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cons_rate_modified_by` int(11) NOT NULL DEFAULT '0',
  `cons_rate_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`cons_rate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.billing_consultant_rate: ~0 rows (approximately)
/*!40000 ALTER TABLE `billing_consultant_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_consultant_rate` ENABLE KEYS */;

-- Dumping structure for table galileo.billing_rate
CREATE TABLE IF NOT EXISTS `billing_rate` (
  `rates_id` int(11) NOT NULL AUTO_INCREMENT,
  `rates_service_type_id` int(11) NOT NULL DEFAULT '0',
  `rates_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `rates_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `rates_created_by` int(11) NOT NULL DEFAULT '0',
  `rates_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rates_modified_by` int(11) NOT NULL DEFAULT '0',
  `rates_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`rates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.billing_rate: ~0 rows (approximately)
/*!40000 ALTER TABLE `billing_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_rate` ENABLE KEYS */;

-- Dumping structure for table galileo.billing_task_reference
CREATE TABLE IF NOT EXISTS `billing_task_reference` (
  `billing_reference_id` int(11) NOT NULL AUTO_INCREMENT,
  `billing_reference_billing_id` int(11) NOT NULL DEFAULT '0',
  `billing_reference_client_name` varchar(255) NOT NULL DEFAULT '0',
  `billing_reference_user_fname` varchar(155) NOT NULL DEFAULT '',
  `billing_reference_user_lname` varchar(155) NOT NULL DEFAULT '',
  `billing_reference_task_id` int(11) NOT NULL DEFAULT '0',
  `billing_reference_task_user_id` int(11) NOT NULL DEFAULT '0',
  `billing_reference_task_client_id` int(11) NOT NULL DEFAULT '0',
  `billing_reference_service_qb_ref_id` int(11) NOT NULL DEFAULT '0',
  `billing_reference_task_type` tinyint(1) NOT NULL DEFAULT '0',
  `billing_reference_marsha_code` varchar(200) NOT NULL DEFAULT '',
  `billing_reference_division_code` varchar(50) NOT NULL DEFAULT '',
  `billing_reference_service_type_name` varchar(255) NOT NULL DEFAULT '',
  `billing_reference_rate_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `billing_reference_no_of_units` int(11) NOT NULL DEFAULT '0',
  `billing_reference_tire` varchar(255) NOT NULL DEFAULT '',
  `billing_reference_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `billing_reference_created_by` int(11) NOT NULL DEFAULT '0',
  `billing_reference_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `billing_reference_modified_by` int(11) NOT NULL DEFAULT '0',
  `billing_reference_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `billing_reference_doc_number` bigint(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`billing_reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.billing_task_reference: ~0 rows (approximately)
/*!40000 ALTER TABLE `billing_task_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_task_reference` ENABLE KEYS */;

-- Dumping structure for procedure galileo.checkActivationLink
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `checkActivationLink`(
_userId INT(11),
_activationCode TEXT
)
BEGIN
	DECLARE QryCond TEXT;
	
	
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 AND user.user_id = ',_userId, ' AND user.user_activation_link = ',Quote(_activationCode));
	
	SET @IdQry1 = CONCAT(' SELECT user_id,user_activation_link,user_activation_link_expire FROM user ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.checkTaskAlert
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `checkTaskAlert`(
_clientId INT(11),
_moduleId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE notification.notification_client_id= ',_clientId,' AND notification.notification_record_status=0 AND modules.modules_record_status=0 AND notification.notification_module_id = ',_moduleId);
	
	SET @IdQry1 = CONCAT(' SELECT notification_id,notification_client_id,notification_module_id,modules_name,modules_desc
	FROM notification  
	INNER JOIN modules ON modules.modules_id = notification.notification_module_id
	', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.checkUserEmailExist
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `checkUserEmailExist`(
	IN `_userEmail` VARCHAR(200)
)
    COMMENT 'Check User Email Exist'
BEGIN
DECLARE _existId INT DEFAULT 0;
DECLARE _userExist INT DEFAULT 0;
	SELECT user_id INTO _existId FROM user WHERE lower(user_email) = lower(_userEmail) AND user_record_status = 0;
	SET _existId = IFNULL(_existId, 0);
	IF(_existId > 0) THEN 
		SET _userExist = 1;
	END IF;
	SELECT _userExist as userExist;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.checkUserEmailExistForUpdate
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `checkUserEmailExistForUpdate`(
	IN `_userEmail` VARCHAR(200),
	IN `_userId` INT(11)
)
    COMMENT 'Check User Email Exist for update'
BEGIN
DECLARE _existId INT DEFAULT 0;
DECLARE _userExist INT DEFAULT 0;
	SELECT user_id INTO _existId FROM user WHERE lower(user_email) = lower(_userEmail) AND user_record_status = 0 AND user_id != _userId;
	SET _existId = IFNULL(_existId, 0);
	IF(_existId > 0) THEN 
		SET _userExist = 1;
	END IF;
	SELECT _userExist as userExist;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.checkUserNameExist
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `checkUserNameExist`(IN `_userName` VARCHAR(155))
BEGIN
DECLARE _existId INT DEFAULT 0;
DECLARE _userExist INT DEFAULT 0;
	SELECT user_id INTO _existId FROM user WHERE lower(user_name) = lower(_userName);
	SET _existId = IFNULL(_existId, 0);
	IF(_existId > 0) THEN 
		SET _userExist = 1;
	END IF;
	SELECT _userExist as userExist;
END//
DELIMITER ;

-- Dumping structure for table galileo.client
CREATE TABLE IF NOT EXISTS `client` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_user_id` int(11) NOT NULL DEFAULT '0',
  `client_name` varchar(255) NOT NULL DEFAULT '',
  `client_qb_associated_reference` int(11) NOT NULL DEFAULT '0',
  `client_street` varchar(255) NOT NULL DEFAULT '',
  `client_city` varchar(255) NOT NULL DEFAULT '',
  `client_state` varchar(255) NOT NULL DEFAULT '',
  `client_zipcode` varchar(50) NOT NULL DEFAULT '',
  `client_country` varchar(255) NOT NULL DEFAULT '',
  `client_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `client_created_by` int(11) NOT NULL DEFAULT '0',
  `client_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `client_modified_by` int(11) NOT NULL DEFAULT '0',
  `client_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.client: ~11 rows (approximately)
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` (`client_id`, `client_user_id`, `client_name`, `client_qb_associated_reference`, `client_street`, `client_city`, `client_state`, `client_zipcode`, `client_country`, `client_record_status`, `client_created_by`, `client_created_on`, `client_modified_by`, `client_modified_on`) VALUES
	(1, 1, 'Marriott', 1, 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom', 0, 1, '2017-11-16 06:19:52', 10, '2018-02-19 13:52:47'),
	(2, 1, 'Starwood', 0, 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
	(3, 1, 'Better Homes & Gardens', 0, 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
	(4, 1, 'Booyah', 0, 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
	(5, 1, 'Amplio', 0, 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
	(6, 1, 'Mattress Merchants', 0, 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
	(7, 1, 'American Queen Steamboat', 0, 'Sample1', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom', 0, 1, '2017-11-16 06:19:52', 10, '2018-01-05 14:06:30'),
	(8, 1, 'BlueOrange Travel', 0, 'Sample', 'London', 'Fetter Ln', 'EC4A 1EN', 'United Kingdom\r\n', 0, 1, '2017-11-16 06:19:52', 1, '2017-11-16 06:19:52'),
	(9, 1, 'Test', 0, 'Test', 'Test', 'test', '121', 'test', 1, 1, '2018-01-16 08:30:58', 1, '2018-01-19 05:46:25'),
	(10, 1, 'Vasanth Test Client', 0, 'Test', 'Test', 'Test', '121', 'US', 1, 1, '2018-01-19 05:47:01', 1, '2018-01-19 05:47:20'),
	(11, 10, 'Travel Leaders', 566, '', '', '', '', '', 0, 10, '2018-02-14 14:15:06', 10, '2018-02-14 14:15:06');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;

-- Dumping structure for table galileo.client_entity
CREATE TABLE IF NOT EXISTS `client_entity` (
  `client_entity_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `client_entity_region` varchar(255) NOT NULL DEFAULT '',
  `client_entity_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `client_entity_created_by` int(11) NOT NULL DEFAULT '0',
  `client_entity_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `client_entity_modified_by` int(11) NOT NULL DEFAULT '0',
  `client_entity_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`client_entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2436 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.client_entity: ~2,415 rows (approximately)
/*!40000 ALTER TABLE `client_entity` DISABLE KEYS */;
INSERT INTO `client_entity` (`client_entity_id`, `client_entity_marsha_code`, `client_entity_hotel_name`, `client_entity_street`, `client_entity_city`, `client_entity_state`, `client_entity_zipcode`, `client_entity_country`, `client_entity_client_id`, `client_entity_user_id`, `client_entity_division_id`, `client_entity_region`, `client_entity_record_status`, `client_entity_created_by`, `client_entity_created_on`, `client_entity_modified_by`, `client_entity_modified_on`) VALUES
	(1, 'AUAAR', 'Aruba Marriott Resort & Stellaris Casino', '', '', '', '', 'Aruba', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2, 'STTFR', 'Frenchman\'s Reef & Morning Star Marriott Beach Resort', '', '', '', '', 'Us virgin islands', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(3, 'DPSAK', 'The Stones Hotel - Legian Bali, Autograph Collection', '', '', '', '', 'Indonesia', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(4, 'DPSUW', 'Renaissance Bali Uluwatu Resort & Spa', '', '', '', '', 'Indonesia', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(5, 'MELMC', 'Melbourne Marriott Hotel', '', '', '', '', 'Australia', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(6, 'MFMJW', 'JW Marriott Hotel Macau', '', '', '', '', 'China', 1, 0, 2, 'Greater China', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(7, 'MNLAP', 'Manila Marriott Hotel', '', '', '', '', 'Philippines', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(8, 'NANMC', 'Fiji Marriott Resort Momi Bay', '', '', '', '', 'Fiji', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(9, 'OOLSP', 'Surfers Paradise Marriott Resort & Spa', '', '', '', '', 'Australia', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(10, 'SELSA', 'RYSE, Autograph Collection', '', '', '', '', 'South Korea', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(11, 'SELSN', 'Courtyard Seoul Namdaemun', '', '', '', '', 'South korea', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(12, 'SINCY', 'Courtyard Singapore Novena', '', '', '', '', 'Singapore', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(13, 'SINDT', 'Singapore Marriott Tang Plaza Hotel', '', '', '', '', 'Australia', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(14, 'SYDAK', 'Pier One Sydney Harbour, Autograph Collection', '', '', '', '', 'Australia', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(15, 'SYDMC', 'Sydney Harbour Marriott Hotel at Circular Quay', '', '', '', '', 'Australia', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(16, 'SYDRY', 'Courtyard Sydney-North Ryde', '', '', '', '', 'Australia', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(17, 'TYOMC', 'Tokyo Marriott Hotel', '', '', '', '', 'Japan', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(18, 'SELDP', 'JW Marriott Dongdaemun Square Seoul', '', '', '', '', 'South korea', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(19, 'SINJW', 'JW Marriott Hotel Singapore South Beach', '', '', '', '', 'Singapore', 1, 0, 2, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(20, 'ADBBR', 'RH Izmir', '', '', '', '', 'Turkey', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(21, 'AERMC', 'Sochi Marriott Krasnaya Polyana Hotel', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(22, 'BERAK', 'AK Berlin', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(23, 'BRQCY', 'Courtyard Brno', '', '', '', '', 'Czech republic', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(24, 'BUSAK', 'Paragraph Resort & Spa Shekvetili, Autograph Collection', '', '', '', '', 'Georgia', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(25, 'CGNCY', 'CY Cologne', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(26, 'CPTBR', 'Protea Hotel Cape Town Waterfront Breakwater Lodge', '', '', '', '', 'South africa', 1, 0, 1, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(27, 'CPTCF', 'Protea Hotel Fire & Ice Cape Town', '', '', '', '', 'South africa', 1, 0, 1, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(28, 'CPTST', 'Protea Hotel Stellenbosch', '', '', '', '', 'South africa', 1, 0, 1, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(29, 'DURED', 'Protea Hotel Durban Edward', '', '', '', '', 'South africa', 1, 0, 1, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(30, 'ESBJW', 'JW Ankara', '', '', '', '', 'Turkey', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(31, 'EVNMC', 'MH Yerevan', '', '', '', '', 'Armenia', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(32, 'GLACA', 'CY Glasgow Airport', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(33, 'ISTDT', 'MH Istanbul Sisli', '', '', '', '', 'Turkey', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(34, 'JNBMG', 'African Pride Mount Grace Country House & Spa', '', '', '', '', 'South africa', 1, 0, 1, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(35, 'JNBOR', 'Protea Hotel O.R. Tambo Airport', '', '', '', '', 'South africa', 1, 0, 1, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(36, 'KUFBR', 'RH Samara', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(37, 'LEDBR', 'RH St. Petersburg', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(38, 'LEDCY', 'CY St. Petersburg Vasiliewsky', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(39, 'LEJDT', 'MH Leipzig', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(40, 'LNZCY', 'CY Linz', '', '', '', '', 'Austria', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(41, 'LONSE', 'AK St. Ermin\'s', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(42, 'LUNLS', 'Protea Hotel Lusaka', '', '', '', '', 'Zambia', 1, 0, 1, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(43, 'LVILI', 'Protea Hotel Livingstone', '', '', '', '', 'Zambia', 1, 0, 1, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(44, 'MHPBR', 'RH Minsk', '', '', '', '', 'Belarus', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(45, 'MOWBR', 'RH Moscow Monarch Centre', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(46, 'MOWCY', 'CY Moscow City Centre', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(47, 'MOWDT', 'MH Moscow Royal Aurora', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(48, 'MOWGR', 'MH Moscow Grand', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(49, 'MOWTV', 'MH Moscow Tverskaya', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(50, 'MRSAR', 'AC Hotel Marseille Prado Velodrome', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(51, 'MUCCY', 'CY Munich City Center', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(52, 'MUCFR', 'MH Munich Airport', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(53, 'NCEAC', 'AC Hotel Nice', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(54, 'PARBB', 'CY Paris Boulogne', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(55, 'PRGPA', 'CY Prague Airport', '', '', '', '', 'Czech republic', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(56, 'PRGPZ', 'CY Pilzen', '', '', '', '', 'Czech republic', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(57, 'PRYWA', 'Protea Hotel Pretoria Centurion', '', '', '', '', 'South africa', 1, 0, 1, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(58, 'ROMCP', 'Courtyard Rome Central Park', '', '', '', '', 'Italy', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(59, 'SKPMC', 'MH Skopje', '', '', '', '', 'Macedonia', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(60, 'TLSCY', 'CY Toulouse Airport', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(61, 'TSEMC', 'Astana Marriott Hotel', '', '', '', '', 'Kazakhstan', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(62, 'VIEFG', 'CY Vienna Messe', '', '', '', '', 'Austria', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(63, 'MOWNA', 'Moscow Marriott Hotel Novy Arbat', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(64, 'ATLAS', 'Twelve Atlantic Station', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(65, 'ATLPK', 'Twelve Centennial Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(66, 'BGRFP', 'Four Points by Sheraton Bangor Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(67, 'BNAAL', 'Aloft Nashville - Cool Springs', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(68, 'BUFNY', 'Buffalo Marriott Niagara', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(69, 'BWIAL', 'Aloft BWI Baltimore Washington International Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(70, 'CLTVF', 'Four Points by Sheraton Charlotte - Pineville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(71, 'CMHOF', 'Four Points by Sheraton Columbus Ohio Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(72, 'CMHPF', 'Four Points by Sheraton Columbus - Polaris', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(73, 'DENEL', 'Element Denver Park Meadows', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(74, 'DFWFA', 'FPBS Arlington', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(75, 'EWRES', 'Sheraton Eatontown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(76, 'FAREL', 'Element Fargo', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(77, 'FARFP', 'Four Points by Sheraton Fargo', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(78, 'FLLCS', 'Courtyard Fort Lauderdale Coral Springs', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(79, 'HOUBB', 'Four Points by Sheraton Houston Hobby Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(80, 'HOUGI', 'Sheraton North Houston at George Bush Intercontinental', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(81, 'ISNFP', 'Four Points by Sheraton Williston', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(82, 'ISPFP', 'Four Points by Sheraton Long Island City/Queensboro Bridge', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(83, 'JAXAL', 'Aloft Jacksonville Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(84, 'JAXFP', 'Four Points by Sheraton Jacksonville Baymeadows', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(85, 'LASFF', 'Four Points by Sheraton Las Vegas East Flamingo', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(86, 'MCODW', 'Lake Buena - Westin (SWAN)', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(87, 'MCOPW', 'Four Points by Sheraton Westwood Boulevard Orlando', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(88, 'MCOSI', 'Lake Buena Vista - Sheraton (DOLPHIN)', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(89, 'MEMWF', 'Four Points by Sheraton Memphis - Southwind', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(90, 'MIAEL', 'Element Miami Intl Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(91, 'MIAFA', 'FPBS Miami Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(92, 'NYCMA', 'AC Hotel New York Times Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(93, 'NYCMH', 'Courtyard New York Manhattan/Upper East Side', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(94, 'ONTFP', 'Four Points by Sheraton Ontario-Rancho Cucamonga', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(95, 'ORFBO', 'Residence Inn Virginia Beach Oceanfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(96, 'QKBRI', 'Residence Inn Breckenridge', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(97, 'RDUFP', 'Four Points by Sheraton Raleigh Durham Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(98, 'RQSFP', 'Four Points by Sheraton Barrie', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(99, 'RSWMF', 'Four Points by Sheraton Fort Myers Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(100, 'SAVLC', 'The Perry Lane Hotel, a Luxury Collection Hotel, Savannah', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(101, 'SBYCI', 'Fairfield Inn & Suites Chincoteague Island', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(102, 'SDFAL', 'Aloft Louisville East', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(103, 'SEAFP', 'FPBS Downtown Seattle Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(104, 'SFONP', 'Napa Valley Marriott Hotel & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(105, 'SJCFP', 'FPBS San Jose Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(106, 'YEGAF', 'Four Points by Sheraton Edmonton International Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(107, 'YEGFP', 'Four Points by Sheraton Edmonton South', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(108, 'YKAFP', 'Four Points by Sheraton Kamloops', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(109, 'YQRFP', 'Four Points by Sheraton Regina', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(110, 'YVRSF', 'Four Points by Sheraton Surrey', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(111, 'YXEFP', 'Four Points by Sheraton Saskatoon', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(112, 'ATLMQ', 'Atlanta Marriott Marquis', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(113, 'CHIMQ', 'Marriott Marquis Chicago', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(114, 'CHISR', 'Renaissance Chicago Downtown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(115, 'DENDS', 'Sheraton Denver Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(116, 'FLLSB', 'Fort Lauderdale Marriott Harbor Beach Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(117, 'HNMMC', 'Wailea Beach Resort - Marriott, Maui', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(118, 'HOUMQ', 'Marriott Marquis Houston', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(119, 'JAXSW', 'Sawgrass Marriott Golf Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(120, 'LAXAH', 'Anaheim Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(121, 'MCOJW', 'JW Marriott Orlando', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(122, 'MCORZ', 'The Ritz-Carlton Orlando', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(123, 'MCOSR', 'Renaissance Orlando at SeaWorld®', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(124, 'MCOWC', 'Orlando World Center Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(125, 'MIAMB', 'Marriott Stanton South Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(126, 'MRKFL', 'JW Marriott Marco Island Beach Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(127, 'MSYLA', 'New Orleans Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(128, 'PHXCB', 'JW Marriott Scottsdale Camelback Inn Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(129, 'PHXDR', 'JW Marriott Phoenix Desert Ridge Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(130, 'PHXLC', 'Phoenician Resort ', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(131, 'SANDT', 'Marriott Marquis San Diego Marina', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(132, 'SATJW', 'JW Marriott San Antonio Hill Country Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(133, 'SFODT', 'San Francisco Marriott Marquis', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(134, 'SFOPC', 'The Park Central San Francisco', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(135, 'TPAMC', 'Tampa Marriott Waterside Hotel &amp; Marina', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(136, 'TPASR', 'The Vinoy® Renaissance St. Petersburg Resort & Golf Club', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(137, 'TUSSP', 'JW Marriott Tucson Starr Pass Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(138, 'AIYSI', 'Sheraton Atlantic City Convent', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(139, 'ASEMW', 'The Westin Snowmass Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(140, 'ASEXR', 'The St. Regis Aspen Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(141, 'ATLAG', 'Renaissance Atlanta Airport Gateway Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(142, 'ATLAP', 'Atlanta Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(143, 'ATLAW', 'Atlanta Marriott Alpharetta', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(144, 'ATLBD', 'Renaissance Atlanta Midtown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(145, 'ATLEG', 'Atlanta Evergreen Marriott Conference Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(146, 'ATLJW', 'JW Marriott Atlanta Buckhead', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(147, 'ATLMA', 'Atlanta Airport Marriott Gateway', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(148, 'ATLMW', 'W Atlanta Midtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(149, 'ATLPC', 'Atlanta Marriott Perimeter Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(150, 'ATLRB', 'Renaissance Atlanta Waverly Hotel & Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(151, 'ATLXR', 'St. Regis Atlanta Hotel & Res', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(152, 'AUSSH', 'Renaissance Austin Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(153, 'AUSWH', 'W Austin', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(154, 'BDRCT', 'Trumbull Marriott Merritt Parkway', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(155, 'BHMSI', 'Sheraton Birmingham Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(156, 'BHMWI', 'The Westin Birmingham', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(157, 'BNASH', 'Renaissance Nashville Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(158, 'BNATN', 'Nashville Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(159, 'BOSBO', 'Sheraton Boston Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(160, 'BOSCB', 'Boston Marriott Cambridge', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(161, 'BOSCO', 'Boston Marriott Copley Place', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(162, 'BOSLW', 'Boston Marriott Long Wharf', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(163, 'BOSOW', 'The Westin Boston Waterfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(164, 'BOSQU', 'Boston Marriott Quincy', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(165, 'BURAP', 'Los Angeles Marriott Burbank Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(166, 'BWIAP', 'BWI Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(167, 'BWIIH', 'Baltimore Marriott Inner Harbor at Camden Yards', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(168, 'BWISH', 'Renaissance Baltimore Harborplace Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(169, 'CAEMH', 'Columbia Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(170, 'CHIAP', 'Chicago Marriott O\'Hare', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(171, 'CHIBR', 'Renaissance Chicago O\'Hare Suites Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(172, 'CHILY', 'Westin Lombard Yorktown Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(173, 'CHIRL', 'Residence Inn Chicago Downtown/Loop', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(174, 'CHIRS', 'Renaissance Schaumburg Convention Center Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(175, 'CHIRZ', 'The Ritz-Carlton, Chicago', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(176, 'CHIWI', 'Westin Michigan Avenue', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(177, 'CHSBR', 'Renaissance Charleston Historic District Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(178, 'CIDIC', 'Coralville Marriott Hotel & Conference Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(179, 'CLERZ', 'The Ritz-Carlton, Cleveland', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(180, 'CLESC', 'Cleveland Marriott Downtown at Key Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(181, 'CLTCC', 'Charlotte Marriott City Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(182, 'CLTCW', 'The Westin Charlotte', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(183, 'CLTRP', 'Renaissance Charlotte SouthPark Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(184, 'CMHBR', 'Renaissance Columbus Downtown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(185, 'DALAK', 'The Adolphus', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(186, 'DALDT', 'Dallas Marriott City Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(187, 'DALDW', 'The Westin Dallas Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(188, 'DALPT', 'Dallas/Plano Marriott at Legacy Town Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(189, 'DALWH', 'W Dallas - Victory Hotel & Res', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(190, 'DALWL', 'Dallas/Fort Worth Marriott Solana', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(191, 'DENSA', 'Renaissance Denver Stapleton Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(192, 'DENWE', 'Denver Marriott West', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(193, 'DENWI', 'Westin Denver Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(194, 'DFWWA', 'Westin Dallas Fort Worth Airpt', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(195, 'DSMIA', 'Des Moines Marriott Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(196, 'DTTTT', 'Detroit Marriott Troy', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(197, 'DTWCW', 'Westin Book Cadillac', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(198, 'EWRAP', 'Newark Liberty International Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(199, 'EWRHB', 'W Hoboken', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(200, 'EWRNR', 'Renaissance Newark Airport Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(201, 'EWRWJ', 'Westin Jersey City', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(202, 'FLLWH', 'W Ft Lauderdale Hotel & Res', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(203, 'GEGAD', 'The Davenport Grand', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(204, 'GEGAK', 'The Historic Davenport, Autograph Collection', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(205, 'HAFRZ', 'The Ritz-Carlton, Half Moon Bay', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(206, 'HOUGW', 'Westin Galleria Houston', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(207, 'HOUJW', 'JW Marriott Houston', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(208, 'HOUOW', 'Westin Oaks Houston Galleria', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(209, 'HOUWL', 'Houston Marriott West Loop by The Galleria', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(210, 'HOUXR', 'The St. Regis Houston', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(211, 'IADAP', 'Washington Dulles Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(212, 'IADWF', 'Westfields Marriott Washington Dulles', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(213, 'IAGNF', 'Niagara Falls Marriott Fallsview Hotel & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(214, 'IAGSI', 'Sheraton on the Falls Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(215, 'IAHAP', 'Houston Airport Marriott at George Bush Intercontinental', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(216, 'ILEGT', 'Sheraton Georgetown Texas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(217, 'JHMRZ', 'The Ritz-Carlton, Kapalua', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(218, 'KOASI', 'Sheraton Keauhou Bay Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(219, 'LASJW', 'JW Marriott Las Vegas Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(220, 'LASST', 'Las Vegas Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(221, 'LAXBW', 'The Westin Bonaventure Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(222, 'LAXGR', 'Sheraton Grand Los Angeles', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(223, 'LAXMB', 'Marina del Rey Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(224, 'LAXRR', 'Renaissance Los Angeles Airport Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(225, 'LAXTR', 'Torrance Marriott Redondo Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(226, 'LAXWI', 'Westin Los Angeles Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(227, 'LGBRN', 'Renaissance Long Beach Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(228, 'LIHAK', 'Koloa Landing Resort at Poipu', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(229, 'LIHSI', 'Sheraton Kauai Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(230, 'LIHXR', 'St. Regis Princeville Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(231, 'MCICC', 'Sheraton Overland Park Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(232, 'MCICR', 'Sheraton Kansas City at Crown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(233, 'MCIDT', 'Kansas City Marriott Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(234, 'MCIWI', 'Westin Kansas City Crown Cnt', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(235, 'MEMDS', 'Sheraton Memphis Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(236, 'MIAAS', 'Residence Inn Miami Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(237, 'MIACS', 'Courtyard Miami Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(238, 'MIATR', 'Hotel Colonnade Coral Gables', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(239, 'MSPCC', 'Minneapolis Marriott City Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(240, 'MSPJW', 'JW Marriott Minneapolis Mall of America', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(241, 'MSYBR', 'Aloft New Orleans Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(242, 'MSYCI', 'Courtyard New Orleans French Quarter/Iberville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(243, 'MSYDT', 'Renaissance New Orleans Arts Warehouse District Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(244, 'MSYMC', 'New Orleans Downtown Marriott at the Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(245, 'MSYQF', 'FPBS French Quarter', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(246, 'NPBST', 'Newport Beach Marriott Bayview', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(247, 'NYCAK', 'The Algonquin Hotel Times Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(248, 'NYCEA', 'New York Marriott East Side', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(249, 'NYCLI', 'Long Island Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(250, 'NYCNU', 'W New York - Union Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(251, 'NYCWD', 'W New York Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(252, 'NYCWE', 'Westchester Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(253, 'NYCWS', 'New York Marriott Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(254, 'NYCXR', 'The St. Regis New York', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(255, 'NYCZW', 'Westin New York Grand Central', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(256, 'OAKBR', 'Renaissance ClubSport Walnut Creek Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(257, 'OAKDT', 'Oakland Marriott City Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(258, 'OAKSR', 'San Ramon Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(259, 'OXRVB', 'Ventura Beach Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(260, 'PFNSI', 'Sheraton Bay Point Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(261, 'PHLAR', 'Philadelphia Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(262, 'PHLDC', 'Courtyard Philadelphia Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(263, 'PHLRT', 'The Ritz-Carlton, Philadelphia', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(264, 'PHLWE', 'Philadelphia Marriott West', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(265, 'PHXBD', 'Renaissance Phoenix Downtown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(266, 'PHXGP', 'Sheraton Grand Phoenix', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(267, 'PHXWP', 'Sheraton Grand at Wild Horse', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(268, 'PHXWS', 'The Westin Kierland Resort &amp; Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(269, 'PITWI', 'Westin Convention Pittsburgh', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(270, 'PSPWI', 'Westin Mission Hills Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(271, 'PVDLW', 'Newport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(272, 'RNORZ', 'The Ritz-Carlton, Lake Tahoe', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(273, 'SANWI', 'Westin San Diego Gaslamp Qtr', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(274, 'SATDT', 'San Antonio Marriott Riverwalk', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(275, 'SATLC', 'The St. Anthony', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(276, 'SATRC', 'San Antonio Marriott Rivercenter', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(277, 'SATVW', 'Westin Riverwalk Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(278, 'SAVWI', 'Westin Savannah Harbor Golf', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(279, 'SBARZ', 'The Ritz-Carlton Bacara, Santa Barbara', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(280, 'SEAMC', 'Seattle Marriott Redmond', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(281, 'SEASI', 'Sheraton Seattle Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(282, 'SEAWF', 'Seattle Marriott Waterfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(283, 'SFOBG', 'San Francisco Airport Marriott Waterfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(284, 'SFOCD', 'Courtyard San Francisco Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(285, 'SFOJW', 'JW Marriott San Francisco Union Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(286, 'SFOLC', 'Palace Hotel, a Luxury Collection Hotel, San Francisco', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(287, 'SFOLS', 'The Lodge at Sonoma Renaissance Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(288, 'SFORZ', 'The Ritz-Carlton, San Francisco', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(289, 'SFOUS', 'San Francisco Marriott Union Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(290, 'SFOXR', 'The St. Regis San Francisco', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(291, 'SJCGA', 'Santa Clara Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(292, 'SLCUT', 'Salt Lake Marriott Downtown at City Creek', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(293, 'SLCVO', 'Provo Marriott Hotel & Conference Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(294, 'SLCXR', 'The St. Regis Deer Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(295, 'SNAAV', 'Renaissance ClubSport Aliso Viejo Laguna Beach Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(296, 'SNAMC', 'Marriott Irvine Spectrum', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(297, 'SNAST', 'Costa Mesa Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(298, 'SOSBW', 'Bridgewater Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(299, 'TPAAP', 'Tampa Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(300, 'TRICC', 'MeadowView Conference Resort & Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(301, 'TTNDF', 'Princeton Marriott at Forrestal', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(302, 'WASBN', 'Bethesda North Marriott Hotel & Conference Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(303, 'WASGW', 'Crystal Gateway Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(304, 'WASKB', 'Key Bridge Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(305, 'WASMC', 'Washington Marriott at Metro Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(306, 'WASPC', 'The Ritz-Carlton, Pentagon City', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(307, 'WASPY', 'Renaissance Arlington Capital View Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(308, 'WASRB', 'Renaissance Washington, DC Downtown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(309, 'WASSX', 'The St. Regis Washington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(310, 'WASTW', 'Westin Georgetown Wash DC', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(311, 'WASUM', 'College Park Marriott Hotel & Conference Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(312, 'WASWH', 'W Washington D.C.', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(313, 'YHZMC', 'Halifax Marriott Harbourfront Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(314, 'YLWOK', 'Delta Hotels Grand Okanagan Resort', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(315, 'YOWDM', 'Delta Hotels Ottawa City Centre', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(316, 'YOWMC', 'Ottawa Marriott Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(317, 'YOWWI', 'Westin Ottawa', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(318, 'YQAJW', 'JW Marriott The Rosseau Muskoka Resort &amp; Spa', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(319, 'YQBDR', 'Delta Hotels Quebec', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(320, 'YULSI', 'Le Centre Sheraton Montreal', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(321, 'YVRDT', 'Vancouver Marriott Pinnacle Downtown Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(322, 'YVRJW', 'JW Marriott Parq Vancouver', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(323, 'YVRPS', 'the DOUGLAS', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(324, 'YYCBV', 'Delta Hotels Calgary Downtown', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(325, 'YYCDT', 'Calgary Marriott Downtown Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(326, 'YYCXA', 'Calgary Airport Marriott In-Terminal Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(327, 'YYZCC', 'Toronto Marriott City Centre Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(328, 'YYZCY', 'Courtyard Toronto Downtown', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(329, 'YYZDL', 'Delta Hotels Toronto', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(330, 'YYZEC', 'Toronto Marriott Downtown Eaton Centre Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(331, 'YYZMC', 'Toronto Marriott Bloor Yorkville Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(332, 'YYZOT', 'Toronto Airport Marriott Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(333, 'YYZXR', 'The Adelaide Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(334, 'ATLBW', 'W Atlanta Buckhead', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(335, 'ATLPL', 'Westin Peachtree Plaza', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(336, 'BOSWF', 'Renaissance Boston Waterfront Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(337, 'BOSWI', 'Westin Copley Place', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(338, 'BWIWF', 'Baltimore Marriott Waterfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(339, 'CHIDT', 'Chicago Marriott Downtown Magnificent Mile', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(340, 'CHIGS', 'Sheraton Grand Chicago', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(341, 'CHIJW', 'JW Marriott Chicago', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(342, 'CTDCA', 'JW Marriott Desert Springs Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(343, 'CVGBR', 'Renaissance Cincinnati Downtown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(344, 'DALBP', 'Renaissance Dallas at Plano Legacy West Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(345, 'DALBR', 'Renaissance Dallas Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(346, 'DALDH', 'Sheraton Dallas Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(347, 'DALGW', 'Westin Galleria Dallas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(348, 'DALSB', 'The Westin Stonebriar Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(349, 'DENAW', 'Westin Denver Intl Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(350, 'DFWDT', 'The Worthington Renaissance Fort Worth Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(351, 'DTWDT', 'Detroit Marriott at the Renaissance Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(352, 'FLLOF', 'Hollywood Beach Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(353, 'FLLPM', 'Fort Lauderdale Marriott Pompano Beach Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(354, 'HHHGR', 'Hilton Head Marriott Resort &amp; Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(355, 'HHHWI', 'Westin Resort Hilton Head', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(356, 'HNLKS', 'Sheraton Princess Kaiulani', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(357, 'HNLLC', 'The Royal Hawaiian', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(358, 'HNLMC', 'Waikiki Beach Marriott Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(359, 'HNLWI', 'Moana Surfrider', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(360, 'HNLWS', 'Sheraton Waikiki Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(361, 'HNMSI', 'Sheraton Maui Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(362, 'HNMWI', 'Westin Maui Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(363, 'HOUMY', 'Westin Houston Memorial City', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(364, 'KOAAK', 'Mauna Kea Beach Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(365, 'KOAMC', 'Waikoloa Beach Marriott Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(366, 'KOAWI', 'Hapuna Beach Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(367, 'LAXAP', 'Los Angeles Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(368, 'LAXIR', 'Irvine Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(369, 'LAXJW', 'JW Marriott Los Angeles L.A. LIVE', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(370, 'LAXMN', 'Manhattan Beach Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(371, 'LAXNB', 'Newport Beach Marriott Hotel & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(372, 'LEXKY', 'Griffin Gate Marriott Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(373, 'LIHHI', 'Kaua\'i Marriott Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(374, 'MCOAP', 'Orlando Airport Marriott Lakeside', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(375, 'MIAAP', 'Miami Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(376, 'MIABB', 'Miami Marriott Biscayne Bay', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(377, 'MIAWM', 'W Miami', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(378, 'MIAXR', 'St. Regis Bal Harbour', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(379, 'MRYCA', 'Monterey Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(380, 'MSYIS', 'Sheraton New Orleans Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(381, 'MSYJW', 'JW Marriott New Orleans', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(382, 'MTHKL', 'Key Largo Bay Marriott Beach Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(383, 'MYRGD', 'Myrtle Beach Marriott Resort &amp; Spa at Grande Dunes', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(384, 'NPBAK', 'Lido House', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(385, 'NYCBK', 'New York Marriott at the Brooklyn Bridge', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(386, 'NYCEX', 'JW Marriott Essex House New York', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(387, 'NYCMQ', 'New York Marriott Marquis', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(388, 'NYCOX', 'MOXY NYC Times Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(389, 'NYCRT', 'Renaissance New York Times Square Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(390, 'NYCST', 'Sheraton New York Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(391, 'NYCSW', 'Westin NY Times Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(392, 'NYCWH', 'W New York - Times Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(393, 'NYCWW', 'W New York', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(394, 'PBIDR', 'Delray Beach Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(395, 'PBIIR', 'Hutchinson Island Marriott Beach Resort &amp; Marina', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(396, 'PBIMC', 'West Palm Beach Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(397, 'PBISG', 'Palm Beach Marriott Singer Island Beach Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(398, 'PHLDT', 'Philadelphia Marriott Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(399, 'PSPSR', 'Renaissance Indian Wells Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(400, 'RSWSB', 'Sanibel Harbour Marriott Resort &amp; Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(401, 'RSWWI', 'Westin Tarpon Point Marina', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(402, 'SANCI', 'Coronado Island Marriott Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(403, 'SANSI', 'Sheraton San Diego Hotel & Mar', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(404, 'SAVRF', 'Savannah Marriott Riverfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(405, 'SEAWI', 'Westin Seattle', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(406, 'SFOUW', 'Westin St. Francis', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(407, 'SJCSJ', 'San Jose Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(408, 'STLMG', 'Marriott St. Louis Grand', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(409, 'TPAIM', 'Renaissance Tampa International Plaza Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(410, 'WASAK', 'The Mayflower Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(411, 'WASBT', 'Bethesda Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(412, 'WASCO', 'Marriott Marquis Washington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(413, 'WASDT', 'Washington Marriott Wardman Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(414, 'WASJW', 'JW Marriott Washington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(415, 'WASWE', 'Washington Marriott Georgetown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(416, 'WHRCO', 'Vail Marriott Mountain Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(417, 'YYZTC', 'Sheraton Centre Toronto Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(418, 'YYZWI', 'Westin Harbour Castle Toronto', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(419, 'AHNRZ', 'The Ritz-Carlton Reynolds', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(420, 'ANCSI', 'Sheraton Anchorage Hotel & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(421, 'ARBSI', 'Sheraton Ann Arbor Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(422, 'ATLAK', 'Glenn Hotel, Autograph Collection', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(423, 'ATLBC', 'Atlanta Marriott Buckhead Hotel & Conference Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(424, 'ATLHW', 'W Atlanta Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(425, 'ATLLM', 'Le Meridien Atlanta Perimeter', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(426, 'ATLLU', 'The Whitley, a Luxury Collection Hotel, Atlanta Buckhead', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(427, 'ATLMS', 'Atlanta Marriott Suites Midtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(428, 'ATLPN', 'The Westin Atlanta Perimeter North', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(429, 'ATLRZ', 'The Ritz-Carlton, Atlanta Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(430, 'ATLWI', 'The Westin Atlanta Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(431, 'ATLXS', 'Sheraton Atlanta Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(432, 'AUSDA', 'Aloft Austin Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(433, 'AUSDW', 'Westin Austin at The Domain', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(434, 'AUSED', 'Element Austin Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(435, 'AUSWI', 'The Westin Austin Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(436, 'BNATX', 'Noelle', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(437, 'BNAWI', 'The Westin Nashville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(438, 'BOSDM', 'Courtyard Boston Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(439, 'BOSFS', 'Sheraton Framingham Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(440, 'BOSPB', 'Boston Marriott Peabody', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(441, 'BOSRT', 'The Ritz-Carlton, Boston', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(442, 'BOSSI', 'Sheraton Needham Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(443, 'BOSWH', 'W Boston Hotel & Residences', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(444, 'BQKWI', 'Westin Jekyll Island', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(445, 'BURSI', 'Sheraton Universal Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(446, 'BVUBW', 'Westin Bellevue', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(447, 'BVUWH', 'W Bellevue', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(448, 'BWIBU', 'Towson University Marriott Conference Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(449, 'BWIBW', 'Westin Baltimore Wash Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(450, 'BWIIS', 'Sheraton Inner Harbor Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(451, 'BWILS', 'Sheraton Baltimore Washington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(452, 'BWINS', 'Sheraton Baltimore North Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(453, 'BWISC', 'Sheraton Columbia Town Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(454, 'CHAWI', 'The Westin Chattanooga', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(455, 'CHICC', 'Aloft Chicago City Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(456, 'CHIIS', 'Sheraton Lisle Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(457, 'CHILC', 'The Gwen', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(458, 'CHINO', 'Westin River North', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(459, 'CHIOB', 'Chicago Marriott Oak Brook', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(460, 'CHIOW', 'The Westin Chicago North Shore', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(461, 'CHISI', 'Sheraton Chicago O\'Hare Airport Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(462, 'CHIWA', 'Westin O\'Hare', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(463, 'CHIWB', 'Courtyard Chicago Downtown/River North', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(464, 'CHIWC', 'W Chicago - City Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(465, 'CHIWH', 'W Chicago - Lakeshore', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(466, 'CHIWN', 'The Westin Chicago Northwest', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(467, 'CLEWI', 'The Westin Cleveland Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(468, 'CLTLC', 'The Ballantyne', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(469, 'CLTMD', 'Le M?ridien Charlotte', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(470, 'CLTPH', 'Charlotte Marriott SouthPark', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(471, 'CLTWS', 'Sheraton Charlotte Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(472, 'CMHCS', 'Sheraton Columbus Capitol Sq', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(473, 'CMHSI', 'Sheraton Suites Columbus', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(474, 'CMHWI', 'The Westin Columbus', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(475, 'CRWWV', 'Charleston Marriott Town Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(476, 'CSMTX', 'Avenue of the Arts Costa Mesa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(477, 'DALGI', 'Sheraton Arlington Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(478, 'DALMD', 'LM Dallas by the Galleria', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(479, 'DALRZ', 'The Ritz-Carlton, Dallas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(480, 'DALSA', 'Sheraton Stonebriar Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(481, 'DALSL', 'Sheraton Dallas Hotel Galleria', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(482, 'DALWI', 'The WestinDallas Park Central', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(483, 'DENMD', 'Le Mridien Denver Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(484, 'DENRZ', 'The Ritz-Carlton, Denver', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(485, 'DFWAH', 'Sheraton DFW Airport Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(486, 'DFWDS', 'Sheraton Fort Worth Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(487, 'DSMSI', 'Sheraton West Des Moines Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(488, 'DTWMA', 'Westin Detroit Metropolitan', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(489, 'DTWWI', 'The Westin Southfield Detroit', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(490, 'ERISI', 'Sheraton Erie Bayfront Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(491, 'EWRSL', 'Sheraton Lincoln Harbor Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(492, 'EWRWM', 'The Westin Governor Morris', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(493, 'EYWSI', 'Sheraton Suites Key West', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(494, 'FLLHT', 'Courtyard Fort Lauderdale Airport & Cruise Port', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(495, 'FLLLW', 'Westin For Laudersale Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(496, 'FLLMC', 'Fort Lauderdale Marriott Coral Springs Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(497, 'FLLRZ', 'The Ritz-Carlton, Fort Lauderdale', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(498, 'FLLSC', 'Sheraton Suites Fort Lauderdal', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(499, 'GSOSI', 'Sheraton Greensboro Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(500, 'GSPWI', 'Westin Poinsett', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(501, 'HARSI', 'Sheraton Harrisburg Hershey', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(502, 'HNLOW', 'Courtyard Waikiki Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(503, 'HNMKW', 'The Westin Ka\'anapali Ocean Resort Villas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(504, 'HNMRI', 'Residence Inn Maui Wailea', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(505, 'HOUDM', 'Le Mridien Houston Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(506, 'HOUHG', 'Sheraton Suites Houston Galler', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(507, 'HOUMC', 'Houston Marriott Medical Center/Museum District', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(508, 'HOUMW', 'The Woodlands Waterway Marriott Hotel & Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(509, 'HOUSI', 'Sheraton Houston Brookhollow', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(510, 'HOUWI', 'The Westin Houston Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(511, 'HPNSH', 'Renaissance Westchester Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(512, 'IAGFV', 'FPBS Niagara Falls Fallsview', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(513, 'IAHWI', 'The Westin at The Woodlands', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(514, 'ILGSI', 'Sheraton Suites Wilmington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(515, 'ILGWI', 'The Westin Wilmington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(516, 'INDSC', 'Sheraton Indianapolis City Cen', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(517, 'INDSI', 'Sheraton Indianapolis Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(518, 'JAXAM', 'The Ritz-Carlton, Amelia Island', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(519, 'JAXBR', 'World Golf Village Renaissance St. Augustine Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(520, 'JHMWI', 'The Westin Nanea Ocean Villas, Ka\'anapali', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(521, 'LASTX', 'SLS Las Vegas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(522, 'LASVW', 'The Westin Las Vegas Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(523, 'LASWH', 'W - Las Vegas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(524, 'LASWI', 'Westin Lake Las Vegas Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(525, 'LAXDM', 'LM Delfina Santa Monica', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(526, 'LAXFP', 'FPBS Los Angeles Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(527, 'LAXLD', 'Courtyard Los Angeles L.A. LIVE', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(528, 'LAXLS', 'SLS Beverly Hills', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(529, 'LAXMD', 'The Ritz-Carlton, Marina del Rey', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(530, 'LAXOC', 'Fairfield Inn Anaheim Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(531, 'LAXRI', 'Residence Inn Los Angeles L.A. LIVE', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(532, 'LAXRO', 'Residence Inn Los Angeles Pasadena/Old Town', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(533, 'LAXSI', 'Sheraton Gateway Los Angeles Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(534, 'LAXWB', 'W Los Angeles - Westwood', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(535, 'LAXWH', 'W Hollywood Hotel & Residences', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(536, 'LGASI', 'Sheraton LaGuardia East Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(537, 'LGBCY', 'Courtyard Long Beach Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(538, 'LGBFP', 'Sheraton Los Angeles San Gabriel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(539, 'LGBWI', 'The Westin Long Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(540, 'LIHPW', 'The Westin Princeville Ocean Resort Villas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(541, 'MCIOP', 'Marriott Kansas City Overland Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(542, 'MCISI', 'Sheraton Suites Country Club', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(543, 'MCOLX', 'SpringHill Suites Orlando Lake Buena Vista in Marriott Village', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(544, 'MCOLY', 'Courtyard Orlando Lake Buena Vista in the Marriott Village', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(545, 'MCOLZ', 'Fairfield Inn & Suites Orlando Lake Buena Vista in the Marriott Village', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(546, 'MCOSW', 'Residence Inn Orlando at SeaWorld®', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(547, 'MCOYR', 'Residence Inn Orlando South', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(548, 'MCOYS', 'SpringHill Suites Orlando South', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(549, 'MIAAC', 'AC Hotel Miami Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(550, 'MIACB', 'Courtyard Miami Beach South Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(551, 'MIACH', 'Residence Inn Miami Beach South Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(552, 'MIAEB', 'Miami Beach EDITION', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(553, 'MIAHD', 'SpringHill Suites Miami Downtown/Medical Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(554, 'MIAKB', 'The Ritz-Carlton Key Biscayne', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(555, 'MIAKC', 'Courtyard Cadillac Miami Beach/Oceanfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(556, 'MIANM', 'Residence Inn Miami Sunny Isles Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(557, 'MIASB', 'The Ritz-Carlton, South Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(558, 'MIATX', 'Royal Palm South Beach Miami', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(559, 'MIAWS', 'W South Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(560, 'MIAZL', 'The Ritz-Carlton Bal Harbour', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(561, 'MKEIW', 'The Westin Milwaukee', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(562, 'MMHWI', 'Westin Monache Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(563, 'MSNSI', 'Sheraton Madison Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(564, 'MSPLC', 'Hotel Ivy', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(565, 'MSPMD', 'LM Chambers Minneapolis', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(566, 'MSPOS', 'Sheraton Bloomington Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(567, 'MSPWH', 'W Minneapolis - The Foshay', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(568, 'MSPWI', 'The Westin Edina Galleria', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(569, 'MSPWS', 'Sheraton Minneapolis West', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(570, 'MSYMD', 'Le Meridien New Orleans', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(571, 'MSYRZ', 'The Ritz-Carlton, New Orleans', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(572, 'MSYWH', 'W New Orleans - French Quarter', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(573, 'MSYWI', 'Westin New Orleans Canal Place', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(574, 'MYRSI', 'Sheraton Myrtle Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(575, 'NPBBR', 'The Duke Hotel Newport Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(576, 'NYCBR', 'Renaissance New York Hotel 57', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(577, 'NYCCE', 'Courtyard New York Manhattan/Chelsea', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(578, 'NYCCP', 'The Ritz-Carlton New York, Central Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(579, 'NYCEB', 'New York EDITION', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(580, 'NYCEL', 'Element NY Times Square West', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(581, 'NYCES', 'Courtyard New York Manhattan/Fifth Avenue', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(582, 'NYCLT', 'The Chatwal', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(583, 'NYCME', 'Courtyard New York Manhattan/Midtown East', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(584, 'NYCMS', 'Courtyard New York Manhattan/Herald Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(585, 'NYCMT', 'Courtyard New York Manhattan/SoHo', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(586, 'NYCRD', 'The Ritz-Carlton New York, Battery Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(587, 'NYCRW', 'The Ritz-Carlton New York, Westchester', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(588, 'NYCSM', 'SpringHill Suites New York Midtown Manhattan/Fifth Avenue', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(589, 'NYCTR', 'Sheraton Tribeca New York', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(590, 'OKCBR', 'Renaissance Oklahoma City Convention Center Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(591, 'OKCSI', 'Sheraton Oklahoma City Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(592, 'ONTAK', 'Lake Arrowhead Resort and Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(593, 'ORFSI', 'Sheraton Norfolk Waterside', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(594, 'ORFVS', 'Sheraton Virginia Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(595, 'PDXLN', 'The Nines', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(596, 'PDXOR', 'Portland Marriott Downtown Waterfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(597, 'PHLBC', 'Sheraton Bucks County Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(598, 'PHLCS', 'Courtyard Philadelphia South at The Navy Yard', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(599, 'PHLMW', 'The Westin Mount Laurel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(600, 'PHLPR', 'The Franklin Hotel at Independence Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(601, 'PHLSI', 'Sheraton Society Hill Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(602, 'PHLUS', 'Sheraton Philadelphia Univ', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(603, 'PHLVS', 'Sheraton Great Valley Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(604, 'PHLWS', 'Sheraton Philadelphia Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(605, 'PHXIW', 'The Westin Phoenix Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(606, 'PHXNO', 'Scottsdale Marriott at McDowell Mountains', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(607, 'PHXST', 'Scottsdale Marriott Suites Old Town', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(608, 'PHXWH', 'W Scottsdale', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(609, 'PHXWW', 'Sheraton Mesa Wrigleyville West', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(610, 'PITPS', 'Sheraton Pittsburgh Hotel at Station Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(611, 'PITSA', 'Sheraton Pittsburgh Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(612, 'PSMSI', 'Sheraton Portsmouth Harborside', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(613, 'PSPPS', 'The Ritz-Carlton, Rancho Mirage', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(614, 'PSPTX', 'Riviera Palm Springs', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(615, 'RDUIS', 'Sheraton Imperial Hotel & Conv', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(616, 'RDUSI', 'Sheraton Raleigh Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(617, 'RICWI', 'The Westin Richmond', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(618, 'RSWGR', 'The Ritz-Carlton Golf Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(619, 'RSWRZ', 'The Ritz-Carlton, Naples Beach Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(620, 'RUTLC', 'The Equinox, a Luxury Collection Golf Resort &amp; Spa, Vermont', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(621, 'SACSI', 'Sheraton Grand Sacramento', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(622, 'SANBS', 'Sheraton Carlsbad Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(623, 'SANDH', 'SpringHill Suites San Diego Downtown/Bayfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(624, 'SANLC', 'The U.S. Grant', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(625, 'SANRH', 'Residence Inn San Diego Downtown/Bayfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(626, 'SANVS', 'Sheraton Mission Valley San Di', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(627, 'SANWC', 'The Westin Carlsbad Resort & Spa', '', '', '', '', 'United states', 1, 0, 3, 'Americs West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(628, 'SEAWA', 'Seattle Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(629, 'SEAWH', 'W Seattle', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(630, 'SFOAL', 'Aloft San Francisco Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(631, 'SFOSI', 'Sheraton Fisherman\'s Wharf Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(632, 'SFOWH', 'W San Francisco', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(633, 'SFOWI', 'Westin San Francisco Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(634, 'SJCSI', 'Sheraton Palo Alto Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(635, 'SNAPS', 'Sheraton Park Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(636, 'SNARZ', 'The Ritz-Carlton, Laguna Niguel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(637, 'SNAWI', 'Westin South Coast Plaza', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(638, 'SRQRZ', 'The Ritz-Carlton, Sarasota', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(639, 'SRQWI', 'The Westin Sarasota', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(640, 'STLRZ', 'The Ritz-Carlton, St Louis', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(641, 'TPAAC', 'AC Hotel Tampa Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(642, 'TPAFP', 'Sheraton Suites Tampa Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(643, 'TPASI', 'Sheraton Sand Key Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(644, 'TPAWH', 'Westin Tampa Harbour Island', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(645, 'TPAWK', 'Sheraton Tampa Riverwalk Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(646, 'TTNWI', 'Westin Princeton Forrestal Vil', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(647, 'TUSRZ', 'The Ritz-Carlton, Dove Mountain', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(648, 'TUSWI', 'Westin La Paloma Resort & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(649, 'WASAG', 'The Westin Arlington Gateway', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(650, 'WASBV', 'Sheraton Washington North', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(651, 'WASCC', 'Crystal City Marriott at Reagan National Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(652, 'WASFB', 'Courtyard Washington, DC/Foggy Bottom', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(653, 'WASFP', 'Falls Church Marriott Fairview Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(654, 'WASMO', 'The Alexandrian, Autograph Collection', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(655, 'WASNS', 'The Westin Tysons Corner', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(656, 'WASRT', 'The Ritz-Carlton, Washington D.C.', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(657, 'WASSG', 'Sheraton Silver Spring Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(658, 'WASSI', 'Sheraton Suites Old Town', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(659, 'WASTC', 'Tysons Corner Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(660, 'WASTY', 'The Ritz-Carlton, Tysons Corner', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(661, 'WASUS', 'Courtyard Washington, DC/U.S. Capitol', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(662, 'WASVS', 'Sheraton Rockville Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(663, 'WASXW', 'The Westin Alexandria', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(664, 'WASYS', 'Sheraton Tysons Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(665, 'WHRRZ', 'The Ritz-Carlton, Bachelor Gulch', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(666, 'WHRTA', 'Hotel Talsia', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(667, 'YEGEC', 'Delta Hotels Edmonton Centre Suites', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(668, 'YEGES', 'Delta Hotels Edmonton South Conference Centre', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(669, 'YEGMC', 'Edmonton Marriott at River Cree Resort', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(670, 'YEGWI', 'Westin Edmonton', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(671, 'YFCDF', 'Delta Hotels Fredericton', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(672, 'YHMSI', 'Sheraton Hamilton Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(673, 'YMYWI', 'Le Westin Tremblant', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(674, 'YOWSI', 'Sheraton Ottawa Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(675, 'YQBPU', 'Hotel PUR Quebec', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(676, 'YSEWI', 'The Westin Resort & Spa, Whistler', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(677, 'YULDB', 'Delta Hotels Montreal', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(678, 'YULLE', 'Le Westin Montreal', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(679, 'YULMA', 'Montreal Airport Marriott In-Terminal Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(680, 'YULRM', 'the Ritz-Carlton Montreal', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(681, 'YULSA', 'Sheraton Montreal Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(682, 'YULWH', 'W Montreal', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(683, 'YVRDV', 'Delta Hotels Vancouver Downtown Suites', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(684, 'YVRGW', 'The Westin Grand', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(685, 'YVRSA', 'Vancouver Airport Marriott Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(686, 'YVRSI', 'Sheraton Vancouver Guildford', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(687, 'YVRVS', 'Sheraton Vancouver Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(688, 'YVRWI', 'The Westin Bayshore', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(689, 'YVRWS', 'Sheraton Vancouver Wall Centre', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(690, 'YWGDW', 'Delta Hotels Winnipeg', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(691, 'YYCKV', 'Delta Hotels Kananaskis Lodge', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(692, 'YYGDP', 'Delta Hotels Prince Edward', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(693, 'YYJVO', 'Delta Hotels Victoria Ocean Pointe Resort', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(694, 'YYTSI', 'Sheraton Hotel Newfoundland', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(695, 'YYZBW', 'Westin Toronto Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(696, 'YYZDS', 'Sheraton Toronto Airport Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(697, 'YYZGS', 'Sheraton Gateway Hotel Toronto', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(698, 'YYZMR', 'Toronto Marriott Markham', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(699, 'YYZPW', 'The Westin Prince Toronto', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(700, 'YYZRZ', 'The Ritz-Carlton, Toronto', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(701, 'YYZTH', 'Westin Trillium House', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(702, 'ABEBR', 'Renaissance Allentown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(703, 'ABECY', 'Courtyard Allentown Bethlehem/Lehigh Valley Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(704, 'ABERI', 'Residence Inn Allentown Bethlehem/Lehigh Valley Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(705, 'ABQAH', 'Sheraton Albuquerque Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(706, 'ABQCA', 'Courtyard Albuquerque Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(707, 'ABQMC', 'Albuquerque Marriott Pyramid North', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(708, 'ABQRI', 'Residence Inn Albuquerque', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(709, 'ABQSI', 'Sheraton Albuquerque Uptown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(710, 'AFAFP', 'FPBS San Rafael', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(711, 'AGSCH', 'Courtyard Augusta', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(712, 'AGSSI', 'Sheraton Augusta Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(713, 'ALBTX', 'The Wick', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(714, 'ASEEL', 'Element Basalt - Aspen', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(715, 'ATLAB', 'SpringHill Suites Atlanta Buckhead', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(716, 'ATLAN', 'Courtyard Atlanta Airport North/Virginia Avenue', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(717, 'ATLBH', 'Residence Inn Atlanta Buckhead', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(718, 'ATLCA', 'Courtyard Atlanta Airport South/Sullivan Road', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(719, 'ATLCU', 'Courtyard Atlanta Cumberland/Galleria', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(720, 'ATLDN', 'Aloft Atlanta Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(721, 'ATLDO', 'Courtyard Atlanta Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(722, 'ATLEP', 'Courtyard Atlanta Executive Park/Emory', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(723, 'ATLFW', 'FPBS Atlanta Airport West', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(724, 'ATLGI', 'SpringHill Suites Atlanta Airport Gateway', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(725, 'ATLGM', 'Courtyard Atlanta Duluth/Gwinnett Place', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(726, 'ATLGS', 'Sheraton Suites Galleria Atl', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(727, 'ATLJC', 'Courtyard Atlanta Norcross/I-85', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(728, 'ATLMN', 'Courtyard Atlanta Midtown/Georgia Tech', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(729, 'ATLNP', 'Residence Inn Atlanta Alpharetta/North Point Mall', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(730, 'ATLNR', 'Sheraton Atlanta Perimeter Nor', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(731, 'ATLPE', 'Courtyard Atlanta Perimeter Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(732, 'ATLPH', 'Courtyard Atlanta Alpharetta', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(733, 'ATLRA', 'Residence Inn Atlanta Airport North/Virginia Avenue', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(734, 'ATLRE', 'The Hotel at Avalon, Autograph Collection', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(735, 'ATLTC', 'Residence Inn Atlanta Kennesaw/Town Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(736, 'ATLTN', 'TownePlace Suites Atlanta Norcross/Peachtree Corners', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(737, 'ATLTS', 'TownePlace Suites Atlanta Northlake', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(738, 'ATLWB', 'Westin Buckhead Atlanta', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(739, 'ATLWS', 'Residence Inn Atlanta Alpharetta/Windward', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(740, 'AUART', 'The Ritz-Carlton, Aruba', '', '', '', '', 'Aruba', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(741, 'AUSAL', 'Aloft Austin at The Domain', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(742, 'AUSTL', 'Aloft Austin Northwest', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(743, 'AVLAL', 'Aloft Downtown Asheville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(744, 'AVLFP', 'FPBS Asheville Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(745, 'AZOFP', 'FPBS Kalamazoo', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(746, 'BDLHR', 'Sheraton Hartford South Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(747, 'BDLSM', 'Sheraton Springfield Monarch', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(748, 'BDLWD', 'Courtyard Hartford Windsor', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(749, 'BFLCH', 'Courtyard Bakersfield', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(750, 'BFLFP', 'FPBS Bakersfield', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(751, 'BFLSH', 'SpringHill Suites Bakersfield', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(752, 'BHMAL', 'Aloft Birmingham Soho Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(753, 'BHMHM', 'Residence Inn Birmingham Homewood', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(754, 'BHMHW', 'Courtyard Birmingham Homewood', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(755, 'BHMSC', 'Courtyard Birmingham Colonnade/Grandview', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(756, 'BLIFP', 'FPBS Bellingham Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(757, 'BNABN', 'Residence Inn Nashville Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(758, 'BNABR', 'Courtyard Nashville Brentwood', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(759, 'BNACA', 'Courtyard Nashville Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(760, 'BNADT', 'Courtyard Nashville Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(761, 'BNAFP', 'FPBS Nashville - Brentwood', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(762, 'BNAGV', 'Courtyard Nashville Goodlettsville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(763, 'BNAMF', 'Residence Inn Nashville Brentwood', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(764, 'BNAND', 'Sheraton Grand Nashville Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(765, 'BNAPA', 'Four Points by Sheraton Nashville Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(766, 'BNASA', 'SpringHill Suites Nashville Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(767, 'BNASI', 'Sheraton Music City Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(768, 'BNATG', 'TownePlace Suites Nashville Goodlettsville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(769, 'BNAVB', 'Residence Inn Nashville Vanderbilt/West End', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(770, 'BNAVW', 'SpringHill Suites Nashville Vanderbilt/West End', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(771, 'BNAWH', 'TownePlace Suites Clarksville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(772, 'BNAWL', 'Aloft Nashville West End', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(773, 'BOBMD', 'Le M?ridien Bora Bora', '', '', '', '', 'French Polynesia', 1, 0, 4, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(774, 'BOBXR', 'The St. Regis Bora Bora Resort', '', '', '', '', 'French Polynesia', 1, 0, 4, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(775, 'BOSAL', 'Aloft Boston Seaport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(776, 'BOSAV', 'SpringHill Suites Boston Andover', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(777, 'BOSBM', 'Le Meridien Cambridge-MIT', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(778, 'BOSCM', 'Residence Inn Boston Cambridge', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(779, 'BOSCS', 'Sheraton Commander Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(780, 'BOSDV', 'Courtyard Boston Danvers', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(781, 'BOSEL', 'Element Boston Seaport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(782, 'BOSEX', 'Element Lexington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(783, 'BOSFB', 'Courtyard Boston Foxborough/Mansfield', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(784, 'BOSFF', 'FPBS Wakefiled Boston', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(785, 'BOSLC', 'The Liberty Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(786, 'BOSLF', 'FPBS Boston Logan Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(787, 'BOSLL', 'Courtyard Boston Lowell/Chelmsford', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(788, 'BOSML', 'Courtyard Boston Milford', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(789, 'BOSNT', 'Boston Marriott Newton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(790, 'BOSNW', 'Courtyard Boston Norwood/Canton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(791, 'BOSOF', 'FPBS Norwood', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(792, 'BOSST', 'Courtyard Boston Stoughton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(793, 'BOSTD', 'TownePlace Suites Boston North Shore/Danvers', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(794, 'BOSWB', 'Courtyard Boston Woburn/Burlington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(795, 'BOSWE', 'Residence Inn Boston Westborough', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(796, 'BOSWW', 'Westin Waltham Boston', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(797, 'BOSXL', 'Aloft Lexington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(798, 'BTRAK', 'WATERMARK Baton Rouge', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(799, 'BTRBB', 'Renaissance Baton Rouge Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(800, 'BTRCH', 'Courtyard Baton Rouge Acadian Centre/LSU Area', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(801, 'BUFAL', 'Aloft Airport Buffalo', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(802, 'BUFTX', 'Reikart House', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(803, 'BUFWI', 'The Westin Buffalo', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(804, 'BURAH', 'Sheraton Agoura Hills Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(805, 'BURRI', 'Residence Inn Los Angeles Burbank/Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(806, 'BURSH', 'SpringHill Suites Los Angeles Burbank/Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(807, 'BVUCH', 'Courtyard Seattle Bellevue/Redmond', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(808, 'BVUSI', 'Sheraton Bellevue Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(809, 'BWIAN', 'Courtyard Annapolis', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(810, 'BWICA', 'Courtyard Baltimore BWI Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(811, 'BWICB', 'Residence Inn Columbia', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(812, 'BWICL', 'Courtyard Columbia', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(813, 'BWIEM', 'Element Arundel Mills', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(814, 'BWIFM', 'Courtyard Fort Meade BWI Business District', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(815, 'BWIHU', 'Courtyard Baltimore Hunt Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(816, 'BWIMA', 'Aloft Arundel Mills', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(817, 'BWIRA', 'Residence Inn Annapolis', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(818, 'BWIRI', 'Residence Inn Baltimore BWI Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(819, 'BWIWA', 'The Westin Annapolis', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(820, 'BWRAR', 'Residence Inn Pasadena Arcadia', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(821, 'BZNEL', 'Element Bozeman', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(822, 'CAEAL', 'Aloft Columbia Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(823, 'CAKSI', 'Sheraton Suites Akron Cuyahoga', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(824, 'CHACH', 'Courtyard Chattanooga at Hamilton Place', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(825, 'CHIAC', 'AC Hotel Chicago Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(826, 'CHIAL', 'Aloft Chicago O\'Hare', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(827, 'CHIAN', 'Courtyard Chicago Arlington Heights/North', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(828, 'CHIBF', 'FPBS Buffalo Grove', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(829, 'CHICA', 'Courtyard Chicago O\'Hare', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(830, 'CHIDG', 'Chicago Marriott Suites Downers Grove', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(831, 'CHIDN', 'Courtyard Chicago Elgin/West Dundee', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(832, 'CHIES', 'Sheraton Suites Elk Grove', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(833, 'CHIFP', 'FPBS Chicago O\'Hare Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(834, 'CHIHP', 'Courtyard Chicago Highland Park/Northbrook', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(835, 'CHILS', 'Courtyard Chicago Lincolnshire', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(836, 'CHIMB', 'LM Chicago - Oakbrook Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(837, 'CHINP', 'Courtyard Chicago Naperville', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(838, 'CHIOL', 'Aloft Bolingbrook', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(839, 'CHIOS', 'Sheraton Chicago Northbrook', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(840, 'CHIOT', 'Courtyard Chicago Oakbrook Terrace', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(841, 'CHIRD', 'Residence Inn Chicago Downtown/Magnificent Mile', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(842, 'CHIRW', 'Residence Inn Chicago Waukegan/Gurnee', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(843, 'CHISH', 'SpringHill Suites Chicago Lincolnshire', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(844, 'CHITL', 'TownePlace Suites Chicago Lombard', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(845, 'CHITR', 'Tremont Chicago Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(846, 'CHITS', 'TownePlace Suites Chicago Elgin/West Dundee', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(847, 'CHIWK', 'Courtyard Chicago Waukegan/Gurnee', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(848, 'CHOCH', 'Courtyard Charlottesville North', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(849, 'CHORI', 'Residence Inn Charlottesville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(850, 'CHOWR', 'Residence Inn Charlottesville Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(851, 'CHSCN', 'Courtyard North Charleston Airport/Coliseum', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(852, 'CIDMC', 'Cedar Rapids Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(853, 'CLEAA', 'Aloft Cleveland Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(854, 'CLEAL', 'Aloft Cleveland Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(855, 'CLEAP', 'Cleveland Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(856, 'CLEAS', 'Sheraton Cleveland Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(857, 'CLEBE', 'Aloft Beachwood', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(858, 'CLECI', 'Courtyard Cleveland Independence', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(859, 'CLEFP', 'FPBS Cleveland Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(860, 'CLENO', 'Courtyard Cleveland Airport North', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(861, 'CLLAL', 'Aloft College Station', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(862, 'CLLFP', 'FPBS College Station', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(863, 'CLTAL', 'Aloft Charlotte Ballantyne', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(864, 'CLTAW', 'Courtyard Charlotte Arrowood', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(865, 'CLTBR', 'Renaissance Charlotte Suites Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(866, 'CLTEX', 'Courtyard Charlotte SouthPark', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(867, 'CLTFO', 'FPBS Charlotte - Lake Norman', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(868, 'CLTFP', 'FPBS Charlotte', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(869, 'CLTRZ', 'The Ritz-Carlton, Charlotte', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(870, 'CLTSC', 'Sheraton Charlotte Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(871, 'CLTSH', 'SpringHill Suites Charlotte University Research Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(872, 'CLTUL', 'Aloft Charlotte Uptown EpiCentre', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(873, 'CLTUN', 'Courtyard Charlotte University Research Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(874, 'CMHAW', 'Aloft Westerville', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(875, 'CMHCW', 'Courtyard Columbus Worthington', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(876, 'CMHDB', 'Courtyard Columbus Dublin', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(877, 'CMHDM', 'LM Columbus', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(878, 'CMHRD', 'Residence Inn Columbus Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(879, 'COSMC', 'Colorado Springs Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(880, 'CRPAL', 'Aloft Corpus Christi', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(881, 'CRWCY', 'Courtyard Charleston Downtown/Civic Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(882, 'CRWFP', 'FPBS Charleston', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(883, 'CRWRI', 'Residence Inn Charleston', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(884, 'CSGCH', 'Courtyard Columbus', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(885, 'CSMNB', 'Residence Inn Costa Mesa Newport Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(886, 'CVGBA', 'Courtyard Cincinnati Blue Ash', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(887, 'CVGCF', 'FFPBS Cincinnati North', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(888, 'CVGCY', 'Courtyard Cincinnati Covington', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(889, 'CVGHA', 'Courtyard Hamilton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(890, 'CVGKG', 'Kingsgate Marriott Conference Center at the University of Cincinnati', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(891, 'CVGPL', 'Aloft Newport on the Levee', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(892, 'CYMFP', 'FPBS Eastham Cape Code', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(893, 'DABCY', 'Courtyard Daytona Beach Speedway/Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(894, 'DABRI', 'Residence Inn Daytona Beach Speedway/Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(895, 'DALAL', 'Courtyard Dallas Arlington/Entertainment District', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(896, 'DALCC', 'Courtyard Dallas Central Expressway', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(897, 'DALCE', 'Residence Inn Dallas Central Expressway', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(898, 'DALDL', 'Aloft Dallas Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(899, 'DALEL', 'Element Dallas Love Field', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(900, 'DALKS', 'Sheraton McKinney Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(901, 'DALLA', 'Courtyard Dallas Las Colinas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(902, 'DALLF', 'Aloft Frisco', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(903, 'DALLO', 'Aloft Dallas Love Field', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(904, 'DALLP', 'Courtyard Dallas Plano in Legacy Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(905, 'DALLR', 'Aloft Richardson', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(906, 'DALLS', 'Residence Inn Dallas Las Colinas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(907, 'DALMK', 'Residence Inn Dallas Market Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(908, 'DALML', 'Le M?ridien Dallas, The Stoneleigh', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(909, 'DALNE', 'Courtyard Dallas Richardson at Spring Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(910, 'DALNL', 'Aloft Plano', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(911, 'DALPL', 'Residence Inn Dallas Plano/Legacy', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(912, 'DALPN', 'Courtyard Dallas Plano Parkway at Preston Road', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(913, 'DALRH', 'Residence Inn Dallas Richardson', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(914, 'DALRS', 'Courtyard Dallas Richardson at Campbell', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(915, 'DALSH', 'SpringHill Suites Dallas Addison/Quorum Drive', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(916, 'DALSI', 'Sheraton Suites Market Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(917, 'DENAL', 'Aloft Broomfield Denver', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(918, 'DENAP', 'Courtyard Denver Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(919, 'DENBD', 'Courtyard Boulder', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(920, 'DENCA', 'Courtyard Denver Stapleton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(921, 'DENDW', 'Aloft Denver Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(922, 'DENIA', 'Aloft Denver Intl Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(923, 'DENMG', 'Magnolia Hotel Denver', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(924, 'DENSE', 'Courtyard Denver Tech Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(925, 'DENSI', 'Sheraton Denver Tech Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(926, 'DENSW', 'Sheraton Denver West Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(927, 'DENTC', 'Denver Marriott Tech Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(928, 'DETLV', 'Courtyard Detroit Livonia', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(929, 'DFWAD', 'Aloft Fort Worth Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(930, 'DFWAI', 'Aloft Las Colinas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(931, 'DFWCH', 'Courtyard Fort Worth University Drive', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(932, 'DFWEL', 'Element Dallas Fort Worth Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(933, 'DFWFC', 'Courtyard Fort Worth Fossil Creek', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(934, 'DFWFP', 'FPBS Dallas Fort Worth Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(935, 'DFWMS', 'Courtyard Fort Worth Downtown/Blackstone', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(936, 'DFWRI', 'Residence Inn Fort Worth Fossil Creek', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(937, 'DFWUV', 'SpringHill Suites Fort Worth University', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(938, 'DLHSI', 'Sheraton Duluth Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(939, 'DSMCH', 'Courtyard Des Moines West/Clive', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(940, 'DSMEL', 'Element West Des Moines', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(941, 'DTTDB', 'Courtyard Detroit Dearborn', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(942, 'DTTTR', 'Courtyard Detroit Troy', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(943, 'DTTWR', 'Courtyard Detroit Warren', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(944, 'DTWAB', 'Courtyard Detroit Auburn Hills', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(945, 'DTWAL', 'Aloft Detroit at David Whitney', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(946, 'DTWCA', 'Courtyard Detroit Metro Airport Romulus', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(947, 'DTWDC', 'Courtyard Detroit Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(948, 'DTWDI', 'The Dearborn Inn', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(949, 'DTWFN', 'FPBS Detroit Novi', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(950, 'DTWFP', 'FPBS Detroit Metro Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(951, 'DTWMS', 'Sheraton Detroit-Metro Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(952, 'DTWNV', 'Courtyard Detroit Novi', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(953, 'DTWOS', 'Sheraton Detroit Novi Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(954, 'DTWRI', 'Residence Inn Detroit Warren', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(955, 'DTWTS', 'TownePlace Suites Detroit Novi', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(956, 'DXRSH', 'SpringHill Suites Danbury', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(957, 'ELPAL', 'Aloft El Paso Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(958, 'EWRCA', 'Courtyard Newark Liberty International Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(959, 'EWRCP', 'Courtyard Paramus', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(960, 'EWRDT', 'Courtyard Newark Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(961, 'EWREB', 'Residence Inn Newark Elizabeth/Liberty International Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(962, 'EWREL', 'Element Harrison - Newark', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(963, 'EWREZ', 'Courtyard Newark Elizabeth', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(964, 'EWRHO', 'Hanover Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(965, 'EWRMW', 'Courtyard Mahwah', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(966, 'EWRNB', 'Fairfield Inn & Suites North Bergen', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(967, 'EWRNJ', 'Courtyard Hanover Whippany', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(968, 'EWRNW', 'Courtyard Jersey City Newport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(969, 'EWRPR', 'Park Ridge Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(970, 'EWRPS', 'Courtyard Parsippany', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(971, 'EWRPY', 'Residence Inn Parsippany', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(972, 'EWRRB', 'Courtyard Lincroft Red Bank', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(973, 'EWRRS', 'Sheraton Edison Raritan Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(974, 'EWRSE', 'Courtyard Secaucus Meadowlands', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(975, 'EWRTC', 'Courtyard Tinton Falls Eatontown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(976, 'EWRWS', 'Sheraton Mahwah Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(977, 'FATCH', 'Courtyard Fresno', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(978, 'FATRI', 'Residence Inn Fresno', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(979, 'FAYCH', 'Courtyard Fayetteville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(980, 'FHKNY', 'Courtyard Fishkill', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(981, 'FLLCC', 'Fort Lauderdale Marriott North', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(982, 'FLLFC', 'Four Points by Sheraton Fort Lauderdale Airport/Cruise Port', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(983, 'FLLFP', 'FPBS Coral Gables', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(984, 'FLLPL', 'Courtyard Fort Lauderdale Plantation', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(985, 'FLLSI', 'Sheraton Suites Plantation', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(986, 'FLLWC', 'Courtyard Fort Lauderdale Weston', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(987, 'FLLWI', 'The Westin Fort Lauderdale', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(988, 'FSDSI', 'Sheraton Sioux Falls & Convent', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(989, 'FYVEL', 'Element Bentonville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(990, 'GEGAL', 'The Davenport Lusso, Autograph Collection', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(991, 'GEGAT', 'The Davenport Tower, Autograph Collection', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(992, 'GEGCH', 'Courtyard Spokane Downtown at the Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(993, 'GLSFP', 'Four Points by Sheraton Galveston', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(994, 'GRBAL', 'Aloft Green Bay', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(995, 'GSOWN', 'Courtyard Greensboro', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(996, 'GSPAL', 'Aloft Greenville Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(997, 'GSPCH', 'Courtyard Greenville Haywood Mall', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(998, 'HARFP', 'Four Points by Sheraton York', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(999, 'HNMMK', 'Courtyard Maui Kahului Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1000, 'HOUCC', 'FPBS Houston-City Centre', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1001, 'HOUCP', 'Courtyard Houston Pearland', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1002, 'HOUDW', 'Aloft Houston Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1003, 'HOUEG', 'Houston Marriott Energy Corridor', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1004, 'HOUEK', 'Element Katy', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1005, 'HOUEL', 'Element Houston Vintage Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1006, 'HOUFP', 'FPBS Houston Energy Corridor', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1007, 'HOUGF', 'FPBS Houston Greenway Plaza', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1008, 'HOUHB', 'Courtyard Houston Hobby Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1009, 'HOUHH', 'Houston Marriott South at Hobby Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1010, 'HOUMG', 'Magnolia Hotel Houston', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1011, 'HOUNW', 'Courtyard Houston Northwest', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1012, 'HOUWH', 'Sheraton Houston West Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1013, 'HPNGR', 'Courtyard Tarrytown Greenburgh', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1014, 'HPNNW', 'Courtyard Norwalk', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1015, 'HPNRY', 'Courtyard Rye', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1016, 'HPNSI', 'Sheraton Tarrytown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1017, 'HSVEL', 'Element Huntsville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1018, 'HSVWI', 'The Westin Huntsville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1019, 'HVNFP', 'FPBS Meriden', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1020, 'HVNWA', 'Courtyard New Haven Wallingford', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1021, 'IADAL', 'Aloft Dulles Airport North', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1022, 'IADCA', 'Courtyard Dulles Airport Chantilly', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1023, 'IADCY', 'Courtyard Dunn Loring Fairfax', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1024, 'IADDS', 'Washington Dulles Marriott Suites', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1025, 'IADFL', 'Residence Inn Fair Lakes Fairfax', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1026, 'IADFO', 'Courtyard Fairfax Fair Oaks', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1027, 'IADFX', 'Residence Inn Chantilly Dulles South', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1028, 'IADHC', 'Courtyard Herndon Reston', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1029, 'IADRF', 'Residence Inn Fairfax City', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1030, 'IADRI', 'Residence Inn Dulles Airport at Dulles 28 Centre', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1031, 'IADSH', 'SpringHill Suites Herndon Reston', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1032, 'IADTC', 'Courtyard Dulles Town Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1033, 'IADTS', 'TownePlace Suites Chantilly Dulles South', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1034, 'IADWI', 'Westin Washington Dulles Airp', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1035, 'IADXM', 'Residence Inn Fairfax Merrifield', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1036, 'IAGAF', 'Sheraton At The Falls Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1037, 'IAGFP', 'FPBS St. Catharines Niagara', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1038, 'IAHFP', 'FPBS Houston Intercontinental', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1039, 'ILGCY', 'Courtyard Wilmington Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1040, 'ILGFP', 'Four Points by Sheraton Newark', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1041, 'ILGSW', 'Sheraton Wilmington South Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1042, 'ILGWC', 'Courtyard Wilmington Newark/Christiana Mall', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1043, 'INDCA', 'Courtyard Indianapolis Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1044, 'INDCM', 'Courtyard Indianapolis Carmel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1045, 'INDCS', 'Courtyard Indianapolis Castleton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1046, 'INDMD', 'Le Meridien Indianapolis', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1047, 'ISPRI', 'Residence Inn Long Island Hauppauge/Islandia', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1048, 'ISPVA', ' Aloft Long Island City', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1049, 'JANWI', 'The Westin Jackson', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1050, 'JAXBF', 'FPBS Jacksonville Beachfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1051, 'JAXMC', 'Courtyard Jacksonville Mayo Clinic/Beaches', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1052, 'JAXSI', 'Sheraton Jacksonville Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1053, 'JAXTL', 'Aloft Jacksonville Tapestry', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1054, 'JNUFP', 'Four Points by Sheraton Juneau', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1055, 'LAFFP', 'FPBS West Lafayette', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1056, 'LAJCA', 'Residence Inn San Diego La Jolla', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1057, 'LASCH', 'Courtyard Las Vegas Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1058, 'LASEL', 'Element Las Vegas Summerlin', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1059, 'LASHH', 'Residence Inn Las Vegas Hughes Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1060, 'LASNV', 'Residence Inn Las Vegas Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1061, 'LASNW', 'Courtyard Las Vegas Summerlin', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1062, 'LAXBH', 'Residence Inn Long Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1063, 'LAXCA', 'Courtyard Los Angeles LAX/El Segundo', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1064, 'LAXCH', 'Courtyard Irvine John Wayne Airport/Orange County', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1065, 'LAXCT', 'Courtyard Los Angeles Torrance/South Bay', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1066, 'LAXFL', 'Fullerton Marriott at California State University', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1067, 'LAXHH', 'Courtyard Los Angeles Hacienda Heights/Orange County', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1068, 'LAXHT', 'TownePlace Suites Los Angeles LAX/Manhattan Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1069, 'LAXHW', 'SpringHill Suites Los Angeles LAX/Manhattan Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1070, 'LAXLA', 'Aloft El Segundo - Los Angeles', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1071, 'LAXLZ', 'The Ritz-Carlton, Los Angeles', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1072, 'LAXSP', 'Sheraton Pasadena Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1073, 'LAXTC', 'Residence Inn Los Angeles Torrance/Redondo Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1074, 'LAXTO', 'Courtyard Los Angeles Torrance/Palos Verdes', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1075, 'LAXWF', 'Four Points by Sheraton Los Angeles Westside', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1076, 'LEBEL', 'Element Hanover - Lebanon', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1077, 'LEXFP', 'FPBS Lexington', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1078, 'LGAAL', 'Aloft New York LaGuardia Airpt', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1079, 'LGBRI', 'Residence Inn Long Beach Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1080, 'LGBSI', 'Sheraton Cerritos Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1081, 'LITFP', 'FPBS Little Rock Midtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1082, 'MAFFP', 'FPBS Midland', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1083, 'MBSFP', 'FPBS Saginaw', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1084, 'MCIAL', 'Aloft Leawood-Overland Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1085, 'MCICA', 'Courtyard Kansas City Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1086, 'MCICV', 'Courtyard Kansas City Overland Park/Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1087, 'MCIHM', 'Courtyard Kansas City South', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1088, 'MCIOV', 'Courtyard Kansas City Overland Park/Metcalf', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1089, 'MCNGA', 'Courtyard Macon', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1090, 'MCOBS', 'Sheraton Lake Buena Vista', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1091, 'MCOCH', 'Courtyard Orlando Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1092, 'MCODL', 'Aloft Orlando Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1093, 'MCOFP', 'FPBS Orlando Studio City', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1094, 'MCOFW', 'Fairfield Inn & Suites Orlando at SeaWorld®', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1095, 'MCOLS', 'Sheraton Vistana Villages Resort Villas', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1096, 'MCOOI', 'Courtyard Orlando International Drive/Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1097, 'MCOON', 'Sheraton Orlando North Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1098, 'MCOOR', 'Sheraton Suites Orlando Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1099, 'MCOSS', 'SpringHill Suites Orlando at SeaWorld®', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1100, 'MCOVS', 'Sheraton Vistana Resort Villas', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1101, 'MCOWL', 'Westin Lake Mary Orlando North', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1102, 'MCOYC', 'Courtyard Orlando South/John Young Parkway', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1103, 'MEMCA', 'Courtyard Memphis Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1104, 'MEMEF', 'FPBS Memphis East', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1105, 'MEMPA', 'Courtyard Memphis East/Park Avenue', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1106, 'MEMWI', 'Westin Memphis Beale Street', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1107, 'MHTCH', 'Courtyard Boston Andover', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1108, 'MIAAL', 'Aloft Miami Doral', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1109, 'MIABA', 'Aloft Miami - Brickell', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1110, 'MIACA', 'Courtyard Miami Airport West/Doral', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1111, 'MIACL', 'Aloft Coral Gables', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1112, 'MIAEM', 'Element Miami Doral', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1113, 'MIAES', 'Sheraton Miami Airport Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1114, 'MIAFP', 'FPBS Miami Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1115, 'MIAMD', 'Aloft Miami Dadeland', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1116, 'MIAML', 'Courtyard Miami Lakes', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1117, 'MIARZ', 'The Ritz-Carlton Coconut Grove', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1118, 'MKEAL', 'Aloft Milwaukee Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1119, 'MKEBC', 'Courtyard Milwaukee Brookfield', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1120, 'MKEDT', 'Courtyard Milwaukee Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1121, 'MKEFA', 'Four Points by Sheraton Milwaukee Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1122, 'MKEFP', 'FPBS Milwaukee North Shore', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1123, 'MKESI', 'Sheraton Milwaukee Brookfield', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1124, 'MLBAP', 'Residence Inn Melbourne', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1125, 'MLBCF', 'FPBS Cocoa Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1126, 'MLBCH', 'Courtyard Melbourne West', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1127, 'MLICH', 'Courtyard Bettendorf Quad Cities', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1128, 'MLIEL', 'Element Moline', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1129, 'MSNAC', 'AC Hotel Madison Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1130, 'MSNCW', 'Courtyard Madison West/Middleton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1131, 'MSNCY', 'Courtyard Madison East', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1132, 'MSNME', 'Fairfield Inn &amp; Suites Madison East', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1133, 'MSNMW', 'Fairfield Inn &amp; Suites Madison West/Middleton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1134, 'MSNWE', 'Madison Marriott West', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1135, 'MSNWM', 'Residence Inn Madison West/Middleton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1136, 'MSPAL', 'Aloft Minneapolis', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1137, 'MSPDC', 'Courtyard Minneapolis Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1138, 'MSPED', 'Courtyard Minneapolis Eden Prairie', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1139, 'MSPMF', 'FPBS Mall of America', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1140, 'MSPMH', 'Courtyard Minneapolis-St. Paul Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1141, 'MSPMT', 'Sheraton Minneapolis Midtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1142, 'MSYAL', 'Aloft New Orleans Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1143, 'MSYCM', 'Courtyard New Orleans Metairie', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1144, 'MSYCN', 'Courtyard New Orleans Downtown/Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1145, 'MSYCV', 'Courtyard New Orleans Covington/Mandeville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1146, 'MSYCY', 'Courtyard New Orleans Downtown Near the French Quarter', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1147, 'MSYMS', 'Sheraton Metairie-New Orleans', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1148, 'MSYNS', 'Residence Inn New Orleans Covington/North Shore', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1149, 'MSYRI', 'Residence Inn New Orleans Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1150, 'MSYRM', 'Residence Inn New Orleans Metairie', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1151, 'MSYSH', 'SpringHill Suites New Orleans Downtown/Convention Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1152, 'MYRCY', 'Courtyard Myrtle Beach Broadway', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1153, 'NYCAL', 'Aloft Manhattan Downtown - Financial District', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1154, 'NYCFI', 'Fairfield Inn & Suites New York Manhattan/Times Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1155, 'NYCJK', 'Sheraton JFK Airport Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1156, 'NYCLH', 'Aloft Harlem', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1157, 'NYCLM', 'Fairfield Inn New York Manhattan/Financial District', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1158, 'NYCLX', 'The Lexington New York City, Autograph Collection', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1159, 'NYCMF', 'FPBS Manhattan Midtown West', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1160, 'NYCPF', 'FPBS Plainview Long Island', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1161, 'NYCTF', 'FPBS Midtown - Times Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1162, 'NYCTM', 'Fairfield Inn &amp; Suites New York Manhattan/Fifth Avenue', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1163, 'NYCTW', 'Fairfield Inn & Suites New York Manhattan/Chelsea', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1164, 'NYCXM', 'Courtyard New York Downtown Manhattan/World Trade Center Area', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1165, 'OAKCP', 'Courtyard Pleasant Hill', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1166, 'OAKCY', 'Courtyard Richmond Berkeley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1167, 'OAKFP', 'FPBS Pleasanton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1168, 'OAKMV', 'Courtyard Oakland Emeryville', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1169, 'OAKPH', 'Residence Inn Pleasant Hill Concord', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1170, 'OAKPL', 'Courtyard Pleasanton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1171, 'OAKRM', 'Courtyard San Ramon', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1172, 'OAKRS', 'Residence Inn San Ramon', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1173, 'OAKSI', 'Sheraton Pleasanton Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1174, 'OKCAL', 'Aloft Oklahoma City Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1175, 'OKCBW', 'Renaissance Waterford Oklahoma City Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1176, 'OKCMS', 'Sheraton Midwest City Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1177, 'OKCNW', 'Courtyard Oklahoma City Northwest', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1178, 'OMACY', 'Courtyard Omaha Downtown/Old Market Area', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1179, 'OMAEL', 'Element Omaha Midtown Crossing', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1180, 'ONTAL', 'Aloft Ontario-Rancho Cucamonga', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1181, 'ONTOA', 'Sheraton Ontario Airport Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1182, 'ONTSI', 'Sheraton Suites Fairplex', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1183, 'ORFAL', 'Aloft Chesapeake', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1184, 'ORFCD', 'Delta Hotels Chesapeake', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1185, 'ORFFP', 'FPBS Virginia Beach Oceanfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1186, 'ORFTS', 'TownePlace Suites Virginia Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1187, 'ORFVA', 'Fairfield Inn & Suites Virginia Beach Oceanfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1188, 'ORFVB', 'Courtyard Virginia Beach Norfolk', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1189, 'ORFVO', 'SpringHill Suites Virginia Beach Oceanfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1190, 'ORFWI', 'The Westin Virginia Beach Town', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1191, 'OXRCH', 'Courtyard Camarillo', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1192, 'OXRCR', 'Residence Inn Camarillo', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1193, 'OXRFP', 'FPBS Ventura Harbor Resort', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1194, 'OXRRI', 'Residence Inn Oxnard River Ridge', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1195, 'PBIBC', 'Courtyard Boca Raton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1196, 'PBIBR', 'Boca Raton Marriott at Boca Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1197, 'PBICH', 'Courtyard West Palm Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1198, 'PBIJA', 'Courtyard Palm Beach Jupiter', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1199, 'PBIRD', 'Residence Inn West Palm Beach Downtown/CityPlace Area', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1200, 'PBIRH', 'Renaissance Boca Raton Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1201, 'PDXAH', 'Aloft Hillsboro-Beaverton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1202, 'PDXAL', 'Aloft Portland Arpt at Cascade', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1203, 'PDXCY', 'Courtyard Portland Beaverton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1204, 'PDXFP', 'FPBS Portland East', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1205, 'PDXPD', 'Residence Inn Portland Downtown/Pearl District', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1206, 'PDXSI', 'Sheraton Portland Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1207, 'PHFCH', 'Courtyard Hampton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1208, 'PHFTS', 'TownePlace Suites Newport News Yorktown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1209, 'PHFWB', 'Courtyard Williamsburg Busch Gardens Area', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1210, 'PHLAD', 'Aloft Philadelphia Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1211, 'PHLAI', 'Aloft Philadelphia Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1212, 'PHLAL', 'Aloft Mount Laurel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1213, 'PHLAT', 'Courtyard Philadelphia Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1214, 'PHLBW', 'Residence Inn Philadelphia Valley Forge', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1215, 'PHLCP', 'FPBS Philadelphia City Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1216, 'PHLCY', 'Courtyard Philadelphia Plymouth Meeting', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1217, 'PHLDV', 'Courtyard Philadelphia Devon', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1218, 'PHLFO', 'Sheraton Valley Forge Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1219, 'PHLFP', 'FPBS Philadelphia Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1220, 'PHLLD', 'Courtyard Philadelphia Lansdale', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1221, 'PHLML', 'Courtyard Mt. Laurel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1222, 'PHLPF', 'FPBS Philadelphia Northeast', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1223, 'PHLPY', 'SpringHill Suites Philadelphia Plymouth Meeting', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1224, 'PHLRI', 'Residence Inn Philadelphia Center City', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1225, 'PHLRW', 'Residence Inn Philadelphia Willow Grove', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1226, 'PHLSA', 'Sheraton Suites Philly Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1227, 'PHLVA', 'Courtyard Philadelphia Valley Forge/King of Prussia', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1228, 'PHLWG', 'Courtyard Philadelphia Willow Grove', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1229, 'PHLWI', 'The Westin Philadelphia', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1230, 'PHLWL', 'SpringHill Suites Philadelphia Willow Grove', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1231, 'PHXAL', 'Aloft Tempe', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1232, 'PHXCA', 'Courtyard Phoenix Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1233, 'PHXCC', 'Courtyard Phoenix Camelback', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1234, 'PHXCL', 'Courtyard Phoenix Chandler', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1235, 'PHXEL', 'Element Chandler Fashion Ctr', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1236, 'PHXFP', 'FPBS Phoenix North', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1237, 'PHXMA', 'FPBS Phoenix Mesa Gateway Arpt', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1238, 'PHXMC', 'Courtyard Phoenix North', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1239, 'PHXME', 'Courtyard Phoenix Mesa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1240, 'PHXMH', 'Residence Inn Phoenix Desert View at Mayo Clinic', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1241, 'PHXMY', 'Courtyard Scottsdale at Mayo Clinic', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1242, 'PHXPI', 'Courtyard Scottsdale Salt River', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1243, 'PHXRS', 'Residence Inn Scottsdale Paradise Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1244, 'PHXRT', 'Residence Inn Tempe', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1245, 'PHXSC', 'Courtyard Scottsdale Old Town', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1246, 'PHXSD', 'Aloft Scottsdale', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1247, 'PHXSF', 'FPBS Phoenix South Mountain', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1248, 'PHXSI', 'Sheraton Crescent Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1249, 'PHXTA', 'Sheraton Phoenix Airport Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1250, 'PHXTD', 'Residence Inn Tempe Downtown/University', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1251, 'PHXTE', 'Courtyard Tempe Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1252, 'PHXTO', 'TownePlace Suites Scottsdale', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1253, 'PHXXL', 'Aloft Phoenix-Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1254, 'PIAFP', 'Four Points by Sheraton Peoria', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1255, 'PITCA', 'Courtyard Pittsburgh Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1256, 'POUCH', 'Courtyard Poughkeepsie', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1257, 'POURI', 'Residence Inn Poughkeepsie', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1258, 'PPTMD', 'Le M?ridien Tahiti', '', '', '', '', 'French Polynesia', 1, 0, 4, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1259, 'PSPCH', 'Courtyard Palm Springs', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1260, 'PVDBR', 'Renaissance Providence Downtown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1261, 'PVDMD', 'Courtyard Newport Middletown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1262, 'PVDSI', 'Sheraton Providence Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1263, 'PWMWI', 'Westin Portland Harborview', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1264, 'RDDSI', 'Sheraton Redding Hotel Sundial', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1265, 'RDUAP', 'Residence Inn Raleigh-Durham Airport/Morrisville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1266, 'RDUCA', 'Courtyard Raleigh Cary', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1267, 'RDUCL', 'Aloft Chapel Hill', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1268, 'RDUDD', 'Residence Inn Durham McPherson/Duke University Medical Center Area', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1269, 'RDUDR', 'Residence Inn Durham Research Triangle Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1270, 'RDUFE', 'FPBS Raleigh North', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1271, 'RDULD', 'Aloft Durham Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1272, 'RDUNT', 'Courtyard Raleigh North/Triangle Town Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1273, 'RDURA', 'Aloft Raleigh', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1274, 'RDURD', 'Courtyard Raleigh-Durham Airport/Morrisville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1275, 'RDURT', 'Courtyard Durham Research Triangle Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1276, 'RDURY', 'Residence Inn Raleigh Cary', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1277, 'RDUSC', 'Sheraton Chapel Hill Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1278, 'RDUSH', 'SpringHill Suites Raleigh-Durham Airport/Research Triangle Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1279, 'RDUWF', 'Courtyard Raleigh Midtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1280, 'REHRI', 'Bethany Beach Ocean Suites Residence Inn', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1281, 'RFDRF', 'Fairfield Inn &amp; Suites Rockford', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1282, 'RICFP', 'FPBS Richmond', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1283, 'RICNW', 'Courtyard Richmond Northwest/Short Pump', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1284, 'RICPA', 'FPBS Richmond Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1285, 'RICRA', 'Fairfield Inn &amp; Suites Richmond Ashland', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1286, 'RICTS', 'TownePlace Suites Richmond', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1287, 'RICWE', 'Courtyard Richmond West', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1288, 'RNOBR', 'Renaissance Reno Downtown Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1289, 'RNORI', 'Residence Inn Reno', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1290, 'ROASI', 'Sheraton Roanoke Hotel & Conf', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1291, 'ROCAP', 'Rochester Airport Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1292, 'ROCDL', 'The Del Monte Lodge Renaissance Rochester Hotel & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1293, 'ROGAL', 'Aloft Rogers-Bentonville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1294, 'ROGFP', 'FPBS Bentonville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1295, 'SACCH', 'Courtyard Sacramento Airport Natomas', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1296, 'SACFP', 'FPBS Sacramento Int\'l Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1297, 'SACRC', 'Courtyard Sacramento Rancho Cordova', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1298, 'SACWS', 'The Westin Sacramento', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1299, 'SAFLC', 'La Posada de Santa Fe, A Tribute Portfolio Resort &amp; Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1300, 'SANAA', 'Residence Inn San Diego Sorrento Mesa/Sorrento Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1301, 'SANDL', 'Residence Inn San Diego Del Mar', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1302, 'SANFP', 'FPBS San Diego', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1303, 'SANGL', 'San Diego Marriott Gaslamp Quarter', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1304, 'SANJS', 'Sheraton La Jolla Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1305, 'SANLJ', 'San Diego Marriott La Jolla', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1306, 'SANMM', 'Courtyard San Diego Sorrento Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1307, 'SANON', 'Courtyard San Diego Oceanside', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1308, 'SANOS', 'Residence Inn San Diego Oceanside', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1309, 'SANPD', 'FPBS San Diego Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1310, 'SANRB', 'Residence Inn San Diego Rancho Bernardo/Carmel Mountain Ranch', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1311, 'SANTR', 'The Inn at Rancho Santa Fe', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1312, 'SANWS', 'The Westin San Diego', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1313, 'SANYA', 'Hotel Republic San Diego, Autograph Collection', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1314, 'SATAL', 'Aloft San Antonio Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1315, 'SATAP', 'Residence Inn San Antonio Airport/Alamo Heights', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1316, 'SATCA', 'Courtyard San Antonio Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1317, 'SATCD', 'Courtyard San Antonio Downtown/Market Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1318, 'SATCR', 'Courtyard San Antonio Riverwalk', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1319, 'SATFP', 'FPBS San Antonio Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1320, 'SATGS', 'Sheraton Gunter San Antonio', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1321, 'SATMC', 'Courtyard San Antonio Medical Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1322, 'SATRW', 'Residence Inn San Antonio Downtown/Alamo Plaza', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1323, 'SAVCH', 'Courtyard Savannah Midtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1324, 'SBACY', 'Courtyard Santa Barbara Goleta', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1325, 'SBAGO', 'Residence Inn Santa Barbara Goleta', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1326, 'SBNAL', 'Aloft South Bend', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1327, 'SBYFI', 'Fairfield Inn & Suites Ocean City', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1328, 'SCRFP', 'FPBS Scranton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1329, 'SDFCH', 'Courtyard Louisville East', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1330, 'SDFFP', 'FPBS Louisville Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1331, 'SDFLD', 'Aloft Louisville Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1332, 'SDFSI', 'Sheraton Louisville Riverside', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1333, 'SEAAD', 'Aloft Redmond', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1334, 'SEAAL', 'Aloft Seattle Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1335, 'SEACD', 'Courtyard Seattle Downtown/Lake Union', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1336, 'SEAFW', 'Courtyard Seattle Federal Way', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1337, 'SEAMB', 'Seattle Marriott Bellevue', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1338, 'SEAPS', 'Courtyard Seattle Downtown/Pioneer Square', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1339, 'SEARA', 'Residence Inn Seattle Sea-Tac Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1340, 'SEARD', 'Residence Inn Seattle East/Redmond', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1341, 'SEARE', 'Element Redmond', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1342, 'SEASC', 'Courtyard Seattle Southcenter', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1343, 'SEASF', 'FPBS Seattle Airport South', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1344, 'SEASR', 'SpringHill Suites Seattle South/Renton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1345, 'SEATR', 'TownePlace Suites Seattle South/Renton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1346, 'SFOFC', 'Courtyard San Mateo Foster City', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1347, 'SFOFP', 'FPBS SF Bay Bridge', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1348, 'SFOLA', 'Las Alcobas Nappa Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1349, 'SFOLL', 'Courtyard San Francisco Larkspur Landing/Marin County', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1350, 'SFOLO', 'Residence Inn Redwood City San Carlos', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1351, 'SFONV', 'Courtyard Novato Marin/Sonoma', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1352, 'SFONW', 'The Westin Verasa Napa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1353, 'SFOOP', 'Courtyard San Francisco Airport/Oyster Point Waterfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1354, 'SFORI', 'Residence Inn San Francisco Airport/Oyster Point Waterfront', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1355, 'SFOSB', 'Courtyard San Francisco Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1356, 'SJCAC', 'AC Hotel San Jose Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West ', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1357, 'SJCAL', 'Aloft Silicon Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1358, 'SJCCA', 'Courtyard San Jose Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1359, 'SJCCU', 'Courtyard San Jose Cupertino', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1360, 'SJCFE', 'Courtyard Fremont Silicon Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1361, 'SJCJC', 'Aloft San Jose Cupertino', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1362, 'SJCJF', 'FPBS San Jose Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1363, 'SJCMP', 'Courtyard Milpitas Silicon Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1364, 'SJCSA', 'Sheraton San Jose Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1365, 'SJCSL', 'Aloft Santa Clara', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1366, 'SJCTM', 'TownePlace Suites Milpitas Silicon Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1367, 'SJCUP', 'Aloft Cupertino', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1368, 'SJCVL', 'Aloft Sunnyvale', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1369, 'SJCVS', 'Sheraton Sunnyvale Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1370, 'SJCWI', 'Westin San Jose', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1371, 'SJCWP', 'The Westin Palo Alto', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1372, 'SJUDO', 'Dorado Beach, a Ritz-Carlton Reserve', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1373, 'SLCSI', 'Sheraton Salt Lake City Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1374, 'SLCTT', 'Residence Inn Salt Lake City Cottonwood', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1375, 'SNAAN', 'Sheraton Garden Grove-Anaheim', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1376, 'SNAAO', 'SpringHill Suites Anaheim Maingate', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1377, 'SNABP', 'Courtyard Anaheim Buena Park', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1378, 'SNAFC', 'Courtyard Huntington Beach Fountain Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1379, 'SNAFR', 'Courtyard Foothill Ranch Irvine East/Lake Forest', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1380, 'SNAFV', 'Residence Inn Huntington Beach Fountain Valley', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1381, 'SNAIR', 'Residence Inn Irvine Spectrum', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1382, 'SNAIV', 'Residence Inn Irvine John Wayne Airport/Orange County', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1383, 'SNALH', 'Courtyard Laguna Hills Irvine Spectrum/Orange County', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1384, 'SNAME', 'Hotel Menage', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1385, 'SNAOC', 'Residence Inn Cypress Los Alamitos', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1386, 'SNAPL', 'Residence Inn Anaheim Placentia/Fullerton', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1387, 'SNASA', 'Courtyard Costa Mesa South Coast Metro', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1388, 'SNASI', 'Courtyard Irvine Spectrum', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1389, 'SNASJ', 'Residence Inn Dana Point San Juan Capistrano', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1390, 'SNATF', 'Fairfield Inn & Suites Tustin Orange County', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1391, 'SNATU', 'Residence Inn Tustin Orange County', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1392, 'SOSFT', 'Residence Inn Somerset', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1393, 'SOSLB', 'Courtyard Lebanon', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1394, 'SOSSM', 'Courtyard Basking Ridge', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1395, 'SPACH', 'Courtyard Spartanburg', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1396, 'SRQAL', 'Aloft Sarasota', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1397, 'STFCY', 'Courtyard Stamford Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1398, 'STFSI', 'Sheraton Stamford Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1399, 'STLBR', 'Courtyard St. Louis Airport/Earth City', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1400, 'STLBW', 'SpringHill Suites St. Louis Brentwood', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1401, 'STLCC', 'Courtyard St. Louis Creve Coeur', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1402, 'STLCH', 'Courtyard St Louis Downtown West', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1403, 'STLCP', 'Sheraton Clayton Plaza Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1404, 'STLEC', 'SpringHill Suites St. Louis Airport/Earth City', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1405, 'STLSH', 'SpringHill Suites St. Louis Chesterfield', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1406, 'STLTR', 'Magnolia Hotel St. Louis', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1407, 'STLWE', 'Marriott St. Louis West', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1408, 'STLWP', 'Courtyard St. Louis Westport Plaza', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1409, 'STSSI', 'Sheraton Sonoma County - Petaluma', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1410, 'SWFFP', 'FPBS Newburgh Stewart Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1411, 'SYRAL', 'Aloft Syracuse Inner Harbor', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1412, 'SYRCA', 'Courtyard Syracuse Carrier Circle', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1413, 'SYRFE', 'Fairfield Inn & Suites Syracuse Carrier Circle', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1414, 'SYRRI', 'Residence Inn Syracuse Carrier Circle', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1415, 'SYRSH', 'SpringHill Suites Syracuse Carrier Circle', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1416, 'SYRSI', 'Sheraton Syracuse University', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1417, 'TLHAL', 'Aloft Tallahassee Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1418, 'TLHCH', 'Courtyard Tallahassee Capital', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1419, 'TLHDT', 'Residence Inn Tallahassee Universities at the Capitol', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1420, 'TLHFP', 'FPBS Tallahassee Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1421, 'TOLCR', 'Courtyard Toledo Rossford/Perrysburg', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1422, 'TOLCY', 'Courtyard Toledo Maumee/Arrowhead', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1423, 'TPAEA', 'Sheraton Tampa East Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1424, 'TPAGR', 'The Westshore Grand', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1425, 'TPAMD', 'Le Meridien Tampa', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1426, 'TPAPG', 'Courtyard St. Petersburg Clearwater', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1427, 'TPATL', 'Aloft Tampa Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1428, 'TPAWI', 'The Westin Tampa Bay', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1429, 'TPAWT', 'Courtyard Tampa Westshore/Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1430, 'TPAYR', 'Residence Inn Clearwater Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1431, 'TPAYS', 'SpringHill Suites Clearwater Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1432, 'TTNCY', 'Courtyard Princeton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1433, 'TTNEL', 'Element Ewing Princeton', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1434, 'TTNRI', 'Residence Inn Cranbury South Brunswick', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1435, 'TULAL', 'Aloft Tulsa Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1436, 'TULTL', 'Aloft Tulsa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1437, 'TUSAL', 'Aloft Tucson University', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1438, 'TUSFP', 'FPBS Tucson Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1439, 'TUSSI', 'Sheraton Tucson Hotel & Suites', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1440, 'TYSFP', 'FPBS Knoxville Cumberland', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1441, 'VBOCG', 'Residence Inn Boulder', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1442, 'VPSFP', 'FPBS Destin-Fort Walton Beach', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1443, 'WASAL', 'Courtyard Alexandria Old Town/Southwest', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1444, 'WASAR', 'Courtyard Arlington Rosslyn', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1445, 'WASBR', 'Residence Inn Bethesda Downtown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1446, 'WASCG', 'Courtyard Gaithersburg Washingtonian Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1447, 'WASCT', 'Courtyard Arlington Crystal City/Reagan National Airport', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1448, 'WASCV', 'SpringHill Suites Centreville Chantilly', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1449, 'WASCW', 'The Westin Washington, D.C. City Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1450, 'WASDC', 'Residence Inn Washington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1451, 'WASDK', 'Residence Inn Alexandria Old Town/Duke Street', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1452, 'WASGB', 'Greenbelt Marriott', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1453, 'WASGO', 'The Ritz-Carlton Georgetown', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1454, 'WASGR', 'Courtyard Greenbelt', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1455, 'WASGT', 'SpringHill Suites Gaithersburg', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1456, 'WASLD', 'Courtyard New Carrollton Landover', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1457, 'WASLV', 'Residence Inn Silver Spring', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1458, 'WASMH', 'Morrison House, Autograph Collection', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1459, 'WASNH', 'Residence Inn National Harbor Washington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1460, 'WASOW', 'The Westin Reston Heights', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1461, 'WASPS', 'Courtyard Alexandria Pentagon South', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1462, 'WASPT', 'Residence Inn Arlington Pentagon City', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1463, 'WASRL', 'Le M?ridien Arlington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1464, 'WASRV', 'Courtyard Rockville', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1465, 'WASRY', 'Residence Inn Arlington Capital View', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1466, 'WASSB', 'Bethesda Marriott Suites', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1467, 'WASSR', 'Sheraton Reston Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1468, 'WASSS', 'Courtyard Silver Spring North/White Oak', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1469, 'WASTS', 'TownePlace Suites Falls Church', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1470, 'WASVA', 'SpringHill Suites Alexandria Old Town/Southwest', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1471, 'WASWA', 'AC Hotel National Harbor Washington', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1472, 'WASWG', 'Gaithersburg Marriott Washingtonian Center', '', '', '', '', 'United states', 1, 0, 4, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1473, 'WHRBW', 'Westin Riverfront Beaver Creek', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1474, 'WJFEL', 'Element Palmdale', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1475, 'YAMDS', 'Delta Hotels Sault Ste. Marie Waterfront', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1476, 'YEGEF', 'FPBS Edmonton Gateway', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1477, 'YEGWF', 'FPBS Sherwood Park', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1478, 'YGKFP', 'FPBS Kingston', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1479, 'YHMFP', 'Four Points by Sheraton Hamilton - Stoney Creek', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1480, 'YHZDB', 'Delta Hotels Barrington', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1481, 'YHZFP', ' ', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1482, 'YHZHF', 'Delta Hotels Halifax', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1483, 'YHZWI', 'The Westin Nova Scotian', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1484, 'YKAFI', 'Fairfield Inn &amp; Suites Kamloops', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1485, 'YKFDW', 'Delta Hotels Waterloo', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1486, 'YKFFP', 'FPBS Cambridge Kitchener', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1487, 'YLWFP', 'FPBS Kelowna Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1488, 'YQARI', 'Residence Inn Gravenhurst Muskoka Wharf', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1489, 'YQBEP', 'FPBS Edmundston', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1490, 'YQBFP', 'FPBS Quebec Resort', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1491, 'YQBLF', 'FPBS Levis Convention Centre', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1492, 'YQFSI', 'Sheraton Red Deer Hotel', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1493, 'YQMDR', 'Delta Hotels Beausejour', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1494, 'YQMFP', 'FPBS Moncton', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1495, 'YQRAK', 'The Hotel Saskatchewan', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1496, 'YQUFP', 'FPBS Grande Prairie', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1497, 'YRQDR', 'Delta Hotels Trois Rivieres Conference Centre', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1498, 'YSCDR', 'Delta Hotels Sherbrooke Conference Centre', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1499, 'YSEWV', 'Delta Hotels Whistler Village Suites', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1500, 'YULAL', 'Aloft Montreal Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1501, 'YULMV', 'Le Meridien Versailles', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1502, 'YULRI', 'Residence Inn Montreal Downtown', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1503, 'YVRDB', 'Delta Hotels Burnaby Conference Centre', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1504, 'YVREL', 'Element Vancouver Metrotown', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1505, 'YVRFP', 'FPBS Vancouver Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1506, 'YVRWC', 'Westin Wall Centre', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1507, 'YWGFP', 'FPBS Winnipeg Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1508, 'YWGWF', 'FPBS Winnipeg South', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1509, 'YXEDB', 'Delta Hotels Bessborough', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1510, 'YXESI', 'Sheraton Cavalier Saskatoon', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1511, 'YXSPF', 'FPBS Prince George', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1512, 'YXUFP', 'FPBS Hotel & Suites London', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1513, 'YYCAP', 'Courtyard Calgary Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1514, 'YYCCA', 'Delta Hotels Calgary Airport In-Terminal', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1515, 'YYCCF', 'FPBS Calgary Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1516, 'YYCEL', 'Element Calgary Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1517, 'YYCES', 'Sheraton Suites Calgary Eau', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1518, 'YYCFI', 'Fairfield Inn & Suites Calgary Downtown', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1519, 'YYCFP', 'FPBS Calgary West', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1520, 'YYCRI', 'Residence Inn Calgary Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1521, 'YYCSC', 'Sheraton Cavalier Calgary', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1522, 'YYCUL', 'Aloft Calgary University', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1523, 'YYCWI', 'Westin Calgary', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1524, 'YYJFP', 'FPBS Victoria Gateway', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1525, 'YYJWI', 'Westin Bear Mountain Victoria', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1526, 'YYZAL', 'Aloft Vaughan Mills', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1527, 'YYZEL', 'Element Vaughan Southwest', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1528, 'YYZFP', 'FPBS Toronto Mississauga', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1529, 'YYZPA', 'FPBS Toronto Airport', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1530, 'YYZSI', 'Sheraton Parkway Toronto North', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1531, 'YYZVF', 'FPBS Mississauga - Meadowvale', '', '', '', '', 'Canada', 1, 0, 4, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1532, 'ABZCY', 'CY Aberdeen', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1533, 'ABZRI', 'RI Aberdeen', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1534, 'AMSCY', 'CY Amsterdam Airport', '', '', '', '', 'Netherlands', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1535, 'AMSOX', 'MOXY Amsterdam Houthavens', '', '', '', '', 'Netherlands', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1536, 'BEGCY', 'CY Belgrade', '', '', '', '', 'Serbia', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1537, 'BHXAC', 'AC Birmingham', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1538, 'BRUBR', 'RH Brussels', '', '', '', '', 'Belgium', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1539, 'BRUCY', 'Courtyard Brussels', '', '', '', '', 'Belgium', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1540, 'BRUDT', 'MH Brussels', '', '', '', '', 'Belgium', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1541, 'BUDCY', 'CY Budapest', '', '', '', '', 'Hungary', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1542, 'BUHRO', 'JW Bucharest', '', '', '', '', 'Romania', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1543, 'DUBAK', 'AK Powerscourt', '', '', '', '', 'Ireland', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1544, 'DUSCY', 'CY Duesseldorf Seestern', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1545, 'DUSHF', 'CY Duesseldorf Hafen', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1546, 'EDIHW', 'CY Edinburgh West', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1547, 'EDIRI', 'RI Edinburgh', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1548, 'FLRAK', 'Dubai Marriott Harbour Hotel & Suites', '', '', '', '', 'United arab emirates', 1, 0, 1, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1549, 'FRAOH', 'OX Frankfurt City East', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1550, 'FRAWB', 'CY Wiesbaden-Nordenstadt', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1551, 'GNEMC', 'MH Ghent', '', '', '', '', 'Belgium', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1552, 'GYDJW', 'JW Baku', '', '', '', '', 'Azerbaijan', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1553, 'ISTCY', 'CY Istanbul Airport', '', '', '', '', 'Turkey', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1554, 'LCVBR', 'RH Tuscany Il Ciocco Resort & Spa', '', '', '', '', 'Italy', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1555, 'LISAK', 'Fontecruz Lisboa, Autograph Collection', '', '', '', '', 'Portugal', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1556, 'LONER', 'MEA London', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1557, 'LONXE', 'Hotel Xenia, Autograph Collection', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1558, 'MILIT', 'Milan Marriott Hotel', '', '', '', '', 'Italy', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1559, 'MOWPV', 'CY Moscow Paveletskaya', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1560, 'OVBMC', 'MH Novosibirsk', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1561, 'PARAL', 'AC Paris le Bourget', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1562, 'PARSD', 'CY Paris Saint Denis', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1563, 'PRGAK', 'AK Boscolo Prague', '', '', '', '', 'Czech republic', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1564, 'PRGCY', 'CY Prague City', '', '', '', '', 'Czech republic', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1565, 'TBSCY', 'Courtyard by Marriott Tbilisi', '', '', '', '', 'Georgia', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1566, 'TBSMC', 'MH Tbilisi', '', '', '', '', 'Georgia', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1567, 'TBSOX', 'Moxy Tbilisi', '', '', '', '', 'Georgia', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1568, 'VIECY', 'CY Vienna Schoenbrunn', '', '', '', '', 'Austria', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1569, 'VIEHW', 'RH Vienna', '', '', '', '', 'Austria', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1570, 'VIEOX', 'OX Vienna', '', '', '', '', 'Austria', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1571, 'VOZMC', 'Voronezh Marriott', '', '', '', '', 'Russian federation', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1572, 'WAWCY', 'CY Warsaw Airport', '', '', '', '', 'Poland', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1573, 'AMSNT', 'MH Amsterdam', '', '', '', '', 'Netherlands', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1574, 'AMSRD', 'RH Amsterdam', '', '', '', '', 'Netherlands', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1575, 'BCNDM', 'RH Barcelona', '', '', '', '', 'Spain', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1576, 'BERMC', 'MH Berlin', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1577, 'BERMT', 'CY Berlin City Center', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1578, 'BUDAK', 'Boscolo Budapest, Autograph Collection', '', '', '', '', 'Hungary', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1579, 'BUDHU', 'MH Budapest', '', '', '', '', 'Hungary', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1580, 'CGNMC', 'MH Cologne', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1581, 'CPHAC', 'AC Bella Sky Copenhagen', '', '', '', '', 'Denmark', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1582, 'DUSRN', 'RH Duesseldorf', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1583, 'FRADT', 'MH Frankfurt', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1584, 'HAMDT', 'MH Hamburg', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1585, 'HAMRN', 'RH Hamburg', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1586, 'HDBMC', 'MH Heidelberg', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1587, 'LGWCY', 'CY London Gatwick Airport', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1588, 'LGWGS', 'Lingfield Park Marriott Hotel & Country Club', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1589, 'LHRBR', 'RH London Heathrow', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1590, 'LISPT', 'MH Lisbon', '', '', '', '', 'Portugal', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1591, 'LONAK', 'Threadneedles, Autograph Collection', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1592, 'LONCW', 'MH London West India Quay', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1593, 'LONDT', 'MH London Grosvenor Square', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1594, 'LONTW', 'MH London Twickenham', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1595, 'MANAC', 'AC Hotel Manchester Salford Quays', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1596, 'MANVA', 'MH Manchester Victoria & Albert', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1597, 'MCMCD', 'MH Cap D\'Ail', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1598, 'MILEX', 'AK Boscolo Milano', '', '', '', '', 'Italy', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1599, 'MRSBR', 'Renaissance Aix-en-Provence Hotel', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1600, 'MUCNO', 'MH Munich', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1601, 'NCEJW', 'JW Cannes', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1602, 'PARAR', 'AC Paris Porte Maillot', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1603, 'PARDT', 'MH Paris Champs-Elysees', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1604, 'PARLD', 'RH Paris La Defense', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1605, 'PARMC', 'MH Paris Charles de Gaulle Airport', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1606, 'PAROA', 'MH Paris Opera Ambassador', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1607, 'PARPR', 'RH Paris Republique', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1608, 'PARSP', 'RH Paris Le Parc Trocad?ro', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1609, 'PARST', 'MH Paris Rive Gauche', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1610, 'PARVD', 'RH Paris Vendome', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1611, 'PARXA', 'Courtyard Paris Charles de Gaulle Airport', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1612, 'PRGDT', 'MH Prague', '', '', '', '', 'Czech republic', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1613, 'ROMEX', 'Boscolo Exedra Roma, Autograph Collection', '', '', '', '', 'Italy', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1614, 'RTMMC', 'The Hague Marriott Hotel', '', '', '', '', 'Netherlands', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1615, 'STNGS', 'MH Hanbury Manor', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1616, 'STOCY', 'Courtyard Stockholm Kungsholmen', '', '', '', '', 'Sweden', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1617, 'VCEJW', 'JW Venice', '', '', '', '', 'Italy', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1618, 'VIEAT', 'MH Vienna', '', '', '', '', 'Austria', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1619, 'VIESE', 'RH Vienna Imperial Riding School', '', '', '', '', 'Austria', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1620, 'WAWPL', 'MH Warsaw', '', '', '', '', 'Poland', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1621, 'ZPZDE', 'MH Stuttgart Sindelfingen', '', '', '', '', 'Germany', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1622, 'ZRHDT', 'MH Zurich', '', '', '', '', 'Switzerland', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1623, 'DUBBR', 'RH The Shelbourne', '', '', '', '', 'Ireland', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1624, 'LONGH', 'JW London Grosvenor House', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1625, 'LONPL', 'MH London Park Lane', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1626, 'LONPR', 'RH London St. Pancras', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1627, 'PARWG', 'RH Paris Arc de Triomphe', '', '', '', '', 'France', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1628, 'ABZAP', 'MH Aberdeen', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1629, 'BHXBH', 'MH Birmingham', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1630, 'BLKBP', 'MH Preston', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1631, 'BOHBM', 'MH Bournemouth', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1632, 'BRSDT', 'MH Bristol City Centre', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1633, 'BRSRY', 'MH Bristol Royal', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1634, 'CBGHD', 'MH Huntingdon', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1635, 'CVTGS', 'MH Forest of Arden', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1636, 'CWLDT', 'MH Cardiff', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1637, 'CWLGS', 'MH St Pierre', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1638, 'EDIEB', 'MH Edinburgh', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1639, 'EMAGS', 'MH Breadsall Priory', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1640, 'EMALM', 'MH Leicester', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1641, 'GLADT', 'MH Glasgow', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1642, 'LBADT', 'MH Leeds', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1643, 'LBAGS', 'MH Hollins Hall', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1644, 'LHRHR', 'MH Heathrow', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1645, 'LHRSL', 'MH Heathrow Windsor', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1646, 'LONBH', 'MH Bexleyheath', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1647, 'LONCH', 'MH London County Hall', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1648, 'LONLM', 'MH London Kensington', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1649, 'LONMA', 'MH London Marble Arch', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1650, 'LONRP', 'MH London Regents Park', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1651, 'LONWA', 'MH Waltham Abbey', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1652, 'LONWH', 'MH London Maida Vale', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1653, 'LPLLP', 'MH Liverpool', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1654, 'MANAP', 'MH Manchester Airport', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1655, 'MANBR', 'RH Manchester', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1656, 'MANGS', 'MH Worsley Park', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1657, 'NCLGF', 'MH Newcastle Gosforth Park', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1658, 'NCLGH', 'MH Newcastle MetroCentre', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1659, 'NCLSL', 'MH Sunderland', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1660, 'NWIGS', 'MH Sprowston Manor', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1661, 'ORMNH', 'MH Northampton', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1662, 'PMEHA', 'MH Portsmouth', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1663, 'QQYYK', 'MH York', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1664, 'SOUGS', 'MH Meon Valley', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1665, 'STNCH', 'MH Cheshunt', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1666, 'SWIDT', 'MH Swindon', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1667, 'SWSDT', 'MH Swansea', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1668, 'TDMGS', 'MH Tudor Park', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1669, 'XVHPB', 'MH Peterborough', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1670, 'XVUDM', 'MH Durham', '', '', '', '', 'United kingdom', 1, 0, 1, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1671, 'AGRCY', 'Courtyard Agra', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1672, 'AMDBR', 'Renaissance Ahmedabad Hotel', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1673, 'AMDCY', 'Courtyard Ahmedabad', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1674, 'AMMJR', 'Amman Marriott Hotel', '', '', '', '', 'Jordan', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1675, 'AUHAL', 'Marriott Hotel Al Forsan, Abu Dhabi', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1676, 'AUHCY', 'Courtyard World Trade Center, Abu Dhabi', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1677, 'AUHMC', 'Marriott Hotel Downtown, Abu Dhabi', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1678, 'BKKBR', 'Renaissance Bangkok Ratchaprasong Hotel', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1679, 'BKKCY', 'Courtyard by Marriott Bangkok', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1680, 'BKKDT', 'JW Marriott Hotel Bangkok', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1681, 'BKKEA', 'Sathorn Vista, Bangkok - Marriott Executive Apartments', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1682, 'BKKER', 'Mayfair, Bangkok - Marriott Executive Apartments', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1683, 'BKKQP', 'Bangkok Marriott Marquis Queen?s Park', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1684, 'BKKSP', 'Sukhumvit Park, Bangkok - Marriott Executive Apartments', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1685, 'BKKWO', 'Bangkok Marriott Hotel The Surawongse', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1686, 'BLRBH', 'Renaissance Bengaluru Race Course Hotel', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1687, 'BLRFI', 'Fairfield by Marriott Bengaluru Outer Ring Road', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1688, 'BLRGT', 'Courtyard Bengaluru Outer Ring Road', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1689, 'BLRWF', 'Bengaluru Marriott Hotel Whitefield', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1690, 'BNEDT', 'Brisbane Marriott Hotel', '', '', '', '', 'Australia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1691, 'BOMBR', 'Renaissance Mumbai Convention Centre Hotel', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1692, 'BOMCY', 'Courtyard Mumbai International Airport', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1693, 'BOMER', 'Lakeside Chalet, Mumbai - Marriott Executive Apartments', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1694, 'BOMJW', 'JW Marriott Mumbai Juhu', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1695, 'CAIBR', 'Renaissance Cairo Mirage City Hotel', '', '', '', '', 'Egypt', 1, 0, 3, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1696, 'CAIEG', 'Cairo Marriott Hotel & Omar Khayyam Casino', '', '', '', '', 'Egypt', 1, 0, 3, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1697, 'CAIJW', 'JW Marriott Hotel Cairo', '', '', '', '', 'Egypt', 1, 0, 3, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1698, 'CJBFI', 'Fairfield by Marriott Coimbatore', '', '', '', '', 'india', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1699, 'CMBMC', 'Weligama Bay Marriott Resort & Spa', '', '', '', '', 'Sri lanka', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1700, 'COKAP', 'Courtyard Kochi Airport', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1701, 'CPTCM', 'Cape Town Marriott Hotel Crystal Towers', '', '', '', '', 'South africa', 1, 0, 3, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1702, 'DEDJW', 'JW Marriott Mussoorie Walnut Grove Resort & Spa', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1703, 'DELAP', 'JW Marriott Hotel New Delhi Aerocity', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1704, 'DELGU', 'Courtyard Gurugram Downtown', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1705, 'DOHMC', 'Doha Marriott Hotel', '', '', '', '', 'Qatar', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1706, 'DPSCY', 'Courtyard by Marriott Bali Nusa Dua Resort', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1707, 'DPSFI', 'Fairfield by Marriott Bali Legian', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1708, 'DPSSM', 'Courtyard Bali Seminyak Resort', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1709, 'DXBAE', 'JW Marriott Hotel Dubai', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1710, 'DXBAK', 'Lapita, Dubai Parks and Resorts, Autograph Collection', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1711, 'DXBBB', 'Renaissance Downtown Hotel, Dubai', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1712, 'DXBHG', 'Habtoor Grand Resort, Autograph Collection', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1713, 'DXBHR', 'Dubai Marriott Harbour Hotel & Suites', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1714, 'DXBJW', 'JW Marriott Marquis Hotel Dubai', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1715, 'DXBLV', 'La Ville Hotel & Suites CITY WALK, Dubai, Autograph Collection', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1716, 'DXBMH', 'Marriott Hotel Al Jaddaf, Dubai', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1717, 'FEZMC', 'Fes Marriott Jnan Place', '', '', '', '', 'india', 1, 0, 3, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1718, 'GOIMC', 'Goa Marriott Resort & Spa', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1719, 'HANJW', 'JW Marriott Hotel Hanoi', '', '', '', '', 'Vietnam', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1720, 'HHQMR', 'Hua Hin Marriott Resort & Spa', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1721, 'HKTBR', 'Renaissance Phuket Resort & Spa', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1722, 'HKTJW', 'JW Marriott Phuket Resort & Spa', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1723, 'HKTKL', 'JW Marriott Khao Lak Resort & Spa', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1724, 'HKTMB', 'Phuket Marriott Resort & Spa, Merlin Beach', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1725, 'HKTNB', 'Phuket Marriott Resort and Spa, Nai Yang Beach', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1726, 'HYDCY', 'Courtyard Hyderabad', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1727, 'HYDHY', 'Marriott Executive Apartments Hyderabad', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1728, 'HYDMC', 'Hyderabad Marriott Hotel & Convention Centre', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1729, 'IDRFI', 'Fairfield by Marriott Indore', '', '', '', '', 'india', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1730, 'IDRMH', 'Indore Marriott Hotel', '', '', '', '', 'india', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1731, 'IXCJW', 'JW Marriott Hotel Chandigarh', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1732, 'IXGFI', 'Fairfield by Marriott Belagavi', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1733, 'JAINH', 'Jaipur JW Marriot National Highway India', '', '', '', '', 'india', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1734, 'JDHFI', 'Fairfield by Marriott Jodhpur Hotel', '', '', '', '', 'india', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1735, 'JHBBR', 'Renaissance Johor Bahru Hotel', '', '', '', '', 'Malaysia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1736, 'JKTJW', 'JW Marriott Hotel Jakarta', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1737, 'JOGMC', 'Yogyakarta Marriott Hotel', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1738, 'KGLMC', 'Kigali Marriott Hotel', '', '', '', '', 'Rwanda', 1, 0, 3, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1739, 'KTMFI', 'Fairfield by Marriott Kathmandu', '', '', '', '', 'Nepal', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1740, 'KULRN', 'Renaissance Kuala Lumpur Hotel', '', '', '', '', 'Malaysia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1741, 'LKOBR', 'Renaissance Lucknow Hotel', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1742, 'MAACY', 'Courtyard by Marriott Chennai', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1743, 'PNQCK', 'Courtyard Pune Chakan', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1744, 'PNQMC', 'JW Marriott Hotel Pune', '', '', '', '', 'india', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1745, 'PNQMS', 'Marriott Suites Pune', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1746, 'PNQPH', 'Courtyard Pune Hinjewadi', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1747, 'PQCJW', 'JW Marriott Phu Quoc Emerald Bay Resort & Spa', '', '', '', '', 'Vietnam', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1748, 'PYXBR', 'Renaissance Pattaya Resort & Spa', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1749, 'QMDJV', 'Jordan Valley Marriott Resort & Spa', '', '', '', '', 'Jordan', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1750, 'RPRCY', 'Courtyard Raipur', '', '', '', '', 'India', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1751, 'RUHAB', 'Courtyard Riyadh Diplomatic Quarter', '', '', '', '', 'Saudi arabia', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1752, 'RUHSA', 'Riyadh Marriott Hotel', '', '', '', '', 'Saudi arabia', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1753, 'SELCY', 'Courtyard Seoul Times Square', '', '', '', '', 'South korea', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1754, 'SELER', 'Yeouido Park Centre, Seoul - Marriott Executive Apartments', '', '', '', '', 'South korea', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1755, 'SELPN', 'Courtyard Seoul Pangyo', '', '', '', '', 'South korea', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1756, 'SGNBR', 'Renaissance Riverside Hotel Saigon', '', '', '', '', 'Vietnam', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1757, 'SSHEG', 'Sharm El Sheikh Marriott Resort', '', '', '', '', 'Egypt', 1, 0, 3, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1758, 'SUBJW', 'JW Marriott Hotel Surabaya', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1759, 'USMBR', 'Renaissance Koh Samui Resort & Spa', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1760, 'VTZFI', 'Fairfield by Marriott Visakhapatnam', '', '', '', '', 'india', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1761, 'ALARZ', 'The Ritz Carlton, Almaty', '', '', '', '', 'Kazakhstan', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1762, 'AUHRZ', 'The Ritz-Carlton Abu Dhabi, Grand Canal', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1763, 'BAHRZ', 'The Ritz-Carlton, Bahrain', '', '', '', '', 'Bahrain', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1764, 'BCNRZ', 'Hotel Arts', '', '', '', '', 'Spain', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1765, 'BERZT', 'RC Berlin', '', '', '', '', 'Germany', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1766, 'BJSFS', 'The Ritz-Carlton Beijing, Financial Street', '', '', '', '', 'China', 1, 0, 3, 'Greater China', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1767, 'BLRRZ', 'The Ritz-Carlton, Bangalore', '', '', '', '', 'india', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1768, 'BUDRZ', 'The Ritz-Carlton, Budapest', '', '', '', '', 'Hungary', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1769, 'CAIRZ', 'The Nile Ritz-Carlton, Cairo', '', '', '', '', 'Egypt', 1, 0, 3, 'Africa', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1770, 'CANRZ', 'The Ritz-Carlton, Guangzhou', '', '', '', '', 'China', 1, 0, 3, 'Greater China', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1771, 'CTURZ', 'The Ritz-Carlton, Chengdu', '', '', '', '', 'China', 1, 0, 3, 'Greater China', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1772, 'DOHRZ', 'The Ritz-Carlton, Doha', '', '', '', '', 'Qatar', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1773, 'DOHSQ', 'Sharq Village & Spa', '', '', '', '', 'Qatar', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1774, 'DPSSW', 'The Ritz-Carlton, Bali', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1775, 'DPSUB', 'Mandapa, A Ritz-Carlton Reserve', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1776, 'DXBIF', 'The Ritz-Carlton, Dubai International Financial Centre', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1777, 'DXBRZ', 'The Ritz-Carlton, Dubai', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1778, 'GCMRZ', 'The Ritz-Carlton, Grand Cayman', '', '', '', '', 'Cayman islands', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1779, 'GVARZ', 'RC Geneva', '', '', '', '', 'Switzerland', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1780, 'HKGKW', 'The Ritz-Carlton, Hong Kong', '', '', '', '', 'China', 1, 0, 3, 'Greater China', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1781, 'HNLRR', 'The Ritz-Carlton Residences, Waikiki Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1782, 'ISTRZ', 'RC Istanbul', '', '', '', '', 'Turkey', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1783, 'JEDRJ', 'The Ritz-Carlton Jeddah', '', '', '', '', 'Saudi arabia', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1784, 'JKTRT', 'The Ritz-Carlton Jakarta, Pacific Place', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1785, 'JKTRZ', 'The Ritz-Carlton Jakarta, Mega Kuningan', '', '', '', '', 'Indonesia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1786, 'LGKRZ', 'The Ritz-Carlton, Langkawi', '', '', '', '', 'Malaysia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1787, 'LISRZ', 'Penha Longa Resort', '', '', '', '', 'Portugal', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1788, 'MCTRZ', 'Al Bustan Palace, A Ritz-Carlton Hotel', '', '', '', '', 'Oman', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1789, 'MFMMR', 'The Ritz-Carlton, Macau', '', '', '', '', 'China', 1, 0, 3, 'Greater China', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1790, 'MOWRZ', 'RC Moscow', '', '', '', '', 'Russian federation', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1791, 'OKARZ', 'The Ritz-Carlton, Okinawa', '', '', '', '', 'Japan', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1792, 'OSARZ', 'The Ritz-Carlton, Osaka', '', '', '', '', 'Japan', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1793, 'RKTRW', 'Al Wadi Desert, Ras Al Khaimah, a Ritz-Carlton partner hotel', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1794, 'RKTRZ', 'The Ritz-Carlton Ras Al Khaimah, Al Hamra Beach', '', '', '', '', 'United arab emirates', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1795, 'RUHRZ', 'The Ritz-Carlton Riyadh Palace', '', '', '', '', 'Saudi arabia', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1796, 'SCLRZ', 'The Ritz-Carlton, Santiago', '', '', '', '', 'Chile', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1797, 'SHASZ', 'The Ritz-Carlton Shanghai, Pudong', '', '', '', '', 'China', 1, 0, 3, 'Greater China', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1798, 'SINRZ', 'The Ritz-Carlton, Millenia Singapore', '', '', '', '', 'Singapore', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1799, 'SJURZ', 'The Ritz-Carlton, San Juan', '', '', '', '', 'Puerto rico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1800, 'SZXRZ', 'The Ritz-Carlton, Shenzhen', '', '', '', '', 'China', 1, 0, 3, 'Greater China', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1801, 'TFSRZ', 'The Ritz-Carlton, Abama', '', '', '', '', 'Spain', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1802, 'TLVRZ', 'The Ritz-Carlton, Herzliya', '', '', '', '', 'Israel', 1, 0, 3, 'Middle East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1803, 'TSERZ', 'RC Astana', '', '', '', '', 'Kazakhstan', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1804, 'TSNRZ', 'The Ritz-Carlton, Tianjin', '', '', '', '', 'China', 1, 0, 3, 'Greater China', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1805, 'TYORZ', 'The Ritz-Carlton, Tokyo', '', '', '', '', 'Japan', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1806, 'UKYRZ', 'The Ritz-Carlton, Kyoto', '', '', '', '', 'Japan', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1807, 'VIERZ', 'RC Vienna', '', '', '', '', 'Austria', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1808, 'WFGRZ', 'The Ritz-Carlton, Wolfsburg', '', '', '', '', 'Germany', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1809, 'AIYFW', 'Marriott\'s Fairway Villas', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1810, 'AUAAO', 'Marriott\'s Aruba Ocean Club', '', '', '', '', 'Aruba', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1811, 'BOSCH', 'Marriott Vacation Club Pulse at Custom House, Boston', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1812, 'CTDDS', 'Marriott\'s Desert Springs Villas I', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1813, 'CTDSR', 'Marriott\'s Shadow Ridge I-The Villages', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1814, 'CTDVI', 'Marriott\'s Desert Springs Villas II', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1815, 'HHHBB', 'Marriott\'s Barony Beach Club', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1816, 'HHHVI', 'Marriott\'s Grande Ocean', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1817, 'HKTPA', 'Marriott\'s Mai Khao Beach - Phuket', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1818, 'HKTPB', 'Marriott\'s Phuket Beach Club', '', '', '', '', 'Thailand', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1819, 'HNLKO', 'Marriott\'s Ko Olina Beach Club', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1820, 'HNMMH', 'Marriott\'s Maui Ocean Club  - Molokai, Maui & Lanai Towers', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1821, 'HNMMU', 'Marriott\'s Maui Ocean Club  - Lahaina & Napili Towers', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1822, 'KOAMV', 'Marriott?s Waikoloa Ocean Club', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1823, 'LASVG', 'Marriott\'s Grand Chateau', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1824, 'LAXNC', 'Marriott\'s Newport Coast Villas', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1825, 'LIHKA', 'Marriott\'s Kaua\'i Beach Club', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1826, 'LIHKN', 'Marriott\'s Kauai Lagoons - Kalanipu\'u', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1827, 'LIHWI', 'Marriott\'s Waiohai Beach Club', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1828, 'LONQL', 'Grand Residences by Marriott - Mayfair-London', '', '', '', '', 'United kingdom', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1829, 'MIAMV', 'Marriott Vacation Club Pulse, South Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1830, 'MRKML', 'Marriott\'s Crystal Shores', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1831, 'MYROW', 'Marriott\'s OceanWatch Villas at Grande Dunes', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1832, 'NYCVC', 'Marriott Vacation Club Pulse, New York City', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1833, 'PARDP', 'Marriott\'s Village d\'lle-de-France', '', '', '', '', 'France', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1834, 'PBIPS', 'Marriott\'s Ocean Pointe', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1835, 'PFNLE', 'Marriott\'s Legends Edge at Bay Point', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1836, 'PHFVI', 'Marriott\'s Manor Club at Ford\'s Colony', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1837, 'PHXCV', 'Marriott\'s Canyon Villas', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1838, 'QKBVI', 'Marriott\'s Mountain Valley Lodge at Breckenridge', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1839, 'RNOGR', 'Grand Residences by Marriott, Lake Tahoe - studios, 1 & 2 bedrooms', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1840, 'RNOTL', 'Marriott\'s Timber Lodge', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1841, 'SANVA', 'Marriott Vacation Club Pulse, San Diego', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1842, 'SGFHB', 'Marriott\'s Willow Ridge Lodge', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1843, 'SLCMS', 'Marriott\'s MountainSide', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1844, 'SLCVI', 'Marriott\'s Summit Watch', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1845, 'WHRBI', 'Marriott\'s StreamSide Birch at Vail', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1846, 'WHRDO', 'Marriott\'s StreamSide Douglas at Vail', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1847, 'WHRVI', 'Marriott\'s StreamSide Evergreen at Vail', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1848, 'OOLMV', 'Marriott Vacation Club at Surfers Paradise', '', '', '', '', 'Australia', 1, 0, 3, 'APEC', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1849, 'AGPMB', 'Marriott\'s Marbella Beach Resort', '', '', '', '', 'Spain', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1850, 'AGPPY', 'Marriott\'s Playa Andaluza', '', '', '', '', 'Spain', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1851, 'AUAAC', 'Marriott\'s Aruba Surf Club', '', '', '', '', 'Aruba', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1852, 'FLLBP', 'Marriott\'s BeachPlace Towers', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1853, 'MCOCY', 'Marriott\'s Cypress Harbour Villas', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1854, 'MCOGV', 'Marriott\'s Grande Vista', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1855, 'MIADA', 'Marriott\'s Villas at Doral', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1856, 'PMIMC', 'Marriott\'s Club Son Antem', '', '', '', '', 'Spain', 1, 0, 3, 'Europe', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1857, 'AVLAK', 'Grand Bohemian Hotel Asheville, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1858, 'BHMAG', 'Grand Bohemian Hotel Mountain Brook, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1859, 'BUFBD', 'Buffalo Marriott HARBORCENTER', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1860, 'CHADT', 'Chattanooga Marriott Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1861, 'CHINB', 'Renaissance Chicago North Shore Hotel', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1862, 'CHSAK', 'Grand Bohemian Hotel Charleston, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1863, 'CMHAC', 'AC Hotel Columbus Dublin', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1864, 'DALRD', 'Renaissance Dallas Richardson Hotel', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1865, 'EYWFK', 'Fairfield Inn & Suites Key West at The Keys Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1866, 'HARCA', 'Courtyard Hershey Chocolate Avenue', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1867, 'JAXAK', 'Casa Monica Resort & Spa, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1868, 'JAXJV', 'Courtyard Jacksonville Beach Oceanfront', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1869, 'MCOAK', 'Grand Bohemian Hotel Orlando, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1870, 'MCOCA', 'Castle Hotel, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1871, 'MCOCB', 'Bohemian Hotel Celebration, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1872, 'MIAXB', 'Residence Inn Miami Beach Surfside', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1873, 'MTHMC', 'Courtyard Marathon Florida Keys', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1874, 'PHXAK', 'The Camby, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1875, 'PHXGR', 'Renaissance Phoenix Glendale Hotel & Spa', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1876, 'SAVAD', 'Mansion on Forsyth Park, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1877, 'SAVAK', 'The Bohemian Hotel Savannah Riverfront, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1878, 'SUXDE', 'Delta Hotels South Sioux City Riverfront', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1879, 'TPAFW', 'Fairfield Inn & Suites Clearwater Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1880, 'TPAMB', 'Courtyard St. Petersburg Clearwater/Madeira Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1881, 'VPSSH', 'SpringHill Suites Navarre Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1882, 'YULMD', 'Renaissance Montreal Downtown Hotel', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1883, 'YYCCS', 'Courtyard Calgary South', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1884, 'YYZDA', 'Delta Hotels Toronto Airport & Conference Centre', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1885, 'PHFAK', 'Williamsburg Lodge, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1886, 'AEPSI', 'Sheraton Buenos Aires Hotel & Convention Center', '', '', '', '', 'Argentina', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1887, 'ASUAL', 'Aloft Asuncion ', '', '', '', '', 'Paraguay', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1888, 'ASUSI', 'Sheraton Asuncion Hotel', '', '', '', '', 'Paraguay', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1889, 'BOGAL', 'Aloft Bogota Airport ', '', '', '', '', 'Colombia', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1890, 'BOGWH', 'W Bogota Hotel ', '', '', '', '', 'Colombia', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1891, 'CORSI', 'Sheraton Cordoba Hotel', '', '', '', '', 'Argentina', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1892, 'CPEHL', 'Hacienda Puerta Campeche', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1893, 'CPELC', 'Hacienda Uayamon', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1894, 'CUNAL', 'Aloft Cancun ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1895, 'CUNFP', 'Four Points by Sheraton Cancun Centro  ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1896, 'CUZLC', 'Palacio del Inka Hotel', '', '', '', '', 'Peru', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1897, 'CUZTL', 'Tambo del Inka, A Luxury Collection Resort & Spa, Valle Sagrado ', '', '', '', '', 'Peru', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1898, 'CYRSI', 'Sheraton Colonia Golf & Spa Resort ', '', '', '', '', 'Uruguay', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1899, 'CZMWI', 'The Westin Cozumel (opens May 22)  ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1900, 'GCMMI', 'The Westin Grand Cayman Seven Mile Beach Resort & Spa', '', '', '', '', 'Grand Cayman', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1901, 'GDLWI', 'The Westin Hotel Guadalajara ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1902, 'HAVFP', 'Four Points Havana, Cuba', '', '', '', '', 'Cuba', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1903, 'KNASI', 'Sheraton Miramar Hotel & Convention Center', '', '', '', '', 'Chile', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1904, 'LIMSI', 'Sheraton Lima Hotel & Convention Center', '', '', '', '', 'Peru', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1905, 'LIMWI', 'The Westin Lima Hotel and Convention Center ', '', '', '', '', 'Peru', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1906, 'MDQSI', 'Sheraton Mar del Plata Hotel', '', '', '', '', 'Argentina', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1907, 'MEXIS', 'Sheraton Mexico City Maria Isabel Hotel ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1908, 'MEXWM', 'W Hotel Mexico City', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1909, 'MEXWS', 'The Westin Santa Fe, Mexico City', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1910, 'MEXXR', 'The St. Regis Mexico City Hotel ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1911, 'MIDLC', 'Hacienda San Jose', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1912, 'MIDRL', 'Hacienda Santa Rosa ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1913, 'MIDTL', 'Hacienda Temozon', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1914, 'MTYSI', 'Sheraton Ambassador Hotel ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1915, 'MVDFP', 'Four Points by Sheraton Montevideo', '', '', '', '', 'Uruguay', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1916, 'MVDSI', 'Sheraton Montevideo Hotel', '', '', '', '', 'Uruguay', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1917, 'PBXSI', 'Sheraton Porto Alegre Hotel ', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1918, 'PIOLC', 'Hotel Paracas, A Luxury Collection Resort ', '', '', '', '', 'Peru', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1919, 'PTYBB', 'Sheraton Bijao Beach Resort', '', '', '', '', 'Panama', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1920, 'PUJFP', 'Four Points by Sheraton Puntacana Village', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1921, 'PUJWI', 'The Westin Puntacana Resort & Club', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1922, 'PVRSI', 'Sheraton Buganvilias Resort & Convention Center', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1923, 'PVRWH', 'W Punta de Mita', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1924, 'PVRWI', 'The Westin Resort & Spa Puerto Vallarta', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1925, 'PVRXR', 'The St. Regis Punta Mita Resort', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1926, 'RECCY', 'Courtyard by Marriott Recife Boa Viagem', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1927, 'RECSI', 'Sheraton Reserva do Paiva, Recife Hotel & Conv Center', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1928, 'RIOAC', 'AC Hotel Rio de Janeiro Barra de Tijuca', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1929, 'RIOCY', 'Courtyard by Marriott Rio de Janeiro Barra de Tijuca', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1930, 'RIOMC', 'JW Marriott Hotel Rio de Janeiro', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1931, 'RIOPM', 'AC Hotel Rio de Janeiro Porto Maravilha', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1932, 'RIORI', 'Residence Inn Rio de Janeiro Barra de Tijuca', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1933, 'RIOSI', 'Sheraton Grand Rio Hotel & Resort', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1934, 'SAOBR', 'Renaissance Sao Paulo Hotel', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1935, 'SAOER', 'Sao Paulo Marriott Executive Apartments', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1936, 'SCLFP', 'Four Points by Sheraton Santiago', '', '', '', '', 'Chile', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1937, 'SCLLC', 'San Cristobal Tower', '', '', '', '', 'Chile', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1938, 'SCLSI', 'Sheraton Santiago Hotel & Convention Center', '', '', '', '', 'Chile', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1939, 'SCLWH', 'W Santiago ', '', '', '', '', 'Chile', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1940, 'SDQDS', 'Sheraton Santo Domingo', '', '', '', '', 'Dominican republic', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1941, 'SJFWI', 'Westin St. John Villas  ', '', '', '', '', 'Us virgin islands', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1942, 'SJUFP', 'Four Points by Sheraton Caguas Real Hotel & Casino', '', '', '', '', 'Puerto rico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1943, 'SJUOL', 'Sheraton Old San Juan Hotel', '', '', '', '', 'Puerto rico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1944, 'SJUSR', 'Sheraton Puerto Rico Hotel & Casino', '', '', '', '', 'Puerto rico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1945, 'SJUXR', 'The St. Regis Bahia Beach Resort, Puerto Rico', '', '', '', '', 'Puerto rico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1946, 'SLASS', 'Sheraton Salta Hotel ', '', '', '', '', 'Argentina', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1947, 'TNOWI', 'Westin Golf Resort & Spa, Playa Conchal', '', '', '', '', 'Costa rica', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1948, 'VIXSI', 'Sheraton Vitoria Hotel', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1949, 'VQSWH', 'W Retreat & Spa - Vieques Island', '', '', '', '', 'Puerto Rico', 1, 0, 4, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1950, '', 'Park Tower Buenos Aires', '', '', '', '', 'Argentina', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:47'),
	(1951, '', 'Sheraton Santa Fe, Mexico City ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:43'),
	(1952, '', 'The Westin Los Cabos Resort Villas & Spa  ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:35'),
	(1953, '', 'The Westin Resort & Spa Cancun', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:32'),
	(1954, '', 'Sheraton Hacienda del Mar Golf & Spa Resort', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:30'),
	(1955, '', 'The Westin Dawn Beach Resort & Spa, St. Maarten', '', '', '', '', 'Us virgin islands', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:28'),
	(1956, '', 'Le Meridien Mexico City', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:26'),
	(1957, '', 'Sheraton Da Bahia Hotel ', '', '', '', '', 'Brazil', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:24'),
	(1958, '', 'Las Alcobas, a Luxury Collection Hotel, Mexico City ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:21'),
	(1959, '', 'Four Points by Sheraton Cusco', '', '', '', '', 'Peru', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:38'),
	(1960, '', 'The Westin Lagunamar Ocean Resort Villas & Spa  ', '', '', '', '', 'Mexico', 1, 0, 4, 'Caribbean Latin America', 1, 1, '2018-02-03 03:54:11', 10, '2018-02-16 08:58:41'),
	(1961, 'CHSNO', 'Residence Inn Charleston Airport', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1962, 'OKCBT', 'Residence Inn Oklahoma City Downtown/Bricktown', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1963, 'OKCDT', 'Courtyard Oklahoma City Downtown', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1964, 'PLHCC', 'Fairfield Inn & Suites Philadelphia Downtown/Center City', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1965, 'YQRFI', 'Fairfield Inn & Suites Regina', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1966, 'ABECV', 'Springhill Suites Allentown Bethelhem/Center Valley', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1967, 'ABQNM', 'Albuquerque Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1968, 'ADMCY', 'Courtyard Ardmore', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1969, 'AGSAF', 'Fairfield Inn & Suites Augusta', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1970, ' AGUMC ', 'Aguascalientes Marriott Hotel', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1971, 'ALBCA', 'Courtyard Albany Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1972, 'ALBMC', 'TownePlace Suites Albany Downtown/Medical Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1973, 'ALBNY', 'Albany Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1974, 'ALBWS', 'Courtyard Albany Thruway', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1975, 'ALOFW', 'Fairfield Inn & Suites Waterloo Cedar Falls', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1976, 'AMAAP', 'Fairfield Inn & Suites Amarillo Airport', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1977, 'AMADT', 'Courtyard Amarillo Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1978, 'ANCDT', 'Anchorage Marriott Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1979, 'ATLCP', 'Atlanta Marriott Peachtree Corners', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1980, 'ATLFB', 'Fairfield Inn & Suites Atlanta Buckhead', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1981, 'ATLFI', 'Fairfield Inn &amp; Suites Atlanta Alpharetta', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1982, 'ATLNO', 'Atlanta Marriott Northwest at Galleria', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1983, 'ATLPF', 'Fairfield Inn & Suites Atlanta Perimeter Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1984, 'ATLSA', 'Renaissance Concourse Atlanta Airport Hotel', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1985, 'ATLWE', 'Residence Inn Atlanta Perimeter Center/Dunwoody', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1986, 'ATLWF', 'Fairfield Inn & Suites Atlanta Woodstock', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1987, 'ATLXM', 'Fairfield Inn & Suites Atlanta Buford/Mall of Georgia', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1988, 'ATWCY', 'Courtyard Appleton Riverfront', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1989, 'AUABR', 'Renaissance Aruba Resort & Casino', '', '', '', '', 'Aruba', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1990, 'AUSBU', 'Fairfield Inn & Suites Austin Buda', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1991, 'AUSCP', 'SpringHill Suites Austin Cedar Park', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1992, 'AUSNB', 'Residence Inn Austin Northwest/The Domain Area', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1993, 'AUSPF', 'Courtyard Austin Pflugerville', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1994, 'AUSSN', 'SpringHill Suites Austin Northwest/The Domain Area', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1995, 'AUSTN', 'TownePlace Suites Austin Round Rock', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1996, 'AVLAR', 'Courtyard Asheville Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1997, 'AVLFA', 'Fairfield Inn & Suites Asheville Tunnel Road', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1998, 'AVLRI', 'Residence Inn Asheville Biltmore', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(1999, 'BDLCT', 'Hartford Marriott Farmington', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2000, 'BEHFI', 'Fairfield Inn & Suites St. Joseph Stevensville', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2001, 'BFFFI', 'Fairfield Inn & Suites Scottsbluff', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2002, 'BGICY', 'Courtyard Bridgetown, Barbados', '', '', '', '', 'Barbados', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2003, 'BGMVS', 'Courtyard Binghamton', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2004, 'BGRCY', 'Courtyard Bangor', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2005, 'BGRFI', 'Fairfield Inn Bangor', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2006, 'BGRRI', 'Residence Inn Bangor', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2007, 'BGRTS', 'TownePlace Suites Bangor', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2008, 'BHMHV', 'Renaissance Birmingham Ross Bridge Golf Resort & Spa', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2009, 'BILRI', 'Residence Inn Billings', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2010, 'BJXCY', 'Courtyard Leon at The Poliforum', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2011, 'BLISH', 'SpringHill Suites Bellingham', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2012, 'BMIMC', 'Bloomington-Normal Marriott Hotel & Conference Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2013, 'BNACK?', 'Fairfield Inn & Suites Cookeville', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2014, 'BNACL', 'Residence Inn Franklin Cool Springs', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2015, 'BNAGH', 'Courtyard Nashville Green Hills', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2016, 'BNAGI', 'The Inn at Opryland, A Gaylord Hotel', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2017, 'BNAGO', 'Gaylord Opryland Resort & Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2018, 'BNAVI', 'TownePlace Suites Cookeville', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2019, 'BNAWE', 'Courtyard Nashville Vanderbilt/West End', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2020, 'BOGAK', 'The Artisan D.C. Hotel, Autograph Collection', '', '', '', '', 'Colombia', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2021, 'BOGCY', 'Courtyard by Marriott Bogota Airport', '', '', '', '', 'Colombia', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2022, 'BOGJW', 'JW Marriott Hotel Bogota', '', '', '', '', 'Colombia', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2023, 'BOGMC', 'Bogota Marriott Hotel', '', '', '', '', 'Colombia', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2024, 'BOIRD', 'Residence Inn Boise Downtown/City Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2025, 'BONCY', 'Courtyard Bonaire', '', '', '', '', 'Bonaiire', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2026, 'BOSBL', 'Courtyard Boston Brookline', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2027, 'BOSLA', 'Courtyard by Marriott Boston Logan Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2028, 'BOSPO', 'Fairfield Inn & Suites Boston Walpole', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2029, 'BOSRR', 'Residence Inn Boston Braintree', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2030, 'BOSTT', 'TownePlace Suites Boston Tewksbury/Andover', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2031, 'BOSXR', 'Residence Inn Boston Burlington', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2032, 'BTRGZ', 'TownePlace Suites Baton Rouge Gonzales', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2033, 'BTRRO', 'SpringHill Suites Baton Rouge Gonzales', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2034, 'BUFCY', 'Courtyard Buffalo Amherst/University', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2035, 'BVUDT', 'Courtyard Seattle Bellevue/Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2036, 'BWIHB', 'Residence Inn Baltimore Downtown/ Inner Harbor', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2037, 'BWITS', 'TownePlace Suites Baltimore BWI Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2038, 'CAKAS', 'Fairfield Inn & Suites Akron Stow', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2039, 'CHAOW', 'SpringHill Suites Chattanooga North/Ooltewah', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2040, 'CHATV', 'TownePlace Suites Cleveland', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2041, 'CHIAX', 'Hotel Chicago Downtown, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2042, 'CHIDE', 'Delta Hotels Chicago North Shore Suites', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2043, 'CHIDX', 'Hotel EMC2, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2044, 'CHIFD', 'Fairfield Inn & Suites Chicago Downtown/Magnificent Mile', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2045, 'CHISB', 'Chicago Marriott Schaumburg', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2046, 'CHISW', 'Chicago Marriott Southwest at Burr Ridge', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2047, 'CHIZS', 'Fairfield Inn & Suites Chicago Schaumburg', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2048, 'CIDSH', 'SpringHill Suites Coralville', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2049, 'CKBFI', 'Fairfield Inn & Suites Fairmont', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2050, 'CLEAB', 'Residence Inn Cleveland Avon at The Emerald Event Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2051, 'CLELY', 'Courtyard Cleveland Elyria', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2052, 'CLEMD', 'Fairfield Inn & Suites Medina', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2053, 'CLOMC', 'Cali Marriott Hotel', '', '', '', '', 'Colombia', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2054, 'CLTBL', 'Courtyard Charlotte Ballantyne', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2055, 'CLTFS', 'Fairfield Inn & Suites Charlotte Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2056, 'CMECY', 'Courtyard Ciudad del Carmen', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2057, 'CMHAK', 'Hotel LeVeque, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2058, 'CMHDF', 'Fairfield Inn & Suites Columbus Dublin', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2059, 'CSGFI', 'Fairfield Inn & Suites Columbus', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2060, 'CSGMC', 'Columbus Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2061, 'CTDPD', 'Fairfield Inn & Suites Palm Desert', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2062, 'CUNCY', 'Courtyard Cancun Airport', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2063, 'CUNJW', 'JW Marriott Cancun Resort & Spa', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2064, 'CUNMX', 'Marriott Cancun Resort', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2065, 'CURBR', 'Renaissance Curacao Resort & Casino', '', '', '', '', 'Cura?ao', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2066, 'CUZMC', 'JW Marriott El Convento Cusco', '', '', '', '', 'Peru', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2067, 'CVGBC', 'AC Hotel Cincinnati at The Banks', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2068, 'CVGFL', 'Courtyard Cincinnati Airport South/Florence', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2069, 'CVGSB', 'SpringHill Suites Cincinnati Blue Ash', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2070, 'DALAN', 'Courtyard Dallas Allen at the John Q. Hammons Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2071, 'DALCH', 'Courtyard Dallas Medical/Market Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2072, 'DALCL', 'Dallas Marriott Las Colinas', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2073, 'DALDZ', 'Residence Inn Dallas Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2074, 'DALGT', 'Gaylord Texan Resort & Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2075, 'DALIR', 'SpringHill Suites Dallas DFW Airport East/Las Colinas Irving', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2076, 'DALIV', 'Courtyard Dallas DFW Airport South/Irving', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2077, 'DALPR', 'Residence Inn Dallas Plano/Richardson', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2078, 'DALPS', 'SpringHill Suites Dallas Plano/Frisco', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2079, 'DALRW', 'SpringHill Suites Dallas Rockwall', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2080, 'DALSS', 'SpringHill Suites Dallas NW Highway at Stemmons/I-35E', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2081, 'DALTG', 'TownePlace Suites Dallas DFW Airport North/Grapevine', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2082, 'DALWE', 'SpringHill Suites Dallas Downtown/West End', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2083, 'DALWF', 'Fairfield Inn & Suites Dallas West/I-30', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2084, 'DALXC', 'Courtyard Dallas Plano/Richardson', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2085, 'DALXS', 'AC Hotel Dallas Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2086, 'DENAC', 'AC Hotel Denver Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2087, 'DENBT', 'Fairfield Inn & Suites Denver Northeast/Brighton', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2088, 'DENTA', 'TownePlace Suites Denver Airport at Gateway Park', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2089, 'DENTL', 'TownePlace Suites Denver South/Lone Tree', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2090, 'DFWAS', 'Residence Inn Dallas DFW Airport South/Irving', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2091, 'DFWCA', 'Fairfield Inn & Suites Decatur', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2092, 'DFWGV', 'Courtyard Dallas DFW Airport North/Grapevine', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2093, 'DFWRD', 'Residence Inn Denton', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2094, 'DFWRW', 'Residence Inn Fort Worth Cultural District', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2095, 'DFWTD', 'TownePlace Suites Fort Worth Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2096, 'DMOFI', 'Fairfield Inn & Suites Warrensburg', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2097, 'DTTTS', 'TownePlace Suites Detroit Troy', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2098, 'DTWFT', 'Fairfield Inn & Suites Detroit Troy', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2099, 'DTWXC', 'Fairfield Inn & Suites Detroit Canton', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2100, 'DTWYC', 'TownePlace Suites Detroit Canton', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2101, 'EISAK', 'Scrub Island Resort, Spa & Marina, Autograph Collection', '', '', '', '', 'British virgin islands', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2102, 'ELPCE', 'Courtyard by Marriott El Paso East/I-10', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2103, 'ELPTX', 'El Paso Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2104, 'EUGCO', 'Courtyard Corvallis', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2105, 'EUGFI', 'Fairfield Inn & Suites Eugene East/Springfield', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2106, 'EVVFW', 'Fairfield Inn Evansville West', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2107, 'EWRBK', 'Courtyard by Marriott Cranbury South Brunswick', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2108, 'EWRFS', 'Fairfield Inn & Suites Newark Liberty International Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2109, 'EWRJR', 'Residence Inn Jersey City', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2110, 'EWRNP', 'Residence Inn Neptune at Gateway Centre', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2111, 'EWROG', 'Residence Inn West Orange', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2112, 'EWRPX', 'Fairfield Inn & Suites Paramus', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2113, 'EWRSB', 'Saddle Brook Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2114, 'EWRWT', 'Courtyard Wall at Monmouth Shores Corporate Park', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2115, 'FAISH', 'SpringHill Suites Fairbanks', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2116, 'FAYSP', 'TownePlace Suites Southern Pines Aberdeen', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2117, 'FKLTS', 'TownePlace Suites Grove City Mercer/Outlets', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2118, 'FKRCY', 'Courtyard Fredericksburg Historic District', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2119, 'FLLCY', 'Courtyard Fort Lauderdale East', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2120, 'FSDCY', 'Courtyard Sioux Falls', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2121, 'FSDSH', 'SpringHill Suites Sioux Falls', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2122, 'GBRCY', 'Courtyard Lenox Berkshires', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2123, 'GBRFI', 'Fairfield Inn & Suites Lenox Great Barrington/Berkshires', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2124, 'GCMGC', 'Grand Cayman Marriott Beach Resort', '', '', '', '', 'Cayman islands', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2125, 'GDLAC', 'AC Hotel Guadalajara, Mexico', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2126, 'GEOMC', 'Guyana Marriott Hotel Georgetown', '', '', '', '', 'Guyana', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2127, 'GFLCY', 'Courtyard Lake George', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2128, 'GNVOC', 'Courtyard Ocala', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2129, 'GNVSH', 'SpringHill Suites Gainesville', '', '', '', '', 'united states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2130, 'GRRGS', 'SpringHill Suites Grand Rapids West', '', '', '', '', 'United States', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2131, 'GSODT', 'Greensboro Marriott Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2132, 'GUACY', 'Courtyard Guatemala City', '', '', '', '', 'Guatemala', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2133, 'GYECY', 'Courtyard Guayaquil', '', '', '', '', 'Ecuador', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2134, 'HARCY', 'Courtyard Harrisburg Hershey', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2135, 'HARRI', 'Residence Inn Harrisburg Carlisle', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2136, 'HARTS', 'TownePlace Suites Harrisburg Hershey', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2137, 'HARWM', 'Courtyard Harrisburg West/Mechanicsburg', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2138, 'HMOCY', 'Courtyard Hermosillo', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2139, 'HNLOA', 'Courtyard Oahu North Shore', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2140, 'HOTCY', 'Courtyard Hot Springs', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2141, 'HOUCF', 'Courtyard Houston Sugar Land/Lake Pointe', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2142, 'HOUGP', 'Houston Marriott North', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2143, 'HOUPS', 'Courtyard Houston I-10 West/Park Row', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2144, 'HOURN', 'Residence Inn Houston Northwest/Cypress', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2145, 'HOUTM', 'Residence Inn Houston Tomball', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2146, 'HOUYP', 'Courtyard Houston Northwest/Cypress', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2147, 'HOUZN', 'SpringHill Suites Houston Northwest', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2148, 'HPNNB', 'Courtyard Newburgh Stewart Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2149, 'HSVWE', 'SpringHill Suites Huntsville West/Research Park', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2150, 'HVNUN', 'Fairfield Inn & Suites Uncasville', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2151, 'IADHR', 'Residence Inn Herndon Reston', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2152, 'IAGCY', 'Courtyard Niagara Falls', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2153, 'IAGMC', 'Niagara Falls Marriott on the Falls', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2154, 'ICTAK', 'Ambassador Hotel Wichita, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2155, 'ICTWE', 'Wichita Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2156, 'ILGBW', 'Courtyard Wilmington Brandywine', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2157, 'ILGUD', 'Courtyard Newark-University of Delaware', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2158, 'ILGWD', 'Residence Inn Wilmington Downtown', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2159, 'INDIF', 'Fairfield Inn & Suites Indianapolis Fishers', '', '', '', '', 'united states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2160, 'INDNO', 'Indianapolis Marriott North', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2161, 'ISPRH', 'Residence Inn New York Long Island - East End', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2162, 'ITHCY', 'Courtyard Ithaca Airport/University', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2163, 'ITHMC', 'Ithaca Marriott Downtown on the Commons', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2164, 'JANSH', 'SpringHill Suites Jackson Ridgeland/The Township at Colony Park', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2165, 'JAXCB', 'Courtyard St. Augustine Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2166, 'JAXCO', 'Courtyard Jacksonville Orange Park', '', '', '', '', 'united states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2167, 'JAXCS', 'Courtyard St. Augustine I-96', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2168, 'JAXFL', 'Jacksonville Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2169, 'JAXJB', 'Fairfield Inn & Suites Jacksonville Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2170, 'JAXNE', 'Courtyard Jacksonville I-295/East Beltway', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2171, 'JAXST', 'Fairfield Inn & Suites St. Augustine I-95', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2172, 'JENCH', 'Courtyard Hutchinson Island Oceanside/Jensen Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2173, 'KINCY', 'Courtyard Kingston, Jamaica', '', '', '', '', 'Jamaica', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2174, 'KOACY', 'Courtyard King Kamehameha\'s Kona Beach Hotel', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2175, 'LANEA', 'East Lansing Marriott at University Place', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2176, 'LAXAD', 'Courtyard Anaheim Resort/Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2177, 'LAXAM', 'Fairfield Inn Anaheim Hills Orange County', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2178, 'LAXCV', 'Courtyard Los Angeles Westside', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2179, 'LAXCY', 'Courtyard Los Angeles LAX/Century Boulevard', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2180, 'LAXLM', 'JW Marriott Santa Monica Le Merigot', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2181, 'LCHSL', 'Fairfield Inn & Suites Lake Charles Sulphur', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2182, 'LGAFI', 'Fairfield Inn New York LaGuardia Airport/Flushing', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2183, 'LGVFS', 'Fairfield Inn & Suites Marshall', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2184, 'LIMDT', 'JW Marriott Hotel Lima', '', '', '', '', 'Peru', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2185, 'LIMLM', 'Courtyard Lima Miraflores', '', '', '', '', 'Peru', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2186, 'LIREL', 'El Mangroove, Autograph Collection', '', '', '', '', 'Costa rica', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2187, 'LITCN', 'Courtyard Little Rock North', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2188, 'LYHFI', 'Fairfield Inn & Suites Lynchburg Liberty University', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2189, 'MBSFR', 'Fairfield Inn & Suites Frankenmuth', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2190, 'MBSRI', 'Residence Inn Saginaw', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2191, 'MBSSG', 'SpringHill Suites Saginaw', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2192, 'MBSSH', 'SpringHill Suites Frankenmuth', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2193, 'MBSTP', 'TownePlace Suites Saginaw', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2194, 'MCIAA', 'Ambassador Hotel Kansas City, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2195, 'MCIAP', 'Kansas City Airport Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2196, 'MCIKS', 'Courtyard Kansas City Downtown/Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2197, 'MCIPL', 'Kansas City Marriott Country Club Plaza', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2198, 'MCISR', 'Residence Inn Kansas City Downtown/Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2199, 'MCIXA', 'SpringHill Suites Kansas City Lenexa/City Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2200, 'MCOBN', 'Courtyard Orlando Lake Buena Vista at Vista Centre', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2201, 'MCOCR', 'TownePlace Suites Orlando at Flamingo Crossings/Western Entrance', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2202, 'MCOFM', 'SpringHill Suites Orlando at Flamingo Crossings/Western Entrance', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2203, 'MCOGP', 'Gaylord Palms Resort & Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2204, 'MCOKX', 'Fairfield Inn & Suites Orlando Kissimmee/Celebration', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2205, 'MCORL', 'Residence Inn Orlando Lake Buena Vista', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2206, 'MCOUS', 'Fairfield Inn & Suites Orlando Near Universal Orlando Resort', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2207, 'MCOZD', 'Residence Inn Orlando Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2208, 'MDEMC', 'Medellin Marriott Hotel', '', '', '', '', 'Colombia', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2209, 'MDWMU', 'SpringHill Suites Chicago Southeast/Munster, IN', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2210, 'MEMHV', 'Courtyard Memphis Southaven', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2211, 'MEMTH', 'Residence Inn Memphis Southaven', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2212, 'MEXCY', 'Courtyard Mexico City Airport', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2213, 'MEXFI', 'Fairfield Inn &amp; Suites Mexico City Vallejo', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2214, 'MEXIX', 'Ixtapan de la Sal Marriott Hotel, Spa &amp; Convention Center', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2215, 'MEXJW', 'JW Marriott Hotel Mexico City', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2216, 'MEXMC', 'Mexico City Marriott Reforma Hotel', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2217, 'MEXSF', 'JW Marriott Hotel Mexico City Santa Fe', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2218, 'MEXVJ', 'Courtyard Mexico City Vallejo', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2219, 'MFETS', 'TownePlace Suites McAllen Edinburg', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2220, 'MGMMM', 'Montgomery Marriott Prattville Hotel & Conference Center at Capitol Hill', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2221, 'MGWCY', 'Courtyard Morgantown', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2222, 'MIAAK', 'Winter Haven, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2223, 'MIABM', 'Blue Moon Hotel, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2224, 'MIACO', 'Residence Inn Miami Coconut Grove', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2225, 'MIAHS', 'Courtyard Miami Homestead', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2226, 'MIATM', 'TownePlace Suites Miami Homestead', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2227, 'MKEAP', 'Fairfield Inn & Suites Milwaukee Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2228, 'MLUWM', 'Fairfield Inn & Suites West Monroe', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2229, 'MOBBR', 'The Battle House Renaissance Mobile Hotel & Spa', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2230, 'MSLMC', 'Marriott Shoals Hotel & Spa', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2231, 'MSNWD', 'Fairfield Inn & Suites Wisconsin Dells', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2232, 'MSPAC', 'AC Hotel Bloomington Mall of America', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2233, 'MSPDA', 'Residence Inn Minneapolis Edina', '', '', '', '', 'United states', 1, 0, 4, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2234, 'MSPMN', 'Minneapolis Airport Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2235, 'MSPNW', 'Minneapolis Marriott Northwest', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2236, 'MSYQC', 'Q&C HotelBar New Orleans, Autograph Collection?', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2237, 'MTHCY', 'Courtyard Key Largo', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2238, 'NASAK', 'Atlantis, Royal Towers, Autograph Collection', '', '', '', '', 'Bahamas', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2239, 'NASBT', 'Atlantis, Beach Tower, Autograph Collection', '', '', '', '', 'Bahamas', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2240, 'NASCT', 'Atlantis, Coral Towers, Autograph Collection', '', '', '', '', 'Bahamas', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2241, 'NASCV', 'The Cove Atlantis, Autograph Collection', '', '', '', '', 'Bahamas', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2242, 'NASCY', 'Courtyard Nassau Downtown/Junkanoo Beach', '', '', '', '', 'Bahamas', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2243, 'NASRT', 'The Reef Atlantis, Autograph Collection', '', '', '', '', 'Bahamas', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2244, 'NOGFI', 'Fairfield Inn &amp; Suites Nogales', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2245, 'NYCBL', 'Courtyard Westbury Long Island', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2246, 'NYCBX', 'Residence Inn New York The Bronx at Metro Center Atrium', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2247, 'NYCFM', 'Fairfield Inn & Suites New York Manhattan/Downtown East', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2248, 'NYCJF', 'Courtyard New York JFK Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2249, 'NYCML', 'Melville Marriott Long Island', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2250, 'NYCQC', 'SpringHill Suites New York LaGuardia Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2251, 'NYCRE', 'Fairfield Inn & Suites New York Downtown Manhattan/World Trade Center Area', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2252, 'OCWFI', 'Fairfield Inn & Suites Washington', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2253, 'OKCAK', 'Ambassador Hotel Oklahoma City, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2254, 'OKCDC', 'SpringHill Suites Oklahoma City Midwest City/Del City', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2255, 'OMAFR', 'Fairfield Inn & Suites Fremont', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2256, 'OMALV', 'Courtyard Omaha La Vista', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2257, 'OWBFI', 'Fairfield Inn Owensboro', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2258, 'PAPMC', 'Marriott Port-au-Prince Hotel', '', '', '', '', 'Haiti', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2259, 'PBCCY', 'Courtyard Puebla Las Animas', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2260, 'PBCMC', 'Marriott Puebla Hotel Meson del Angel', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2261, 'PBIBB', 'Courtyard Boynton Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2262, 'PBIFD', 'Fairfield Inn & Suites Delray Beach I-95', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2263, 'PBIPG', 'Palm Beach Gardens Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2264, 'PBIRI', 'Residence Inn Delray Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2265, 'PBMCY', 'Courtyard Paramaribo', '', '', '', '', 'Suriname', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2266, 'PDXAK', 'Hi-Lo Hotel, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2267, 'PHFOY', 'Newport News Marriott at City Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2268, 'PHLKP', 'SpringHill Suites Philadelphia Valley Forge/King of Prussia', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2269, 'PHLMA', 'Residence Inn Philadelphia Great Valley/Malvern', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2270, 'PHLSM', 'SpringHill Suites Mt. Laurel Cherry Hill', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2271, 'PHLSW', 'TownePlace Suites Swedesboro Philadelphia', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2272, 'PHXAC', 'AC Hotel Phoenix Tempe/Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2273, 'PHXAP', 'Phoenix Airport Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2274, 'PHXMP', 'Fairfield Inn & Suites Phoenix Tempe/Airport', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2275, 'PHXTW', 'Residence Inn Phoenix Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2276, 'PITCR', 'Residence Inn Pittsburgh Cranberry Township', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2277, 'PITMC', 'Pittsburgh Airport Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2278, 'PITRR', 'TownePlace Suites Pittsburgh Cranberry Township', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2279, 'PNSPB', 'SpringHill Suites Pensacola Beach', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2280, 'PNSTF', 'TownePlace Suites Foley at OWA', '', '', '', '', 'United States', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2281, 'POSCY', 'Courtyard Port of Spain', '', '', '', '', 'Trinidad and tobago', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2282, 'PRHFI', 'Fairfield Inn Port Huron', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2283, 'PSMEX', 'Fairfield Inn & Suites Portsmouth Exeter', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2284, 'PSMRI', 'Residence Inn Portsmouth', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2285, 'PTLAL', 'Grand Hotel Marriott Resort, Golf Club & Spa', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2286, 'PTYAR', 'AC Hotel Panama City', '', '', '', '', 'Panama', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2287, 'PTYCY', 'Courtyard Panama at Multiplaza Mall', '', '', '', '', 'Panama', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2288, 'PTYER', 'Marriott Executive Apartments Panama City, Finisterre', '', '', '', '', 'Panama', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2289, 'PTYKP', 'The Buenaventura Golf &; Beach Resort Panama, Autograph Collection', '', '', '', '', 'Panama', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2290, 'PTYMM', 'Courtyard Panama at Metromall Mall', '', '', '', '', 'Panama', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2291, 'PTYPA', 'Panama Marriott Hotel', '', '', '', '', 'Panama', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2292, 'PVRMX', 'Marriott Puerto Vallarta Resort & Spa', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2293, 'PWMAB', 'Residence Inn by Marriott Auburn', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2294, 'PWMAP', 'Portland Marriott at Sable Oaks', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2295, 'PWMBW', 'Fairfield Inn & Suites Brunswick Freeport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2296, 'PYMFM', 'Fairfield Inn Plymouth Middleboro', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2297, 'QROCY', 'Courtyard Queretaro', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2298, 'QROPT', 'Fairfield Inn &amp; Suites Queretaro Juriquilla', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2299, 'QROQA', 'AC Hotel Queretaro Antea', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2300, 'RALTS', 'TownePlace Suites San Bernardino Loma Linda', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2301, 'RDUAY', 'Fairfield Inn & Suites Raleigh Cary', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2302, 'RDUCV', 'Durham Marriott City Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2303, 'RDUMC', 'Raleigh Marriott City Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2304, 'RICMW', 'Richmond Marriott Short Pump', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2305, 'RKHCY', 'Courtyard Rock Hill', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2306, 'RNOCY', 'Courtyard Reno', '', '', '', '', 'United States', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2307, 'ROASL', 'Fairfield Inn & Suites Roanoke Salem', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2308, 'ROCCH', 'Courtyard Rochester Brighton', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2309, 'ROCCY', 'Courtyard Rochester East/Penfield', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2310, 'ROCRI', 'Residence Inn Rochester West/Greece', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2311, 'ROCWB', 'Fairfield Inn Rochester East', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2312, 'RQXFI', 'Fairfield Inn &amp; Suites Burlington', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2313, 'RSWFS', 'Fairfield Inn & Suites Naples', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2314, 'RSWNS', 'SpringHill Suites Naples', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2315, 'RWLFI', 'Fairfield Inn & Suites Rawlins', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2316, 'SALCY', 'Courtyard San Salvador', '', '', '', '', 'El salvador', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2317, 'SALFI', 'Fairfield by Marriott San Salvador', '', '', '', '', 'El salvador', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2318, 'SANCD', 'Courtyard San Diego Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2319, 'SANCG', 'Courtyard San Diego Gaslamp/Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2320, 'SANCM', 'Courtyard San Diego Mission Valley/Hotel Circle', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2321, 'SANES', 'Fairfield Inn & Suites San Diego North/San Marcos', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2322, 'SANFI', 'Fairfield Inn & Suites San Diego Old Town', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2323, 'SANOT', 'Courtyard San Diego Old Town', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2324, 'SANYR', 'Renaissance San Diego Hotel', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2325, 'SATBF', 'Fairfield Inn & Suites New Braunfels', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2326, 'SATNB', 'Courtyard New Braunfels River Village', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2327, 'SAVFD', 'Fairfield Inn & Suites Savannah Downtown/Historic District', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2328, 'SAVMD', 'Fairfield Inn & Suites Savannah Midtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2329, 'SBPSH', 'SpringHill Suites Paso Robles Atascadero', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2330, 'SCECO', 'Fairfield Inn & Suites State College', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2331, 'SCESH', 'SpringHill Suites State College', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2332, 'SCLBR', 'Renaissance Santiago Hotel', '', '', '', '', 'Chile', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2333, 'SCLCS', 'Courtyard Santiago Las Condes', '', '', '', '', 'Chile', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2334, 'SCLDT', 'Santiago Marriott Hotel', '', '', '', '', 'Chile', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2335, 'SDQCY', 'Courtyard Santo Domingo', '', '', '', '', 'Dominican republic', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2336, 'SDQGW', 'Renaissance Santo Domingo Jaragua Hotel &amp; Casino', '', '', '', '', 'Dominican republic', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2337, 'SDQJW', 'JW Marriott Hotel Santo Domingo', '', '', '', '', 'Dominican republic', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2338, 'SEATL', 'TownePlace Suites Tacoma Lakewood', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2339, 'SEAUD', 'Residence Inn Seattle University District', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2340, 'SEGBL', 'Fairfield Inn & Suites Bloomsburg', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2341, 'SFOFN', 'Courtyard Fairfield Napa Valley Area', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2342, 'SFOFW', 'San Francisco Marriott Fisherman\'s Wharf', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2343, 'SHDFI', 'Fairfield Inn & Suites Harrisonburg', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2344, 'SJCAK', 'Hotel Paradox, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2345, 'SJDFI', 'Fairfield Inn Los Cabos', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2346, 'SJDJW', 'JW Marriott Los Cabos Beach Resort & Spa', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2347, 'SJOAP', 'Courtyard San Jose Airport Alajuela', '', '', '', '', 'Costa rica', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2348, 'SJOCR', 'Costa Rica Marriott Hotel San Jose', '', '', '', '', 'Costa rica', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2349, 'SJOCY', 'Courtyard San Jose Escazu', '', '', '', '', 'Costa rica', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2350, 'SJOJW', 'JW Marriott Guanacaste Resort & Spa', '', '', '', '', 'Costa rica', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2351, 'SJOLS', 'Los Suenos Marriott Ocean & Golf Resort', '', '', '', '', 'Costa rica', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2352, 'SJORI', 'Residence Inn San Jose Escazu', '', '', '', '', 'Costa rica', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2353, 'SJUAC', 'AC Hotel San Juan Condado', '', '', '', '', 'Puerto rico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2354, 'SJUBR', 'La Concha Renaissance San Juan Resort', '', '', '', '', 'Puerto rico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2355, 'SJUIV', 'Courtyard Isla Verde Beach Resort', '', '', '', '', 'Puerto rico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2356, 'SJUPR', 'San Juan Marriott Resort & Stellaris Casino', '', '', '', '', 'Puerto rico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2357, 'SKBRB', 'St. Kitts Marriott Resort & The Royal Beach Casino', '', '', '', '', 'Saint kitts and nevis', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2358, 'SLCJO', 'SpringHill Suites Salt Lake City-South Jordan', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2359, 'SLCPC', 'Park City Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2360, 'SLCSH', 'SpringHill Suites Salt Lake City Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2361, 'SLKCY', 'Courtyard Lake Placid', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2362, 'SLWCS', 'Courtyard Saltillo', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2363, 'SLWFI', 'Fairfield Inn &amp; Suites Saltillo', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2364, 'SNAAI', 'AC Hotel Irvine', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2365, 'SNADP', 'Laguna Cliffs Marriott Resort & Spa', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2366, 'SPAWE', 'Residence Inn By Marriott Spartanburg Westgate', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2367, 'SRQAK', 'Waterline Marina Resort & Beach Club, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2368, 'SRQBD', 'Courtyard Bradenton Sarasota/Riverfront', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2369, 'STLDW', 'Courtyard St. Louis Downtown/Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2370, 'STLSA', 'Renaissance St. Louis Airport Hotel', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2371, 'STLXC', 'Courtyard St Louis Chesterfield', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2372, 'TCLSH', 'SpringHill Suites Tuscaloosa', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2373, 'TGUMC', 'Tegucigalpa Marriott Hotel', '', '', '', '', 'Honduras', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2374, 'TGZMC', 'Marriott Tuxtla Gutierrez Hotel', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2375, 'TIJMC', 'Tijuana Marriott Hotel', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2376, 'TLCCY', 'Courtyard Toluca Airport', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2377, 'TLCTM', 'Courtyard Toluca Tollocan', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2378, 'TOLGP', 'Renaissance Toledo Downtown Hotel', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2379, 'TPAAK', 'Epicurean Hotel, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2380, 'TPAPC', 'Fairfield Inn & Suites Lakeland Plant City', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2381, 'TPASH', 'SpringHill Suites Tampa Westshore Airport', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2382, 'TPATI', 'Residence Inn St. Petersburg Treasure Island', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2383, 'TPAWE', 'Tampa Marriott Westshore', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2384, 'TPAXL', 'TownePlace Suites Lakeland', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2385, 'TRITN', 'Fairfield Inn & Suites Johnson City', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2386, 'TTNTC', 'TownePlace Suites Cranbury South Brunswick', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2387, 'TULAK', 'Ambassador Hotel Tulsa, Autograph Collection', '', '', '', '', 'United states', 1, 0, 3, '', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2388, 'TULBR', 'Renaissance Tulsa Hotel & Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2389, 'TUSAD', 'AC Hotel Tucson Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2390, 'TXKRI', 'Residence Inn Texarkana', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2391, 'TYRTR', 'Residence Inn Tyler', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2392, 'TYRVT', 'Fairfield Inn & Suites Van', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2393, 'TYSKD', 'Fairfield Inn & Suites Sevierville Kodak', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2394, 'TYSKX', 'Courtyard Knoxville Airport Alcoa', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2395, 'TYSMC', 'Knoxville Marriott', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2396, 'TYSSP', 'SpringHill Suites Pigeon Forge', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2397, 'UIODT', 'JW Marriott Hotel Quito', '', '', '', '', 'Ecuador', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2398, 'VERAC', 'AC Hotel Veracruz', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2399, 'VPSCY', 'Courtyard Sandestin at Grand Boulevard', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2400, 'VPSRI', 'Residence Inn Sandestin at Grand Boulevard', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2401, 'VSAFI', 'Fairfield Inn & Suites Villahermosa Tabasc', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2402, 'VSAMC', 'Villahermosa Marriott Hotel', '', '', '', '', 'Mexico', 1, 0, 3, 'Caribbean Latin America', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2403, 'WASEM', 'Courtyard Washington Embassy Row', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2404, 'WASFC', 'Fairfield Inn & Suites Washington, DC/Downtown', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2405, 'WASGN', 'Gaylord National Resort & Convention Center', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2406, 'WASNW', 'Courtyard Washington, DC/Dupont Circle', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2407, 'WASNY', 'Courtyard Washington Capitol Hill/Navy Yard', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2408, 'WASVY', 'Courtyard Chevy Chase', '', '', '', '', 'United states', 1, 0, 3, 'Americas East', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2409, 'WCOLL', 'Fairfield Inn & Suites Waco North', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2410, 'WCOSH', 'SpringHill Suites Waco Woodway', '', '', '', '', 'United states', 1, 0, 3, 'Americas West', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2411, 'YEGFI', 'Fairfield Inn & Suites Edmonton North', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2412, 'YEGTS', 'TownePlace Suites Edmonton South', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2413, 'YHZDM', 'Delta Hotels Dartmouth', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2414, 'YKDTS', 'TownePlace Suites Kincardine', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2415, 'YLWFI', 'Fairfield Inn & Suites Kelowna', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2416, 'YMYMT', 'Residence Inn Mont Tremblant Manoir Labelle', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2417, 'YOWCY', 'Courtyard Ottawa Downtown', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2418, 'YQBCQ', 'Courtyard Quebec City', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2419, 'YQBMC', 'Quebec City Marriott Downtown', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2420, 'YQMFI', 'Fairfield Inn & Suites Moncton', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2421, 'YQRDR', 'Delta Hotels Regina', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2422, 'YQRRI', 'Residence Inn Regina', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2423, 'YULAP', 'Courtyard Montreal Airport', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2424, 'YULFI', 'Fairfield Inn & Suites Montreal Airport', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2425, 'YULRA', 'Residence Inn Montreal Airport', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2426, 'YULSH', 'SpringHill Suites By Marriott Old Montreal', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2427, 'YVRDR', 'Residence Inn Vancouver Downtown', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2428, 'YWGFI', 'Fairfield Inn & Suites Winnipeg', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2429, 'YYCCR', 'Residence Inn Calgary South', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2430, 'YYJMC', 'Victoria Marriott Inner Harbour', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2431, 'YYTCY', 'Courtyard St. John\'s Newfoundland', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2432, 'YYTDS', 'Delta Hotels St. John\'s Conference Centre', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2433, 'YYZMT', 'Courtyard Toronto Northeast/Markham', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2434, 'YYZTS', 'TownePlace Suites Mississauga-Airport Corporate Centre', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11'),
	(2435, 'YYZXM', 'TownePlace Suites Toronto Northeast/Markham', '', '', '', '', 'Canada', 1, 0, 3, 'Canada', 0, 1, '2018-02-03 03:54:11', 1, '2018-02-03 03:54:11');
/*!40000 ALTER TABLE `client_entity` ENABLE KEYS */;

-- Dumping structure for table galileo.client_entity_feb_8
CREATE TABLE IF NOT EXISTS `client_entity_feb_8` (
  `client_entity_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `client_entity_region` varchar(255) NOT NULL DEFAULT '',
  `client_entity_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `client_entity_created_by` int(11) NOT NULL DEFAULT '0',
  `client_entity_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `client_entity_modified_by` int(11) NOT NULL DEFAULT '0',
  `client_entity_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`client_entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.client_entity_feb_8: ~186 rows (approximately)
/*!40000 ALTER TABLE `client_entity_feb_8` DISABLE KEYS */;
INSERT INTO `client_entity_feb_8` (`client_entity_id`, `client_entity_marsha_code`, `client_entity_hotel_name`, `client_entity_street`, `client_entity_city`, `client_entity_state`, `client_entity_zipcode`, `client_entity_country`, `client_entity_client_id`, `client_entity_user_id`, `client_entity_division_id`, `client_entity_region`, `client_entity_record_status`, `client_entity_created_by`, `client_entity_created_on`, `client_entity_modified_by`, `client_entity_modified_on`) VALUES
	(2, 'EVNMC', 'MH Yerevan', '', '', '', '', 'Armenia', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(3, 'LNZCY', 'CY Linz', '', '', '', '', 'Austria', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(4, 'VIEAT', 'MH Vienna', '', '', '', '', 'Austria', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(5, 'VIECY', 'CY Vienna Schoenbrunn', '', '', '', '', 'Austria', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(6, 'VIEFG', 'CY Vienna Messe', '', '', '', '', 'Austria', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(7, 'VIEHW', 'RH Vienna', '', '', '', '', 'Austria', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(8, 'VIEOX', 'OX Vienna', '', '', '', '', 'Austria', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(9, 'VIESE', 'RH Vienna Imperial Riding School', '', '', '', '', 'Austria', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(10, 'GYDJW', 'JW Baku', '', '', '', '', 'Azerbaijan', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(11, 'MHPBR', 'RH Minsk', '', '', '', '', 'Belarus', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(12, 'BRUBR', 'RH Brussels', '', '', '', '', 'Belgium', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(13, 'BRUCY', 'CY Brussels', '', '', '', '', 'Belgium', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(14, 'BRUDT', 'MH Brussels', '', '', '', '', 'Belgium', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(15, 'GNEMC', 'MH Ghent', '', '', '', '', 'Belgium', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(16, 'BRQCY', 'CY Brno', '', '', '', '', 'Czech republic', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(17, 'PRGAK', 'AK Boscolo Prague', '', '', '', '', 'Czech republic', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(18, 'PRGCY', 'CY Prague City', '', '', '', '', 'Czech republic', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(19, 'PRGDT', 'MH Prague', '', '', '', '', 'Czech republic', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(20, 'PRGPA', 'CY Prague Airport', '', '', '', '', 'Czech republic', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(21, 'PRGPZ', 'CY Pilzen', '', '', '', '', 'Czech republic', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(22, 'CPHAC', 'AC Bella Sky Copenhagen', '', '', '', '', 'Denmark', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(23, 'CPHDK', 'MH Copenhagen', '', '', '', '', 'Denmark', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(24, 'MCMCD', 'MH Cap D\'Ail', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(25, 'MRSAR', 'AC Marseille', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(26, 'NCEAC', 'AC Nice', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(27, 'NCEAK', 'AK Boscolo Exedra Nice', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(28, 'NCEJW', 'JW Cannes', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(29, 'PARAL', 'AC Paris le Bourget', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(30, 'PARAR', 'AC Paris Porte Maillot', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(31, 'PARBB', 'CY Paris Boulogne', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(32, 'PARCF', 'CY Paris Colombes', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(33, 'PARDT', 'MH Paris Champs-Elysees', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(34, 'PARLD', 'RH Paris La Defense', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(35, 'PARMC', 'MH Paris Charles de Gaulle Airport', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(36, 'PAROA', 'MH Paris Opera Ambassador', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(37, 'PARPR', 'RH Paris Republique', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(38, 'PARSD', 'CY Paris Saint Denis', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(39, 'PARSP', 'RH Paris Le Parc Trocad?ro', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(40, 'PARST', 'MH Paris Rive Gauche', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(41, 'PARVD', 'RH Paris Vendome', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(42, 'PARWG', 'RH Paris Arc de Triomphe', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(43, 'PARXA', 'Courtyard Paris Charles de Gaulle Airport', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(44, 'TLSCY', 'CY Toulouse Airport', '', '', '', '', 'France', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(45, 'TBSMC', 'MH Tbilisi', '', '', '', '', 'Georgia', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(46, 'BERAK', 'AK Berlin', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(47, 'BERMC', 'MH Berlin', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(48, 'BERMT', 'CY Berlin City Center', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(49, 'CGNCY', 'CY Cologne', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(50, 'CGNMC', 'MH Cologne', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(51, 'DUSCY', 'CY Duesseldorf Seestern', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(52, 'DUSHF', 'CY Duesseldorf Hafen', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(53, 'DUSRN', 'RH Duesseldorf', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(54, 'FRADT', 'MH Frankfurt', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(55, 'FRAOH', 'OX Frankfurt City East', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(56, 'FRAWB', 'CY Wiesbaden-Nordenstadt', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(57, 'HAMDT', 'MH Hamburg', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(58, 'HAMRN', 'RH Hamburg', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(59, 'HDBMC', 'MH Heidelberg', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(60, 'LEJDT', 'MH Leipzig', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(61, 'MUCCY', 'CY Munich City Center', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(62, 'MUCFR', 'MH Munich Airport', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(63, 'MUCNO', 'MH Munich', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(64, 'ZPZDE', 'MH Stuttgart Sindelfingen', '', '', '', '', 'Germany', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(65, 'BUDAK', 'AK Boscolo Budapest', '', '', '', '', 'Hungary', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(66, 'BUDCY', 'CY Budapest', '', '', '', '', 'Hungary', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(67, 'BUDHU', 'MH Budapest', '', '', '', '', 'Hungary', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(68, 'DUBAK', 'AK Powerscourt', '', '', '', '', 'Ireland', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(69, 'DUBBR', 'RH The Shelbourne', '', '', '', '', 'Ireland', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(70, 'LCVBR', 'RH Tuscany Il Ciocco Resort & Spa', '', '', '', '', 'Italy', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(71, 'MILEX', 'AK Boscolo Milano', '', '', '', '', 'Italy', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(72, 'MILIT', 'Milan Marriott Hotel', '', '', '', '', 'Italy', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(73, 'ROMCP', 'CY Rome Central Park', '', '', '', '', 'Italy', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(74, 'ROMEX', 'AK Boscolo Exedra Roma', '', '', '', '', 'Italy', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(75, 'VCEJW', 'JW Venice', '', '', '', '', 'Italy', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(76, 'TSEMC', 'MH Astana', '', '', '', '', 'Kazakhstan', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(77, 'SKPMC', 'MH Skopje', '', '', '', '', 'Macedonia', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(78, 'AMSCY', 'CY Amsterdam Airport', '', '', '', '', 'Netherlands', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(79, 'AMSNT', 'MH Amsterdam', '', '', '', '', 'Netherlands', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(80, 'AMSRD', 'RH Amsterdam', '', '', '', '', 'Netherlands', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(81, 'RTMMC', 'MH The Hague', '', '', '', '', 'Netherlands', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(82, 'WAWCY', 'CY Warsaw Airport', '', '', '', '', 'Poland', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(83, 'WAWPL', 'MH Warsaw', '', '', '', '', 'Poland', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(84, 'LISAK', 'AK Fontecruz Lisboa', '', '', '', '', 'Portugal', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(85, 'LISPT', 'MH Lisbon', '', '', '', '', 'Portugal', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(86, 'BUHRO', 'JW Bucharest', '', '', '', '', 'Romania', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(87, 'AERMC', 'MH Sochi Krasnaya Polyana', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(88, 'KUFBR', 'RH Samara', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(89, 'LEDBR', 'RH St. Petersburg', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(90, 'LEDCY', 'CY St. Petersburg Vasiliewsky', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(91, 'MOWBR', 'RH Moscow Monarch Centre', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(92, 'MOWCY', 'CY Moscow City Centre', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(93, 'MOWDT', 'MH Moscow Royal Aurora', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(94, 'MOWGR', 'MH Moscow Grand', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(95, 'MOWNA', 'MH Moscow Novy Arbat', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(96, 'MOWPV', 'CY Moscow Paveletskaya', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(97, 'MOWTV', 'MH Moscow Tverskaya', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(98, 'OVBMC', 'MH Novosibirsk', '', '', '', '', 'Russian federation', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(99, 'BEGCY', 'CY Belgrade', '', '', '', '', 'Serbia', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(100, 'CPTBR', 'Protea Hotel Cape Town Waterfront Breakwater Lodge', '', '', '', '', 'South africa', 1, 0, 2, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(101, 'CPTCF', 'Protea Hotel Fire & Ice Cape Town', '', '', '', '', 'South africa', 1, 0, 2, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(102, 'CPTST', 'Protea Hotel Stellenbosch', '', '', '', '', 'South africa', 1, 0, 2, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(103, 'DURED', 'Protea Hotel Durban Edward', '', '', '', '', 'South africa', 1, 0, 2, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(104, 'JNBMG', 'African Pride Mount Grace Country House & Spa', '', '', '', '', 'South africa', 1, 0, 2, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(105, 'JNBOR', 'Protea Hotel O.R. Tambo Airport', '', '', '', '', 'South africa', 1, 0, 2, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(106, 'PRYWA', 'Protea Hotel Pretoria Centurion', '', '', '', '', 'South africa', 1, 0, 2, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(107, 'BCNDM', 'RH Barcelona', '', '', '', '', 'Spain', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(108, 'STOCY', 'CY Stockholm Kungsholmen', '', '', '', '', 'Sweden', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(109, 'ZRHDT', 'MH Zurich', '', '', '', '', 'Switzerland', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(110, 'ADBBR', 'RH Izmir', '', '', '', '', 'Turkey', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(111, 'ESBJW', 'JW Ankara', '', '', '', '', 'Turkey', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(112, 'ISTCY', 'CY Istanbul Airport', '', '', '', '', 'Turkey', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(113, 'ISTDT', 'MH Istanbul Sisli', '', '', '', '', 'Turkey', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(114, 'ABZAP', 'MH Aberdeen', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(115, 'ABZCY', 'CY Aberdeen', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(116, 'ABZRI', 'RI Aberdeen', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(117, 'BHXAC', 'AC Birmingham', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(118, 'BHXBH', 'MH Birmingham', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(119, 'BLKBP', 'MH Preston', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(120, 'BOHBM', 'MH Bournemouth', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(121, 'BRSDT', 'MH Bristol City Centre', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(122, 'BRSRY', 'MH Bristol Royal', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(123, 'CBGHD', 'MH Huntingdon', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(124, 'CVTGS', 'MH Forest of Arden', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(125, 'CWLDT', 'MH Cardiff', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(126, 'CWLGS', 'MH St Pierre', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(127, 'EDIEB', 'MH Edinburgh', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(128, 'EDIHW', 'CY Edinburgh West', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(129, 'EDIRI', 'RI Edinburgh', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(130, 'EMAGS', 'MH Breadsall Priory', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(131, 'EMALM', 'MH Leicester', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(132, 'GLACA', 'CY Glasgow Airport', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(133, 'GLADT', 'MH Glasgow', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(134, 'LBADT', 'MH Leeds', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(135, 'LBAGS', 'MH Hollins Hall', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(136, 'LGWCY', 'CY London Gatwick Airport', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(137, 'LGWGS', 'MH Lingfield Park', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(138, 'LHRBR', 'RH London Heathrow', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(139, 'LHRHR', 'MH Heathrow', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(140, 'LHRSL', 'MH Heathrow Windsor', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(141, 'LONAK', 'AK Threadneedles', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(142, 'LONBH', 'MH Bexleyheath', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(143, 'LONCH', 'MH London County Hall', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(144, 'LONCW', 'MH London West India Quay', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(145, 'LONDT', 'MH London Grosvenor Square', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(146, 'LONER', 'MEA London', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(147, 'LONGH', 'JW London Grosvenor House', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(148, 'LONLM', 'MH London Kensington', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(149, 'LONMA', 'MH London Marble Arch', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(150, 'LONPL', 'MH London Park Lane', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(151, 'LONPR', 'RH London St. Pancras', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(152, 'LONRP', 'MH London Regents Park', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(153, 'LONSE', 'AK St. Ermin\'s', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(154, 'LONTW', 'MH London Twickenham', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(155, 'LONWA', 'MH Waltham Abbey', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(156, 'LONWH', 'MH London Maida Vale', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(157, 'LONXE', 'AK London Xenia', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(158, 'LPLLP', 'MH Liverpool', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(159, 'MANAC', 'AC Manchester', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(160, 'MANAP', 'MH Manchester Airport', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(161, 'MANBR', 'RH Manchester', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(162, 'MANGS', 'MH Worsley Park', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(163, 'MANVA', 'MH Manchester Victoria & Albert', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(164, 'NCLGF', 'MH Newcastle Gosforth Park', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(165, 'NCLGH', 'MH Newcastle MetroCentre', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(166, 'NCLSL', 'MH Sunderland', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(167, 'NWIGS', 'MH Sprowston Manor', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(168, 'ORMNH', 'MH Northampton', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(169, 'PMEHA', 'MH Portsmouth', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(170, 'QQYYK', 'MH York', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(171, 'SOUGS', 'MH Meon Valley', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(172, 'STNCH', 'MH Cheshunt', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(173, 'STNGS', 'MH Hanbury Manor', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(174, 'SWIDT', 'MH Swindon', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(175, 'SWSDT', 'MH Swansea', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(176, 'TDMGS', 'MH Tudor Park', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(177, 'XVHPB', 'MH Peterborough', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(178, 'XVUDM', 'MH Durham', '', '', '', '', 'United kingdom', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(179, 'LUNLS', 'Protea Hotel Lusaka', '', '', '', '', 'Zambia', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(180, 'LVILI', 'Protea Hotel Livingstone', '', '', '', '', 'Zambia', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(181, 'BUSAK', 'Paragraph Resort & Spa Shekvetili, Autograph Collection', '', '', '', '', '', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(182, 'FLRAK', 'Sina Villa Medici, Autograph Collection', '', '', '', '', '', 1, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(183, 'CLIENT CODE', 'Client Code Test', '', '', '', '', '', 2, 0, 1, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(184, 'CLIENT CODE NON EU', 'Client Code Test For Non EU', '', '', '', '', '', 2, 0, 2, '', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(185, 'Test', '1212', '1212', '1212', '12', '1212', '121', 2, 1, 1, '', 1, 1, '2018-01-12 08:54:27', 1, '2018-01-12 08:55:33'),
	(186, 'Test', '1212', '1212', '1212', '12', '1212', '121', 2, 1, 1, '', 1, 1, '2018-01-12 08:55:41', 1, '2018-01-12 08:55:45'),
	(187, 'asdfasdf', 'test', '', '', '', '', '', 1, 10, 1, '', 1, 10, '2018-01-12 17:52:14', 1, '2018-01-19 07:30:06');
/*!40000 ALTER TABLE `client_entity_feb_8` ENABLE KEYS */;

-- Dumping structure for table galileo.client_qb_reference
CREATE TABLE IF NOT EXISTS `client_qb_reference` (
  `client_qb_ref_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_qb_ref_client_id` int(11) NOT NULL DEFAULT '0',
  `client_qb_ref_division_id` int(11) NOT NULL DEFAULT '0',
  `client_qb_ref_qb_id` int(11) NOT NULL DEFAULT '0',
  `client_qb_ref_qb_class` int(11) NOT NULL DEFAULT '0',
  `client_qb_ref_record_status` int(11) NOT NULL DEFAULT '0',
  `client_qb_ref_created_by` int(11) NOT NULL DEFAULT '0',
  `client_qb_ref_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `client_qb_ref_modified_by` int(11) NOT NULL DEFAULT '0',
  `client_qb_ref_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`client_qb_ref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.client_qb_reference: ~2 rows (approximately)
/*!40000 ALTER TABLE `client_qb_reference` DISABLE KEYS */;
INSERT INTO `client_qb_reference` (`client_qb_ref_id`, `client_qb_ref_client_id`, `client_qb_ref_division_id`, `client_qb_ref_qb_id`, `client_qb_ref_qb_class`, `client_qb_ref_record_status`, `client_qb_ref_created_by`, `client_qb_ref_created_on`, `client_qb_ref_modified_by`, `client_qb_ref_modified_on`) VALUES
	(1, 1, 1, 463, 1, 0, 1, '2018-01-18 06:25:10', 1, '2018-01-23 12:31:34'),
	(2, 1, 2, 1, 1, 0, 1, '2018-01-18 06:25:25', 1, '2018-01-24 09:12:55');
/*!40000 ALTER TABLE `client_qb_reference` ENABLE KEYS */;

-- Dumping structure for table galileo.consultant_rate
CREATE TABLE IF NOT EXISTS `consultant_rate` (
  `cons_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `cons_rate_user_id` int(11) NOT NULL DEFAULT '0',
  `cons_rate_client_id` int(11) NOT NULL DEFAULT '0',
  `cons_rate_service_type_id` int(11) NOT NULL DEFAULT '0',
  `cons_rate_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `cons_rate_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `cons_rate_created_by` int(11) NOT NULL DEFAULT '0',
  `cons_rate_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cons_rate_modified_by` int(11) NOT NULL DEFAULT '0',
  `cons_rate_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`cons_rate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.consultant_rate: ~4 rows (approximately)
/*!40000 ALTER TABLE `consultant_rate` DISABLE KEYS */;
INSERT INTO `consultant_rate` (`cons_rate_id`, `cons_rate_user_id`, `cons_rate_client_id`, `cons_rate_service_type_id`, `cons_rate_per_unit`, `cons_rate_record_status`, `cons_rate_created_by`, `cons_rate_created_on`, `cons_rate_modified_by`, `cons_rate_modified_on`) VALUES
	(1, 3, 1, 1, 22.00, 0, 1, '2018-01-03 11:40:05', 1, '2018-01-03 11:40:05'),
	(2, 3, 1, 2, 33.00, 0, 1, '2018-01-03 11:40:15', 1, '2018-01-03 11:40:15'),
	(3, 13, 1, 4, 44.00, 1, 1, '2018-01-03 11:40:41', 10, '2018-02-02 06:18:09'),
	(4, 57, 1, 1, 18.00, 0, 10, '2018-02-02 06:18:47', 10, '2018-02-02 06:18:47');
/*!40000 ALTER TABLE `consultant_rate` ENABLE KEYS */;

-- Dumping structure for table galileo.consultant_skill
CREATE TABLE IF NOT EXISTS `consultant_skill` (
  `cons_skill_id` int(11) NOT NULL AUTO_INCREMENT,
  `cons_client_id` int(11) NOT NULL DEFAULT '0',
  `cons_user_id` int(11) NOT NULL DEFAULT '0',
  `cons_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `cons_created_by` int(11) NOT NULL DEFAULT '0',
  `cons_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cons_modified_by` int(11) NOT NULL DEFAULT '0',
  `cons_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`cons_skill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.consultant_skill: ~12 rows (approximately)
/*!40000 ALTER TABLE `consultant_skill` DISABLE KEYS */;
INSERT INTO `consultant_skill` (`cons_skill_id`, `cons_client_id`, `cons_user_id`, `cons_record_status`, `cons_created_by`, `cons_created_on`, `cons_modified_by`, `cons_modified_on`) VALUES
	(1, 1, 3, 0, 1, '2017-12-26 10:58:38', 1, '2017-12-26 10:59:02'),
	(2, 1, 4, 0, 1, '2017-12-26 10:58:51', 1, '2017-12-26 10:59:38'),
	(3, 1, 8, 0, 1, '2018-01-02 10:51:32', 1, '2018-01-02 10:51:32'),
	(4, 1, 6, 0, 1, '2018-01-02 10:51:40', 1, '2018-01-02 10:53:06'),
	(5, 1, 13, 0, 1, '2018-01-02 10:51:51', 10, '2018-02-19 13:53:58'),
	(6, 1, 5, 0, 1, '2018-01-02 10:51:57', 1, '2018-01-19 06:15:00'),
	(7, 1, 11, 1, 10, '2018-01-12 11:26:28', 10, '2018-01-12 11:27:51'),
	(8, 1, 11, 1, 10, '2018-01-12 11:27:59', 1, '2018-02-02 09:13:42'),
	(9, 1, 29, 1, 1, '2018-02-02 09:14:19', 1, '2018-02-02 09:18:10'),
	(10, 4, 19, 0, 10, '2018-02-14 12:24:06', 10, '2018-02-14 12:24:06'),
	(11, 4, 34, 0, 10, '2018-02-14 12:24:18', 10, '2018-02-14 12:24:18'),
	(12, 1, 1, 1, 1, '2018-02-15 12:40:16', 1, '2018-02-15 12:45:08');
/*!40000 ALTER TABLE `consultant_skill` ENABLE KEYS */;

-- Dumping structure for table galileo.consultant_skill_items
CREATE TABLE IF NOT EXISTS `consultant_skill_items` (
  `csi_id` int(11) NOT NULL AUTO_INCREMENT,
  `csi_skill_id` int(11) NOT NULL DEFAULT '0',
  `csi_service_type_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`csi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.consultant_skill_items: ~21 rows (approximately)
/*!40000 ALTER TABLE `consultant_skill_items` DISABLE KEYS */;
INSERT INTO `consultant_skill_items` (`csi_id`, `csi_skill_id`, `csi_service_type_id`) VALUES
	(5, 1, 1),
	(6, 1, 2),
	(7, 1, 3),
	(10, 2, 2),
	(11, 2, 5),
	(12, 3, 1),
	(17, 4, 2),
	(18, 4, 5),
	(26, 7, 2),
	(27, 7, 3),
	(38, 6, 1),
	(39, 6, 3),
	(40, 6, 4),
	(41, 6, 5),
	(42, 6, 7),
	(45, 8, 2),
	(46, 9, 64),
	(52, 10, 63),
	(53, 11, 63),
	(54, 12, 2),
	(55, 5, 7);
/*!40000 ALTER TABLE `consultant_skill_items` ENABLE KEYS */;

-- Dumping structure for table galileo.cron_jobs
CREATE TABLE IF NOT EXISTS `cron_jobs` (
  `cronId` int(11) NOT NULL AUTO_INCREMENT,
  `cronFile` varchar(256) NOT NULL,
  `cronDescription` mediumtext NOT NULL,
  `cronIsRun` int(11) NOT NULL COMMENT '0=>Not Run the File, 1=> Run the File',
  PRIMARY KEY (`cronId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table galileo.cron_jobs: ~1 rows (approximately)
/*!40000 ALTER TABLE `cron_jobs` DISABLE KEYS */;
INSERT INTO `cron_jobs` (`cronId`, `cronFile`, `cronDescription`, `cronIsRun`) VALUES
	(1, 'importCsvKeyword.php', 'Import Csv Task keyword in cron', 0),
	(2, 'updateRefreshToken.php', 'Update Referesh for quick books', 0);
/*!40000 ALTER TABLE `cron_jobs` ENABLE KEYS */;

-- Dumping structure for procedure galileo.deleteAdminPersonnel
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteAdminPersonnel`(`_userId` INT(11), `_userDeleteId` INT(11), `_dateTime` DATETIME)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE user.user_id = ',_userDeleteId);
	
	SET @IdQry1 = CONCAT(' UPDATE user SET user_record_status = 1 , user_modified_on = ',Quote(_dateTime), ', user_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteAlert
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteAlert`(
_userId INT(11),
_notificationId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE notification.notification_id = ',_notificationId);
	
	SET @IdQry1 = CONCAT(' UPDATE notification SET notification_record_status = 1 , notification_modified_on = ',Quote(_dateTime), ', notification_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteClient
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteClient`(
_userId INT(11),
_clientDelId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE client.client_id = ',_clientDelId);
	
	SET @IdQry1 = CONCAT(' UPDATE client SET client_record_status = 1 , client_modified_on = ',Quote(_dateTime), ', client_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteClientDivision
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteClientDivision`(
_userId INT(11),
_clientQbRefDeleteId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE client_qb_reference.client_qb_ref_id = ',_clientQbRefDeleteId);
	
	SET @IdQry1 = CONCAT(' UPDATE client_qb_reference SET client_qb_ref_record_status = 1 , client_qb_ref_modified_on = ',Quote(_dateTime), ', client_qb_ref_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteClientEntity
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteClientEntity`(
_userId INT(11),
_clientEntityId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE client_entity.client_entity_id = ',_clientEntityId);
	
	SET @IdQry1 = CONCAT(' UPDATE client_entity SET client_entity_record_status = 1 , client_entity_modified_on = ',Quote(_dateTime), ', client_entity_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteConsultantRate
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteConsultantRate`(
_userId INT(11),
_rateDelId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE consultant_rate.cons_rate_id = ',_rateDelId);
	
	SET @IdQry1 = CONCAT(' UPDATE consultant_rate SET cons_rate_record_status = 1 , cons_rate_modified_on = ',Quote(_dateTime), ', cons_rate_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteDivision
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteDivision`(
_userId INT(11),
_deleteId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE division.division_id = ',_deleteId);
	
	SET @IdQry1 = CONCAT(' UPDATE division SET division_record_status = 1 , division_modified_on = ',Quote(_dateTime), ', division_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteForm
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteForm`(
_userId INT(11),
_formDelId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE form.form_id = ',_formDelId);
	
	SET @IdQry1 = CONCAT(' UPDATE form SET form_record_status = 1 , form_modified_on = ',Quote(_dateTime), ', form_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteQbClassReference
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteQbClassReference`(
_userId INT(11),
_qbClassRefDeleteId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE qb_class_reference.qb_cls_ref_id = ',_qbClassRefDeleteId);
	
	SET @IdQry1 = CONCAT(' UPDATE qb_class_reference SET qb_cls_ref_record_status = 1 , qb_cls_ref_modified_on = ',Quote(_dateTime), ', qb_cls_ref_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteServiceType
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteServiceType`(
_userId INT(11),
_serviceTypeId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE service_type.serv_type_id = ',_serviceTypeId);
	
	SET @IdQry1 = CONCAT(' UPDATE service_type SET serv_type_record_status = 1 , serv_type_modified_on = ',Quote(_dateTime), ', serv_type_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteSkill
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteSkill`(
_userId INT(11),
_skillDelId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE consultant_skill.cons_skill_id = ',_skillDelId);
	
	SET @IdQry1 = CONCAT(' UPDATE consultant_skill SET cons_record_status = 1 , cons_modified_on = ',Quote(_dateTime), ', cons_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteTaskManagerContent
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteTaskManagerContent`(`_userId` INT(11), `_taskContentId` INT(11), `_dateTime` DATETIME)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_content SET task_content_record_status = 1 , task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.deleteTaskManagerKeyword
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `deleteTaskManagerKeyword`(`_userId` INT(11), `_taskKeywordId` INT(11), `_dateTime` DATETIME)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_record_status = 1 , task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for table galileo.division
CREATE TABLE IF NOT EXISTS `division` (
  `division_id` int(11) NOT NULL AUTO_INCREMENT,
  `division_code` varchar(50) NOT NULL DEFAULT '',
  `division_name` varchar(255) NOT NULL DEFAULT '',
  `division_client_id` int(11) NOT NULL DEFAULT '0',
  `division_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `division_created_by` int(11) NOT NULL DEFAULT '0',
  `division_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `division_modified_by` int(11) NOT NULL DEFAULT '0',
  `division_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`division_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.division: ~4 rows (approximately)
/*!40000 ALTER TABLE `division` DISABLE KEYS */;
INSERT INTO `division` (`division_id`, `division_code`, `division_name`, `division_client_id`, `division_record_status`, `division_created_by`, `division_created_on`, `division_modified_by`, `division_modified_on`) VALUES
	(1, '2546', '2546', 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(2, '2210', '2210', 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(3, '2712', '2712', 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(4, '2713', '2713', 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48');
/*!40000 ALTER TABLE `division` ENABLE KEYS */;

-- Dumping structure for table galileo.division_feb_8
CREATE TABLE IF NOT EXISTS `division_feb_8` (
  `division_id` int(11) NOT NULL AUTO_INCREMENT,
  `division_code` varchar(50) NOT NULL DEFAULT '',
  `division_name` varchar(255) NOT NULL DEFAULT '',
  `division_client_id` int(11) NOT NULL DEFAULT '0',
  `division_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `division_created_by` int(11) NOT NULL DEFAULT '0',
  `division_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `division_modified_by` int(11) NOT NULL DEFAULT '0',
  `division_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`division_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.division_feb_8: ~2 rows (approximately)
/*!40000 ALTER TABLE `division_feb_8` DISABLE KEYS */;
INSERT INTO `division_feb_8` (`division_id`, `division_code`, `division_name`, `division_client_id`, `division_record_status`, `division_created_by`, `division_created_on`, `division_modified_by`, `division_modified_on`) VALUES
	(1, 'EU', 'European Union hotels', 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(2, 'NON EU', 'Non European Union hotels', 1, 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48');
/*!40000 ALTER TABLE `division_feb_8` ENABLE KEYS */;

-- Dumping structure for table galileo.form
CREATE TABLE IF NOT EXISTS `form` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_user_id` int(11) NOT NULL DEFAULT '0',
  `form_client_id` int(11) NOT NULL DEFAULT '0',
  `form_first_name` varchar(255) NOT NULL DEFAULT '',
  `form_last_name` varchar(255) NOT NULL DEFAULT '',
  `form_email` varchar(100) NOT NULL DEFAULT '',
  `form_contact_no` varchar(50) NOT NULL DEFAULT '',
  `form_street` varchar(255) NOT NULL DEFAULT '',
  `form_city` varchar(255) NOT NULL DEFAULT '',
  `form_state` varchar(255) NOT NULL DEFAULT '',
  `form_zipcode` varchar(100) NOT NULL DEFAULT '',
  `form_country` varchar(255) NOT NULL DEFAULT '',
  `form_w_nine` varchar(255) NOT NULL DEFAULT '',
  `form_resume` varchar(255) NOT NULL DEFAULT '',
  `form_ach` varchar(255) NOT NULL DEFAULT '',
  `form_consultant_agree` varchar(255) NOT NULL DEFAULT '',
  `form_notes` text NOT NULL,
  `form_needed` text NOT NULL,
  `form_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `form_created_by` int(11) NOT NULL DEFAULT '0',
  `form_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `form_modified_by` int(11) NOT NULL DEFAULT '0',
  `form_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`form_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.form: ~13 rows (approximately)
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
INSERT INTO `form` (`form_id`, `form_user_id`, `form_client_id`, `form_first_name`, `form_last_name`, `form_email`, `form_contact_no`, `form_street`, `form_city`, `form_state`, `form_zipcode`, `form_country`, `form_w_nine`, `form_resume`, `form_ach`, `form_consultant_agree`, `form_notes`, `form_needed`, `form_record_status`, `form_created_by`, `form_created_on`, `form_modified_by`, `form_modified_on`) VALUES
	(1, 8, 1, 'Jill', 'Jill', 'jill@galileo.com', '12121', '', '', '', '', '', '2018_01_10_07_49_w9.pdf', '2018_01_10_07_49_galileo_resume.pdf', '2018_01_10_07_49_ach.png', '2018_01_10_07_49_consultant-agreement.pdf', '', '', 0, 1, '2018-01-10 07:49:39', 1, '2018-01-10 07:49:39'),
	(2, 13, 1, 'John', 'John', 'john@galileo.com', '121211212', '', '', '', '', '', '2018_01_10_07_50_w9.pdf', '2018_01_10_07_50_galileo_resume.pdf', '2018_01_10_07_50_ach.png', '2018_01_10_07_50_consultant-agreement.pdf', '', '', 0, 1, '2018-01-10 07:50:50', 1, '2018-01-10 07:50:50'),
	(3, 4, 1, 'Vicky', 'Vicky', 'vicky@galileo.com', '12121', '', '', '', '', '', '2018_01_10_07_52_w9.pdf', '', '2018_01_10_07_52_ach.png', '2018_01_10_07_52_consultant-agreement.pdf', '', '', 0, 1, '2018-01-10 07:52:40', 1, '2018-01-10 07:52:40'),
	(4, 3, 1, 'Bala', 'Krishnan', 'bala@galileo.com', '121212', '', '', '', '', '', '2018_01_10_07_54_w9.pdf', '', '2018_01_10_07_54_ach.png', '2018_01_10_07_54_consultant-agreement.pdf', '', '', 0, 1, '2018-01-10 07:55:01', 1, '2018-01-10 07:55:01'),
	(5, 5, 1, '', '', 'karthi@galileo.com', '121212', '', '', '', '', '', '2018_01_11_12_57_w9.pdf', '', '2018_01_11_12_57_ach.png', '2018_01_11_12_57_consultant-agreement.pdf', '', '', 0, 1, '2018-01-11 12:58:06', 1, '2018-01-11 12:58:06'),
	(6, 59, 1, '', '', '', '', '', '', '', '', '', '2018_02_07_05_31_consultant-agreement.pdf', '', '2018_02_07_05_30_consultant-agreement.pdf', '2018_02_07_05_30_consultant-agreement.pdf', '', '', 1, 1, '2018-02-07 05:30:43', 1, '2018-02-07 05:34:53'),
	(7, 16, 1, '', '', '', '', '', '', '', '', '', '2018_02_07_05_40_consultant-agreement.pdf', '', '', '', '', '', 1, 1, '2018-02-07 05:40:49', 1, '2018-02-07 05:41:25'),
	(8, 16, 1, '', '', '', '', '', '', '', '', '', '', '', '2018_02_07_05_40_consultant-agreement.pdf', '2018_02_07_05_41_consultant-agreement.pdf', '', '', 1, 1, '2018-02-07 05:41:14', 1, '2018-02-07 05:41:29'),
	(9, 16, 1, '', '', '', '', '', '', '', '', '', '2018_02_07_05_41_consultant-agreement.pdf', '', '', '', '', '', 1, 1, '2018-02-07 05:41:49', 1, '2018-02-07 05:42:20'),
	(10, 16, 1, '', '', '', '', '', '', '', '', '', '', '', '2018_02_07_05_42_consultant-agreement.pdf', '', '', '', 1, 1, '2018-02-07 05:42:04', 1, '2018-02-07 05:47:26'),
	(11, 10, 1, '', '', '', '', '', '', '', '', '', '2018_02_14_10_24_Screen Shot 2018-02-12 at 1.20.54 PM.png', '2018_01_10_07_50_galileo_resume.pdf', '2018_01_10_07_50_ach.png', '2018_01_10_07_50_consultant-agreement.pdf', '', '', 1, 10, '2018-02-14 10:24:33', 10, '2018-02-14 10:24:38'),
	(12, 67, 1, '', '', '', '', '', '', '', '', '', '2018_02_19_14_10_GTM_JillWright_W9_041517.pdf', '', '', '2018_02_19_14_10_GTM_JillWright_Contract_041517.pdf', '', '', 0, 10, '2018-02-19 14:11:01', 10, '2018-02-19 14:11:01'),
	(13, 70, 1, '', '', '', '', '', '', '', '', '', '2018_02_19_14_15_FW9_SaraLynn_Leary.pdf', '', '', '2018_02_19_14_15_SEO_Writing_Consulting_Agreement_SaraLynn_Leary.pdf', '', '', 0, 10, '2018-02-19 14:15:30', 10, '2018-02-19 14:15:30');
/*!40000 ALTER TABLE `form` ENABLE KEYS */;

-- Dumping structure for procedure galileo.geMarshaIdByMarshaCode
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `geMarshaIdByMarshaCode`(IN `_marshaCode` VARCHAR(100))
BEGIN
	SELECT client_entity_id
	FROM client_entity 
	WHERE client_entity.client_entity_marsha_code=_marshaCode LIMIT 1;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAdminConsultantTaskList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAdminConsultantTaskList`(
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
_isComplete TINYINT(1),
_divisionId INT(11)
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
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpAdminConsultantTaskList engine=memory SELECT SQL_CALC_FOUND_ROWS task_keyword.task_keyword_id AS taskId,
							"Task Keyword" AS TaskTypeVal,1 AS TaskType,client_entity_marsha_code AS marshaCode,division_code AS divisionCode,serv_type_name AS servTypeName, task_keyword_added_box_date AS dateAddedToBox, task_keyword_due AS contentDue,task_keyword_priority AS priority,user.user_fname AS userName, user.user_lname AS userLName, task_keyword_setup_complete AS isCompleted,task_keyword_tire AS tire,task_keyword_no_of_pages AS unitNo
							FROM task_keyword
							INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
							INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
							INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code 
							INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
							LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id
							' ,QryCondKeyword, '
							UNION
							SELECT task_content.task_content_id AS taskId,
							"Task Content" AS TaskTypeVal,2 AS TaskType,client_entity_marsha_code AS marshaCode,division_code AS divisionCode,serv_type_name AS servTypeName, task_content_added_box_date AS dateAddedToBox,task_content_due_date AS contentDue,task_content_priority AS priority,user.user_fname AS userName,  user.user_lname AS userLName, task_content_is_complete AS isCompleted,task_content_tire AS tire,task_content_no_of_units AS unitNo
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
	
	SET @IdQry3 = CONCAT('  SELECT  user.user_id,user.user_qb_ref_id, user.user_fname AS userName, user.user_lname AS userLName,  user.user_email,  user.user_record_status,
							user_role.user_role_id,user_role.user_role_name,  user_role.user_role_record_status,task_keyword.task_keyword_id AS taskId,task_keyword_marsha_code AS marshaId,client_entity_marsha_code AS marshaCode,division_id,division_code AS divisionCode,division_name,task_keyword_link_db_file AS linkToFile, task_keyword_added_box_date AS dateAddedToBox, task_keyword_due AS contentDue,task_keyword_priority AS priority,service_type.serv_type_id,service_type.serv_type_name AS servTypeName,task_keyword_tire AS tire,task_keyword_date AS tireDate,
							task_keyword_setup_complete AS isCompleted,
							"Task Keyword" AS TaskTypeVal,1 AS TaskType,
							task_keyword.task_keyword_admin_complete AS adminComplete,task_keyword.task_keyword_client_id AS taskClientId,task_keyword.task_keyword_admin_notes AS adminNotes,task_keyword_qb_process AS isQbProcess,task_keyword_no_of_pages AS unitNo
							FROM task_keyword
								INNER JOIN tmpAdminConsultantTaskList ON tmpAdminConsultantTaskList.taskId = task_keyword.task_keyword_id
								INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
								INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
								INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code 
								INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
								LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id
							' ,QryCondKeyword, '
							UNION
							SELECT user.user_id, user.user_qb_ref_id, user.user_fname AS userName, user.user_lname AS userLName,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,task_content.task_content_id AS taskId,task_content_marsha_code AS marshaId,client_entity_marsha_code AS marshaCode,division_id,division_code AS divisionCode,division_name ,task_content_link_to_file AS linkToFile, task_content_added_box_date AS dateAddedToBox, task_content_due_date AS contentDue, task_content_priority AS priority,service_type.serv_type_id,service_type.serv_type_name AS servTypeName,task_content_tire AS tire,task_content_ass_writer_date AS tireDate,
							task_content_is_complete AS isCompleted,
							"Task Content" AS TaskTypeVal,2 AS TaskType,
							task_content.task_content_admin_complete AS adminComplete,task_content.task_content_client_id AS taskClientId ,task_content.task_content_admin_notes AS adminNotes,task_content_qb_process AS isQbProcess, task_content_no_of_units AS unitNo
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
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAlertById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAlertById`(
_userId INT(11),
_notificationId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	
	SET QryCond = CONCAT(' WHERE notification.notification_record_status=0 AND notification.notification_id = ',_notificationId);
	
	SET @IdQry1 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,notification.notification_id,notification_user_id,notification_client_id,notification_module_id,notification_email,
	notification_record_status,notification_created_by,notification_created_on,notification_modified_by,notification_modified_on,client.client_name,
	modules.modules_id,modules.modules_name,modules.modules_record_status,modules.modules_created_by,modules.modules_created_on,modules.modules_modified_by,modules.modules_modified_on
	FROM notification 
	INNER JOIN user ON user.user_id = notification.notification_user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	INNER JOIN client ON client.client_id = notification.notification_client_id
	INNER JOIN modules ON modules.modules_id = notification.notification_module_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAlertCount
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAlertCount`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_writerId INT(11),
_clientId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	
	DROP TEMPORARY TABLE IF EXISTS tmpNotificationCount;
	
	SET QryCond = CONCAT(' WHERE notification.notification_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 1) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(notification.notification_created_on) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 1) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(notification.notification_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND notification.notification_client_id = ", _clientId);
	END IF;
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND notification.notification_user_id = ", _userId);
	END IF;
	
	
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpNotificationCount engine=memory SELECT SQL_CALC_FOUND_ROWS  notification_id 
		FROM notification 
		', QryCond);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	DROP TEMPORARY TABLE IF EXISTS tmpNotificationCount;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAlertList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAlertList`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_clientId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpNotification;
	
	SET QryCond = CONCAT(' WHERE notification.notification_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 1) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(notification.notification_created_on) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 1) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(notification.notification_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND notification.notification_client_id = ", _clientId);
	END IF;
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND user.user_role_id = ", _userRole , " AND user.user_id = ", _userId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY notification.notification_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpNotification engine=memory SELECT SQL_CALC_FOUND_ROWS  notification_id 
		FROM notification 
		LEFT JOIN user ON user.user_id = notification.notification_user_id
		LEFT JOIN user_role ON user_role.user_role_id = user.user_role_id AND user.user_record_status=0
		LEFT JOIN client ON client.client_id = notification.notification_client_id
		LEFT JOIN modules ON modules.modules_id = notification.notification_module_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,notification.notification_id,notification_user_id,notification_client_id,notification_module_id,notification_email,
	notification_record_status,notification_created_by,notification_created_on,notification_modified_by,notification_modified_on,client.client_name,
	modules.modules_id,modules.modules_name,modules.modules_desc,modules.modules_record_status,modules.modules_created_by,modules.modules_created_on,modules.modules_modified_by,modules.modules_modified_on
	FROM notification 
	INNER JOIN tmpNotification ON tmpNotification.notification_id = notification.notification_id
	LEFT JOIN user ON user.user_id = notification.notification_user_id AND user.user_record_status=0
	LEFT JOIN user_role ON user_role.user_role_id = user.user_role_id
	LEFT JOIN client ON client.client_id = notification.notification_client_id
	LEFT JOIN modules ON modules.modules_id = notification.notification_module_id ', QryCond, QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpNotification;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAlertNotificationCount
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAlertNotificationCount`(
_userId INT(11),
_clientId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	DROP TEMPORARY TABLE IF EXISTS tmpCount;
	
	SET QryCond = CONCAT(' WHERE alert_notification_is_read = 0 AND alert_notification.alert_notification_record_status=0 AND alert_notification_module_user_id = ',_userId,' AND alert_notification_client_id = ',_clientId);
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpCount engine=memory SELECT SQL_CALC_FOUND_ROWS  alert_notification_id 
		FROM alert_notification 
		', QryCond);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;

	DROP TEMPORARY TABLE IF EXISTS tmpCount;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAlertNotifications
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAlertNotifications`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_clientId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	DECLARE DivisionCode VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpAlertNot;
	
	SET QryCond = CONCAT(' WHERE  alert_notification_is_read=0 AND alert_notification.alert_notification_record_status=0 AND user.user_record_status=0 AND alert_notification.alert_notification_module_user_id=',_userId);
	
	SET QryCond = CONCAT(QryCond, " AND alert_notification.alert_notification_client_id = ", _clientId);
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY alert_notification.alert_notification_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpAlertNot engine=memory SELECT SQL_CALC_FOUND_ROWS  alert_notification_id 
		FROM alert_notification 
		INNER JOIN user ON user.user_id = alert_notification.alert_notification_module_user_id
		INNER JOIN modules ON modules.modules_id = alert_notification.alert_notification_module_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT alert_notification.alert_notification_id,alert_notification_is_read,alert_notification_module_user_id,alert_notification_client_id,alert_notification_module_id,alert_notification_email,alert_notification_record_status,alert_notification_created_by,alert_notification_created_on,alert_notification_modified_by,alert_notification_modified_on,alert_notification_task_id,alert_notification_invoice_id,alert_notification_billing_id,alert_notification_message,user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,modules_id,modules_name FROM alert_notification  
	INNER JOIN tmpAlertNot ON tmpAlertNot.alert_notification_id = alert_notification.alert_notification_id
	INNER JOIN user ON user.user_id = alert_notification.alert_notification_module_user_id
	INNER JOIN modules ON modules.modules_id = alert_notification.alert_notification_module_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpAlertNot;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAllClients
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAllClients`()
BEGIN
	SELECT client_id,client_user_id,client_name,client_street,client_city,client_state,client_zipcode,client_country
	client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on
	FROM client 
	WHERE client_record_status = 0;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAllDivsions
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAllDivsions`()
BEGIN
	SELECT division_id,division_code,division_name,division_client_id,division_record_status,division_created_by,division_created_on,division_modified_by,division_modified_on FROM division WHERE division_record_status = 0;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAllServiceTypes
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAllServiceTypes`()
BEGIN
	SELECT serv_type_id,serv_type_name,serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on FROM service_type WHERE serv_type_record_status = 0;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAllServiceTypesByClient
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAllServiceTypesByClient`(_clientId INT(11))
BEGIN
	SELECT serv_type_id,serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on FROM service_type WHERE serv_type_record_status = 0 AND serv_type_client_id =_clientId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAllServiceTypesByUser
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAllServiceTypesByUser`(_userId INT(11),_clientId INT(11))
BEGIN

	SELECT serv_type_id,serv_type_name,serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on
	FROM consultant_skill_items
	INNER JOIN consultant_skill ON consultant_skill.cons_skill_id = consultant_skill_items.csi_skill_id AND consultant_skill.cons_record_status = 0 AND consultant_skill.cons_user_id = _userId
	INNER JOIN service_type ON service_type.serv_type_id = consultant_skill_items.csi_service_type_id
	WHERE consultant_skill.cons_client_id =_clientId;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getAllUserRoles
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getAllUserRoles`()
BEGIN
	SELECT user_role_id,user_role_name,user_role_record_status,user_role_created_by,user_role_created_on,user_role_modified_by,user_role_modified_on FROM user_role WHERE user_role_record_status = 0;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getBillingCount
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getBillingCount`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_writerId INT(11),
_clientId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	DROP TEMPORARY TABLE IF EXISTS tmpBillingCount;
	
	SET QryCond = CONCAT(' WHERE billing_task_reference.billing_reference_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(billing_task_reference.billing_reference_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(billing_task_reference.billing_reference_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_task_user_id = ", _writerId );
  
	END IF;
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_task_user_id = ", _userId);
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_task_client_id = ", _clientId);
	END IF;

	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpBillingCount engine=memory SELECT SQL_CALC_FOUND_ROWS  billing_reference_id 
		FROM billing_task_reference 
		', QryCond);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;

	DROP TEMPORARY TABLE IF EXISTS tmpBillingCount;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getBillingTaskList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getBillingTaskList`(
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
_divisionText VARCHAR(100),
_divisionId INT(11),
_qbBillId BIGINT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpBilling;
	
	SET QryCond = CONCAT(' WHERE billing_task_reference.billing_reference_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(billing_task_reference.billing_reference_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(billing_task_reference.billing_reference_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_task_user_id = ", _writerId );
	ELSEIF(_divisionId  > 0 && _filterBy = 4) THEN
	  SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_division_code =", Quote(_divisionId) );
	ELSEIF(_qbBillId > 0 && _filterBy = 5) THEN
	 SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_doc_number = ", _qbBillId );
	END IF;
	
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_task_user_id = ", _userId);
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_task_client_id = ", _clientId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY billing_task_reference.billing_reference_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpBilling engine=memory SELECT SQL_CALC_FOUND_ROWS  billing_reference_id 
		FROM billing_task_reference 
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT billing_task_reference.billing_reference_id,billing_reference_billing_id,billing_reference_client_name,billing_reference_user_fname,billing_reference_user_lname,billing_reference_task_id,billing_reference_task_user_id,billing_reference_task_client_id,billing_reference_task_type,billing_reference_marsha_code,billing_reference_division_code,billing_reference_service_type_name,billing_reference_rate_per_unit,billing_reference_no_of_units,billing_reference_tire,billing_reference_record_status,billing_reference_created_by,billing_reference_created_on,billing_reference_modified_by,billing_reference_modified_on,billing_reference_doc_number FROM billing_task_reference  
	INNER JOIN tmpBilling ON tmpBilling.billing_reference_id = billing_task_reference.billing_reference_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpBilling;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getClientById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getClientById`(
	IN `_clientId` INT(11)
)
BEGIN
	SELECT client_id,client_user_id,client_name,client_qb_associated_reference,client_street,client_city,client_state,client_zipcode,client_country,
	client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on
	FROM client WHERE  client_id = _clientId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getClientDivisionById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getClientDivisionById`(
	IN `_clientQbRefId` INT(11)
)
BEGIN
	SELECT client_qb_reference.client_qb_ref_id,client_qb_ref_client_id,client_qb_ref_division_id,client_qb_ref_qb_id,client_qb_ref_qb_class,client_qb_ref_record_status,client_qb_ref_created_by,client_qb_ref_created_on,client_qb_ref_modified_by,client_qb_ref_modified_on,division_code,division_name,client_name,client_id FROM client_qb_reference  
	INNER JOIN client ON client.client_id = client_qb_reference.client_qb_ref_client_id
	INNER JOIN division ON division.division_id = client_qb_reference.client_qb_ref_division_id
	WHERE client_qb_ref_record_status = 0 AND client_qb_ref_id = _clientQbRefId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getClientDivisionList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getClientDivisionList`(
	IN `_userId` INT(11),
	IN `_filterBy` TINYINT(1),
	IN `_userRole` INT(11),
	IN `_FromDate` DATE,
	IN `_ToDate` DATE,
	IN `_Start` INT,
	IN `_Limit` INT,
	IN `_SortOrder` VARCHAR(100),
	IN `_clientId` INT(11)

)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbRef;
	
	SET QryCond = CONCAT(' WHERE client_qb_reference.client_qb_ref_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client_qb_reference.client_qb_ref_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client_qb_reference.client_qb_ref_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND client_qb_reference.client_qb_ref_client_id = ", _clientId );
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY client_qb_reference.client_qb_ref_client_id ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClientQbRef engine=memory SELECT SQL_CALC_FOUND_ROWS  client_qb_ref_id 
		FROM client_qb_reference 
		INNER JOIN client ON client.client_id = client_qb_reference.client_qb_ref_client_id
		INNER JOIN division ON division.division_id = client_qb_reference.client_qb_ref_division_id
		INNER JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT client_qb_reference.client_qb_ref_id,client_qb_ref_client_id,client_qb_ref_division_id,client_qb_ref_qb_id,client_qb_ref_qb_class,client_qb_ref_record_status,client_qb_ref_created_by,client_qb_ref_created_on,client_qb_ref_modified_by,client_qb_ref_modified_on,division_code,division_name,client_name,client_id,
	qb_class_reference.qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
	FROM client_qb_reference  
	INNER JOIN tmpClientQbRef ON tmpClientQbRef.client_qb_ref_id = client_qb_reference.client_qb_ref_id
	INNER JOIN client ON client.client_id = client_qb_reference.client_qb_ref_client_id
	INNER JOIN division ON division.division_id = client_qb_reference.client_qb_ref_division_id
	INNER JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbRef;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getClientEntityById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getClientEntityById`(
	IN `_clientEntityId` INT(11)
)
BEGIN
	SELECT client.client_id,client.client_user_id,client.client_name,client_entity.client_entity_id,client_entity_marsha_code,client_entity_hotel_name,client_entity_client_id,client_entity_user_id,client_entity_division_id,division_code,division_name,client_entity_created_on,client_entity_record_status,client_entity_modified_by,client_entity_modified_on,client_entity_country,client_entity_street,client_entity_city,client_entity_state,client_entity_zipcode
	FROM client_entity  
	INNER JOIN client ON client.client_id = client_entity.client_entity_client_id
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
	WHERE client_entity_record_status = 0 AND client_entity_id = _clientEntityId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getClientEntityList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getClientEntityList`(
	IN `_userId` INT(11),
	IN `_filterBy` TINYINT(1),
	IN `_userRole` INT(11),
	IN `_FromDate` DATE,
	IN `_ToDate` DATE,
	IN `_Start` INT,
	IN `_Limit` INT,
	IN `_SortOrder` VARCHAR(100),
	IN `_clientId` INT(11),
	IN `_divisionId` INT(11)

)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientEntity;
	
	SET QryCond = CONCAT(' WHERE client_entity.client_entity_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client_entity.client_entity_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client_entity.client_entity_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_divisionId > 0 && _filterBy = 4) THEN
	  SET QryCond = CONCAT(QryCond, " AND client_entity.client_entity_division_id =", _divisionId );
	END IF;
	
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND client_entity.client_entity_client_id = ", _clientId);
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
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClientEntity engine=memory SELECT SQL_CALC_FOUND_ROWS client_entity_id 
		FROM client_entity 
		INNER JOIN client ON client.client_id = client_entity.client_entity_client_id
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT client.client_id,client.client_user_id,client.client_name,client_entity.client_entity_id,client_entity_marsha_code,client_entity_hotel_name,client_entity_client_id,client_entity_user_id,client_entity_division_id,division_code,division_name,client_entity_created_on,client_entity_record_status,client_entity_modified_by,client_entity_modified_on,client_entity_country,client_entity_street,client_entity_city,client_entity_state,client_entity_zipcode
	FROM client_entity  
	INNER JOIN tmpClientEntity ON tmpClientEntity.client_entity_id = client_entity.client_entity_id
	INNER JOIN client ON client.client_id = client_entity.client_entity_client_id
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientEntity;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getClientList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getClientList`(
	IN `_userId` INT(11),
	IN `_filterBy` TINYINT(1),
	IN `_userRole` INT(11),
	IN `_FromDate` DATE,
	IN `_ToDate` DATE,
	IN `_Start` INT,
	IN `_Limit` INT,
	IN `_SortOrder` VARCHAR(100),
	IN `_clientId` INT(11),
	IN `_recordStatus` TINYINT(1)
)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpClient;
	
	SET QryCond = CONCAT(' WHERE client.client_record_status= ', _recordStatus);
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 5) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client.client_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 5) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client.client_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_clientId > 0 && _filterBy = 2) THEN
	 SET QryCond = CONCAT(QryCond, " AND client.client_id = ", _clientId );
	END IF;
	
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY client.client_name ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClient engine=memory SELECT SQL_CALC_FOUND_ROWS  client_id 
		FROM client ', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT client.client_id,client_user_id,client_name,client_street,client_city,client_state,client_zipcode,client_country,client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on FROM client  
	INNER JOIN tmpClient ON tmpClient.client_id = client.client_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClient;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getClientsByUserId
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getClientsByUserId`(`_userId` INT(11))
BEGIN
	SELECT client_id,client_user_id,client_name,client_street,client_city,client_state,client_zipcode,client_country
	client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on
	FROM client WHERE client_record_status = 0 AND client_user_id = _userId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getConsultantBySkill
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getConsultantBySkill`(
_skillId INT(11),
_clientId INT(11),
_formStatus TINYINT(11)
)
BEGIN
SELECT user_id,user_fname,user_lname,consultant_skill_items.csi_skill_id, consultant_skill_items.csi_service_type_id , consultant_skill.cons_user_id
FROM consultant_skill_items
INNER JOIN consultant_skill ON consultant_skill.cons_skill_id = consultant_skill_items.csi_skill_id AND consultant_skill.cons_record_status = 0
INNER JOIN user ON  user.user_id = consultant_skill.cons_user_id AND user.user_record_status = 0 AND user.user_role_id = 4 AND user.user_form_completed = _formStatus
WHERE consultant_skill_items.csi_service_type_id = _skillId AND consultant_skill.cons_client_id =_clientId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getConsultantRateById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getConsultantRateById`(_rateId INT(11))
BEGIN
	SELECT consultant_rate.cons_rate_id,cons_rate_user_id,cons_rate_service_type_id,cons_rate_client_id,cons_rate_per_unit,cons_rate_record_status,cons_rate_created_by,cons_rate_created_on,cons_rate_modified_by,cons_rate_modified_on,user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status, serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate
	FROM consultant_rate 
	INNER JOIN service_type ON service_type.serv_type_id = consultant_rate.cons_rate_service_type_id
	INNER JOIN user ON user.user_id = consultant_rate.cons_rate_user_id AND user.user_record_status = 0
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	WHERE cons_rate_record_status = 0 AND cons_rate_id = _rateId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getConsultantRateList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getConsultantRateList`(
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
	
	DROP TEMPORARY TABLE IF EXISTS tmpConsultantRate;
	
	SET QryCond = CONCAT(' WHERE consultant_rate.cons_rate_record_status=0 AND user.user_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(consultant_rate.cons_rate_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(consultant_rate.cons_rate_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND consultant_rate.cons_rate_user_id = ", _writerId );
  
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND consultant_rate.cons_rate_client_id = ", _clientId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY consultant_rate.cons_rate_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpConsultantRate engine=memory SELECT SQL_CALC_FOUND_ROWS  cons_rate_id 
		FROM consultant_rate 
		INNER JOIN user ON user.user_id = consultant_rate.cons_rate_user_id
		INNER JOIN service_type ON service_type.serv_type_id = consultant_rate.cons_rate_service_type_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT consultant_rate.cons_rate_id,cons_rate_user_id,cons_rate_client_id,cons_rate_service_type_id,cons_rate_per_unit,cons_rate_record_status,cons_rate_created_by,cons_rate_created_on,cons_rate_modified_by,cons_rate_modified_on,user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status, serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate FROM consultant_rate  
	INNER JOIN tmpConsultantRate ON tmpConsultantRate.cons_rate_id = consultant_rate.cons_rate_id
	INNER JOIN service_type ON service_type.serv_type_id = consultant_rate.cons_rate_service_type_id
	INNER JOIN user ON user.user_id = consultant_rate.cons_rate_user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpConsultantRate;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getConsultantSkillById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getConsultantSkillById`(_skillId INT(11))
BEGIN
	SELECT consultant_skill.cons_skill_id,cons_client_id,cons_user_id,cons_record_status,cons_created_by,cons_created_on,cons_modified_by,cons_modified_on
	FROM  consultant_skill
	WHERE cons_record_status = 0 AND cons_skill_id = _skillId;
	
	SELECT consultant_skill.cons_skill_id ,GROUP_CONCAT(serv_type_name) AS service_type ,GROUP_CONCAT(serv_type_id) AS service_type_id
	FROM service_type
	INNER JOIN consultant_skill_items ON csi_service_type_id = serv_type_id
	INNER JOIN consultant_skill ON consultant_skill.cons_skill_id = csi_skill_id
	WHERE consultant_skill.cons_skill_id = _skillId AND consultant_skill.cons_record_status = 0
	GROUP BY consultant_skill.cons_skill_id;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getConsultantSkillList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getConsultantSkillList`(
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
_serviceTypeId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryCond1 TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpSkill;
	DROP TEMPORARY TABLE IF EXISTS tmpSkillList;
	
	SET QryCond = CONCAT(' WHERE consultant_skill.cons_record_status=0 AND user.user_record_status=0 AND user_role_id = 4');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(consultant_skill.cons_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(consultant_skill.cons_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND consultant_skill.cons_user_id = ", _writerId );
	ELSEIF(_serviceTypeId > 0 && _filterBy = 5) THEN
	 SET QryCond = CONCAT( QryCond, " AND consultant_skill_items.csi_service_type_id = ", _serviceTypeId);
	ELSEIF(_filterBy = 4) THEN
		SET QryCond = CONCAT(QryCond, " AND consultant_skill_items.csi_service_type_id = ", _serviceTypeId , " AND consultant_skill.cons_user_id = ", _writerId);
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND consultant_skill.cons_client_id = ", _clientId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY consultant_skill.cons_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpSkill engine=memory SELECT SQL_CALC_FOUND_ROWS  cons_skill_id 
		FROM consultant_skill 
		INNER JOIN user ON user.user_id = consultant_skill.cons_user_id	
		INNER JOIN consultant_skill_items ON csi_skill_id = consultant_skill.cons_skill_id
		', QryCond, ' GROUP BY consultant_skill.cons_skill_id ', QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() AS total;
	
	SET @IdQry2 = CONCAT(' CREATE TEMPORARY TABLE tmpSkillList engine=memory SELECT consultant_skill.cons_skill_id,cons_client_id,cons_user_id,cons_record_status,cons_created_by,cons_created_on,cons_modified_by,cons_modified_on,
	user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status FROM consultant_skill  
	INNER JOIN tmpSkill ON tmpSkill.cons_skill_id = consultant_skill.cons_skill_id
	INNER JOIN user ON user.user_id = consultant_skill.cons_user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	', QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	SELECT tmpSkillList.cons_skill_id,cons_client_id,cons_user_id,cons_record_status,cons_created_by,cons_created_on,cons_modified_by,cons_modified_on,
	tmpSkillList.user_id, tmpSkillList.user_fname, tmpSkillList.user_lname,  tmpSkillList.user_email,  tmpSkillList.user_record_status,  tmpSkillList.user_role_id,  tmpSkillList.user_role_name,  tmpSkillList.user_role_record_status FROM tmpSkillList;
	
	SET QryCond1 = CONCAT(" AND service_type.serv_type_record_status = 0 ");
	
	IF(_serviceTypeId > 0 && _filterBy = 5) THEN
	 SET QryCond1 = CONCAT( QryCond1, " AND service_type.serv_type_id = ", _serviceTypeId);
	END IF;
	
	IF(_serviceTypeId > 0 && _filterBy = 4) THEN
	 SET QryCond1 = CONCAT(QryCond1, " AND consultant_skill_items.csi_service_type_id = ", _serviceTypeId , " AND consultant_skill.cons_user_id = ", _writerId);
	END IF;
	
	SET @IdQry3 = CONCAT(' SELECT tmpSkillList.cons_skill_id ,GROUP_CONCAT(serv_type_name) AS service_type 
	FROM service_type
	INNER JOIN consultant_skill_items ON csi_service_type_id = serv_type_id
	INNER JOIN consultant_skill ON consultant_skill.cons_skill_id = csi_skill_id
	INNER JOIN tmpSkillList ON tmpSkillList.cons_skill_id = consultant_skill.cons_skill_id ',QryCond1,
	' GROUP BY tmpSkillList.cons_skill_id' );
	
	PREPARE stmt3 FROM @IdQry3;
	EXECUTE stmt3;
	DEALLOCATE PREPARE stmt3;
	
	DROP TEMPORARY TABLE IF EXISTS tmpSkill;
	DROP TEMPORARY TABLE IF EXISTS tmpSkillList;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getConsultantTaskManagerContentList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getConsultantTaskManagerContentList`(
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
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getCsvExistingKeywordByFieldName
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getCsvExistingKeywordByFieldName`(IN `_fieldName` VARCHAR(255), IN `_userId` INT(11), IN `_clientId` INT(11))
BEGIN
	SET @Query = CONCAT('SELECT task_keyword_id, client_entity_marsha_code,  ', _fieldName ,' 
	FROM task_keyword 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	WHERE task_keyword_client_id = ',_clientId, ' AND task_keyword_created_by =', _userId);
	PREPARE stmnt FROM @Query;
	EXECUTE stmnt;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getCsvImportFields
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getCsvImportFields`(IN `_csvImportId` INT)
BEGIN
	SELECT ic_id,  ic_file_name,  ic_skip_header, ic_status,ic_user_id, ic_client_id, icf_ic_id, 
	icf_field_id, icf_field_name,  icf_client_id, icf_is_unique, ic_import_opt
	FROM import_csv_file 
	INNER JOIN import_csv_fields ON ic_id = icf_ic_id 
	WHERE ic_id = _csvImportId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getCsvImportFiles
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getCsvImportFiles`(
	IN `_status` int
)
BEGIN
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
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getCsvImportFilesForUser
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getCsvImportFilesForUser`(IN `_userId` INT)
BEGIN
	SELECT ic_id,  ic_file_name, 
	ic_skip_header, ic_status, ic_user_id, ic_import_opt, ic_import_type, ic_import_keyword_date ic_est_time, import_csv_file.created_date, 
	user.user_id, user_fname, user_lname, user_email
	FROM import_csv_file 
	INNER JOIN user ON user.user_id = import_csv_file.created_by
	WHERE ic_status > 0 AND ic_user_id = _userId ORDER BY ic_id DESC LIMIT 5; 
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getCsvImportUniqueField
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getCsvImportUniqueField`(IN `_importId` INT)
BEGIN
	SELECT icf_id, icf_ic_id, icf_field_id, icf_field_name,  icf_user_id, icf_client_id, icf_is_unique 
	FROM import_csv_fields 
	WHERE icf_is_unique = 1 AND icf_ic_id = _importId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getDivisionByClientId
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getDivisionByClientId`(
	IN `_clientId` INT(11)
)
    COMMENT 'get division by marsha code'
BEGIN
	SELECT client_id,division_id,division_code,division_name
	FROM division 
	INNER JOIN client ON client.client_id = division.division_client_id
	WHERE division.division_client_id=_clientId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getDivisionById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getDivisionById`(
	IN `_clientId` INT(11),
	IN `_divisionId` INT(11)
)
    COMMENT 'get division by id'
BEGIN
	SELECT division.division_id,division_code,division_name,division_client_id,division_record_status,division_created_by,division_created_on,division_modified_by,division_modified_on
	FROM division 
	INNER JOIN client ON client.client_id = division.division_client_id AND client.client_record_status = 0
	WHERE division.division_id=_divisionId AND division_client_id = _clientId LIMIT 1;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getDivisionByMarshaCode
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getDivisionByMarshaCode`(IN `_userId` INT(11), IN `_marshaCode` INT(11))
BEGIN
	SELECT client_entity_id,client_entity_marsha_code,division_id,division_code,division_name
	FROM client_entity 
	INNER JOIN division ON division_id = client_entity_division_id
	WHERE client_entity.client_entity_id=_marshaCode LIMIT 1;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getDivisionList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getDivisionList`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_clientId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpDivision;
	
	SET QryCond = CONCAT(' WHERE division.division_record_status=0 AND client.client_record_status = 0 AND division.division_client_id = ', _clientId);
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 1) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(division.division_created_on) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 1) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(division.division_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY division.division_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpDivision engine=memory SELECT SQL_CALC_FOUND_ROWS  division_id 
		FROM division 
		INNER JOIN client ON client.client_id = division.division_client_id ', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT division.division_id,division_code,division_name,division_client_id,division_record_status,division_created_by,division_created_on,division_modified_by,division_modified_on
	FROM division 
	INNER JOIN tmpDivision ON tmpDivision.division_id = division.division_id
	INNER JOIN client ON client.client_id = division.division_client_id ', QryCond, QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpDivision;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getFormById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getFormById`(_formId INT(11))
BEGIN
	SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,form_id,form_user_id,form_client_id,form_first_name,form_last_name,form_email,form_contact_no,form_street,form_city,form_state,form_zipcode,form_country,form_w_nine,form_resume,form_ach,form_consultant_agree,form_record_status,form_created_by,form_created_on,form_modified_by,form_modified_on
	FROM form 
	INNER JOIN user ON user.user_id = form.form_user_id 
	WHERE user_record_status= 0 AND form_record_status = 0 AND form_id = _formId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getFormList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getFormList`(
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
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getFormStatus
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getFormStatus`(
_clientId INT(11),
_formUserId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE form.form_client_id= ',_clientId,' AND form.form_user_id= ',_formUserId);
	
	SET @IdQry1 = CONCAT(' SELECT * FROM form ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getIfKeywordSetupComplete
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getIfKeywordSetupComplete`(
_taskCloneId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_clone.task_clone_record_status=0 AND task_clone.task_clone_is_main_task=0 AND task_clone.task_clone_task_id = ',_taskCloneId);
	
	SET @IdQry1 = CONCAT(' SELECT task_clone_id,task_clone_is_main_task,task_clone_task_id,task_clone_common_id,task_keyword_setup_complete
	FROM task_clone  
	INNER JOIN task_keyword ON task_keyword.task_keyword_id = task_clone.task_clone_common_id
	', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getInvoiceCount
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getInvoiceCount`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_writerId INT(11),
_clientId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	DROP TEMPORARY TABLE IF EXISTS tmpInvoiceCount;
	
	SET QryCond = CONCAT(' WHERE invoice_task_reference.invoice_reference_record_status=0 ');
	
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(invoice_task_reference.invoice_reference_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(invoice_task_reference.invoice_reference_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_task_user_id = ", _writerId );
	END IF;
	
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_task_user_id = ", _userId);
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_task_client_id = ", _clientId);
	END IF;

	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpInvoiceCount engine=memory SELECT SQL_CALC_FOUND_ROWS  invoice_reference_id 
		FROM invoice_task_reference 
		', QryCond);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;

	DROP TEMPORARY TABLE IF EXISTS tmpInvoiceCount;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getInvoiceTaskList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getInvoiceTaskList`(
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
_marshaCode VARCHAR(200),
_invNo BIGINT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpInvoice;
	
	SET QryCond = CONCAT(' WHERE invoice_task_reference.invoice_reference_record_status=0 ');
	
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(invoice_task_reference.invoice_reference_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(invoice_task_reference.invoice_reference_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_task_user_id = ", _writerId );
	ELSEIF(_divisionId && _filterBy = 4) THEN
	  SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_division_code =", Quote(_divisionId) );
	ELSEIF(_serviceTypeName !='0' && _filterBy = 6) THEN
	  SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_service_type_name =", Quote(_serviceTypeName) );
	ELSEIF(_marshaCode !='0' && _filterBy = 5) THEN
	  SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_marsha_code =", Quote(_marshaCode) );
	ELSEIF(_invNo > 0 && _filterBy = 7) THEN
	 SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_doc_number = ", _invNo );
	END IF;
	
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_task_user_id = ", _userId);
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_task_client_id = ", _clientId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY invoice_task_reference.invoice_reference_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpInvoice engine=memory SELECT SQL_CALC_FOUND_ROWS  invoice_reference_id 
		FROM invoice_task_reference 
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT invoice_task_reference.invoice_reference_id,invoice_reference_invoice_id,invoice_reference_client_name,invoice_reference_user_fname,invoice_reference_user_lname,invoice_reference_task_id,invoice_reference_task_user_id,invoice_reference_task_client_id,invoice_reference_task_type,invoice_reference_marsha_code,invoice_reference_division_code,invoice_reference_service_type_name,invoice_reference_rate_per_unit,invoice_reference_no_of_units,invoice_reference_tire,invoice_reference_record_status,invoice_reference_created_by,invoice_reference_created_on,invoice_reference_modified_by,invoice_reference_modified_on,invoice_reference_doc_number FROM invoice_task_reference  
	INNER JOIN tmpInvoice ON tmpInvoice.invoice_reference_id = invoice_task_reference.invoice_reference_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpInvoice;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getKeywordSetupStatus
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getKeywordSetupStatus`(
_userId INT(11),
_taskCloneId INT(11),
_taskCloneCommonId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_clone.task_clone_record_status=0 AND task_clone.task_clone_is_main_task=1 AND task_clone.task_clone_common_id = ',_taskCloneCommonId);
	
	SET @IdQry1 = CONCAT(' SELECT task_clone_id,task_clone_is_main_task,task_clone_task_id,task_clone_common_id,task_keyword_setup_complete
	
	FROM task_clone  
	INNER JOIN task_keyword ON task_keyword.task_keyword_id = task_clone.task_clone_task_id
	', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getMarshaCodes
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getMarshaCodes`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11)
)
    COMMENT 'get division by marsha code'
BEGIN
	SELECT client_entity_id,client_entity_marsha_code,division_id,division_code,division_name
	FROM client_entity 
	INNER JOIN division ON division_id = client_entity_division_id
	WHERE client_entity.client_entity_client_id=_clientId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getMaxTaskCloneCommonId
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getMaxTaskCloneCommonId`()
BEGIN
	SELECT IF(MAX(task_clone_common_id)+1 IS NULL, 1, MAX(task_clone_common_id)+1)  AS commonId FROM task_clone;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getModuleByModuleId
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getModuleByModuleId`(
	IN `_modulesIp` INT(11)
)
    COMMENT 'get division by marsha code'
BEGIN
	SELECT modules_id,modules_name,modules_desc,modules_record_status,modules_created_by,modules_created_on,modules_modified_by,modules_modified_on FROM modules WHERE modules_record_status = 0 AND modules_id=_modulesIp LIMIT 1;
	 
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getModules
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getModules`()
BEGIN
	SELECT modules_id,modules_name,modules_record_status,modules_created_by,modules_created_on,modules_modified_by,modules_modified_on FROM modules WHERE modules_record_status = 0;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getNotificationEmails
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getNotificationEmails`(
IN `_userId` INT(11),
IN `_clientId` INT(11),
IN `_moduleId` TINYINT(1)
)
BEGIN
	DECLARE QryCond TEXT;
		SET QryCond = CONCAT(' WHERE notification_record_status=0 AND notification_client_id = ',_clientId,' AND notification_module_id = ',_moduleId);
		
		SET @IdQry1 = CONCAT(' SELECT notification_id,notification_module_id,notification_client_id,notification_email FROM notification', QryCond); 
			
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getOutstandingBillingList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getOutstandingBillingList`(
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
_divisionId INT(11)
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
	END IF;
	
	 
	SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_admin_complete = 1 AND task_keyword.task_keyword_setup_complete = 1 ");
	SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_admin_complete = 1 AND task_content.task_content_is_complete = 1 ");
	
	SET QryCondKeyword = CONCAT(QryCondKeyword, " AND task_keyword.task_keyword_qb_process = 0");
	SET QryCondContent = CONCAT(QryCondContent, " AND task_content.task_content_qb_process = 0");

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
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpAdminConsultantTaskList engine=memory SELECT SQL_CALC_FOUND_ROWS task_keyword.task_keyword_id AS taskId,
							"Task Keyword" AS TaskTypeVal,1 AS TaskType,client_entity_marsha_code AS marshaCode,division_code AS divisionCode,service_type.serv_type_name AS servTypeName, service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate, task_keyword_added_box_date AS dateAddedToBox, task_keyword_due AS contentDue,task_keyword_priority AS priority,user.user_fname AS userName, user.user_lname AS userLName, task_keyword_setup_complete AS isCompleted,task_keyword_tire AS tire,consultant_rate.cons_rate_per_unit, task_keyword_no_of_pages AS unitNo
							FROM task_keyword
							INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
							INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
							INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code 
							INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
							LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id
							LEFT  JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_keyword.task_keyword_user_id AND consultant_rate.cons_rate_client_id = task_keyword_client_id AND cons_rate_service_type_id = task_keyword.task_keyword_service_type_id AND cons_rate_record_status = 0
							' ,QryCondKeyword, '
							UNION
							SELECT task_content.task_content_id AS taskId,
							"Task Content" AS TaskTypeVal,2 AS TaskType,client_entity_marsha_code AS marshaCode,division_code AS divisionCode,service_type.serv_type_name AS servTypeName, service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate,task_content_added_box_date AS dateAddedToBox,task_content_due_date AS contentDue,task_content_priority AS priority,user.user_fname AS userName, user.user_lname AS userLName, task_content_is_complete AS isCompleted,task_content_tire AS tire,consultant_rate.cons_rate_per_unit,task_content_no_of_units AS unitNo
							FROM task_content
							INNER JOIN user ON user.user_id = task_content.task_content_user_id
							INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
							INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code 
							INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
							LEFT  JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id
							LEFT JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_content.task_content_user_id AND consultant_rate.cons_rate_client_id = task_content_client_id AND cons_rate_service_type_id = task_content.task_content_service_type_id AND cons_rate_record_status = 0
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
	
	SET @IdQry3 = CONCAT('  SELECT  user.user_id, user.user_qb_ref_id, user.user_fname AS userName, user.user_lname AS userLName,  user.user_email,  user.user_record_status,
							user_role.user_role_id,user_role.user_role_name,  user_role.user_role_record_status,task_keyword.task_keyword_id AS taskId,task_keyword_marsha_code AS marshaId,client_entity_marsha_code AS marshaCode,division_id,division_code AS divisionCode,division_name,task_keyword_link_db_file AS linkToFile, task_keyword_added_box_date AS dateAddedToBox, task_keyword_due AS contentDue,task_keyword_priority AS priority,service_type.serv_type_id,service_type.serv_type_name AS servTypeName,service_type.serv_type_gal_rate AS servTypeGalRate,service_type.serv_type_freel_rate AS servTypeFreeLRate,task_keyword_tire AS tire,task_keyword_date AS tireDate,
							task_keyword_setup_complete AS isCompleted,
							"Task Keyword" AS TaskTypeVal,1 AS TaskType,
							task_keyword.task_keyword_admin_complete AS adminComplete,task_keyword.task_keyword_client_id AS taskClientId,task_keyword.task_keyword_admin_notes AS adminNotes,task_keyword_qb_process AS isQbProcess,consultant_rate.cons_rate_per_unit,task_keyword_no_of_pages AS unitNo
							FROM task_keyword
								INNER JOIN tmpAdminConsultantTaskList ON tmpAdminConsultantTaskList.taskId = task_keyword.task_keyword_id
								INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
								INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
								INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code 
								INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
								LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id
								LEFT  JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_keyword.task_keyword_user_id AND consultant_rate.cons_rate_client_id = task_keyword_client_id AND cons_rate_service_type_id = task_keyword.task_keyword_service_type_id AND cons_rate_record_status = 0
							' ,QryCondKeyword, '
							UNION
							SELECT user.user_id, user.user_qb_ref_id, user.user_fname AS userName, user.user_lname AS userLName,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,task_content.task_content_id AS taskId,task_content_marsha_code AS marshaId,client_entity_marsha_code AS marshaCode,division_id,division_code AS divisionCode,division_name ,task_content_link_to_file AS linkToFile, task_content_added_box_date AS dateAddedToBox, task_content_due_date AS contentDue, task_content_priority AS priority,service_type.serv_type_id,service_type.serv_type_name AS servTypeName,service_type.serv_type_gal_rate AS servTypeGalRate,service_type.serv_type_freel_rate AS servTypeFreeLRate,task_content_tire AS tire,task_content_ass_writer_date AS tireDate,
							task_content_is_complete AS isCompleted,
							"Task Content" AS TaskTypeVal,2 AS TaskType,
							task_content.task_content_admin_complete AS adminComplete,task_content.task_content_client_id AS taskClientId ,task_content.task_content_admin_notes AS adminNotes,task_content_qb_process AS isQbProcess,consultant_rate.cons_rate_per_unit,task_content_no_of_units AS unitNo
							FROM task_content
								INNER JOIN tmpAdminConsultantTaskList1 ON tmpAdminConsultantTaskList1.taskId = task_content.task_content_id
								INNER JOIN user ON user.user_id = task_content.task_content_user_id
								INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
								INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code 
								INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
								LEFT  JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id
								LEFT JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_content.task_content_user_id AND consultant_rate.cons_rate_client_id = task_content_client_id AND cons_rate_service_type_id = task_content.task_content_service_type_id AND cons_rate_record_status = 0
							' ,QryCondContent, '
							', QryOrder);
	
	PREPARE stmt3 FROM @IdQry3;
	EXECUTE stmt3;
	DEALLOCATE PREPARE stmt3;
	
	DROP TEMPORARY TABLE IF EXISTS tmpAdminConsultantTaskList;
	DROP TEMPORARY TABLE IF EXISTS tmpAdminConsultantTaskList1;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getOutstandingInvoiceList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getOutstandingInvoiceList`(
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
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getQbClassReferenceByClientId
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getQbClassReferenceByClientId`(IN `_clientId` INT(11))
BEGIN
	SELECT qb_class_reference.qb_cls_ref_id,qb_cls_ref_client_id,qb_cls_ref_class_id,qb_cls_ref_class_name,qb_cls_ref_record_status,qb_cls_ref_created_by,qb_cls_ref_created_on,qb_cls_ref_modified_by,qb_cls_ref_modified_on 
	FROM qb_class_reference  
	INNER JOIN client ON client.client_id = qb_class_reference.qb_cls_ref_client_id
	WHERE qb_class_reference.qb_cls_ref_record_status=0 AND client.client_record_status= 0 AND qb_cls_ref_client_id = _clientId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getQbClassReferenceById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getQbClassReferenceById`(
	IN `_classQbRefId` INT(11)
)
BEGIN
	SELECT qb_class_reference.qb_cls_ref_id,qb_cls_ref_client_id,qb_cls_ref_class_id,qb_cls_ref_class_name,qb_cls_ref_record_status,qb_cls_ref_created_by,qb_cls_ref_created_on,qb_cls_ref_modified_by,qb_cls_ref_modified_on 
	FROM qb_class_reference  
	INNER JOIN client ON client.client_id = qb_class_reference.qb_cls_ref_client_id
	WHERE qb_class_reference.qb_cls_ref_record_status=0 AND client.client_record_status= 0 AND qb_cls_ref_id = _classQbRefId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getQbClassReferenceList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getQbClassReferenceList`(
	IN `_userId` INT(11),
	IN `_filterBy` TINYINT(1),
	IN `_userRole` INT(11),
	IN `_FromDate` DATE,
	IN `_ToDate` DATE,
	IN `_Start` INT,
	IN `_Limit` INT,
	IN `_SortOrder` VARCHAR(100),
	IN `_clientId` INT(11)

)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbClassRef;
	
	SET QryCond = CONCAT(' WHERE qb_class_reference.qb_cls_ref_record_status=0 AND client.client_record_status= 0');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(qb_class_reference.qb_cls_ref_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(qb_class_reference.qb_cls_ref_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND qb_class_reference.qb_cls_ref_client_id = ", _clientId );
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY qb_class_reference.qb_cls_ref_client_id ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClientQbClassRef engine=memory SELECT SQL_CALC_FOUND_ROWS  qb_cls_ref_id 
		FROM qb_class_reference 
		INNER JOIN client ON client.client_id = qb_class_reference.qb_cls_ref_client_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT qb_class_reference.qb_cls_ref_id,qb_cls_ref_client_id,qb_cls_ref_class_id,qb_cls_ref_class_name,qb_cls_ref_record_status,qb_cls_ref_created_by,qb_cls_ref_created_on,qb_cls_ref_modified_by,qb_cls_ref_modified_on FROM qb_class_reference  
	INNER JOIN tmpClientQbClassRef ON tmpClientQbClassRef.qb_cls_ref_id = qb_class_reference.qb_cls_ref_id
	INNER JOIN client ON client.client_id = qb_class_reference.qb_cls_ref_client_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbClassRef;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getQbClientTokenById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getQbClientTokenById`(
	IN `_tokenId` INT(11)
)
BEGIN
	SELECT qb_client_token.qb_client_token_id,qb_client_token_auth_mode,qb_client_token_client_id,qb_client_token_client_secret,qb_client_token_app_client_id,qb_client_token_refresh_token,qb_client_token_access_token,qb_client_token_qbo_real_id,qb_client_token_base_url,qb_client_token_current_refresh_token,qb_client_token_record_status,qb_client_token_created_by,qb_client_token_created_on,qb_client_token_modified_by,qb_client_token_modified_on FROM qb_client_token  
	INNER JOIN client ON client.client_id = qb_client_token.qb_client_token_app_client_id
	WHERE qb_client_token.qb_client_token_record_status=0 AND client.client_record_status= 0 AND qb_client_token_id = _tokenId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getQbClientTokenList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getQbClientTokenList`(
	IN `_userId` INT(11),
	IN `_filterBy` TINYINT(1),
	IN `_userRole` INT(11),
	IN `_FromDate` DATE,
	IN `_ToDate` DATE,
	IN `_Start` INT,
	IN `_Limit` INT,
	IN `_SortOrder` VARCHAR(100),
	IN `_clientId` INT(11)

)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbToken;
	
	SET QryCond = CONCAT(' WHERE qb_client_token.qb_client_token_record_status=0 AND client.client_record_status= 0');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(qb_client_token.qb_client_token_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(qb_client_token.qb_client_token_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY qb_client_token.qb_client_token_app_client_id ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClientQbToken engine=memory SELECT SQL_CALC_FOUND_ROWS  qb_client_token_id 
		FROM qb_client_token 
		INNER JOIN client ON client.client_id = qb_client_token.qb_client_token_app_client_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT qb_client_token.qb_client_token_id,qb_client_token_auth_mode,qb_client_token_client_id,qb_client_token_client_secret,qb_client_token_app_client_id,qb_client_token_refresh_token,qb_client_token_access_token,qb_client_token_qbo_real_id,qb_client_token_base_url,qb_client_token_current_refresh_token,qb_client_token_record_status,qb_client_token_created_by,qb_client_token_created_on,qb_client_token_modified_by,qb_client_token_modified_on FROM qb_client_token  
	INNER JOIN tmpClientQbToken ON tmpClientQbToken.qb_client_token_id = qb_client_token.qb_client_token_id
	INNER JOIN client ON client.client_id = qb_client_token.qb_client_token_app_client_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbToken;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getServiceTypeById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getServiceTypeById`(
_userId INT(11),
_serviceTypeId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE service_type.serv_type_record_status=0 AND service_type.serv_type_id = ',_serviceTypeId);
	
	SET @IdQry1 = CONCAT(' SELECT serv_type_id,serv_type_qb_id,serv_type_task_type,serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,
			serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on
	FROM service_type  ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getServiceTypeByTaskType
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getServiceTypeByTaskType`(
_clientId INT(11),
_taskType INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE service_type.serv_type_record_status=0 AND service_type.serv_type_client_id = ',_clientId,' AND service_type.serv_type_task_type = ',_taskType);
	
	SET @IdQry1 = CONCAT(' SELECT serv_type_id,serv_type_qb_id,serv_type_task_type,serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,
			serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on
	FROM service_type  ', QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getServiceTypesList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getServiceTypesList`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_clientId INT(11),
_serviceTypeId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpServiceTypes;
	
	SET QryCond = CONCAT(' WHERE service_type.serv_type_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(service_type.serv_type_created_on) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(service_type.serv_type_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_serviceTypeId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND service_type.serv_type_id = ", _serviceTypeId );
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND service_type.serv_type_client_id = ", _clientId);
	END IF;
	
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY service_type.serv_type_name ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpServiceTypes engine=memory SELECT SQL_CALC_FOUND_ROWS  serv_type_id 
		FROM service_type 
		INNER JOIN client ON client.client_id = service_type.serv_type_client_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT service_type.serv_type_id,serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,
	serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on,serv_type_qb_id,serv_type_task_type,client.client_name
	FROM service_type 
	INNER JOIN tmpServiceTypes ON tmpServiceTypes.serv_type_id = service_type.serv_type_id
	INNER JOIN client ON client.client_id = service_type.serv_type_client_id ', QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpServiceTypes;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getSubTaskCloneCommonId
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getSubTaskCloneCommonId`(
_taskId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_clone.task_clone_record_status=0 AND task_clone.task_clone_task_id = ',_taskId);
	
	SET @IdQry1 = CONCAT(' SELECT task_clone_id,task_clone_task_id,task_clone_is_main_task,task_clone_common_id,task_clone_record_status,task_clone_created_by,task_clone_created_on
	FROM task_clone  ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskCount
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskCount`(
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
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskDataForBillingReference
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskDataForBillingReference`(
_taskId INT(11),
_taskType TINYINT(1),
_billQty INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	IF(_taskType = 1) THEN
	  
		SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND user.user_record_status=0 AND task_keyword.task_keyword_id = ',_taskId);
		
		SET @IdQry1 = CONCAT(' SELECT ',_billQty,' AS  billQty, user.user_id,user.user_qb_ref_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name, user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
		task_keyword.task_keyword_id AS taskId ,"Task Keyword" AS TaskTypeVal,1 AS TaskType,task_keyword.task_keyword_marsha_code,task_keyword.task_keyword_no_of_pages,task_keyword.task_keyword_notes,task_keyword.task_keyword_box_location,task_keyword.task_keyword_added_box_date,task_keyword.task_keyword_setup_due_date,task_keyword.task_keyword_setup_complete,task_keyword.task_keyword_due AS contentDue ,task_keyword.task_keyword_submitted,task_keyword.task_keyword_user_id,task_keyword.task_keyword_link_db_file,task_keyword.task_keyword_date,task_keyword.task_keyword_admin_complete,task_keyword.task_keyword_client_id,task_keyword.task_keyword_admin_notes,task_keyword.task_keyword_record_status,task_keyword.task_keyword_created_by,task_keyword.task_keyword_created_on,task_keyword.task_keyword_modified_by,task_keyword.task_keyword_modified_on,task_keyword.task_keyword_priority,service_type.serv_type_id,service_type.serv_type_qb_id,service_type.serv_type_name,cons_rate_per_unit,client_id,client_name,task_keyword_tire AS tire,service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate,cons_rate_service_type_id,client_qb_ref_division_id,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_keyword 
		INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
		INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
		INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_keyword_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		LEFT  JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_keyword.task_keyword_user_id AND consultant_rate.cons_rate_client_id = task_keyword_client_id AND cons_rate_service_type_id = task_keyword.task_keyword_service_type_id AND cons_rate_record_status = 0
		INNER JOIN client ON client.client_id = task_keyword.task_keyword_client_id
		INNER JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id ', QryCond, ' LIMIT 1'); 
			
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	ELSEIF(_taskType = 2) THEN
		
		SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND user.user_record_status=0 AND task_content.task_content_id = ',_taskId);
	
		SET @IdQry1 = CONCAT(' SELECT ',_billQty,' AS  billQty, user.user_id,user.user_qb_ref_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
		task_content.task_content_id AS taskId ,"Task Content" AS TaskTypeVal,2 AS TaskType,task_content.task_content_marsha_code,task_content.task_content_service_type_id,task_content.task_content_tire AS tire,task_content.task_content_priority,task_content.task_content_added_box_date,task_content.task_content_due_date AS contentDue,task_content.task_content_due_plus_date,task_content.task_content_added_box_due_date,task_content.task_content_rev_req,task_content.task_content_rev_com,task_content.task_content_rev_sec_req,task_content.task_content_rev_sec_com,task_content.task_content_ass_writer_date,task_content.task_content_is_complete,task_content.task_content_proj_com_date,task_content.task_content_user_id,task_content.task_content_no_of_units,task_content.task_content_link_to_file,task_content.task_content_notes,task_content.task_content_record_status,task_content.task_content_created_by,task_content.task_content_created_on,task_content.task_content_modified_by,task_content.task_content_modified_on,service_type.serv_type_id,service_type.serv_type_qb_id,service_type.serv_type_name,cons_rate_per_unit,client_id,client_name,service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate,cons_rate_service_type_id,client_qb_ref_division_id,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_content 
		INNER JOIN user ON user.user_id = task_content.task_content_user_id
		INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_content_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		LEFT JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_content.task_content_user_id AND consultant_rate.cons_rate_client_id = task_content_client_id AND cons_rate_service_type_id = task_content.task_content_service_type_id AND cons_rate_record_status = 0
		INNER JOIN client ON client.client_id = task_content.task_content_client_id
		INNER JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryCond, ' LIMIT 1'); 
	
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	END IF;


END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskDataForInvoiceReference
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskDataForInvoiceReference`(
_taskId INT(11),
_taskType TINYINT(1),
_invQty INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	IF(_taskType = 1) THEN
	  
		SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND user.user_record_status=0 AND task_keyword.task_keyword_id = ',_taskId);
		
		SET @IdQry1 = CONCAT(' SELECT ',_invQty,' AS  invQty,user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name, user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
		task_keyword.task_keyword_id AS taskId ,"Task Keyword" AS TaskTypeVal,1 AS TaskType,task_keyword.task_keyword_marsha_code,task_keyword.task_keyword_no_of_pages,task_keyword.task_keyword_notes,task_keyword.task_keyword_box_location,task_keyword.task_keyword_added_box_date,task_keyword.task_keyword_setup_due_date,task_keyword.task_keyword_setup_complete,task_keyword.task_keyword_due AS contentDue ,task_keyword.task_keyword_submitted,task_keyword.task_keyword_user_id,task_keyword.task_keyword_link_db_file,task_keyword.task_keyword_date,task_keyword.task_keyword_admin_complete,task_keyword.task_keyword_client_id,task_keyword.task_keyword_admin_notes,task_keyword.task_keyword_record_status,task_keyword.task_keyword_created_by,task_keyword.task_keyword_created_on,task_keyword.task_keyword_modified_by,task_keyword.task_keyword_modified_on,task_keyword.task_keyword_priority,service_type.serv_type_id,service_type.serv_type_qb_id,service_type.serv_type_name,client_id,client_name,task_keyword_tire AS tire,service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate,client_qb_ref_division_id,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_keyword 
		INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
		INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
		INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_keyword_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		INNER JOIN client ON client.client_id = task_keyword.task_keyword_client_id
		INNER JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id ', QryCond, ' LIMIT 1'); 
			
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	ELSEIF(_taskType = 2) THEN
		
		SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND user.user_record_status=0 AND task_content.task_content_id = ',_taskId);
	
		SET @IdQry1 = CONCAT(' SELECT ',_invQty,' AS  invQty, user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
		task_content.task_content_id AS taskId ,"Task Content" AS TaskTypeVal,2 AS TaskType,task_content.task_content_marsha_code,task_content.task_content_service_type_id,task_content.task_content_tire AS tire,task_content.task_content_priority,task_content.task_content_added_box_date,task_content.task_content_due_date AS contentDue,task_content.task_content_due_plus_date,task_content.task_content_added_box_due_date,task_content.task_content_rev_req,task_content.task_content_rev_com,task_content.task_content_rev_sec_req,task_content.task_content_rev_sec_com,task_content.task_content_ass_writer_date,task_content.task_content_is_complete,task_content.task_content_proj_com_date,task_content.task_content_user_id,task_content.task_content_no_of_units,task_content.task_content_link_to_file,task_content.task_content_notes,task_content.task_content_record_status,task_content.task_content_created_by,task_content.task_content_created_on,task_content.task_content_modified_by,task_content.task_content_modified_on,service_type.serv_type_id,service_type.serv_type_qb_id,service_type.serv_type_name,client_id,client_name,service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate,client_qb_ref_division_id,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_content 
		INNER JOIN user ON user.user_id = task_content.task_content_user_id
		INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_content_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		INNER JOIN client ON client.client_id = task_content.task_content_client_id
		INNER JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryCond, ' LIMIT 1'); 
	
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	END IF;


END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskDataForQbBilling
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskDataForQbBilling`(
_taskIds VARCHAR(255),
_taskType TINYINT(1)
)
BEGIN
	DECLARE QryCond TEXT;
	
	IF(_taskType = 1) THEN
	  
		SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND user.user_record_status=0 AND task_keyword.task_keyword_id IN (', _taskIds, ')');
		
		SET @IdQry1 = CONCAT(' SELECT  task_keyword_no_of_pages AS unitNo, (IFNULL(cons_rate_per_unit, serv_type_freel_rate)) * task_keyword_no_of_pages AS sumRate, user.user_qb_ref_id, 
		"Task Keyword" AS TaskTypeVal,1 AS TaskType,client_id,client_name,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_keyword 
		INNER JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id 
		INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_keyword_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		LEFT  JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_keyword.task_keyword_user_id AND consultant_rate.cons_rate_client_id = task_keyword_client_id AND cons_rate_service_type_id = task_keyword.task_keyword_service_type_id AND cons_rate_record_status = 0
		INNER JOIN client ON client.client_id = task_keyword.task_keyword_client_id
		INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
		', QryCond); 
			
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	ELSEIF(_taskType = 2) THEN
		
		SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND user.user_record_status=0 AND task_content.task_content_id IN (', _taskIds, ')');
	
		SET @IdQry1 = CONCAT(' SELECT task_content_no_of_units AS unitNo, (IFNULL(cons_rate_per_unit, serv_type_freel_rate)) * task_content_no_of_units  AS sumRate,   user.user_qb_ref_id,
	 "Task Content" AS TaskTypeVal,2 AS TaskType,client_id,client_name,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_content 
		INNER JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id 
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_content_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		LEFT JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_content.task_content_user_id AND consultant_rate.cons_rate_client_id = task_content_client_id AND cons_rate_service_type_id = task_content.task_content_service_type_id AND cons_rate_record_status = 0
		INNER JOIN client ON client.client_id = task_content.task_content_client_id
		INNER JOIN user ON user.user_id = task_content.task_content_user_id
		', QryCond); 
		
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	END IF;


END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskDataForQbInvoice
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskDataForQbInvoice`(
_taskIds VARCHAR(255),
_taskType TINYINT(1)
)
BEGIN
	DECLARE QryCond TEXT;
	
	IF(_taskType = 1) THEN
	  
		SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND user.user_record_status=0 AND task_keyword.task_keyword_id IN (', _taskIds, ')');
		
		SET @IdQry1 = CONCAT(' SELECT 
		"Task Keyword" AS TaskTypeVal,1 AS TaskType,client_id,client_name,client_qb_ref_id, IF(client_qb_associated_reference>0, client_qb_associated_reference, client_qb_ref_qb_id) AS client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name,
		division_code AS divisionCode, serv_type_qb_id, service_type.serv_type_name , service_type.serv_type_gal_rate,
		SUM(task_keyword_no_of_pages) AS  invQty, SUM(task_keyword_no_of_pages) * serv_type_gal_rate AS qtyRate, serv_type_id
		FROM task_keyword 
		INNER JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id 
		INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_keyword_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		INNER JOIN client ON client.client_id = task_keyword.task_keyword_client_id
		INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
		', QryCond, ' GROUP by division.division_id,service_type.serv_type_id '); 
			
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	ELSEIF(_taskType = 2) THEN
		
		SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND user.user_record_status=0 AND task_content.task_content_id IN (', _taskIds, ')');
	
		SET @IdQry1 = CONCAT(' SELECT  
	 "Task Content" AS TaskTypeVal,2 AS TaskType,client_id,client_name,client_qb_ref_id,IF(client_qb_associated_reference>0, client_qb_associated_reference, client_qb_ref_qb_id) AS client_qb_ref_qb_id ,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name,
		division_code AS divisionCode, serv_type_qb_id, service_type.serv_type_name , service_type.serv_type_gal_rate,
		SUM(task_content_no_of_units) AS invQty, SUM(task_content_no_of_units) * serv_type_gal_rate AS qtyRate,serv_type_id
		FROM task_content 
		INNER JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id 
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_content_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		INNER JOIN client ON client.client_id = task_content.task_content_client_id
		INNER JOIN user ON user.user_id = task_content.task_content_user_id
		', QryCond, ' GROUP by division.division_id,service_type.serv_type_id '); 
		
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	END IF;


END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskManagerContentById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskManagerContentById`(
_userId INT(11),
_taskContentId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_content.task_content_id,task_content.task_content_marsha_code,task_content.task_content_service_type_id,task_content.task_content_tire,task_content.task_content_priority,task_content.task_content_added_box_date,task_content.task_content_due_date,task_content.task_content_due_plus_date,task_content.task_content_added_box_due_date,task_content.task_content_rev_req,task_content.task_content_rev_com,task_content.task_content_rev_sec_req,task_content.task_content_rev_sec_com,task_content.task_content_ass_writer_date,task_content.task_content_is_complete,task_content.task_content_proj_com_date,task_content.task_content_user_id,task_content.task_content_no_of_units,task_content.task_content_link_to_file,task_content.task_content_notes,task_content.task_content_record_status,task_content.task_content_created_by,task_content.task_content_created_on,task_content.task_content_modified_by,task_content.task_content_modified_on,service_type.serv_type_id,service_type.serv_type_name,task_content.task_content_upload_link
	FROM task_content 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT JOIN user ON user.user_id = task_content.task_content_user_id
	LEFT JOIN user_role ON user_role.user_role_id = user.user_role_id
	LEFT JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskManagerContentByIdForAlert
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskManagerContentByIdForAlert`(
_taskContentId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE  task_content.task_content_record_status=0 AND task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' SELECT client_entity_marsha_code AS attrCode,division_id,division_code AS attrDivCode, service_type.serv_type_name AS attrServiceTypeName
	FROM task_content 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT  JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskManagerContentList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskManagerContentList`(
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
_divisionId INT(11)
)
BEGIN
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
	ELSEIF(_divisionId && _filterBy = 4) THEN
	  SET QryCond = CONCAT(QryCond, " AND client_entity.client_entity_division_id =", _divisionId );
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
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
		LEFT JOIN user ON user.user_id = task_content.task_content_user_id AND user.user_record_status = 0
		LEFT JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_content.task_content_id,task_content.task_content_marsha_code,task_content.task_content_service_type_id,task_content.task_content_tire,task_content.task_content_priority,task_content.task_content_added_box_date,task_content.task_content_due_date,task_content.task_content_due_plus_date,task_content.task_content_added_box_due_date,task_content.task_content_rev_req,task_content.task_content_rev_com,task_content.task_content_rev_sec_req,task_content.task_content_rev_sec_com,task_content.task_content_ass_writer_date,task_content.task_content_is_complete,task_content.task_content_proj_com_date,task_content.task_content_user_id,task_content.task_content_no_of_units,task_content.task_content_link_to_file,task_content.task_content_notes,task_content.task_content_record_status,task_content.task_content_created_by,task_content.task_content_created_on,task_content.task_content_modified_by,task_content.task_content_modified_on,service_type.serv_type_id,service_type.serv_type_name,task_content.task_content_admin_complete,task_content.task_content_admin_notes,task_content.task_content_upload_link,task_content_qb_process,task_content_qb_inv_process
	FROM task_content 
	INNER JOIN tmpTaskContentManager ON tmpTaskContentManager.task_content_id = task_content.task_content_id
	INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT JOIN user ON user.user_id = task_content.task_content_user_id AND user.user_record_status = 0
	LEFT JOIN user_role ON user_role.user_role_id = user.user_role_id
	LEFT JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpTaskContentManager;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskManagerKeywordById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskManagerKeywordById`(
_userId INT(11),
_taskKeywordId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name, user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_keyword.task_keyword_id,task_keyword.task_keyword_marsha_code,task_keyword_tire,task_keyword.task_keyword_no_of_pages,task_keyword.task_keyword_notes,task_keyword.task_keyword_box_location,task_keyword.task_keyword_added_box_date,task_keyword.task_keyword_setup_due_date,task_keyword.task_keyword_setup_complete,task_keyword.task_keyword_due,task_keyword.task_keyword_submitted,task_keyword.task_keyword_user_id,task_keyword.task_keyword_link_db_file,task_keyword.task_keyword_date,task_keyword.task_keyword_admin_complete,task_keyword.task_keyword_client_id,task_keyword.task_keyword_admin_notes,task_keyword.task_keyword_record_status,task_keyword.task_keyword_created_by,task_keyword.task_keyword_created_on,task_keyword.task_keyword_modified_by,task_keyword.task_keyword_modified_on,task_keyword.task_keyword_priority,task_keyword.task_keyword_service_type_id,task_keyword.task_is_sub_task,task_clone_id,task_clone_task_id,task_clone_is_main_task,task_clone_common_id
	FROM task_keyword 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	LEFT  JOIN task_clone ON task_clone.task_clone_task_id = ',_taskKeywordId,'
	LEFT JOIN user ON user.user_id = task_keyword.task_keyword_user_id
	LEFT JOIN user_role ON user_role.user_role_id = user.user_role_id
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskManagerKeywordByIdForAlert
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskManagerKeywordByIdForAlert`(
_taskKeywordId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' SELECT client_entity_id,client_entity_marsha_code AS attrCode,division_id,division_code AS attrDivCode,division_name,
	task_keyword.task_keyword_id,task_keyword.task_keyword_marsha_code,service_type.serv_type_id,service_type.serv_type_name AS attrServiceTypeName
	FROM task_keyword 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.getTaskManagerKeywordList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getTaskManagerKeywordList`(
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
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getUserById
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getUserById`(IN `_userId` INT(11))
BEGIN
	SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status, user.user_qb_ref_id
	FROM user 
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	WHERE user.user_id = _userId AND user.user_record_status = 0;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getUserIdByTaskId
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getUserIdByTaskId`(
_taskId INT(11),
_taskType TINYINT(1)
)
BEGIN
	DECLARE QryCond TEXT;
	
	IF(_taskType = 1) THEN
	
		SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND task_keyword.task_keyword_id = ',_taskId);
		
		SET @IdQry1 = CONCAT(' SELECT task_keyword_user_id AS moduleUserId, user_email, user.user_fname, user.user_lname FROM task_keyword  INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id ', QryCond, ' LIMIT 1'); 
		
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
	
	ELSEIF(_taskType = 2) THEN
	
		SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND task_content.task_content_id = ',_taskId);
		
		SET @IdQry1 = CONCAT(' SELECT task_content_user_id AS moduleUserId, user_email, user.user_fname, user.user_lname FROM task_content  INNER JOIN user ON user.user_id = task_content.task_content_user_id', QryCond, ' LIMIT 1'); 
		
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	END IF;
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getUserList
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getUserList`(
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
	
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getUsersByForm
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getUsersByForm`(IN `_roleId` INT(11),IN `_formStatus` TINYINT(1))
BEGIN

	DECLARE QryCond TEXT;
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 ');
	IF(_roleId > 0) THEN
		SET QryCond = CONCAT(QryCond, ' AND user_role.user_role_id =  ',_roleId);
	END IF;
	
	SET QryCond = CONCAT(QryCond, " AND user.user_form_completed =",_formStatus );
	
	SET @IdQry = CONCAT(' SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status 
	FROM user 
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id ', QryCond );
	
	PREPARE stmt1 FROM @IdQry;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getUsersByFormForClone
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getUsersByFormForClone`(IN `_roleId` INT(11),IN `_formStatus` TINYINT(1),IN `_taskUserId` INT(11))
BEGIN

	DECLARE QryCond TEXT;
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 ');
	IF(_roleId > 0) THEN
		SET QryCond = CONCAT(QryCond, ' AND user_role.user_role_id =  ',_roleId);
	END IF;
	
	SET QryCond = CONCAT(QryCond, " AND user.user_form_completed =",_formStatus," AND user.user_id !=",_taskUserId);
	
	SET @IdQry = CONCAT(' SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status 
	FROM user 
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id ', QryCond );
	
	PREPARE stmt1 FROM @IdQry;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getUsersByRole
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getUsersByRole`(IN `_roleId` INT(11))
BEGIN

	DECLARE QryCond TEXT;
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 ');
	IF(_roleId > 0) THEN
		SET QryCond = CONCAT(QryCond, ' AND user_role.user_role_id =  ',_roleId);
	END IF;
	
	SET @IdQry = CONCAT(' SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status 
	FROM user 
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id ', QryCond );
	
	PREPARE stmt1 FROM @IdQry;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.getUsersForForm
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `getUsersForForm`()
BEGIN
	DECLARE QryCond TEXT;
	SET QryCond = CONCAT(" WHERE user.user_form_completed = 0 AND user.user_record_status = 0 AND user_id NOT IN( SELECT form_user_id FROM form WHERE form_record_status=0) ");
	SET @IdQry = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname FROM user ', QryCond );
	PREPARE stmt1 FROM @IdQry;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
END//
DELIMITER ;

-- Dumping structure for table galileo.import_csv_fields
CREATE TABLE IF NOT EXISTS `import_csv_fields` (
  `icf_id` int(11) NOT NULL AUTO_INCREMENT,
  `icf_ic_id` int(11) NOT NULL DEFAULT '0',
  `icf_field_id` int(11) NOT NULL DEFAULT '0',
  `icf_field_name` varchar(250) NOT NULL DEFAULT '',
  `icf_user_id` int(11) NOT NULL DEFAULT '0',
  `icf_client_id` int(11) NOT NULL DEFAULT '0',
  `icf_is_unique` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`icf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Dumping data for table galileo.import_csv_fields: ~9 rows (approximately)
/*!40000 ALTER TABLE `import_csv_fields` DISABLE KEYS */;
INSERT INTO `import_csv_fields` (`icf_id`, `icf_ic_id`, `icf_field_id`, `icf_field_name`, `icf_user_id`, `icf_client_id`, `icf_is_unique`) VALUES
	(1, 1, 0, 'MARSHA', 10, 1, 0),
	(2, 1, 5, 'Notes', 10, 1, 0),
	(3, 3, 0, 'MARSHA', 10, 1, 1),
	(4, 3, 6, 'Notes', 10, 1, 0),
	(5, 5, 0, 'MARSHA', 10, 1, 0),
	(6, 6, 0, 'MARSHA', 10, 1, 0),
	(7, 7, 0, 'MARSHA', 10, 1, 0),
	(8, 9, 0, 'MARSHA', 10, 1, 0),
	(9, 9, 3, 'Date Added to BOX', 10, 1, 0);
/*!40000 ALTER TABLE `import_csv_fields` ENABLE KEYS */;

-- Dumping structure for table galileo.import_csv_file
CREATE TABLE IF NOT EXISTS `import_csv_file` (
  `ic_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `updated_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Dumping data for table galileo.import_csv_file: ~9 rows (approximately)
/*!40000 ALTER TABLE `import_csv_file` DISABLE KEYS */;
INSERT INTO `import_csv_file` (`ic_id`, `ic_file_name`, `ic_skip_header`, `ic_status`, `ic_user_id`, `ic_client_id`, `ic_unique_field`, `ic_import_opt`, `ic_import_type`, `ic_import_keyword_date`, `ic_est_time`, `ic_record_status`, `created_by`, `created_date`, `updated_date`) VALUES
	(1, '2018_02_13_12_31_Galileo_Monthly Batches Tracker_February.xlsx.csv', 1, 3, 10, 1, 0, 0, 1, '2018-02-01', '0000-00-00 00:00:00', 0, 10, '2018-02-13 12:32:05', '2018-02-13 17:36:01'),
	(2, '2018_02_13_13_03_Galileo_Monthly Batches Tracker_February.xlsx.csv', 0, 0, 10, 1, 0, 2, 1, '2018-02-01', '0000-00-00 00:00:00', 0, 10, '2018-02-13 13:04:10', '2018-02-13 13:04:10'),
	(3, '2018_02_13_13_07_Galileo_Monthly Batches Tracker_February.xlsx.csv', 0, 3, 10, 1, 0, 2, 1, '2018-02-01', '0000-00-00 00:00:00', 0, 10, '2018-02-13 13:08:35', '2018-02-13 18:12:01'),
	(4, '2018_02_13_13_14_Galileo_Monthly Batches Tracker_February.xlsx.csv', 0, 0, 10, 1, 0, 2, 1, '2018-02-01', '0000-00-00 00:00:00', 0, 10, '2018-02-13 13:15:02', '2018-02-13 13:15:02'),
	(5, '2018_02_13_13_58_Galileo_Monthly Batches Tracker_January 2018.csv', 1, 3, 10, 1, 0, 0, 1, '2018-01-01', '0000-00-00 00:00:00', 0, 10, '2018-02-13 13:58:33', '2018-02-13 19:00:01'),
	(6, '2018_02_13_14_01_Galileo_Monthly Batches Tracker_January 2018.csv', 0, 3, 10, 1, 0, 0, 1, '2018-01-01', '0000-00-00 00:00:00', 0, 10, '2018-02-13 14:01:30', '2018-02-13 19:02:01'),
	(7, '2018_02_14_11_18_Galileo_Monthly Batches Tracker_February.xlsx.csv', 1, 3, 10, 1, 0, 0, 1, '2018-02-01', '0000-00-00 00:00:00', 0, 10, '2018-02-14 11:18:51', '2018-02-14 16:24:01'),
	(8, '2018_02_19_12_18_Marriott - Keyword Delivery Schedule - Feb 2018.csv', 0, 0, 10, 1, 0, 0, 1, '2018-02-01', '0000-00-00 00:00:00', 0, 10, '2018-02-19 12:18:30', '2018-02-19 12:18:30'),
	(9, '2018_02_19_12_54_Marriott - Keyword Delivery Schedule - Feb 2018.csv', 0, 3, 10, 1, 0, 0, 1, '2018-02-01', '0000-00-00 00:00:00', 0, 10, '2018-02-19 12:54:30', '2018-02-19 17:58:01');
/*!40000 ALTER TABLE `import_csv_file` ENABLE KEYS */;

-- Dumping structure for table galileo.invoice
CREATE TABLE IF NOT EXISTS `invoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_user_id` int(11) NOT NULL DEFAULT '0',
  `invoice_client_id` int(11) NOT NULL DEFAULT '0',
  `invoice_invoice_id` int(11) NOT NULL DEFAULT '0',
  `invoice_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `invoice_date` date NOT NULL DEFAULT '0000-00-00',
  `invoice_is_qbprocessed` tinyint(1) NOT NULL DEFAULT '0',
  `invoice_qbreference_no` varchar(100) NOT NULL DEFAULT '',
  `invoice_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `invoice_created_by` int(11) NOT NULL DEFAULT '0',
  `invoice_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoice_modified_by` int(11) NOT NULL DEFAULT '0',
  `invoice_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.invoice: ~0 rows (approximately)
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;

-- Dumping structure for table galileo.invoice_old
CREATE TABLE IF NOT EXISTS `invoice_old` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `invoice_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.invoice_old: ~0 rows (approximately)
/*!40000 ALTER TABLE `invoice_old` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_old` ENABLE KEYS */;

-- Dumping structure for table galileo.invoice_rate
CREATE TABLE IF NOT EXISTS `invoice_rate` (
  `invoice_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_rate_client_id` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_service_type_id` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_division_id` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `invoice_rate_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `invoice_rate_created_by` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoice_rate_modified_by` int(11) NOT NULL DEFAULT '0',
  `invoice_rate_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`invoice_rate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.invoice_rate: ~0 rows (approximately)
/*!40000 ALTER TABLE `invoice_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_rate` ENABLE KEYS */;

-- Dumping structure for table galileo.invoice_task_reference
CREATE TABLE IF NOT EXISTS `invoice_task_reference` (
  `invoice_reference_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_reference_invoice_id` int(11) NOT NULL DEFAULT '0',
  `invoice_reference_client_name` varchar(255) NOT NULL DEFAULT '0',
  `invoice_reference_user_fname` varchar(155) NOT NULL DEFAULT '',
  `invoice_reference_user_lname` varchar(155) NOT NULL DEFAULT '',
  `invoice_reference_task_id` int(11) NOT NULL DEFAULT '0',
  `invoice_reference_task_user_id` int(11) NOT NULL DEFAULT '0',
  `invoice_reference_task_client_id` int(11) NOT NULL DEFAULT '0',
  `invoice_reference_service_qb_ref_id` int(11) NOT NULL DEFAULT '0',
  `invoice_reference_task_type` tinyint(1) NOT NULL DEFAULT '0',
  `invoice_reference_marsha_code` varchar(200) NOT NULL DEFAULT '',
  `invoice_reference_division_code` varchar(50) NOT NULL DEFAULT '',
  `invoice_reference_service_type_name` varchar(255) NOT NULL DEFAULT '',
  `invoice_reference_rate_per_unit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `invoice_reference_no_of_units` int(11) NOT NULL DEFAULT '0',
  `invoice_reference_tire` varchar(255) NOT NULL DEFAULT '',
  `invoice_reference_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `invoice_reference_created_by` int(11) NOT NULL DEFAULT '0',
  `invoice_reference_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoice_reference_modified_by` int(11) NOT NULL DEFAULT '0',
  `invoice_reference_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoice_reference_doc_number` bigint(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`invoice_reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.invoice_task_reference: ~0 rows (approximately)
/*!40000 ALTER TABLE `invoice_task_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_task_reference` ENABLE KEYS */;

-- Dumping structure for table galileo.modules
CREATE TABLE IF NOT EXISTS `modules` (
  `modules_id` int(11) NOT NULL AUTO_INCREMENT,
  `modules_name` varchar(255) NOT NULL DEFAULT '',
  `modules_desc` text NOT NULL,
  `modules_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `modules_created_by` int(11) NOT NULL DEFAULT '0',
  `modules_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modules_modified_by` int(11) NOT NULL DEFAULT '0',
  `modules_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`modules_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.modules: ~6 rows (approximately)
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` (`modules_id`, `modules_name`, `modules_desc`, `modules_record_status`, `modules_created_by`, `modules_created_on`, `modules_modified_by`, `modules_modified_on`) VALUES
	(1, 'Invoices', '', 1, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
	(2, 'Admin - Task Keyword Alert', 'This Alert will send to selected admin when consultant complete or reassign the Task Keyword', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
	(3, 'Admin - Task Content Alert', 'This Alert will send to selected admin when consultant complete or reassign the Task Content', 0, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
	(4, 'Billing', '', 1, 1, '2017-12-11 09:34:03', 1, '2017-12-11 09:34:03'),
	(5, 'Consultant - Task Keyword Alert', 'This Alert will send to all consultants when admin complete or reassign the Task Keyword', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00'),
	(6, 'Consultant - Task Content Alert', 'This Alert will send to all consultants when admin complete or reassign the Task Content', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;

-- Dumping structure for table galileo.notification
CREATE TABLE IF NOT EXISTS `notification` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_user_id` int(11) NOT NULL DEFAULT '0',
  `notification_client_id` int(11) NOT NULL DEFAULT '0',
  `notification_module_id` int(11) NOT NULL DEFAULT '0',
  `notification_email` varchar(100) NOT NULL DEFAULT '',
  `notification_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `notification_created_by` int(11) NOT NULL DEFAULT '0',
  `notification_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `notification_modified_by` int(11) NOT NULL DEFAULT '0',
  `notification_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.notification: ~11 rows (approximately)
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` (`notification_id`, `notification_user_id`, `notification_client_id`, `notification_module_id`, `notification_email`, `notification_record_status`, `notification_created_by`, `notification_created_on`, `notification_modified_by`, `notification_modified_on`) VALUES
	(1, 14, 1, 2, 'vasanth@sam.ai', 0, 1, '2018-01-09 08:04:48', 1, '2018-01-09 08:04:48'),
	(2, 14, 1, 3, 'vasanth@sam.ai', 0, 1, '2018-01-09 08:04:55', 1, '2018-02-08 12:58:43'),
	(3, 10, 1, 2, 'erin.miller@galileotechmedia.com', 0, 10, '2018-01-12 11:30:54', 10, '2018-01-12 11:31:28'),
	(4, 12, 1, 3, 'ergilliam2002@yahoo.com', 0, 10, '2018-01-12 11:31:13', 10, '2018-01-12 11:31:13'),
	(5, 10, 1, 3, 'erin.miller@galileotechmedia.com', 0, 10, '2018-01-12 11:31:38', 10, '2018-01-12 11:31:38'),
	(6, 59, 2, 2, 'jill.wright@galileotechmedia.com', 0, 10, '2018-02-02 06:16:35', 10, '2018-02-02 06:16:35'),
	(7, 59, 1, 2, 'jill.wright@galileotechmedia.com', 0, 1, '2018-02-02 08:39:36', 1, '2018-02-02 08:39:36'),
	(8, 59, 1, 3, 'jill.wright@galileotechmedia.com', 0, 1, '2018-02-02 08:39:42', 1, '2018-02-02 08:39:42'),
	(9, 0, 1, 5, '', 0, 1, '2018-02-06 06:26:30', 1, '2018-02-06 09:04:19'),
	(10, 0, 1, 6, '', 0, 1, '2018-02-06 06:42:25', 1, '2018-02-06 06:42:25'),
	(11, 0, 5, 6, '', 0, 10, '2018-02-14 14:17:10', 10, '2018-02-14 14:17:10');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;

-- Dumping structure for table galileo.qb_class_reference
CREATE TABLE IF NOT EXISTS `qb_class_reference` (
  `qb_cls_ref_id` int(11) NOT NULL AUTO_INCREMENT,
  `qb_cls_ref_class_id` varchar(100) NOT NULL DEFAULT '',
  `qb_cls_ref_class_name` varchar(255) NOT NULL DEFAULT '',
  `qb_cls_ref_client_id` int(11) NOT NULL DEFAULT '0',
  `qb_cls_ref_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `qb_cls_ref_created_by` int(11) NOT NULL DEFAULT '0',
  `qb_cls_ref_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `qb_cls_ref_modified_by` int(11) NOT NULL DEFAULT '0',
  `qb_cls_ref_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`qb_cls_ref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.qb_class_reference: ~2 rows (approximately)
/*!40000 ALTER TABLE `qb_class_reference` DISABLE KEYS */;
INSERT INTO `qb_class_reference` (`qb_cls_ref_id`, `qb_cls_ref_class_id`, `qb_cls_ref_class_name`, `qb_cls_ref_client_id`, `qb_cls_ref_record_status`, `qb_cls_ref_created_by`, `qb_cls_ref_created_on`, `qb_cls_ref_modified_by`, `qb_cls_ref_modified_on`) VALUES
	(1, '3000000000001201296', 'Marriott', 1, 0, 1, '2018-01-18 06:24:22', 1, '2018-01-24 09:12:09'),
	(2, '5000000000000042928', 'Developer Test For NON EU', 1, 1, 1, '2018-01-18 06:24:39', 1, '2018-01-24 09:12:22');
/*!40000 ALTER TABLE `qb_class_reference` ENABLE KEYS */;

-- Dumping structure for table galileo.qb_client_token
CREATE TABLE IF NOT EXISTS `qb_client_token` (
  `qb_client_token_id` int(11) NOT NULL AUTO_INCREMENT,
  `qb_client_token_auth_mode` varchar(100) NOT NULL DEFAULT '',
  `qb_client_token_client_id` varchar(255) NOT NULL DEFAULT '',
  `qb_client_token_client_secret` varchar(255) NOT NULL DEFAULT '',
  `qb_client_token_refresh_token` varchar(255) NOT NULL DEFAULT '',
  `qb_client_token_access_token` text NOT NULL,
  `qb_client_token_qbo_real_id` varchar(255) NOT NULL DEFAULT '',
  `qb_client_token_base_url` varchar(255) NOT NULL DEFAULT '',
  `qb_client_token_current_refresh_token` varchar(255) NOT NULL DEFAULT '',
  `qb_client_token_app_client_id` int(11) NOT NULL DEFAULT '0',
  `qb_client_token_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `qb_client_token_created_by` int(11) NOT NULL DEFAULT '0',
  `qb_client_token_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `qb_client_token_modified_by` int(11) NOT NULL DEFAULT '0',
  `qb_client_token_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`qb_client_token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.qb_client_token: ~1 rows (approximately)
/*!40000 ALTER TABLE `qb_client_token` DISABLE KEYS */;
INSERT INTO `qb_client_token` (`qb_client_token_id`, `qb_client_token_auth_mode`, `qb_client_token_client_id`, `qb_client_token_client_secret`, `qb_client_token_refresh_token`, `qb_client_token_access_token`, `qb_client_token_qbo_real_id`, `qb_client_token_base_url`, `qb_client_token_current_refresh_token`, `qb_client_token_app_client_id`, `qb_client_token_record_status`, `qb_client_token_created_by`, `qb_client_token_created_on`, `qb_client_token_modified_by`, `qb_client_token_modified_on`) VALUES
	(1, 'oauth2', 'Q0alGFIlSJzW9jmjEcpaaZI1g1fh0pyHa4h1O5NP4q21bgOKwp', 'TkzSsvHqJgMfQLfT0iyWuDWsVLc0Na3dUqkvYCvB', 'Q0115277986024LLR4zAigu2wW7uESQnUZVWqOgbr6JMNpQSPy', 'eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..i-qjeOBKsEdwm2LUD90Mdg.PpBMXFvb57s3G0QsARARQO42M0ASvhRxEXUulDNS8PPEVHcud3_9CZn-mmM9azHKNH_96l_0CjSagOabvDxbUisdaHP_i-_8Rfavf27tUi4yaZorliNneyNMAccE549oC_69WxC3HzbgWJC0XDckVqDY7fKMdnQgttzaBCSknKXXPloMy6qROV37Cbbz-o1-9G6SjyWJ6IlLXVA4C94LRfK011LrW9K707UJZnMSx3n7STfYoA-C9yNVeO-M_eQT6qWocwGPy9NTjlicpJvhE_B3JZhN6AR07MBE7s0M6a4Q0XOtNjOM3pkeP5SqxLcfiexaRKsFoU1azf9iBWxBBsejAxJWlkD834ddSLa3hYcC6uBHmRrYeIvR0qAQC7rshjWQjrQc-avri5rwTQpNPLS30apu5uAiWR1ykvi4jONc940yF2M4xtvNKZA5kQOxZUuSh1vFq2OSJKxOSNvZhZG8sjaAowAzFdw1-gbEgCaqhNTWSPBaQzx3jKV7vVm7jG4ANng1i5KUZlvXrB9ZrPNPk1Bpvm2ch1Sp1mvaQ2zXCin5uqcWOm4YWgWIHvoqsAuu5pYfKMfRJLFgbMl5fkDfzCTfoGk67wWSsQFApHE9dRPbnp59pP7G_cZ9pqLw3bEN2n7DV9ndL5sFTse-S0E3TH-6F6A7BPHwZrPteedHTDNE5ByjGCNCwQve5XEq3KhImimHM9p2QlOK8PRh91iFyGPe-3Y4MDJNPgFK3SE.4oj9zOH-vbgRP6RMH9mLDQ', '1198423095', 'Production', 'Q0115277986024LLR4zAigu2wW7uESQnUZVWqOgbr6JMNpQSPy', 1, 0, 1, '2018-01-18 04:41:10', 1, '2018-02-20 10:30:01');
/*!40000 ALTER TABLE `qb_client_token` ENABLE KEYS */;

-- Dumping structure for table galileo.refresh_token_error
CREATE TABLE IF NOT EXISTS `refresh_token_error` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `error_message` text NOT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.refresh_token_error: ~56 rows (approximately)
/*!40000 ALTER TABLE `refresh_token_error` DISABLE KEYS */;
INSERT INTO `refresh_token_error` (`id`, `error_message`, `created_on`) VALUES
	(1, 'invalid_request', '2018-02-05 11:00:01'),
	(2, 'invalid_request', '2018-02-05 12:00:01'),
	(3, 'invalid_request', '2018-02-05 13:00:01'),
	(4, 'invalid_request', '2018-02-05 14:00:01'),
	(5, 'invalid_request', '2018-02-05 14:30:01'),
	(6, 'invalid_request', '2018-02-05 15:00:01'),
	(7, 'invalid_request', '2018-02-05 15:30:01'),
	(8, 'invalid_request', '2018-02-05 16:00:01'),
	(9, 'invalid_request', '2018-02-05 16:30:01'),
	(10, 'invalid_request', '2018-02-05 17:00:01'),
	(11, 'invalid_request', '2018-02-05 17:30:01'),
	(12, 'invalid_request', '2018-02-05 18:00:01'),
	(13, 'invalid_request', '2018-02-05 18:30:01'),
	(14, 'invalid_request', '2018-02-05 19:00:01'),
	(15, 'invalid_request', '2018-02-05 19:30:01'),
	(16, 'invalid_request', '2018-02-05 20:00:01'),
	(17, 'invalid_request', '2018-02-05 20:30:01'),
	(18, 'invalid_request', '2018-02-05 21:00:01'),
	(19, 'invalid_request', '2018-02-05 21:30:02'),
	(20, 'invalid_request', '2018-02-05 22:00:01'),
	(21, 'invalid_request', '2018-02-05 22:30:01'),
	(22, 'invalid_request', '2018-02-05 23:00:01'),
	(23, 'invalid_request', '2018-02-05 23:30:01'),
	(24, 'invalid_request', '2018-02-06 00:00:01'),
	(25, 'invalid_request', '2018-02-06 00:30:01'),
	(26, 'invalid_request', '2018-02-06 01:00:01'),
	(27, 'invalid_request', '2018-02-06 01:30:01'),
	(28, 'invalid_request', '2018-02-06 02:00:01'),
	(29, 'invalid_request', '2018-02-06 02:30:01'),
	(30, 'invalid_request', '2018-02-06 03:00:01'),
	(31, 'invalid_request', '2018-02-06 03:30:01'),
	(32, 'invalid_request', '2018-02-06 04:00:01'),
	(33, 'invalid_request', '2018-02-06 04:30:01'),
	(34, 'invalid_request', '2018-02-06 05:00:01'),
	(35, 'invalid_request', '2018-02-06 05:30:01'),
	(36, 'invalid_request', '2018-02-06 06:00:01'),
	(37, 'invalid_request', '2018-02-06 06:30:01'),
	(38, 'invalid_request', '2018-02-06 07:00:01'),
	(39, 'invalid_request', '2018-02-06 07:30:01'),
	(40, 'invalid_request', '2018-02-06 08:00:01'),
	(41, 'invalid_request', '2018-02-06 08:30:01'),
	(42, 'invalid_request', '2018-02-06 09:00:01'),
	(43, 'invalid_request', '2018-02-06 09:30:01'),
	(44, 'invalid_request', '2018-02-06 10:00:01'),
	(45, 'invalid_request', '2018-02-06 10:30:01'),
	(46, 'invalid_request', '2018-02-06 11:00:01'),
	(47, 'invalid_request', '2018-02-06 11:30:01'),
	(48, 'invalid_request', '2018-02-06 12:00:01'),
	(49, 'invalid_request', '2018-02-06 12:30:01'),
	(50, 'invalid_request', '2018-02-06 13:00:01'),
	(51, 'invalid_request', '2018-02-06 13:30:01'),
	(52, 'invalid_request', '2018-02-06 14:00:01'),
	(53, 'invalid_request', '2018-02-06 14:30:01'),
	(54, 'invalid_request', '2018-02-06 15:00:01'),
	(55, 'invalid_request', '2018-02-06 15:30:01'),
	(56, 'invalid_request', '2018-02-06 16:00:01');
/*!40000 ALTER TABLE `refresh_token_error` ENABLE KEYS */;

-- Dumping structure for table galileo.service_type
CREATE TABLE IF NOT EXISTS `service_type` (
  `serv_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `serv_type_qb_id` int(11) NOT NULL DEFAULT '0',
  `serv_type_task_type` tinyint(1) NOT NULL DEFAULT '2',
  `serv_type_name` varchar(255) NOT NULL DEFAULT '',
  `serv_type_client_id` int(11) NOT NULL DEFAULT '0',
  `serv_type_gal_rate` decimal(15,2) NOT NULL DEFAULT '0.00',
  `serv_type_freel_rate` decimal(15,2) NOT NULL DEFAULT '0.00',
  `serv_type_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `serv_type_created_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `serv_type_modified_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`serv_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.service_type: ~58 rows (approximately)
/*!40000 ALTER TABLE `service_type` DISABLE KEYS */;
INSERT INTO `service_type` (`serv_type_id`, `serv_type_qb_id`, `serv_type_task_type`, `serv_type_name`, `serv_type_client_id`, `serv_type_gal_rate`, `serv_type_freel_rate`, `serv_type_record_status`, `serv_type_created_by`, `serv_type_created_on`, `serv_type_modified_by`, `serv_type_modified_on`) VALUES
	(1, 63, 2, 'Content + Meta', 1, 33.00, 18.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:03:40'),
	(2, 86, 2, 'Photo Gallery Optimization', 1, 45.00, 25.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:18:02'),
	(3, 74, 2, 'REFRESH - Content + Meta', 1, 29.00, 12.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(4, 64, 2, 'Meta Only', 1, 20.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:15:22'),
	(5, 76, 2, 'TBD', 1, 20.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(6, 69, 1, 'Keyword Research', 1, 32.00, 7.50, 0, 1, '2018-01-03 06:16:20', 10, '2018-02-19 14:00:03'),
	(7, 140, 2, 'Keyword Selection', 1, 32.00, 7.50, 1, 1, '2018-01-03 06:16:20', 10, '2018-02-19 14:00:27'),
	(11, 64, 2, 'REFRESH - Meta Only', 1, 17.00, 6.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:22:30'),
	(12, 73, 2, 'Digital Demand Generation: Offers', 1, 25.00, 15.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:06:21'),
	(13, 72, 2, 'Digital Demand Generation: Emails', 1, 25.00, 15.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:05:23'),
	(14, 129, 2, 'Digital Demand Generation: Emails - Additional Property', 1, 5.00, 3.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:05:45'),
	(15, 102, 2, 'Digital Demand Generation: Landing Pages', 1, 35.00, 25.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:06:08'),
	(16, 84, 2, 'Hotel Marketing Captions', 1, 6.00, 3.50, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(17, 85, 2, 'Hotel Marketing Captions - 20 or more', 1, 5.00, 3.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(18, 86, 2, '2 H2 Headlines', 1, 9.00, 5.50, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:01:24'),
	(19, 87, 2, '2 H2 Headlines- 20 or more', 1, 8.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(20, 88, 2, '3 H2 Headlines - 20 or more', 1, 11.00, 7.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(21, 46, 2, 'Press Releases', 1, 90.00, 50.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:19:50'),
	(22, 90, 2, 'Marketing Description [255 Characters]', 1, 8.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(23, 91, 2, 'Marketing Description [255 Characters] - 20 or more', 1, 7.00, 4.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(24, 98, 2, 'Caption [100 Characters]', 1, 7.00, 4.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:02:48'),
	(25, 93, 2, 'Caption [100 Characters] - 20 or more', 1, 5.00, 3.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(26, 100, 2, 'Property Description [255 Characters]', 1, 8.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:20:16'),
	(27, 95, 2, 'Property Description [255 Characters] - 20 or more', 1, 7.00, 4.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(28, 126, 2, 'Marriott Meetings Description [500 Characters]', 1, 20.00, 9.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:14:56'),
	(29, 97, 2, 'Social Media Audit', 1, 110.00, 50.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(30, 88, 2, 'Local Citation Audit', 1, 64.00, 20.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:10:03'),
	(32, 99, 2, 'Social Optimization - 4 Channels', 1, 135.00, 45.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(33, 90, 2, 'Social Optimization - GMB', 1, 32.50, 11.25, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:25:32'),
	(34, 91, 2, 'Social Optimization - TripAdvisor', 1, 25.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:26:39'),
	(35, 127, 2, 'Expedia Ad Copy', 1, 10.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:06:46'),
	(36, 132, 2, 'Datacube Rank Reports - 6 pages - Foundations', 1, 28.00, 15.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:04:33'),
	(37, 131, 2, 'Datacube Rank Reports - 1 page - Signature', 1, 20.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:04:10'),
	(38, 139, 2, 'HWS Scrapes', 1, 12.00, 6.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:07:31'),
	(39, 138, 2, 'Photo Gallery Scrapes', 1, 12.00, 6.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:18:30'),
	(40, 107, 2, 'Photo Tour Optimization - 20 captions HWS', 1, 40.00, 20.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(41, 134, 2, 'Module Content + Meta - Per Module Page', 1, 65.00, 32.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:16:00'),
	(42, 133, 2, 'Module Content + Meta - Refresh - Per Module Page', 1, 45.00, 20.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-24 06:16:34'),
	(43, 110, 2, 'Yext Descriptions [250 Characters] + Upload [part of Scrape]', 1, 9.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(44, 111, 2, 'Yext Descriptions [250 Characters] + Upload [separate from Scrape]', 1, 11.00, 6.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(45, 112, 2, 'Restaurant Site - CALA - per page - Content + Build', 1, 100.00, 43.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(46, 113, 2, 'Special Offers Pages - CALA - per offer', 1, 15.00, 8.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(47, 114, 2, 'Submit Guest Communications: Reservation Related Offer', 1, 28.00, 14.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(48, 115, 2, 'Submit Guest Communications: Ad Hoc Bounce Back Offers', 1, 28.00, 14.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(49, 116, 2, 'Submit Guest Communications: Essential Guest Notification', 1, 10.00, 3.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(50, 117, 2, 'UK TableRes Restaurant Descriptions + Meta', 1, 28.00, 12.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(51, 118, 2, 'Photo Distribution - 5-9 Captions - OTA + HWS - Price Per Caption', 1, 2.50, 1.50, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(52, 119, 2, 'Photo Distribution - 10-39 Captions - OTA + HWS - Price Per Caption', 1, 1.75, 1.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(53, 120, 2, 'Photo Distribution - > 40 captions - OTA + HWS - Price Per Caption', 1, 1.50, 0.75, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(54, 121, 2, 'Social Optimization - TripAdvisor Outlets - Price Per Outlet', 1, 25.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(55, 121, 2, 'Ritz Carlton Content per Page', 1, 75.00, 25.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(56, 0, 2, 'Joseph test', 1, 100.00, 30.00, 1, 10, '2018-01-12 11:20:34', 10, '2018-01-12 11:22:50'),
	(57, 0, 2, 'jfm test', 1, 200.00, 400.00, 1, 10, '2018-01-12 11:23:08', 1, '2018-01-24 06:08:12'),
	(58, 0, 2, 'jfm test 2', 1, 0.00, -1.00, 1, 10, '2018-01-12 11:23:58', 1, '2018-01-24 06:08:15'),
	(59, 0, 2, 'aaaa', 1, 2.14, 1.23, 1, 1, '2018-01-16 09:40:48', 1, '2018-01-16 09:41:34'),
	(60, 123, 2, 'aaa', 1, 12.00, 12.00, 1, 1, '2018-01-24 06:01:35', 1, '2018-01-24 06:01:45'),
	(61, 0, 2, 'aaa', 1, 4.00, 4.00, 1, 1, '2018-01-24 08:55:05', 1, '2018-01-24 08:55:21'),
	(62, 0, 1, 'Keyword File Set Up - Per Hotel', 1, 0.00, 0.00, 0, 1, '2018-01-25 14:02:09', 10, '2018-02-19 14:02:47'),
	(63, 0, 2, 'Amazon SEO Product Page Content', 4, 65.00, 25.00, 0, 10, '2018-02-02 06:25:29', 10, '2018-02-14 10:32:41'),
	(64, 0, 1, 'Keyword Research - Refresh', 1, 32.00, 7.50, 0, 1, '2018-02-02 09:06:24', 10, '2018-02-19 14:00:41'),
	(65, 120, 2, 'Amazon SEO Product Pages - Parent Page', 5, 65.00, 30.00, 0, 10, '2018-02-14 10:34:06', 10, '2018-02-14 10:34:06'),
	(66, 120, 2, 'Amazon SEO Product Pages - Child Page', 5, 25.00, 12.00, 0, 10, '2018-02-14 10:34:23', 10, '2018-02-14 10:34:23');
/*!40000 ALTER TABLE `service_type` ENABLE KEYS */;

-- Dumping structure for table galileo.service_type_jan3
CREATE TABLE IF NOT EXISTS `service_type_jan3` (
  `serv_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `serv_type_name` varchar(255) NOT NULL DEFAULT '',
  `serv_type_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `serv_type_created_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `serv_type_modified_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`serv_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.service_type_jan3: ~51 rows (approximately)
/*!40000 ALTER TABLE `service_type_jan3` DISABLE KEYS */;
INSERT INTO `service_type_jan3` (`serv_type_id`, `serv_type_name`, `serv_type_record_status`, `serv_type_created_by`, `serv_type_created_on`, `serv_type_modified_by`, `serv_type_modified_on`) VALUES
	(1, 'Content + Meta', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(2, 'Photo Gallery Optimization', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(3, 'REFRESH - Content + Meta', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(4, 'Meta Only', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(5, 'TBD', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(6, 'Keyword Research\r\n', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(7, 'Keyword Selection', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(11, 'REFRESH - Meta Only', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(12, 'Digital Demand Generation: Offers', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(13, 'Digital Demand Generation: Emails', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(14, 'Digital Demand Generation: Emails - Additional Property', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(15, 'Digital Demand Generation: Landing Pages', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(16, 'Hotel Marketing Captions', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(17, 'Hotel Marketing Captions - 20 or more', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(18, '2 H2 Headlines', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(19, '2 H2 Headlines- 20 or more', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(20, '3 H2 Headlines - 20 or more', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(21, 'Press Releases', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(22, 'Marketing Description [255 Characters]', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(23, 'Marketing Description [255 Characters] - 20 or more', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(24, 'Caption [100 Characters]', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(25, 'Caption [100 Characters] - 20 or more', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(26, 'Property Description [255 Characters]', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(27, 'Property Description [255 Characters] - 20 or more', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(28, 'Marriott Meetings Description [500 Characters]', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(29, 'Social Media Audit', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(30, 'Local Citation Audit', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(32, 'Social Optimization - 4 Channels', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(33, 'Social Optimization - GMB', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(34, 'Social Optimization - TripAdvisor', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(35, 'Expedia Ad Copy', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(36, 'Datacube Rank Reports - 6 pages - Foundations', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(37, 'Datacube Rank Reports - 1 page - Signature', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(38, 'HWS Scrapes', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(39, 'Photo Gallery Scrapes', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(40, 'Photo Tour Optimization - 20 captions HWS', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(41, 'Module Content + Meta - Per Module Page', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(42, 'Module Content + Meta - Refresh - Per Module Page', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(43, 'Yext Descriptions [250 Characters] + Upload [part of Scrape]', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(44, 'Yext Descriptions [250 Characters] + Upload [separate from Scrape]', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(45, 'Restaurant Site - CALA - per page - Content + Build', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(46, 'Special Offers Pages - CALA - per offer', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(47, 'Submit Guest Communications: Reservation Related Offer', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(48, 'Submit Guest Communications: Ad Hoc Bounce Back Offers', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(49, 'Submit Guest Communications: Essential Guest Notification', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(50, 'UK TableRes Restaurant Descriptions + Meta', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(51, 'Photo Distribution - 5-9 Captions - OTA + HWS - Price Per Caption', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(52, 'Photo Distribution - 10-39 Captions - OTA + HWS - Price Per Caption', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(53, 'Photo Distribution - > 40 captions - OTA + HWS - Price Per Caption', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(54, 'Social Optimization - TripAdvisor Outlets - Price Per Outlet', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(55, 'Ritz Carlton Content per Page', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20');
/*!40000 ALTER TABLE `service_type_jan3` ENABLE KEYS */;

-- Dumping structure for table galileo.service_type_jan8
CREATE TABLE IF NOT EXISTS `service_type_jan8` (
  `serv_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `serv_type_name` varchar(255) NOT NULL DEFAULT '',
  `serv_type_client_id` int(11) NOT NULL DEFAULT '0',
  `serv_type_gal_rate` decimal(15,2) NOT NULL DEFAULT '0.00',
  `serv_type_freel_rate` decimal(15,2) NOT NULL DEFAULT '0.00',
  `serv_type_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `serv_type_created_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `serv_type_modified_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`serv_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.service_type_jan8: ~51 rows (approximately)
/*!40000 ALTER TABLE `service_type_jan8` DISABLE KEYS */;
INSERT INTO `service_type_jan8` (`serv_type_id`, `serv_type_name`, `serv_type_client_id`, `serv_type_gal_rate`, `serv_type_freel_rate`, `serv_type_record_status`, `serv_type_created_by`, `serv_type_created_on`, `serv_type_modified_by`, `serv_type_modified_on`) VALUES
	(1, 'Content + Meta', 1, 33.00, 18.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(2, 'Photo Gallery Optimization', 1, 45.00, 25.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(3, 'REFRESH - Content + Meta', 1, 29.00, 12.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(4, 'Meta Only', 1, 20.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(5, 'TBD', 1, 20.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(6, 'Keyword Research\r\n', 1, 32.00, 7.50, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(7, 'Keyword Selection', 1, 32.00, 7.50, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(11, 'REFRESH - Meta Only', 1, 17.00, 6.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(12, 'Digital Demand Generation: Offers', 1, 25.00, 15.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(13, 'Digital Demand Generation: Emails', 1, 25.00, 15.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(14, 'Digital Demand Generation: Emails - Additional Property', 1, 5.00, 3.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(15, 'Digital Demand Generation: Landing Pages', 1, 35.00, 25.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(16, 'Hotel Marketing Captions', 1, 6.00, 3.50, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(17, 'Hotel Marketing Captions - 20 or more', 1, 5.00, 3.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(18, '2 H2 Headlines', 1, 9.00, 5.50, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(19, '2 H2 Headlines- 20 or more', 1, 8.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(20, '3 H2 Headlines - 20 or more', 1, 11.00, 7.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(21, 'Press Releases', 1, 90.00, 50.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(22, 'Marketing Description [255 Characters]', 1, 8.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(23, 'Marketing Description [255 Characters] - 20 or more', 1, 7.00, 4.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(24, 'Caption [100 Characters]', 1, 7.00, 4.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(25, 'Caption [100 Characters] - 20 or more', 1, 5.00, 3.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(26, 'Property Description [255 Characters]', 1, 8.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(27, 'Property Description [255 Characters] - 20 or more', 1, 7.00, 4.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(28, 'Marriott Meetings Description [500 Characters]', 1, 20.00, 9.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(29, 'Social Media Audit', 1, 110.00, 50.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(30, 'Local Citation Audit', 1, 64.00, 20.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(32, 'Social Optimization - 4 Channels', 1, 135.00, 45.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(33, 'Social Optimization - GMB', 1, 32.50, 11.25, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(34, 'Social Optimization - TripAdvisor', 1, 25.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(35, 'Expedia Ad Copy', 1, 10.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(36, 'Datacube Rank Reports - 6 pages - Foundations', 1, 28.00, 15.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(37, 'Datacube Rank Reports - 1 page - Signature', 1, 20.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(38, 'HWS Scrapes', 1, 12.00, 6.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(39, 'Photo Gallery Scrapes', 1, 12.00, 6.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(40, 'Photo Tour Optimization - 20 captions HWS', 1, 40.00, 20.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(41, 'Module Content + Meta - Per Module Page', 1, 65.00, 32.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(42, 'Module Content + Meta - Refresh - Per Module Page', 1, 45.00, 20.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(43, 'Yext Descriptions [250 Characters] + Upload [part of Scrape]', 1, 9.00, 5.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(44, 'Yext Descriptions [250 Characters] + Upload [separate from Scrape]', 1, 11.00, 6.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(45, 'Restaurant Site - CALA - per page - Content + Build', 1, 100.00, 43.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(46, 'Special Offers Pages - CALA - per offer', 1, 15.00, 8.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(47, 'Submit Guest Communications: Reservation Related Offer', 1, 28.00, 14.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(48, 'Submit Guest Communications: Ad Hoc Bounce Back Offers', 1, 28.00, 14.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(49, 'Submit Guest Communications: Essential Guest Notification', 1, 10.00, 3.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(50, 'UK TableRes Restaurant Descriptions + Meta', 1, 28.00, 12.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(51, 'Photo Distribution - 5-9 Captions - OTA + HWS - Price Per Caption', 1, 2.50, 1.50, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(52, 'Photo Distribution - 10-39 Captions - OTA + HWS - Price Per Caption', 1, 1.75, 1.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(53, 'Photo Distribution - > 40 captions - OTA + HWS - Price Per Caption', 1, 1.50, 0.75, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(54, 'Social Optimization - TripAdvisor Outlets - Price Per Outlet', 1, 25.00, 10.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20'),
	(55, 'Ritz Carlton Content per Page', 1, 75.00, 25.00, 0, 1, '2018-01-03 06:16:20', 1, '2018-01-03 06:16:20');
/*!40000 ALTER TABLE `service_type_jan8` ENABLE KEYS */;

-- Dumping structure for table galileo.service_type_old
CREATE TABLE IF NOT EXISTS `service_type_old` (
  `serv_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `serv_type_name` varchar(255) NOT NULL DEFAULT '',
  `serv_type_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `serv_type_created_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `serv_type_modified_by` int(11) NOT NULL DEFAULT '0',
  `serv_type_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`serv_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.service_type_old: ~5 rows (approximately)
/*!40000 ALTER TABLE `service_type_old` DISABLE KEYS */;
INSERT INTO `service_type_old` (`serv_type_id`, `serv_type_name`, `serv_type_record_status`, `serv_type_created_by`, `serv_type_created_on`, `serv_type_modified_by`, `serv_type_modified_on`) VALUES
	(1, 'Meta + Content', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(2, 'Photo Gallery Optimization', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(3, 'Refersh + Content + Meta', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(4, 'Meta', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(5, 'TBD', 0, 1, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20'),
	(6, 'Keyword Research\r\n', 0, 0, '2017-11-16 06:16:20', 1, '2017-11-16 06:16:20');
/*!40000 ALTER TABLE `service_type_old` ENABLE KEYS */;

-- Dumping structure for table galileo.task_clone
CREATE TABLE IF NOT EXISTS `task_clone` (
  `task_clone_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_clone_task_id` int(11) NOT NULL DEFAULT '0',
  `task_clone_is_main_task` tinyint(1) NOT NULL DEFAULT '0',
  `task_clone_common_id` int(11) NOT NULL DEFAULT '0',
  `task_clone_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `task_clone_created_by` int(11) NOT NULL DEFAULT '0',
  `task_clone_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`task_clone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.task_clone: ~0 rows (approximately)
/*!40000 ALTER TABLE `task_clone` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_clone` ENABLE KEYS */;

-- Dumping structure for table galileo.task_content
CREATE TABLE IF NOT EXISTS `task_content` (
  `task_content_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_content_marsha_code` int(11) NOT NULL DEFAULT '0',
  `task_content_service_type_id` int(11) NOT NULL DEFAULT '0',
  `task_content_tire` varchar(255) NOT NULL DEFAULT '',
  `task_content_priority` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_added_box_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_due_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_due_plus_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_added_box_due_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_rev_req` date NOT NULL DEFAULT '0000-00-00',
  `task_content_rev_com` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_rev_sec_req` date NOT NULL DEFAULT '0000-00-00',
  `task_content_rev_sec_com` date NOT NULL DEFAULT '0000-00-00',
  `task_content_ass_writer_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_is_complete` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_admin_complete` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_admin_notes` text NOT NULL,
  `task_content_proj_com_date` date NOT NULL DEFAULT '0000-00-00',
  `task_content_user_id` int(11) NOT NULL DEFAULT '0',
  `task_content_client_id` int(11) NOT NULL DEFAULT '0',
  `task_content_no_of_units` int(11) NOT NULL DEFAULT '0',
  `task_content_link_to_file` text NOT NULL,
  `task_content_upload_link` text NOT NULL,
  `task_content_notes` text NOT NULL,
  `task_content_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_qb_process` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_qb_inv_process` tinyint(1) NOT NULL DEFAULT '0',
  `task_content_created_by` int(11) NOT NULL DEFAULT '0',
  `task_content_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `task_content_modified_by` int(11) NOT NULL DEFAULT '0',
  `task_content_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`task_content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.task_content: ~0 rows (approximately)
/*!40000 ALTER TABLE `task_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_content` ENABLE KEYS */;

-- Dumping structure for table galileo.task_content_admin_complete
CREATE TABLE IF NOT EXISTS `task_content_admin_complete` (
  `tcac_id` int(11) NOT NULL AUTO_INCREMENT,
  `tcac_task_content_id` int(11) NOT NULL DEFAULT '0',
  `tcac_comp_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=Completed, 2=Reassigned',
  `tcac_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `tcac_created_by` int(11) NOT NULL DEFAULT '0',
  `tcac_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tcac_modified_by` int(11) NOT NULL DEFAULT '0',
  `tcac_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tcac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.task_content_admin_complete: ~0 rows (approximately)
/*!40000 ALTER TABLE `task_content_admin_complete` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_content_admin_complete` ENABLE KEYS */;

-- Dumping structure for table galileo.task_keyword
CREATE TABLE IF NOT EXISTS `task_keyword` (
  `task_keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_is_sub_task` tinyint(1) NOT NULL DEFAULT '0',
  `task_keyword_marsha_code` int(11) NOT NULL DEFAULT '0',
  `task_keyword_no_of_pages` int(11) NOT NULL DEFAULT '0',
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
  `task_keyword_priority` tinyint(1) NOT NULL DEFAULT '0',
  `task_keyword_service_type_id` int(11) NOT NULL DEFAULT '6',
  `task_keyword_tire` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `task_keyword_qb_process` tinyint(1) NOT NULL DEFAULT '0',
  `task_keyword_qb_inv_process` tinyint(1) NOT NULL DEFAULT '0',
  `task_keyword_created_by` int(11) NOT NULL DEFAULT '0',
  `task_keyword_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `task_keyword_modified_by` int(11) NOT NULL DEFAULT '0',
  `task_keyword_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`task_keyword_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.task_keyword: ~17 rows (approximately)
/*!40000 ALTER TABLE `task_keyword` DISABLE KEYS */;
INSERT INTO `task_keyword` (`task_keyword_id`, `task_is_sub_task`, `task_keyword_marsha_code`, `task_keyword_no_of_pages`, `task_keyword_notes`, `task_keyword_box_location`, `task_keyword_added_box_date`, `task_keyword_setup_due_date`, `task_keyword_setup_complete`, `task_keyword_due`, `task_keyword_submitted`, `task_keyword_user_id`, `task_keyword_link_db_file`, `task_keyword_date`, `task_keyword_admin_complete`, `task_keyword_client_id`, `task_keyword_admin_notes`, `task_keyword_priority`, `task_keyword_service_type_id`, `task_keyword_tire`, `task_keyword_record_status`, `task_keyword_qb_process`, `task_keyword_qb_inv_process`, `task_keyword_created_by`, `task_keyword_created_on`, `task_keyword_modified_by`, `task_keyword_modified_on`) VALUES
	(1, 0, 0, 0, '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(2, 0, 1565, 0, '', '', '2018-02-13', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(3, 0, 1567, 0, '', '', '2018-02-13', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(4, 0, 1596, 0, '', '', '2018-02-12', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(5, 0, 44, 0, '', '', '2018-02-09', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(6, 0, 1675, 0, '', '', '2018-02-09', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(7, 0, 1722, 0, '', '', '2018-02-08', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(8, 0, 8, 0, '', '', '2018-02-05', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(9, 0, 1535, 0, '', '', '2018-02-19', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(10, 0, 1864, 0, '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(11, 0, 1865, 0, '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(12, 0, 1732, 0, '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(13, 0, 0, 0, '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(14, 0, 1885, 0, '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(15, 0, 1875, 0, '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(16, 0, 10, 0, '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01'),
	(17, 0, 1879, 0, '', '', '0000-00-00', '0000-00-00', 0, '0000-00-00', 0, 13, '', '2018-02-01', 0, 1, '', 0, 6, '', 0, 0, 0, 10, '2018-02-19 17:58:01', 10, '2018-02-19 17:58:01');
/*!40000 ALTER TABLE `task_keyword` ENABLE KEYS */;

-- Dumping structure for table galileo.task_keyword_admin_complete
CREATE TABLE IF NOT EXISTS `task_keyword_admin_complete` (
  `tkac_id` int(11) NOT NULL AUTO_INCREMENT,
  `tkac_task_keyword_id` int(11) NOT NULL DEFAULT '0',
  `tkac_comp_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=Completed, 2=Reassigned',
  `tkac_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `tkac_created_by` int(11) NOT NULL DEFAULT '0',
  `tkac_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tkac_modified_by` int(11) NOT NULL DEFAULT '0',
  `tkac_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tkac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.task_keyword_admin_complete: ~0 rows (approximately)
/*!40000 ALTER TABLE `task_keyword_admin_complete` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_keyword_admin_complete` ENABLE KEYS */;

-- Dumping structure for table galileo.task_keyword_old
CREATE TABLE IF NOT EXISTS `task_keyword_old` (
  `task_keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_keyword_marsha_code` int(11) NOT NULL DEFAULT '0',
  `task_keyword_tbd` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_link_db_file` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_foun_prog` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_expanded_seo` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_outlet_mark` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_no_of_pages` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_box_location` varchar(255) NOT NULL DEFAULT '',
  `task_keyword_added_box_date` date NOT NULL DEFAULT '0000-00-00',
  `task_keyword_setup_due_date` date NOT NULL DEFAULT '0000-00-00',
  `task_keyword_setup_file` text NOT NULL,
  `task_keyword_com_due_date` date NOT NULL DEFAULT '0000-00-00',
  `task_keyword_com_date` date NOT NULL DEFAULT '0000-00-00',
  `task_keyword_date` date NOT NULL DEFAULT '0000-00-00',
  `task_keyword_completed_uploaded` int(11) NOT NULL DEFAULT '0',
  `task_keyword_complete` tinyint(1) NOT NULL DEFAULT '0',
  `task_keyword_user_id` int(11) NOT NULL DEFAULT '0',
  `task_keyword_client_id` int(11) NOT NULL DEFAULT '0',
  `task_keyword_notes` text NOT NULL,
  `task_keyword_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `task_keyword_created_by` int(11) NOT NULL DEFAULT '0',
  `task_keyword_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `task_keyword_modified_by` int(11) NOT NULL DEFAULT '0',
  `task_keyword_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`task_keyword_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.task_keyword_old: ~10 rows (approximately)
/*!40000 ALTER TABLE `task_keyword_old` DISABLE KEYS */;
INSERT INTO `task_keyword_old` (`task_keyword_id`, `task_keyword_marsha_code`, `task_keyword_tbd`, `task_keyword_link_db_file`, `task_keyword_foun_prog`, `task_keyword_expanded_seo`, `task_keyword_outlet_mark`, `task_keyword_no_of_pages`, `task_keyword_box_location`, `task_keyword_added_box_date`, `task_keyword_setup_due_date`, `task_keyword_setup_file`, `task_keyword_com_due_date`, `task_keyword_com_date`, `task_keyword_date`, `task_keyword_completed_uploaded`, `task_keyword_complete`, `task_keyword_user_id`, `task_keyword_client_id`, `task_keyword_notes`, `task_keyword_record_status`, `task_keyword_created_by`, `task_keyword_created_on`, `task_keyword_modified_by`, `task_keyword_modified_on`) VALUES
	(1, 2, '', '', 'Program 1', 'SEO 1', 'Outlet 1', '1', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-02', '2017-11-07', '', '2017-12-06', '0000-00-00', '2017-11-01', 0, 1, 8, 1, 'Update  Vasa', 0, 1, '2017-12-07 17:52:01', 1, '2017-12-08 09:50:31'),
	(2, 3, '', '', 'Program 2', 'SEO 2', 'Outlet 2', '2', 'https://mdigitalservices.box.com/s/2gwauhr1ab37euoy56kzj0xinf6xu12s', '2017-11-02', '2017-11-07', '', '2017-11-16', '0000-00-00', '2017-11-01', 0, 0, 8, 1, 'Update', 0, 1, '2017-12-07 17:52:01', 1, '2017-12-07 17:54:01'),
	(3, 4, '', '', 'Program 3', 'SEO 3', 'Outlet 3', '4', 'https://mdigitalservices.box.com/s/usa6z828rkmwuduf6r71i78masyg4asz', '2017-11-02', '2017-11-07', '', '2017-11-16', '0000-00-00', '2017-11-01', 0, 0, 8, 1, 'Global Client Services', 0, 1, '2017-12-07 17:52:01', 1, '2017-12-07 17:54:01'),
	(4, 5, '', '', 'Program 4', 'SEO 4', 'Outlet 4', '1', 'https://mdigitalservices.box.com/s/dlfacofg3qtf6exfiys1rwsvzsotanli', '2017-11-10', '2017-11-15', '', '2017-11-27', '0000-00-00', '2017-11-01', 0, 0, 8, 1, 'Global Client Services', 0, 1, '2017-12-07 17:52:01', 1, '2017-12-07 17:54:01'),
	(5, 6, '', '', 'Program 5', 'SEO 5', '', '7', 'https://mdigitalservices.box.com/s/qfzprw11vxy3vr14p8r45jj5kbie4mzh', '2017-11-10', '2017-11-15', '', '2017-11-27', '0000-00-00', '2017-11-01', 0, 0, 8, 1, 'Update Vasa', 0, 1, '2017-12-07 17:52:01', 1, '2017-12-07 17:54:01'),
	(6, 7, '', '', 'Program 6', 'SEO 6', 'Outlet 6', '8', 'https://mdigitalservices.box.com/s/g54lcnt0g8e4xwx9egn7huj77q258wzz', '2017-11-13', '2017-11-18', '', '2017-11-29', '0000-00-00', '2017-11-01', 0, 0, 8, 1, 'Global Client Update', 0, 1, '2017-12-07 17:52:01', 1, '2017-12-07 17:54:01'),
	(7, 8, '', '', 'Program 7', 'SEO 7', 'Outlet 7', '1', 'https://mdigitalservices.box.com/s/jzow27ckk8avlo9gd4km1sskvwrm7tkx', '2017-11-13', '2017-11-18', '', '2017-11-29', '0000-00-00', '2017-11-01', 0, 0, 8, 1, 'Global Client Update', 0, 1, '2017-12-07 17:52:01', 1, '2017-12-07 17:54:01'),
	(8, 9, '', '', 'Program 8', 'SEO 8', 'Outlet 8', '3', 'https://mdigitalservices.box.com/s/8x1ftq2qp53t4t273ivdxwr6f4lxen7b', '2017-11-15', '2017-11-20', '', '2017-12-01', '0000-00-00', '2017-11-01', 0, 0, 8, 1, 'Global Client Update', 1, 1, '2017-12-07 17:52:01', 1, '2017-12-08 09:50:41'),
	(9, 10, '', '', 'Program 9', 'SEO 9', '', '11', 'https://mdigitalservices.box.com/s/qhjc0fcorqva2j7ne5l59tg8k4k6i4nj', '2017-11-16', '2017-11-21', '', '2017-12-04', '0000-00-00', '2017-11-01', 0, 0, 8, 1, 'Update Vasa', 0, 1, '2017-12-07 17:52:01', 1, '2017-12-07 17:54:01'),
	(10, 11, '', '', 'Program 10', 'SEO 10', 'Outlet 10', '2', 'https://mdigitalservices.box.com/s/24ttfbsc4ga9bh32nfffn9kvcwuagqsj', '2017-11-17', '2017-11-22', '', '2017-12-04', '0000-00-00', '2017-11-01', 0, 0, 8, 1, 'Update Vasa', 0, 1, '2017-12-07 17:52:01', 1, '2017-12-07 17:54:01');
/*!40000 ALTER TABLE `task_keyword_old` ENABLE KEYS */;

-- Dumping structure for procedure galileo.updateActivationLink
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateActivationLink`(
_userId INT(11),
_activationLink TEXT,
_dateExpire date
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 AND user.user_id = ',_userId);
	
	SET @IdQry1 = CONCAT(' UPDATE user SET  user_activation_link = ',Quote(_activationLink), ', user_activation_link_expire = ',Quote(_dateExpire), QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateAlertNotificationIsRead
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateAlertNotificationIsRead`(
_userId INT(11),
_alertId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE alert_notification_id = ',_alertId);
	
	SET @IdQry1 = CONCAT(' UPDATE alert_notification SET alert_notification_is_read = 1, alert_notification_modified_on = ',Quote(_dateTime), ', alert_notification_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateCsvImport
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateCsvImport`(IN `_csvImportId` INT, IN `_hasHeader` TINYINT, IN `_status` INT, IN `_importOpt` INT)
BEGIN
	UPDATE import_csv_file SET ic_skip_header = _hasHeader, ic_status = _status, ic_import_opt =_importOpt  WHERE ic_id = _csvImportId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateCsvStatus
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateCsvStatus`(IN `_csvImportId` INT, IN `_status` INT, IN `_sysTime` DATETIME)
BEGIN
	UPDATE import_csv_file SET ic_status = _status, updated_date = _sysTime WHERE ic_id = _csvImportId;
END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateQbBillingReference
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateQbBillingReference`(
_userId INT(11),
_taskId INT(11),
_taskType TINYINT(11),
_clientId INT(11),
_billingReference BIGINT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE billing_task_reference.billing_reference_task_id = ',_taskId,' AND billing_task_reference.billing_reference_task_type = ',_taskType, ' AND billing_task_reference.billing_reference_task_client_id = ',_clientId);
	
	
	SET @IdQry1 = CONCAT(' UPDATE billing_task_reference SET  billing_reference_doc_number = ',_billingReference, ', billing_reference_modified_on = ',Quote(_dateTime), ', billing_reference_modified_by = ',_userId, QryCond); 
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateQbClientRefreshToken
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateQbClientRefreshToken`(
	IN `_userId` INT(11),
	IN `_tokenUpateId` INT(11),
	IN `_refreshToken` VARCHAR(255),
	IN `_accessToken` TEXT,
	IN `_dateTime` datetime

)
    COMMENT 'Update qb_client_token'
BEGIN
		UPDATE qb_client_token SET  qb_client_token_refresh_token = _refreshToken,qb_client_token_access_token = _accessToken,
		qb_client_token_current_refresh_token = _refreshToken,qb_client_token_modified_by= _userId,qb_client_token_modified_on =  _dateTime WHERE qb_client_token_id = _tokenUpateId;
		
END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateQbClientToken
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateQbClientToken`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_tokenUpateId` INT(11),
	IN `_tokenClientId` VARCHAR(255),
	IN `_tokenClientSecretId` VARCHAR(255),
	IN `_tokenRealId` VARCHAR(255),
	IN `_tokenBaseUrl` VARCHAR(255),
	IN `_refreshToken` VARCHAR(255),
	IN `_accessToken` TEXT,
	IN `_dateTime` datetime

)
    COMMENT 'Update qb_client_token'
BEGIN
		UPDATE qb_client_token SET  qb_client_token_refresh_token = _refreshToken,qb_client_token_access_token = _accessToken ,qb_client_token_current_refresh_token = _refreshToken ,qb_client_token_modified_by= _userId,qb_client_token_modified_on =  _dateTime WHERE qb_client_token_id = _tokenUpateId;
		
END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateQbInvoiceReference
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateQbInvoiceReference`(
_userId INT(11),
_taskId INT(11),
_taskType TINYINT(11),
_clientId INT(11),
_invoiceReference BIGINT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE invoice_task_reference.invoice_reference_task_id = ',_taskId,' AND invoice_task_reference.invoice_reference_task_type = ',_taskType, ' AND invoice_task_reference.invoice_reference_task_client_id = ',_clientId);
	
	
	SET @IdQry1 = CONCAT(' UPDATE invoice_task_reference SET  invoice_reference_doc_number = ',_invoiceReference, ', invoice_reference_modified_on = ',Quote(_dateTime), ', invoice_reference_modified_by = ',_userId, QryCond); 
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateTaskContentAdminComplete
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateTaskContentAdminComplete`(
_userId INT(11),
_taskContentId INT(11),
_taskContentCompleteVal TINYINT(1),
_dateTime datetime,
_notes TEXT,
_taskReassignUserId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_id = ',_taskContentId);
	
	IF(_taskContentCompleteVal = 2) THEN
		SET @IdQry1 = CONCAT(' UPDATE task_content  SET task_content_user_id = ',_taskReassignUserId,', task_content_admin_complete = ',_taskContentCompleteVal, ', task_content_admin_notes = ',Quote(_notes), ', task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	ELSE
		SET @IdQry1 = CONCAT(' UPDATE task_content SET task_content_admin_complete = ',_taskContentCompleteVal, ', task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	END IF;
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	INSERT INTO task_content_admin_complete(tcac_task_content_id,tcac_comp_status,tcac_record_status,tcac_created_by,tcac_created_on,tcac_modified_by,tcac_modified_on)
	VALUES (_taskContentId,_taskContentCompleteVal, 0 ,_userId, _dateTime, _userId, _dateTime);

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateTaskContentComplete
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateTaskContentComplete`(
_userId INT(11),
_taskContentId INT(11),
_taskContentCompleteVal TINYINT(1),
_dateTime datetime,
_completedDate date
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_content SET task_content_is_complete = ',_taskContentCompleteVal,', task_content_proj_com_date = ',Quote(_completedDate), ', task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateTaskContentPriority
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateTaskContentPriority`(
_userId INT(11),
_taskContentId INT(11),
_taskPriorityVal TINYINT(1),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_content SET task_content_priority = ',_taskPriorityVal, ', task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateTaskKeywordAdminComplete
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateTaskKeywordAdminComplete`(
_userId INT(11),
_taskKeywordId INT(11),
_taskKeywordCompleteVal TINYINT(1),
_dateTime datetime,
_notes TEXT,
_taskReassignUserId INT(11)
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	IF(_taskKeywordCompleteVal = 2) THEN
		SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_user_id = ',_taskReassignUserId,',  task_keyword_admin_complete = ',_taskKeywordCompleteVal, ', task_keyword_admin_notes = ',Quote(_notes), ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	ELSE
		SET @IdQry1 = CONCAT(' UPDATE task_keyword SET  task_keyword_admin_complete = ',_taskKeywordCompleteVal, ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	END IF;
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	INSERT INTO task_keyword_admin_complete(tkac_task_keyword_id,tkac_comp_status,tkac_record_status,tkac_created_by,tkac_created_on,tkac_modified_by,tkac_modified_on)
	VALUES (_taskKeywordId,_taskKeywordCompleteVal, 0 ,_userId, _dateTime, _userId, _dateTime);

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateTaskKeywordComplete
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateTaskKeywordComplete`(
_userId INT(11),
_taskKeywordId INT(11),
_taskKeywordCompleteVal TINYINT(1),
_dateTime datetime,
_completedDate date
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_setup_complete = ',_taskKeywordCompleteVal, ', task_keyword_date = ',Quote(_completedDate), ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateTaskKeywordPriority
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateTaskKeywordPriority`(
_userId INT(11),
_taskKeywordId INT(11),
_taskPriorityVal TINYINT(1),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_priority = ',_taskPriorityVal, ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateUserForm
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateUserForm`(
_userId INT(11),
_userFormId INT(11),
_dateTime datetime
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE user_id = ',_userFormId,' AND user_record_status = 0');
	
	SET @IdQry1 = CONCAT(' UPDATE user SET  user_form_completed = 1, user_modified_on = ',Quote(_dateTime), ', user_modified_by = ',_userId, QryCond); 
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	

END//
DELIMITER ;

-- Dumping structure for procedure galileo.updateUserPassword
DELIMITER //
CREATE DEFINER=`466649_leadsk`@`%` PROCEDURE `updateUserPassword`(
_userId INT(11),
_userPass VARCHAR(255),
_date date
)
BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 AND user.user_id = ',_userId);
	
	SET @IdQry1 = CONCAT(' UPDATE user SET user_activation_link="", user_activation_link_expire="0000-00-00",  user_password = ',Quote(_userPass), ', user_modified_on = ',Quote(_date), QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END//
DELIMITER ;

-- Dumping structure for table galileo.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `user_modified_by` int(11) NOT NULL DEFAULT '0',
  `user_qb_ref_id` int(11) NOT NULL DEFAULT '0',
  `user_form_completed` tinyint(1) NOT NULL DEFAULT '0',
  `user_activation_link` text NOT NULL,
  `user_activation_link_expire` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- Dumping data for table galileo.user: ~69 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `user_salutation`, `user_fname`, `user_lname`, `user_image`, `user_email`, `user_password`, `user_address`, `user_notes`, `user_city`, `user_state`, `user_country`, `user_zip`, `user_role_id`, `user_job_title`, `user_record_status`, `user_created_on`, `user_created_by`, `user_modified_on`, `user_modified_by`, `user_qb_ref_id`, `user_form_completed`, `user_activation_link`, `user_activation_link_expire`) VALUES
	(1, 'Mr', 'Vasanthraj', 'Kirubanandhan', '', 'vasanth@sam.ai', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2017-11-10 07:03:48', 1, '2018-02-15 12:37:55', 1, 61, 1, 'f857d2', '2018-02-10'),
	(2, '', 'Sekki', 'Kumaravel', '', 'sekki@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2017-11-16 06:15:44', 1, '2018-01-30 06:34:08', 1, 62, 0, '', '0000-00-00'),
	(3, '', 'Bala', 'Krishana', '', 'vasanth@sam.ai', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2017-11-16 06:16:20', 1, '2018-01-30 06:33:39', 1, 63, 1, '', '0000-00-00'),
	(4, '', 'Vignesh', 'John', '', 'vignesh@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2017-11-16 06:16:20', 1, '2018-01-30 06:34:13', 1, 64, 1, '', '0000-00-00'),
	(5, '', 'Karthi', 'Kumar', '', 'karthi@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2017-11-16 06:16:20', 1, '2018-01-30 06:33:57', 1, 65, 1, '', '0000-00-00'),
	(6, '', 'Jalal', 'Moulabi', '', 'jalal@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2017-11-16 06:16:20', 1, '2018-01-30 06:33:49', 1, 66, 0, '', '0000-00-00'),
	(7, '', 'Sathish', 'Test', '', 'ak@usaweb.net', '9ddc44f3f7f78da5781d6cab571b2fc5', '', '', '', '', '', '', 1, '', 1, '2017-11-23 08:19:46', 1, '2017-11-23 08:19:46', 1, 67, 0, '', '0000-00-00'),
	(8, '', 'Jill', 'Wright', '', 'jill@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 3, '', 1, '2017-11-29 08:19:47', 1, '2018-02-02 05:55:51', 10, 521, 0, '', '0000-00-00'),
	(9, '', 'sugan', 'raj', '', 'sugan@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2017-12-01 05:17:14', 1, '2017-12-01 05:17:22', 1, 68, 0, '', '0000-00-00'),
	(10, '', 'Erin', 'Miller', '', 'erin.miller@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 0, '2017-12-05 12:17:08', 1, '2018-02-14 10:24:33', 10, 69, 1, '', '0000-00-00'),
	(11, '', 'Joseph', 'McElroy', '', 'joseph@galileotechmedia.com', 'eb5ba7c977d21014520ad3ee0432d10f', '', '', '', '', '', '', 1, '', 0, '2017-12-05 13:44:09', 10, '2017-12-05 13:44:09', 10, 70, 0, '', '0000-00-00'),
	(12, '', 'Erin', 'Miller', '', 'ergilliam2002@yahoo.com', 'eb5ba7c977d21014520ad3ee0432d10f', '', '', '', '', '', '', 1, '', 1, '2017-12-05 13:44:28', 10, '2018-02-02 05:55:29', 10, 71, 0, '', '0000-00-00'),
	(13, '', 'John', 'Connolly', '', 'john@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 0, '2017-12-05 13:44:28', 10, '2018-02-19 14:05:23', 10, 13, 1, '', '0000-00-00'),
	(14, '', 'Developer', 'Account', '', 'vasanth@sam.ai', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2018-01-09 08:04:35', 1, '2018-02-14 10:20:19', 10, 0, 0, '', '0000-00-00'),
	(15, '', 'test', 'test', '', 'test@galileo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-24 05:27:52', 1, '2018-01-24 05:28:02', 1, 25, 0, '', '0000-00-00'),
	(16, '', 'Adam', 'Barone', '', 'adam@adambarone.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:42:30', 1, '2018-02-14 10:19:33', 10, 20, 0, '', '0000-00-00'),
	(17, '', 'Alison', 'Evans', '', 'alisonevans@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:44:21', 1, '2018-02-02 05:54:31', 10, 39, 0, '', '0000-00-00'),
	(18, '', 'Andrew', 'Tchabovsky', '', 'andrewtchabovsky@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2018-01-30 05:45:41', 1, '2018-02-15 05:42:55', 10, 0, 0, '', '0000-00-00'),
	(19, '', 'Anna', 'Hartman', '', 'anna.hartman@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:47:29', 1, '2018-02-15 13:12:55', 1, 511, 0, '', '0000-00-00'),
	(20, '', 'Michael', 'Block', '', 'michaelblock@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:48:38', 1, '2018-02-14 10:23:11', 10, 477, 0, '', '0000-00-00'),
	(21, '', 'Lorna', 'Nahil', '', 'lornanahil@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:49:36', 1, '2018-02-15 13:13:36', 1, 456, 0, '', '0000-00-00'),
	(22, '', 'Carolyn', 'Stanek Lucy', '', 'carolynstaneklucy@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:50:53', 1, '2018-02-15 05:43:01', 10, 549, 0, '', '0000-00-00'),
	(23, '', 'Dalton', 'Abbott', '', 'daltonabbott@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:53:07', 1, '2018-02-15 05:43:04', 10, 350, 0, '', '0000-00-00'),
	(24, '', 'Daniel', 'Benderly', '', 'danielbenderly@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:54:34', 1, '2018-02-15 05:43:08', 10, 19, 0, '', '0000-00-00'),
	(25, '', 'Daniel', 'Wilson', '', 'danielwilson@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:55:45', 1, '2018-02-14 10:20:15', 10, 15, 0, '', '0000-00-00'),
	(26, '', 'David', 'Banahan', '', 'davidbanahan@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:56:35', 1, '2018-02-15 13:12:59', 1, 6, 0, '', '0000-00-00'),
	(27, '', 'Elisa', 'Maria', '', 'elisamaria@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:57:45', 1, '2018-02-15 13:13:03', 1, 539, 0, '', '0000-00-00'),
	(28, '', 'Emily', 'Wilhoit', '', 'emily@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:58:28', 1, '2018-02-15 13:13:07', 1, 532, 0, '', '0000-00-00'),
	(29, '', 'Erin', 'Osborne', '', 'erin.osborne@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 05:59:11', 1, '2018-02-15 05:43:14', 10, 534, 0, '', '0000-00-00'),
	(31, '', 'GeAndra', 'Imoudu', '', 'geandra@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:04:59', 1, '2018-02-15 13:13:11', 1, 523, 0, '', '0000-00-00'),
	(32, '', 'Heather', 'Johnson', '', 'HeatherRJohnson@sbcglobal.net', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:05:38', 1, '2018-02-15 05:44:45', 10, 441, 0, '', '0000-00-00'),
	(33, '', 'Heidi', 'Storm Samore', '', 'hsamore@gmail.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:06:20', 1, '2018-02-15 13:13:14', 1, 551, 0, '', '0000-00-00'),
	(34, '', 'Jana', 'Free', '', 'lifejana@gmail.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:06:59', 1, '2018-02-15 13:13:17', 1, 488, 0, '', '0000-00-00'),
	(35, '', 'Jessica', 'Punshon', '', 'jessica@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:07:39', 1, '2018-02-15 13:13:21', 1, 529, 0, '', '0000-00-00'),
	(36, '', 'Julia', 'McVeigh', '', 'juliamcveigh24@gmail.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:11:59', 1, '2018-02-15 13:13:27', 1, 524, 0, '', '0000-00-00'),
	(37, '', 'Kivanc', 'Senocak', '', 'ksenocak@serenehospitality.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:12:54', 1, '2018-02-15 13:13:30', 1, 553, 0, '', '0000-00-00'),
	(38, '', 'Kristin', 'Fitzgerald', '', 'kristin@frothmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:13:33', 1, '2018-02-15 05:45:21', 10, 545, 0, '', '0000-00-00'),
	(39, '', 'Krystin', 'Gill', '', 'krystin@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:14:12', 1, '2018-02-15 13:13:40', 1, 531, 0, '', '0000-00-00'),
	(40, '', 'Laura', 'Mann', '', 'lamann@g.clemson.edu', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:15:12', 1, '2018-02-15 13:13:34', 1, 522, 0, '', '0000-00-00'),
	(41, '', 'Maria', 'Dominguez', '', 'maria@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:15:53', 1, '2018-02-15 13:13:44', 1, 528, 0, '', '0000-00-00'),
	(42, '', 'Martina', 'Sheehan', '', 'contactmartina@gmail.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:16:34', 1, '2018-02-15 13:13:49', 1, 555, 0, '', '0000-00-00'),
	(43, '', 'Matthew', 'Berry', '', 'matthewberry@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:17:30', 1, '2018-02-15 13:13:52', 1, 552, 0, '', '0000-00-00'),
	(44, '', 'Meredith', 'Granese', '', 'meredith@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:18:14', 1, '2018-02-15 13:14:00', 1, 540, 0, '', '0000-00-00'),
	(45, '', 'Michael', 'Zittel', '', 'serrbiz2@gmail.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:18:51', 1, '2018-02-15 13:13:55', 1, 492, 0, '', '0000-00-00'),
	(46, '', 'Nikki', 'Johnson', '', 'nikkijohnson@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:19:54', 1, '2018-02-14 10:23:06', 10, 14, 0, '', '0000-00-00'),
	(47, '', 'Raz', 'Chowdary', '', 'razchowdary@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:22:03', 1, '2018-02-15 05:45:33', 10, 541, 0, '', '0000-00-00'),
	(48, '', 'Your', 'Books', '', 'yourbooks@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:23:14', 1, '2018-02-14 10:22:37', 10, 458, 0, '', '0000-00-00'),
	(49, '', 'Patricia', 'Steffy', '', 'patriciasteffy@yahoo.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:23:47', 1, '2018-02-15 13:13:58', 1, 546, 0, '', '0000-00-00'),
	(50, '', 'Publio.io', 'KR', '', 'publiokr@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:24:49', 1, '2018-02-15 13:14:05', 1, 533, 0, '', '0000-00-00'),
	(51, '', 'Rebecca', 'Williams', '', 'rebeccawilliams@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:25:44', 1, '2018-02-15 13:14:13', 1, 275, 0, '', '0000-00-00'),
	(52, '', 'Rich', 'Jachetti', '', 'richjachetti@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:26:31', 1, '2018-02-14 10:22:55', 10, 40, 0, '', '0000-00-00'),
	(53, '', 'Ryan', 'Lawrence', '', 'ryanlawrence@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:28:07', 1, '2018-02-15 13:14:17', 1, 550, 0, '', '0000-00-00'),
	(54, '', 'Ryan', 'McBurney', '', 'ryanmcBurney@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:29:19', 1, '2018-02-14 10:22:49', 10, 7, 0, '', '0000-00-00'),
	(55, '', 'Sally', 'Odum', '', 'sally.odum@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:30:11', 1, '2018-02-15 13:14:10', 1, 544, 0, '', '0000-00-00'),
	(56, '', 'SaraLynn', 'Leary', '', 'sleary@lemonaideva.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:31:03', 1, '2018-02-15 13:14:19', 1, 530, 0, '', '0000-00-00'),
	(57, '', 'Victoria', 'Ketcham', '', 'victoriaketcham@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:32:06', 1, '2018-02-15 13:14:07', 1, 426, 0, '', '0000-00-00'),
	(58, '', 'Aniruddha', 'Sanyal', '', 'aniruddhasanyal@galileotechmedia.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 4, '', 1, '2018-01-30 06:33:03', 1, '2018-02-14 10:20:08', 10, 459, 0, '', '0000-00-00'),
	(59, '', 'Jill', 'Wright', '', 'jill.wright@galileotechmedia.com', '1b7ce30de0497b161bba850acd262e1f', '', '', '', '', '', '', 3, '', 1, '2018-02-02 05:56:21', 10, '2018-02-09 15:52:13', 10, 0, 0, '', '0000-00-00'),
	(60, '', 'vasatest', 'test', '', 'raj.vasanth2@gmail.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2018-02-08 08:30:01', 1, '2018-02-08 12:53:54', 1, 0, 0, '21d1bc', '2018-02-10'),
	(61, '', 'unni', 'krishanan', '', 'hr@officeinteractive.com', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2018-02-08 11:56:36', 1, '2018-02-08 11:57:03', 1, 0, 0, '', '0000-00-00'),
	(62, '', 'vas', 'vasa', '', 'raj.vasanth2@gmail.com', '098f6bcd4621d373cade4e832627b4f6', '', '', '', '', '', '', 1, '', 1, '2018-02-08 12:54:10', 1, '2018-02-08 12:56:11', 1, 0, 0, '', '0000-00-00'),
	(63, '', 'vasa', 'kiru', '', 'raj.vasanth2@gmail.com', '098f6bcd4621d373cade4e832627b4f6', '', '', '', '', '', '', 1, '', 1, '2018-02-08 12:56:27', 1, '2018-02-08 13:38:29', 1, 0, 0, '', '0000-00-00'),
	(64, '', 'test', 'test', '', 'evelyn@sam.ai', 'cc03e747a6afbbcbf8be7668acfebee5', '', '', '', '', '', '', 1, '', 1, '2018-02-08 13:09:52', 10, '2018-02-15 05:45:39', 10, 0, 0, 'f48153', '2018-02-10'),
	(65, '', 'test', 'test', '', 'evelyn@sam.ai', 'cc03e747a6afbbcbf8be7668acfebee5', '', '', '', '', '', '', 1, '', 1, '2018-02-08 13:09:52', 10, '2018-02-15 05:45:42', 10, 0, 0, '', '0000-00-00'),
	(66, '', 'vasa', 'kiru', '', 'raj.vasanth2@gmail.com', '098f6bcd4621d373cade4e832627b4f6', '', '', '', '', '', '', 1, '', 1, '2018-02-08 13:38:43', 1, '2018-02-15 05:45:45', 10, 0, 0, '', '0000-00-00'),
	(67, '', 'Jill', 'Wright', '', 'jill.wright@galileotechmedia.com', '638190bf025179ecebcc1b3d019a0230', '', '', '', '', '', '', 3, '', 0, '2018-02-09 15:52:39', 10, '2018-02-19 13:52:15', 10, 521, 0, '', '0000-00-00'),
	(68, '', 'vasanth', 'raj', '', 'vasanth@sam.ai', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2018-02-15 09:00:12', 1, '2018-02-15 09:01:59', 1, 0, 0, '', '0000-00-00'),
	(69, '', 'vasanth', 'developer', '', 'vasanth@sam.ai', '780ea9376333dabb1959f16e1622e00c', '', '', '', '', '', '', 1, '', 1, '2018-02-15 09:02:23', 1, '2018-02-15 09:03:02', 1, 0, 0, '', '0000-00-00'),
	(70, '', 'Sara Lynn', 'Leary', '', 'saralynn@galileotechmedia.com', '638190bf025179ecebcc1b3d019a0230', '', '', '', '', '', '', 4, '', 0, '2018-02-19 14:13:50', 10, '2018-02-19 14:13:50', 10, 530, 0, '', '0000-00-00');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table galileo.user_permission
CREATE TABLE IF NOT EXISTS `user_permission` (
  `user_permission` int(11) NOT NULL AUTO_INCREMENT,
  `user_permission_user_id` int(11) NOT NULL DEFAULT '0',
  `user_permission_mod_id` int(11) NOT NULL DEFAULT '0',
  `user_permission_is_access` tinyint(1) NOT NULL DEFAULT '0',
  `user_permission_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `user_permission_created_by` int(11) NOT NULL DEFAULT '0',
  `user_permission_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_permission_modified_by` int(11) NOT NULL DEFAULT '0',
  `user_permission_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_permission`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.user_permission: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;

-- Dumping structure for table galileo.user_role
CREATE TABLE IF NOT EXISTS `user_role` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_role_name` varchar(100) NOT NULL DEFAULT '',
  `user_role_record_status` tinyint(1) NOT NULL DEFAULT '0',
  `user_role_created_by` int(11) NOT NULL DEFAULT '0',
  `user_role_created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_role_modified_by` int(11) NOT NULL DEFAULT '0',
  `user_role_modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.user_role: ~4 rows (approximately)
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` (`user_role_id`, `user_role_name`, `user_role_record_status`, `user_role_created_by`, `user_role_created_on`, `user_role_modified_by`, `user_role_modified_on`) VALUES
	(1, 'Full Access', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(2, 'Billing', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(3, 'Project Manager', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48'),
	(4, 'Consultant', 0, 1, '2017-11-10 07:03:48', 1, '2017-11-10 07:03:48');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;

-- Dumping structure for table galileo.user_session
CREATE TABLE IF NOT EXISTS `user_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_key` varchar(150) NOT NULL DEFAULT '',
  `session_user_id` int(11) NOT NULL DEFAULT '0',
  `session_login_ip` varchar(50) NOT NULL DEFAULT '',
  `session_login_status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '0-Logout, 1 - login, 2 - login in another system',
  `session_login_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0-User, 1-Admin',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=374 DEFAULT CHARSET=latin1;

-- Dumping data for table galileo.user_session: ~373 rows (approximately)
/*!40000 ALTER TABLE `user_session` DISABLE KEYS */;
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
	(38, '21fc08b44ac33cfa3058201bec186c0b', 1, '::1', 2, 0, '2017-12-05 10:23:02', '2017-12-05 15:24:49'),
	(39, '213b6a32ed4206c767bcf59115bedc85', 1, '203.187.247.198', 2, 0, '2017-12-05 15:24:49', '2017-12-05 16:29:13'),
	(40, 'ca1567e254a2204e14b8ece3baee6507', 1, '203.187.247.198', 2, 0, '2017-12-05 16:29:13', '2017-12-05 17:06:21'),
	(41, 'b71fa5f990db8b7688fdc9e62a3cf049', 1, '71.125.5.72', 2, 0, '2017-12-05 17:06:21', '2017-12-05 17:11:17'),
	(42, 'ee8315b6b9854d715d68626581a95e1f', 1, '203.187.247.198', 2, 0, '2017-12-05 17:11:17', '2017-12-05 17:13:28'),
	(43, 'dfa705ed0c7eef3698054a852548fb48', 1, '71.125.5.72', 2, 0, '2017-12-05 17:13:28', '2017-12-05 17:15:32'),
	(44, '6dab2cd4d6002532dc64b55498b75463', 1, '203.187.247.198', 0, 0, '2017-12-05 17:15:32', '2017-12-05 17:17:13'),
	(45, 'efca346f14081d912f490432ca175305', 10, '203.187.247.198', 0, 0, '2017-12-05 17:17:22', '2017-12-05 17:17:27'),
	(46, '58e57d520671dd99ef8d4a690c6e7d10', 10, '71.125.5.72', 0, 0, '2017-12-05 17:24:14', '2017-12-05 17:24:18'),
	(47, '15d56b0b9b02dcade141e321c95ed06c', 10, '23.125.48.149', 2, 0, '2017-12-05 18:02:27', '2017-12-18 18:09:12'),
	(48, '1649d7dce241bad50ebd63e69e9188dd', 1, '203.187.247.198', 2, 0, '2017-12-07 14:12:02', '2017-12-07 15:56:27'),
	(49, '75ad872c84f80679581d9be2451b8d4d', 1, '203.187.247.198', 0, 0, '2017-12-07 15:56:27', '2017-12-07 16:28:52'),
	(50, 'e7be434e5594c133bf20aa5e19528e52', 1, '203.187.247.198', 2, 0, '2017-12-07 16:29:12', '2017-12-07 17:49:52'),
	(51, '7a460119f71121ee9cf99353b97011f5', 1, '203.187.247.198', 2, 0, '2017-12-07 17:49:52', '2017-12-08 14:50:02'),
	(52, 'a58d0bcec07eceb2a789b343a4bef1bd', 1, '203.187.247.198', 0, 0, '2017-12-08 14:50:02', '2017-12-08 14:50:46'),
	(53, 'beb7f85cf07db8fed217d8229d6b7375', 1, '203.187.247.198', 0, 0, '2017-12-12 17:22:12', '2017-12-12 17:45:49'),
	(54, 'f58cadc357f6b821290c29296a5e39f1', 8, '203.187.247.198', 0, 0, '2017-12-12 17:45:56', '2017-12-12 17:46:07'),
	(55, '5fbd79dd74756c7812d4447bdc9a7d7a', 1, '203.187.247.198', 0, 0, '2017-12-12 17:46:13', '2017-12-12 18:52:01'),
	(56, '4c4fbef5492c061bb7867a5ba3282e40', 1, '203.187.247.198', 2, 0, '2017-12-18 09:34:47', '2017-12-18 13:10:35'),
	(57, 'b24b2d8187ce9777823e9705a37fdd85', 1, '203.187.247.198', 0, 0, '2017-12-18 13:10:35', '2017-12-18 13:10:52'),
	(58, '7faaa7d3e1728c9f076183b3fee925c1', 3, '203.187.247.198', 0, 0, '2017-12-18 13:10:59', '2017-12-18 13:11:17'),
	(59, '3ac36095f640c99217b11d8970f71020', 1, '203.187.247.198', 0, 0, '2017-12-18 13:11:23', '2017-12-18 13:11:50'),
	(60, 'aa74640614448cb134ca981c83e1d827', 3, '203.187.247.198', 0, 0, '2017-12-18 13:11:57', '2017-12-18 13:12:40'),
	(61, 'db77b3cc0474819d725930694a140ece', 1, '203.187.247.198', 0, 0, '2017-12-18 13:16:51', '2017-12-18 13:16:57'),
	(62, '713bb5ded3a9de5928be43ec3f64b262', 10, '72.89.51.47', 2, 0, '2017-12-18 18:09:12', '2017-12-19 03:11:50'),
	(63, '44aad9f9e5ab2f57d4f7145df7a2fe50', 10, '72.89.51.47', 2, 0, '2017-12-19 03:11:50', '2017-12-19 04:19:56'),
	(64, 'cd13b362c1b8c3499248eebbe01637f9', 10, '72.89.51.47', 2, 0, '2017-12-19 04:19:56', '2017-12-19 12:13:46'),
	(65, 'd327c1edb1d03c2a62645e7dca2590e0', 1, '203.187.247.198', 0, 0, '2017-12-19 12:06:55', '2017-12-19 12:09:52'),
	(66, '309d1db38268515c0377d284db7a3270', 13, '203.187.247.198', 0, 0, '2017-12-19 12:09:58', '2017-12-19 12:10:17'),
	(67, 'bd519ae21951df7b08c773a1f0737dbb', 10, '203.187.247.198', 2, 0, '2017-12-19 12:13:46', '2017-12-19 14:45:26'),
	(68, '858529ae037e1de2e8bf44e9899c73c6', 1, '203.187.247.198', 2, 0, '2017-12-19 14:44:40', '2017-12-21 15:58:46'),
	(69, '0636403a220029363b1aeafca3eeb789', 10, '72.89.51.47', 2, 0, '2017-12-19 14:45:26', '2017-12-28 13:43:41'),
	(70, '09966efe83aa55fe7b6a753113861d01', 1, '203.187.247.198', 2, 0, '2017-12-21 15:58:46', '2017-12-21 16:46:03'),
	(71, '2e6fc18a8416e10619f6136cbb18bdcd', 1, '203.187.247.198', 2, 0, '2017-12-21 16:46:03', '2017-12-26 15:49:03'),
	(72, 'f6100d91f0685da5c9db70b6ab50afc2', 1, '203.187.247.198', 0, 0, '2017-12-26 15:49:03', '2017-12-26 16:11:45'),
	(73, '739f1e079accd3b952b338b334f10863', 1, '203.187.247.198', 0, 0, '2017-12-26 17:23:02', '2017-12-26 17:24:16'),
	(74, '8f44ace6afddb1069439b332273a4142', 10, '203.187.247.198', 0, 0, '2017-12-28 13:43:41', '2017-12-28 13:43:57'),
	(75, '3bf9e44acccca9684a23217039298bdf', 1, '203.187.247.198', 0, 0, '2017-12-29 16:05:19', '2017-12-29 16:14:57'),
	(76, '2faf881e5c6287326bc39810cbb94efd', 13, '203.187.247.198', 0, 0, '2017-12-29 16:15:05', '2017-12-29 16:16:37'),
	(77, '1d0e9f0d9429bfdc13ac865dae44e3c3', 1, '203.187.247.198', 0, 0, '2017-12-29 16:16:44', '2017-12-29 16:17:26'),
	(78, 'e88fe701bacd39eec7e93e924c7b0490', 13, '203.187.247.198', 0, 0, '2017-12-29 16:17:33', '2017-12-29 16:17:46'),
	(79, '30e17c055e14e5d502ec4061f7897f38', 1, '203.187.247.198', 2, 0, '2017-12-29 18:06:56', '2017-12-29 19:05:41'),
	(80, '1f48ae1d6169dcc75c5c8045e8e9f0ad', 1, '203.187.247.198', 2, 0, '2017-12-29 19:05:41', '2018-01-02 11:42:34'),
	(81, 'fa4c04fa120557200be0d4d60fbe4c97', 1, '203.187.247.198', 0, 0, '2018-01-02 11:42:34', '2018-01-02 12:44:51'),
	(82, '9e65d87b61de88c1f1ba997ac93c5dea', 10, '71.125.5.72', 2, 0, '2018-01-02 15:07:01', '2018-01-03 15:59:50'),
	(83, '0a1e56bff9c04166c84b816bea15f307', 1, '203.187.247.198', 0, 0, '2018-01-02 15:47:36', '2018-01-02 15:54:21'),
	(84, 'de932f2bd1655229ed33123d02b8028a', 5, '203.187.247.198', 0, 0, '2018-01-02 15:54:28', '2018-01-02 15:54:58'),
	(85, '07295a52a8caca0c584b024f5b453f07', 1, '203.187.247.198', 0, 0, '2018-01-02 16:07:42', '2018-01-02 16:08:24'),
	(86, '93bf8c287ca087e71cb70ba1475e7425', 8, '203.187.247.198', 0, 0, '2018-01-02 16:35:56', '2018-01-02 16:36:08'),
	(87, 'd42eea6c3631066ea9ffc8c834f08278', 13, '203.187.247.198', 0, 0, '2018-01-02 16:36:18', '2018-01-02 16:37:04'),
	(88, '4db1622284cfbfc80414f6c5afcfa9f2', 13, '203.187.247.198', 0, 0, '2018-01-02 16:37:45', '2018-01-02 16:38:11'),
	(89, 'bffc4b5acba07a464f60d43b5d8e7322', 13, '71.125.5.72', 0, 0, '2018-01-02 19:13:30', '2018-01-02 19:13:30'),
	(90, '6f0e82f42c84eb5d64165104913788b6', 13, '157.50.23.67', 2, 0, '2018-01-02 19:23:30', '2018-01-02 20:39:18'),
	(91, '3ae70f993b76aad1edc64e4817973cf1', 13, '171.60.223.223', 2, 0, '2018-01-02 20:39:18', '2018-01-03 04:13:43'),
	(92, 'ec76241dcf7c928c97aa7531229595e0', 13, '72.89.51.47', 2, 0, '2018-01-03 04:13:43', '2018-01-03 11:26:14'),
	(93, 'bcffea94c4c4aa71de6a246247fc951a', 1, '203.187.247.198', 2, 0, '2018-01-03 10:05:10', '2018-01-03 10:43:47'),
	(94, '3b3d537f9369fb96381cd892acc25603', 1, '203.187.247.198', 0, 0, '2018-01-03 10:43:47', '2018-01-03 10:44:21'),
	(95, 'ecc2017eaa72c4ba08587418c994196d', 1, '203.187.247.198', 0, 0, '2018-01-03 11:23:38', '2018-01-03 11:26:05'),
	(96, '071bfa06e5c102cffd2ee932f006b1a4', 13, '203.187.247.198', 0, 0, '2018-01-03 11:26:14', '2018-01-03 11:26:41'),
	(97, 'c6f1905022afd5f9cae430d20352ad59', 10, '72.89.51.47', 2, 0, '2018-01-03 15:59:50', '2018-01-03 17:09:34'),
	(98, 'f58a3a4b8f026567311972c006d8ee7c', 1, '203.187.247.198', 0, 0, '2018-01-03 16:38:32', '2018-01-03 16:46:41'),
	(99, '0e02715a6976f0bf03231e4b34aa88a1', 4, '203.187.247.198', 0, 0, '2018-01-03 16:46:54', '2018-01-03 16:46:55'),
	(100, '70867405df460bc3f6cbaae535151d07', 4, '203.187.247.198', 0, 0, '2018-01-03 16:47:03', '2018-01-03 16:47:29'),
	(101, 'e149cfbdb1584a371a8701a61416a83b', 1, '203.187.247.198', 0, 0, '2018-01-03 16:56:19', '2018-01-03 16:56:41'),
	(102, '7f65ff699f2a59e1b77ea46fabd3accd', 4, '203.187.247.198', 0, 0, '2018-01-03 16:58:52', '2018-01-03 16:59:58'),
	(103, '3f97933e17af702d1a1ad632d0f7a940', 10, '72.89.51.47', 0, 0, '2018-01-03 17:09:34', '2018-01-03 18:06:09'),
	(104, 'd169fa6d759bbdaf31ab47b0177a68fd', 1, '203.187.247.198', 0, 0, '2018-01-03 17:16:22', '2018-01-03 17:18:31'),
	(105, '79086d7f80a338c67c1b242be6bc125c', 10, '72.89.51.47', 2, 0, '2018-01-03 18:06:10', '2018-01-05 12:04:19'),
	(106, '8bdf36e254bcba4a17658d041b490b4e', 1, '203.187.247.198', 0, 0, '2018-01-04 12:50:03', '2018-01-04 12:52:46'),
	(107, 'a56fdfb3df2acee9967bef3e89a31185', 1, '203.187.247.198', 0, 0, '2018-01-04 13:37:24', '2018-01-04 13:38:10'),
	(108, '33e5f6a89042862d2c12cb25b69956d9', 10, '23.125.48.149', 2, 0, '2018-01-05 12:04:19', '2018-01-05 15:46:57'),
	(109, '799ff99e6eac4896ece6f761fcab3c15', 1, '203.187.247.198', 0, 0, '2018-01-05 15:31:45', '2018-01-05 15:34:18'),
	(110, '1efc350415605dffd8c75e02981c2a13', 1, '203.187.247.198', 2, 0, '2018-01-05 15:46:39', '2018-01-05 18:04:37'),
	(111, 'dbb0e44d405036174280e34e4bf65969', 10, '72.89.51.47', 2, 0, '2018-01-05 15:46:57', '2018-01-05 18:58:24'),
	(112, 'd9b6709a1cbf0b4d627644c67721dfb8', 1, '203.187.247.198', 0, 0, '2018-01-05 18:04:37', '2018-01-05 18:27:54'),
	(113, '26ca63f296cf1071353ecda1134e98b1', 3, '203.187.247.198', 0, 0, '2018-01-05 18:28:01', '2018-01-05 18:28:19'),
	(114, '795d89e50d3b942dfb38a1c6358e7d65', 13, '203.187.247.198', 0, 0, '2018-01-05 18:28:28', '2018-01-05 18:29:08'),
	(115, 'b92aaea5fabd828a6510dd882a5c1403', 10, '23.125.48.149', 2, 0, '2018-01-05 18:58:24', '2018-01-08 13:56:16'),
	(116, '8b9a61d783ed4d540fc6a5052c3d314f', 1, '203.187.247.198', 0, 0, '2018-01-08 13:18:05', '2018-01-08 13:24:08'),
	(117, '8ae3648731a473416b3df8fd3aaf44f8', 13, '203.187.247.198', 0, 0, '2018-01-08 13:24:16', '2018-01-08 14:06:35'),
	(118, '1c2ca9c96a31fcdd06d8dedb75bfe7b3', 10, '72.89.51.47', 2, 0, '2018-01-08 13:56:16', '2018-01-11 10:02:58'),
	(119, '1cb3c9f1d75f2c027c27e3e1359c100e', 1, '203.187.247.198', 2, 0, '2018-01-08 14:06:42', '2018-01-08 14:40:08'),
	(120, '5d16d5eb6ed20c8fe330fd5e3747d41b', 1, '203.187.247.198', 0, 0, '2018-01-08 14:40:08', '2018-01-08 15:20:41'),
	(121, 'f3f8d79789b9f207c895938f16a1108d', 13, '203.187.247.198', 0, 0, '2018-01-08 15:59:24', '2018-01-08 15:59:25'),
	(122, 'd3aa53ea780d24d89eec47ea96d935d4', 8, '203.187.247.198', 0, 0, '2018-01-08 16:00:01', '2018-01-08 16:03:09'),
	(123, '83d43d0ff695cd33725afb9ff6f03304', 1, '203.187.247.198', 2, 0, '2018-01-08 16:03:27', '2018-01-08 17:16:42'),
	(124, '7b09035d5c49d91ba34a1b474c44887d', 1, '203.187.247.198', 2, 0, '2018-01-08 17:16:42', '2018-01-09 12:57:15'),
	(125, '909fd22c76a0b363c6cc0698c39ac2b6', 1, '203.187.247.198', 0, 0, '2018-01-09 12:57:15', '2018-01-09 13:03:58'),
	(126, '2882e571f5e35bf4b589d60cf3e23180', 1, '203.187.247.198', 0, 0, '2018-01-09 13:04:06', '2018-01-09 13:06:10'),
	(127, '87c0362a12ce5f2ecd9035442b894522', 13, '203.187.247.198', 0, 0, '2018-01-09 13:06:18', '2018-01-09 13:06:36'),
	(128, '853b849004db52b37366166ec904c6a4', 8, '203.187.247.198', 0, 0, '2018-01-09 13:06:43', '2018-01-09 13:07:41'),
	(129, '4d74a6ae236160574783aa280a42b9a0', 1, '203.187.247.198', 0, 0, '2018-01-09 13:59:54', '2018-01-09 14:02:08'),
	(130, '239d33400ff1de562db0c2cc489ab1b3', 13, '203.187.247.198', 0, 0, '2018-01-09 14:02:17', '2018-01-09 14:10:36'),
	(131, '4e02d4f71b58089d61e480147c71959b', 1, '203.187.247.198', 0, 0, '2018-01-09 14:31:05', '2018-01-09 14:31:28'),
	(132, 'd5bdee073fb1747d1c4a6db7230c5d84', 1, '203.187.247.198', 0, 0, '2018-01-09 14:31:39', '2018-01-09 14:32:12'),
	(133, '28369b2764d1d7339a78ccf75ce55e6b', 1, '203.187.247.198', 0, 0, '2018-01-10 12:48:11', '2018-01-10 12:55:36'),
	(134, '3651a451276fe8f08896032726be7292', 5, '203.187.247.198', 0, 0, '2018-01-10 12:55:42', '2018-01-10 12:55:54'),
	(135, 'ad6774dc41aea3cbf33c36d7e1ef6d54', 1, '203.187.247.198', 0, 0, '2018-01-10 12:56:14', '2018-01-10 12:56:15'),
	(136, 'b49e4338cba6f0c292868a50bfcec7d4', 1, '203.187.247.198', 2, 0, '2018-01-10 12:56:24', '2018-01-10 13:46:25'),
	(137, '1faf5998b70f7c325d4a311137300bf6', 1, '203.187.247.198', 0, 0, '2018-01-10 13:46:25', '2018-01-10 14:14:07'),
	(138, 'ebbd7b405f0363a91b2690f388ed05d2', 10, '23.125.48.149', 2, 0, '2018-01-11 10:02:58', '2018-01-11 14:57:32'),
	(139, 'aee442632822be2b33ed3c520086d271', 1, '203.187.247.198', 2, 0, '2018-01-11 14:08:52', '2018-01-11 14:18:49'),
	(140, '8dfa80bb91569cc952852a562655de93', 1, '203.187.247.198', 0, 0, '2018-01-11 14:18:49', '2018-01-11 14:20:00'),
	(141, 'badaeda4d5d940a28ef2054c51f0926e', 1, '203.187.247.198', 2, 0, '2018-01-11 14:44:40', '2018-01-11 17:49:10'),
	(142, '4d9db1c660449ae46f18c05a06a00a65', 10, '72.89.51.47', 0, 0, '2018-01-11 14:57:32', '2018-01-11 15:02:05'),
	(143, '5d2f77b470b631d1834389d70a941131', 13, '72.89.51.47', 0, 0, '2018-01-11 15:02:51', '2018-01-11 15:12:04'),
	(144, '9e15b0198e3ee4db363b2887e7295361', 10, '72.89.51.47', 0, 0, '2018-01-11 15:12:08', '2018-01-11 15:15:20'),
	(145, '299130be73e12a5423dadec862da3d3e', 13, '72.89.51.47', 2, 0, '2018-01-11 15:15:25', '2018-01-18 15:41:05'),
	(146, '389254d91496a79ba4f9f64c8e8981e5', 1, '203.187.247.198', 0, 0, '2018-01-11 17:49:10', '2018-01-11 18:01:27'),
	(147, '179417f24aa743df420422602de55d90', 10, '38.140.162.82', 2, 0, '2018-01-11 21:29:20', '2018-01-12 14:38:32'),
	(148, '213ac8b822f5dcb6c65e60783279d877', 1, '203.187.247.198', 0, 0, '2018-01-12 13:53:47', '2018-01-12 14:10:14'),
	(149, 'a630de1897c8d8c45f97424083d0a532', 10, '68.174.71.56', 2, 0, '2018-01-12 14:38:32', '2018-01-12 16:08:40'),
	(150, '9c999c067f8d55ba8598c982d091c29e', 10, '68.174.71.56', 2, 0, '2018-01-12 16:08:40', '2018-01-12 16:40:39'),
	(151, '17772b68be8a7d6253174b253ef6d4a1', 10, '72.89.51.47', 2, 0, '2018-01-12 16:40:39', '2018-01-12 17:21:33'),
	(152, '7fc666db8be51bc6e3982ea91bdae47c', 1, '203.187.247.198', 2, 0, '2018-01-12 16:41:16', '2018-01-12 17:30:20'),
	(153, 'dc431195c541ca54da9981a89a286b5c', 10, '68.174.71.56', 2, 0, '2018-01-12 17:21:33', '2018-01-12 19:51:04'),
	(154, '0af86b83949f2fe81f26ce780a6ffd6e', 1, '203.187.247.198', 0, 0, '2018-01-12 17:30:20', '2018-01-12 17:31:04'),
	(155, '885fec258ab6bb036559fef0e48cf2b9', 10, '68.174.71.56', 2, 0, '2018-01-12 19:51:04', '2018-01-12 22:47:34'),
	(156, '2402d7e8870715a3dac52fa12f8d73c4', 10, '68.174.71.56', 2, 0, '2018-01-12 22:47:34', '2018-01-18 15:26:41'),
	(157, 'c33791dc027d0050bd91633bae0f5791', 1, '203.187.247.198', 0, 0, '2018-01-16 11:06:18', '2018-01-16 11:11:28'),
	(158, '1efab5087d49c045f3e3d21b35745afb', 1, '203.187.247.198', 0, 0, '2018-01-16 13:25:36', '2018-01-16 13:33:52'),
	(159, '9468825620799272add8c4e536638b80', 1, '203.187.247.198', 0, 0, '2018-01-16 14:40:02', '2018-01-16 14:42:30'),
	(160, 'b7eb3f4752b543bdd58fafebee63d60d', 1, '203.187.247.198', 0, 0, '2018-01-16 17:20:47', '2018-01-16 17:42:59'),
	(161, 'e66c8df7a4865f78a67a431961adfa3c', 1, '203.187.247.198', 0, 0, '2018-01-18 11:22:35', '2018-01-18 11:29:00'),
	(162, 'e55f8b60df0524bd958f2f5b7e64cfd4', 1, '203.187.247.198', 2, 0, '2018-01-18 13:55:23', '2018-01-18 16:20:17'),
	(163, 'ef59da8cdc24dbe7f4836bb4686fd81d', 10, '23.125.48.149', 0, 0, '2018-01-18 15:26:41', '2018-01-18 15:40:47'),
	(164, 'a760fa739bc6bd57490c4f9d995088ad', 13, '23.125.48.149', 0, 0, '2018-01-18 15:41:05', '2018-01-18 15:52:18'),
	(165, '9b506958d7fa0325761224b79b5fb875', 10, '23.125.48.149', 2, 0, '2018-01-18 15:52:22', '2018-01-18 16:44:57'),
	(166, '2e2cf9a0db664126778823ce27ed42a4', 1, '203.187.247.198', 2, 0, '2018-01-18 16:20:17', '2018-01-19 10:45:29'),
	(167, '8ac639a43c23502d21e4f1a4283d0cc1', 10, '207.98.168.221', 0, 0, '2018-01-18 16:44:57', '2018-01-18 17:38:10'),
	(168, '9df2de9ad8f6ec0f5f6f72568418b147', 13, '207.98.168.221', 0, 0, '2018-01-18 17:38:36', '2018-01-18 17:39:39'),
	(169, 'bae05ba0d370ce9b7326f704f801c1eb', 10, '207.98.168.221', 0, 0, '2018-01-18 17:39:47', '2018-01-18 17:40:10'),
	(170, 'cb8f5751bdc15d4cfbe44795f831ffe4', 13, '207.98.168.221', 0, 0, '2018-01-18 17:40:19', '2018-01-18 17:41:08'),
	(171, 'd78e079e148ed94da9a3b5530e25d7d9', 10, '207.98.168.221', 0, 0, '2018-01-18 17:41:16', '2018-01-18 17:41:47'),
	(172, 'e0bd5ca4203844b942b7b7ad29608378', 13, '207.98.168.221', 0, 0, '2018-01-18 17:41:55', '2018-01-18 17:42:25'),
	(173, 'af1365d89f5ace30aeb3474f1ff9bac7', 10, '207.98.168.221', 0, 0, '2018-01-18 17:42:34', '2018-01-18 17:42:48'),
	(174, 'e62af8b993be8802d4e3ca60a090e97f', 13, '207.98.168.221', 0, 0, '2018-01-18 17:43:00', '2018-01-18 17:43:32'),
	(175, '638b181e30b8134144a90412fd56683f', 10, '207.98.168.221', 0, 0, '2018-01-18 17:43:41', '2018-01-18 17:44:54'),
	(176, 'f7a53590c7c91efa759683cbf6579d5b', 13, '207.98.168.221', 0, 0, '2018-01-18 17:45:05', '2018-01-18 17:59:09'),
	(177, 'e284cb64e13d5059c20f629f754183c2', 10, '207.98.168.221', 0, 0, '2018-01-18 17:59:18', '2018-01-18 18:34:14'),
	(178, 'c8db2314ddef2a495b0a2f98820d72fc', 13, '207.98.168.221', 0, 0, '2018-01-18 18:34:28', '2018-01-18 19:16:43'),
	(179, '0222bcc605d4a8de27369d2ee4e84b8a', 10, '207.98.168.221', 0, 0, '2018-01-18 19:16:51', '2018-01-18 19:17:26'),
	(180, '4faabd8774964de4277bf1a0d9653fcf', 13, '207.98.168.221', 0, 0, '2018-01-18 19:17:34', '2018-01-18 19:19:40'),
	(181, '4225cca471188ef971c7603707bf6c29', 10, '207.98.168.221', 0, 0, '2018-01-18 19:19:49', '2018-01-18 19:20:20'),
	(182, 'cba6be3fea82d4a44ad79282707c9d29', 13, '207.98.168.221', 0, 0, '2018-01-18 19:20:30', '2018-01-18 19:21:03'),
	(183, '213065417099ce4763ec8e4838a26316', 10, '207.98.168.221', 0, 0, '2018-01-18 19:21:09', '2018-01-18 19:21:17'),
	(184, 'cca0958f8ab91cebc6d9d1642b812a98', 13, '207.98.168.221', 2, 0, '2018-01-18 19:21:25', '2018-01-18 20:45:20'),
	(185, '1377e02682ebb7eb80c77d4d1e475a43', 13, '207.98.168.221', 0, 0, '2018-01-18 20:45:20', '2018-01-18 21:10:31'),
	(186, '117d21df83d25061de8a791092d86706', 10, '207.98.168.221', 0, 0, '2018-01-18 21:10:38', '2018-01-18 21:11:59'),
	(187, 'c76c87d7d72aa2273cc0422bb89f4fba', 10, '68.97.40.205', 0, 0, '2018-01-18 23:28:04', '2018-01-19 00:04:42'),
	(188, '614b170f10bd649d50bd17d9b56ea153', 13, '68.97.40.205', 0, 0, '2018-01-19 00:04:57', '2018-01-19 00:22:23'),
	(189, '50241d064c0c9664905213a8f1abeb2d', 13, '68.97.40.205', 0, 0, '2018-01-19 00:52:42', '2018-01-19 01:16:23'),
	(190, '599bbb2bf4eb255d1e8fb375564dba2c', 1, '203.187.247.198', 2, 0, '2018-01-19 10:45:29', '2018-01-19 12:29:42'),
	(191, '0500462497fab9535ba86ec3b3f9e5a5', 10, '23.125.48.149', 0, 0, '2018-01-19 10:50:26', '2018-01-19 10:50:35'),
	(192, '19e36085a550eeb47b8ef319d9e047f4', 13, '23.125.48.149', 2, 0, '2018-01-19 10:50:44', '2018-01-19 14:47:04'),
	(193, '9566c0f8f035005b0d15c6acf444b19f', 1, '203.187.247.198', 2, 0, '2018-01-19 12:29:42', '2018-01-19 14:10:17'),
	(194, '24c589ab79dc029e3233380c3951b6b8', 1, '203.187.247.198', 2, 0, '2018-01-19 14:10:17', '2018-01-19 17:32:29'),
	(195, '865c29cd68b2c0683354ef85121e5d39', 10, '104.56.146.115', 0, 0, '2018-01-19 14:40:40', '2018-01-19 14:46:51'),
	(196, '2f78cb7d8978c96ac701bfc5f0b29c06', 13, '104.56.146.115', 2, 0, '2018-01-19 14:47:04', '2018-01-19 15:05:12'),
	(197, 'ccb7945913448de11e859db5302fb46f', 10, '72.89.51.47', 0, 0, '2018-01-19 15:04:58', '2018-01-19 15:05:06'),
	(198, 'a2e83c950b4c2ac3c89f9290ec646a16', 13, '72.89.51.47', 2, 0, '2018-01-19 15:05:12', '2018-01-19 15:10:32'),
	(199, 'f7654adc21c0a7c577231daf55f901d5', 13, '104.56.146.115', 2, 0, '2018-01-19 15:10:32', '2018-01-19 15:11:51'),
	(200, 'b93ef0618a58c4cbc419356fd1697389', 13, '72.89.51.47', 2, 0, '2018-01-19 15:11:51', '2018-01-19 15:12:13'),
	(201, '06c6eb7bc5e2369f917a00cf800a21e6', 13, '104.56.146.115', 2, 0, '2018-01-19 15:12:13', '2018-01-19 15:12:37'),
	(202, '37b51cce4c7c8261e96e4b02c31b1f12', 13, '72.89.51.47', 2, 0, '2018-01-19 15:12:37', '2018-01-19 15:13:33'),
	(203, '7bc5cd2dac1fe110de9dfd22388114f6', 13, '104.56.146.115', 2, 0, '2018-01-19 15:13:33', '2018-01-19 15:14:30'),
	(204, 'aca163df3cbd326f7d50fcf6bf51f4ea', 13, '72.89.51.47', 2, 0, '2018-01-19 15:14:30', '2018-01-19 15:14:46'),
	(205, '915c3a3f96f614a326fa3df8a10112e3', 13, '104.56.146.115', 0, 0, '2018-01-19 15:14:46', '2018-01-19 15:19:44'),
	(206, 'ac27c73db0d13d865fd09289a9fcf4cb', 10, '104.56.146.115', 0, 0, '2018-01-19 15:20:06', '2018-01-19 15:22:14'),
	(207, 'eb4f01475fb4571fa75d60c435b33d38', 13, '104.56.146.115', 0, 0, '2018-01-19 15:22:22', '2018-01-19 15:22:51'),
	(208, '7dcf9bc4d12e0d69c590c5cf0dd52c64', 10, '104.56.146.115', 2, 0, '2018-01-19 15:22:59', '2018-01-20 15:18:29'),
	(209, 'fd9e068e0c4106f3cc77e5e0c7c6fd3c', 13, '207.98.168.221', 2, 0, '2018-01-19 16:37:19', '2018-01-22 14:02:23'),
	(210, '1892fb09573e5b1ce4032afa53297985', 1, '203.187.247.198', 2, 0, '2018-01-19 17:32:29', '2018-01-22 12:30:05'),
	(211, '5ff7ac435a7e297adad1c2dec45bb4df', 10, '23.236.13.135', 2, 0, '2018-01-20 15:18:29', '2018-01-22 13:35:01'),
	(212, '3347d6fe584eee40fc8835296a8232e0', 1, '203.187.247.198', 2, 0, '2018-01-22 12:30:05', '2018-01-22 15:57:14'),
	(213, '9672658d8c47b976893ffb15dbb52306', 10, '207.98.168.221', 2, 0, '2018-01-22 13:35:01', '2018-01-22 19:37:15'),
	(214, '29af14571dd673b1d637e7a4eb94f609', 13, '23.125.48.149', 2, 0, '2018-01-22 14:02:23', '2018-01-22 15:32:23'),
	(215, '83cc5b5e27e0bc99bb848e431b40b32d', 13, '23.125.48.149', 2, 0, '2018-01-22 15:32:23', '2018-01-23 14:33:39'),
	(216, '298f786933ba7025c7deccb78dc3a557', 1, '203.187.247.198', 2, 0, '2018-01-22 15:57:14', '2018-01-22 17:33:54'),
	(217, 'c818b2807fa947440b90998b4820d181', 1, '203.187.247.198', 0, 0, '2018-01-22 17:33:54', '2018-01-22 17:35:25'),
	(218, '67ad7a645fec4d623dcf0489efb2eb0d', 10, '23.236.13.132', 2, 0, '2018-01-22 19:37:15', '2018-01-23 15:00:33'),
	(219, '450b876e6de0397c7089a12f9dc62513', 1, '203.187.247.198', 0, 0, '2018-01-23 10:06:56', '2018-01-23 10:29:32'),
	(220, '04cd43c8716242d1e1daff1935808116', 1, '203.187.247.198', 2, 0, '2018-01-23 14:11:11', '2018-01-23 15:45:51'),
	(221, '3670ab9de8589069285fb2b5291b619e', 13, '203.187.247.198', 2, 0, '2018-01-23 14:33:39', '2018-01-23 15:25:52'),
	(222, 'da2643681ad91b409d5ef379a087a9fc', 10, '72.89.51.47', 0, 0, '2018-01-23 15:00:33', '2018-01-23 15:26:00'),
	(223, '08b5c4a3a176a8b740ffefaf80472b0f', 13, '23.125.48.149', 0, 0, '2018-01-23 15:25:52', '2018-01-23 15:26:05'),
	(224, '486468305db54460bb34bbcdf2b71847', 10, '23.125.48.149', 2, 0, '2018-01-23 15:26:09', '2018-01-23 21:24:19'),
	(225, '14b52421919c6d0070e131818cf810c9', 1, '203.187.247.198', 2, 0, '2018-01-23 15:45:51', '2018-01-23 17:28:03'),
	(226, '8f24b8c4586e24a0ee3d134e0dbf09da', 1, '203.187.247.198', 2, 0, '2018-01-23 17:28:03', '2018-01-23 17:30:57'),
	(227, '1b3c5e0b762c4225d7b7a053b1789022', 1, '203.187.247.198', 2, 0, '2018-01-23 17:30:57', '2018-01-24 08:50:28'),
	(228, 'f557a31422e5aaf429e4cb79ca29d08a', 10, '23.236.13.132', 2, 0, '2018-01-23 21:24:19', '2018-01-26 14:55:37'),
	(229, '1f305e4eed8931df0e579b4cbb1666fc', 1, '203.187.247.198', 2, 0, '2018-01-24 08:50:28', '2018-01-24 10:27:11'),
	(230, '2ef287950a93e90ec81cba6a2de543c5', 1, '203.187.247.198', 2, 0, '2018-01-24 10:27:11', '2018-01-24 13:50:55'),
	(231, '51c147ed8456f1773d47e68c3b9e063a', 1, '203.187.247.198', 2, 0, '2018-01-24 13:50:55', '2018-01-25 19:01:15'),
	(232, '4aaf72cd2bd92743f6c3fe0f11f90892', 1, '203.187.247.198', 0, 0, '2018-01-25 19:01:15', '2018-01-25 19:05:24'),
	(233, '04b31b1cb343806197906eb50588a995', 4, '203.187.247.198', 0, 0, '2018-01-25 19:05:34', '2018-01-25 19:05:48'),
	(234, '474953579d312473f5d76611df52eed1', 3, '203.187.247.198', 0, 0, '2018-01-25 19:06:01', '2018-01-25 19:19:40'),
	(235, 'dfee5dbba321cb467fcdca344ad248a5', 10, '71.125.5.72', 2, 0, '2018-01-26 14:55:37', '2018-01-26 16:30:09'),
	(236, '58de8e8111284d7f1c3871531fb94665', 10, '71.125.5.72', 2, 0, '2018-01-26 16:30:09', '2018-01-30 15:21:05'),
	(237, '4179a7e93d2d63cf1ae4fa00b9f4f53d', 1, '203.187.247.198', 0, 0, '2018-01-29 14:39:35', '2018-01-29 14:40:31'),
	(238, '9f52d2f50754c93589af9cba8febf676', 1, '203.187.247.198', 2, 0, '2018-01-30 10:27:57', '2018-01-30 12:44:15'),
	(239, '381975c49655322ac4674a6e02687fa6', 1, '203.187.247.198', 0, 0, '2018-01-30 12:44:15', '2018-01-30 12:44:15'),
	(240, '9b2432b24d0bee22f9b44126d65f959c', 1, '203.187.247.198', 0, 0, '2018-01-30 12:44:22', '2018-01-30 12:48:02'),
	(241, '23059314843de5e72bccdca440997b67', 1, '203.187.247.198', 0, 0, '2018-01-30 13:29:40', '2018-01-30 13:29:41'),
	(242, '83aaaa4e0f6d90b1143a6b98245b8657', 1, '203.187.247.198', 2, 0, '2018-01-30 13:29:47', '2018-01-30 16:07:07'),
	(243, '31d1612dd8e8b3cc9f8cf81ccc696d70', 10, '23.125.48.149', 2, 0, '2018-01-30 15:21:05', '2018-01-30 18:01:39'),
	(244, '19c07c2342bccfa83dfb5cf9a15b971d', 1, '203.187.247.198', 2, 0, '2018-01-30 16:07:07', '2018-01-31 07:50:47'),
	(245, '85ab7b62efc04a15f9cd1c96ed43d773', 10, '72.89.51.47', 2, 0, '2018-01-30 18:01:39', '2018-01-30 18:59:07'),
	(246, 'e02b73ebc9ef5b9c6a190a240cfc5d6d', 10, '23.125.48.149', 2, 0, '2018-01-30 18:59:07', '2018-02-02 10:43:06'),
	(247, 'a975ac11d264b1f301fcffd1ba4c6d1c', 1, '203.187.247.198', 2, 0, '2018-01-31 07:50:47', '2018-01-31 14:32:56'),
	(248, 'aa73cbe14625c0bdf02f5b0d8274d26e', 1, '203.187.247.198', 0, 0, '2018-01-31 14:32:56', '2018-01-31 14:47:25'),
	(249, '9bc1223cee072094b020d2447f6a0c66', 1, '203.187.247.198', 0, 0, '2018-01-31 15:47:58', '2018-01-31 15:48:51'),
	(250, 'c6bc6decbdb0073b8c41530e065221e5', 8, '203.187.247.198', 0, 0, '2018-01-31 15:48:59', '2018-01-31 15:49:40'),
	(251, 'd57d3fe1d7728dfc85f173b0f22bdc35', 1, '203.187.247.198', 2, 0, '2018-01-31 16:39:41', '2018-01-31 19:28:43'),
	(252, 'd6782897b0a1f555791d09bfc7048375', 1, '203.187.247.198', 2, 0, '2018-01-31 19:28:43', '2018-02-01 11:05:12'),
	(253, '38171c722e189ffb531b9cebfb5fc956', 1, '203.187.247.198', 0, 0, '2018-02-01 11:05:12', '2018-02-01 11:05:38'),
	(254, '399a5b81bd88bc0fd9b419f059b20e1f', 1, '203.187.247.198', 0, 0, '2018-02-01 11:22:33', '2018-02-01 12:59:03'),
	(255, '16b38d94431ea81e49ebc9a504620c60', 1, '203.187.247.198', 0, 0, '2018-02-01 14:04:27', '2018-02-01 14:07:34'),
	(256, 'b596de6c927a5615ba88e1ea0a9a14cf', 1, '203.187.247.198', 0, 0, '2018-02-01 14:21:55', '2018-02-01 14:22:08'),
	(257, 'be63145711943c8418a90a78f97acdcd', 1, '203.187.247.198', 2, 0, '2018-02-01 14:26:08', '2018-02-02 13:38:00'),
	(258, '92c26dae71f8abc1ea40e3632d655c95', 10, '23.125.48.149', 2, 0, '2018-02-02 10:43:06', '2018-02-02 14:20:24'),
	(259, 'a03676950e60059c77a09e57f4f49926', 1, '203.187.247.198', 2, 0, '2018-02-02 13:38:00', '2018-02-02 14:01:20'),
	(260, 'c82be85ded6f003e27900be21eb6298b', 1, '203.187.247.198', 0, 0, '2018-02-02 14:01:20', '2018-02-02 14:21:51'),
	(261, '2f9cf720109dd1399926e18d8764d9b1', 10, '72.89.51.47', 2, 0, '2018-02-02 14:20:24', '2018-02-02 16:58:59'),
	(262, '628d3d2b24c3e52bc163804fce310fc1', 1, '203.187.247.198', 0, 0, '2018-02-02 14:50:41', '2018-02-02 14:51:45'),
	(263, 'f3b067762fcf76de5a2ea649ae81e055', 1, '203.187.247.198', 0, 0, '2018-02-02 15:08:58', '2018-02-02 15:09:24'),
	(264, 'b18fca25f5bc2434f7f38f80906fa393', 10, '23.125.48.149', 0, 0, '2018-02-02 16:58:59', '2018-02-02 16:59:09'),
	(265, '7ab97aede84a23004ee5616b744b1c31', 13, '23.125.48.149', 0, 0, '2018-02-02 16:59:13', '2018-02-02 17:37:02'),
	(266, '90e5d93933b53d4cb7ebe7e7bd33d301', 13, '23.125.48.149', 2, 0, '2018-02-02 17:37:10', '2018-02-05 12:40:06'),
	(267, 'e5d9fa9aa97d9345bbf686b7b8532a33', 1, '203.187.247.198', 2, 0, '2018-02-02 17:44:35', '2018-02-03 07:40:58'),
	(268, '897f0c8a7e8dcdcce1d196fbccc9416d', 1, '203.187.247.198', 0, 0, '2018-02-03 07:40:58', '2018-02-03 08:09:47'),
	(269, '2ad468de20d80b4bc1e79795edb27000', 10, '23.125.48.149', 2, 0, '2018-02-05 11:21:19', '2018-02-06 10:32:23'),
	(270, 'e1817741761fa5a2e808a53c1b121a20', 1, '203.187.247.198', 0, 0, '2018-02-05 12:34:54', '2018-02-05 12:39:43'),
	(271, '0f907908b64f1e83a7ec5e58806370c2', 13, '203.187.247.198', 0, 0, '2018-02-05 12:40:06', '2018-02-05 12:40:22'),
	(272, '6795ac4572944bc382bcbd1484e27654', 1, '203.187.247.198', 2, 0, '2018-02-05 16:20:48', '2018-02-06 11:17:02'),
	(273, 'f7bb9fdd3a5d4431ce5bea762fac7b1f', 10, '23.125.48.149', 0, 0, '2018-02-06 10:32:23', '2018-02-06 10:39:06'),
	(274, '869b8c9c7a9eb9a41301c9269fecead0', 13, '23.125.48.149', 2, 0, '2018-02-06 10:39:11', '2018-02-06 13:00:09'),
	(275, 'cf9f9e8cf5f7b9c9d705c6ffe32c6d55', 1, '203.187.247.198', 0, 0, '2018-02-06 11:17:02', '2018-02-06 11:27:26'),
	(276, '1116c88e3584a689423453493b5e599e', 1, '203.187.247.198', 0, 0, '2018-02-06 11:27:41', '2018-02-06 11:28:44'),
	(277, '3a40613c33b45fb8598bb34a4d02f674', 3, '203.187.247.198', 0, 0, '2018-02-06 11:28:55', '2018-02-06 11:29:24'),
	(278, 'ff6d2d12592f572b791c91bae1e988b1', 1, '203.187.247.198', 0, 0, '2018-02-06 11:29:30', '2018-02-06 11:29:37'),
	(279, '31e50cccc91a19b250b24bb1a969fc1c', 3, '203.187.247.198', 0, 0, '2018-02-06 11:29:46', '2018-02-06 11:39:21'),
	(280, 'cfa563361380ea03f831ecee4d7a5b17', 1, '203.187.247.198', 0, 0, '2018-02-06 11:39:32', '2018-02-06 11:40:11'),
	(281, '8c1f4b22300ca6820efca5aad6e7b506', 3, '203.187.247.198', 0, 0, '2018-02-06 11:40:22', '2018-02-06 11:42:07'),
	(282, '35054c3a5edb59f0e7e2d48b305d2546', 1, '203.187.247.198', 0, 0, '2018-02-06 11:42:15', '2018-02-06 11:42:28'),
	(283, '7cecba2aa9de17f9f865e6bd8752139c', 3, '203.187.247.198', 0, 0, '2018-02-06 11:42:40', '2018-02-06 11:53:46'),
	(284, 'e5ed59fdcf20dab128404a4be8afa7ab', 13, '203.187.247.198', 0, 0, '2018-02-06 13:00:09', '2018-02-06 13:00:29'),
	(285, '6e20f91d2023bd1c834f901cd59cdc18', 1, '203.187.247.198', 0, 0, '2018-02-06 14:03:58', '2018-02-06 14:05:40'),
	(286, 'c41035708b93092085fc2b6ae777dfd0', 1, '203.187.247.198', 2, 0, '2018-02-06 15:04:08', '2018-02-06 15:24:44'),
	(287, 'e526361c6623cb29e1ffa5623080a170', 1, '203.187.247.198', 0, 0, '2018-02-06 15:24:44', '2018-02-06 16:26:36'),
	(288, 'b9bcb992fcbf3afbbccec2db2f8a6547', 10, '23.125.48.149', 2, 0, '2018-02-06 15:40:24', '2018-02-08 14:59:46'),
	(289, '5f9553c9a840a2cc49491d485ff59042', 1, '203.187.247.198', 2, 0, '2018-02-06 17:06:15', '2018-02-07 10:29:36'),
	(290, '487d9594d8f4475a4f41ba707b121e67', 1, '203.187.247.198', 0, 0, '2018-02-07 10:29:36', '2018-02-07 10:47:29'),
	(291, 'a9eae1af85443bf0ce9445874c1c9a0e', 13, '203.187.247.198', 0, 0, '2018-02-07 16:58:50', '2018-02-07 18:14:05'),
	(292, 'ff03345a8ece4798c5cab9dcdd0e742c', 1, '203.187.247.198', 2, 0, '2018-02-07 17:28:24', '2018-02-07 18:14:14'),
	(293, '1e88367f34376f02222fb694635b39a0', 1, '203.187.247.198', 2, 0, '2018-02-07 18:14:14', '2018-02-07 19:48:14'),
	(294, '8e3f32e3e02fd2ec8c6750650564af39', 1, '203.187.247.198', 0, 0, '2018-02-07 19:48:14', '2018-02-07 20:03:24'),
	(295, '6dd91be3986bd1a9ae21ff537b4db42b', 1, '203.187.247.198', 0, 0, '2018-02-08 10:37:00', '2018-02-08 10:46:19'),
	(296, '7a9a063a2bcfcc856d2fa1db72415a02', 1, '203.187.247.198', 0, 0, '2018-02-08 12:33:53', '2018-02-08 12:34:59'),
	(297, '1c83cd9280a4b0ab62c960b2689ce718', 1, '203.187.247.198', 0, 0, '2018-02-08 12:36:10', '2018-02-08 12:38:10'),
	(298, 'b0498550d2a5f5232ac120e5d90a302f', 1, '203.187.247.198', 0, 0, '2018-02-08 13:25:44', '2018-02-08 13:28:44'),
	(299, '1fb7f9bfae386aa3ceb52bbfcd146c24', 1, '203.187.247.198', 0, 0, '2018-02-08 13:29:34', '2018-02-08 13:30:04'),
	(300, '331c273c58dfb370577e1a25dbedbf04', 1, '203.187.247.198', 0, 0, '2018-02-08 13:30:46', '2018-02-08 13:58:41'),
	(301, 'a97fd137dee0c8b63192a8f1e063c61a', 10, '71.125.5.72', 2, 0, '2018-02-08 14:59:46', '2018-02-08 18:05:12'),
	(302, '6167526d04f807c886725dc95196351c', 1, '203.187.247.198', 0, 0, '2018-02-08 16:52:56', '2018-02-08 16:53:08'),
	(303, 'b5d8aead5e9a794118b795f50acfb855', 1, '203.187.247.198', 0, 0, '2018-02-08 16:54:48', '2018-02-08 17:46:10'),
	(304, 'f5b3c37becea03d7b923cb8d8882d069', 14, '203.187.247.198', 0, 0, '2018-02-08 17:52:21', '2018-02-08 17:52:25'),
	(305, '80f2b8b4ffa7709d17d1133d00482ae8', 1, '203.187.247.198', 0, 0, '2018-02-08 17:53:09', '2018-02-08 18:03:49'),
	(306, '462f2ff454d890a71026a7d1f43d3321', 13, '203.187.247.198', 0, 0, '2018-02-08 18:03:58', '2018-02-08 18:09:09'),
	(307, '551831cd6426af3f690a47c58fba4980', 10, '71.125.5.72', 0, 0, '2018-02-08 18:05:12', '2018-02-08 18:12:21'),
	(308, '922df2b7e0f838ae1ebcdf9832b78743', 1, '203.187.247.198', 0, 0, '2018-02-08 18:09:15', '2018-02-08 18:13:02'),
	(309, '1b7894a5d8e328fd7dd72827ceb643fb', 1, '203.187.247.198', 2, 0, '2018-02-08 18:38:18', '2018-02-08 20:17:45'),
	(310, 'b989a0b0da55e37c94a614bb93d360f0', 1, '203.187.247.198', 0, 0, '2018-02-08 20:17:45', '2018-02-08 20:20:34'),
	(311, '3040800aeb9e5a8529bde2180fcd4b72', 1, '203.187.247.198', 0, 0, '2018-02-09 11:05:26', '2018-02-09 11:19:43'),
	(312, '2f79068a3b744651fe81838b2af8caf2', 1, '203.187.247.198', 0, 0, '2018-02-09 12:22:03', '2018-02-09 12:51:13'),
	(313, 'ff9dedfbc2c92f20109b1a1558166020', 1, '203.187.247.198', 0, 0, '2018-02-09 13:37:16', '2018-02-09 13:40:12'),
	(314, '8248c0fbfa3b4a01bdaef9b754a8a679', 1, '203.187.247.198', 0, 0, '2018-02-09 14:41:40', '2018-02-09 14:42:17'),
	(315, 'b8dd393a494b7e4fe07eafefeb4d2574', 10, '71.125.5.72', 2, 0, '2018-02-09 14:42:38', '2018-02-09 20:51:28'),
	(316, 'b673a8639d3e92ae24545305ce62496f', 1, '203.187.247.198', 0, 0, '2018-02-09 17:41:50', '2018-02-09 17:42:14'),
	(317, '84c60c791da0b4422e649bfae0229a9e', 10, '23.125.48.149', 2, 0, '2018-02-09 20:51:28', '2018-02-09 21:00:07'),
	(318, '252f64d57343f4e810c646997fa89e55', 10, '71.125.5.72', 0, 0, '2018-02-09 21:00:07', '2018-02-09 21:06:31'),
	(319, '23328d8ac3084ec8c15112e2e4356c14', 1, '203.187.247.198', 2, 0, '2018-02-12 18:05:14', '2018-02-13 13:52:16'),
	(320, 'c03958bc315ea7400c56059680e2e03e', 1, '203.187.247.198', 0, 0, '2018-02-13 13:52:16', '2018-02-13 13:52:54'),
	(321, '44c18d739127193a2db2265bb8758b04', 67, '207.98.168.221', 0, 0, '2018-02-13 17:23:30', '2018-02-13 17:26:27'),
	(322, '095cd8b0d2da5ea9e69c0663f5718137', 10, '207.98.168.221', 2, 0, '2018-02-13 17:26:37', '2018-02-14 12:40:30'),
	(323, '3b01c8d179880461c6fd2661b904a18b', 1, '203.187.247.198', 2, 0, '2018-02-14 10:48:18', '2018-02-14 17:37:38'),
	(324, '6cf50bb7b747846c2099d0beb6fd40c6', 10, '23.125.48.149', 0, 0, '2018-02-14 12:40:30', '2018-02-14 15:41:30'),
	(325, '529120a159fc839428920bdafa0809d2', 13, '23.125.48.149', 0, 0, '2018-02-14 15:41:36', '2018-02-14 15:43:11'),
	(326, '4f809402fef6e6f513d61d720695b28d', 10, '23.125.48.149', 0, 0, '2018-02-14 15:43:13', '2018-02-14 15:43:29'),
	(327, '598683f40178ffc4d38b660b92d1bbe6', 13, '23.125.48.149', 0, 0, '2018-02-14 15:43:35', '2018-02-14 15:44:07'),
	(328, 'eacef629beb7256d7c2e597a6228e5f1', 10, '23.125.48.149', 0, 0, '2018-02-14 15:44:09', '2018-02-14 15:44:51'),
	(329, '9049d0786d43a94aff50b3fac9b5894a', 13, '23.125.48.149', 0, 0, '2018-02-14 15:44:56', '2018-02-14 15:48:31'),
	(330, '2b76aea0ee023c8e688ae96a1999b9e2', 10, '23.125.48.149', 2, 0, '2018-02-14 15:48:33', '2018-02-14 15:53:24'),
	(331, '4a05344cc2656b433fd33156429ab3e2', 10, '207.98.168.221', 2, 0, '2018-02-14 15:53:24', '2018-02-14 15:53:37'),
	(332, 'eb97974956e0c49914486d9d7f2201c5', 10, '23.125.48.149', 2, 0, '2018-02-14 15:53:37', '2018-02-14 15:55:32'),
	(333, '48883ea1e7e65d48c3c2bc83e6c6394d', 10, '100.12.249.53', 2, 0, '2018-02-14 15:55:32', '2018-02-14 15:55:53'),
	(334, '606844e0de24b4f97e51fd66bb0affd6', 10, '207.98.168.221', 2, 0, '2018-02-14 15:55:53', '2018-02-14 16:00:16'),
	(335, '1fd5411ceae7f181b2bee8fcae60a155', 10, '100.12.249.53', 2, 0, '2018-02-14 16:00:16', '2018-02-14 16:12:37'),
	(336, '2eb613651d123debe32a29878d5d2f5c', 10, '107.77.104.95', 0, 0, '2018-02-14 16:12:37', '2018-02-14 16:12:58'),
	(337, '65886e2cf74c707869eeb4888bb00f1f', 13, '107.77.104.95', 0, 0, '2018-02-14 16:13:04', '2018-02-14 16:14:17'),
	(338, '57da2aaf4697723fc71d5227fae4bb1a', 10, '107.77.104.95', 2, 0, '2018-02-14 16:14:19', '2018-02-14 16:17:10'),
	(339, '309fdfab7ef7588a92337dcc48904008', 10, '100.12.249.53', 2, 0, '2018-02-14 16:17:10', '2018-02-14 16:17:39'),
	(340, '65ce8f5e262b5efac4f716e96f4bd2c2', 10, '107.77.104.95', 2, 0, '2018-02-14 16:17:39', '2018-02-14 16:28:22'),
	(341, 'eeea7fa69ba354c2ca773df7fd9ee850', 10, '203.187.247.198', 2, 0, '2018-02-14 16:28:22', '2018-02-14 16:30:33'),
	(342, 'b463929c65a8c2f4ccdb5b0fb0b01978', 10, '100.12.249.53', 2, 0, '2018-02-14 16:30:33', '2018-02-14 17:10:30'),
	(343, '57268085bc64bcac50f39bc79fc26250', 10, '107.77.104.95', 0, 0, '2018-02-14 17:10:30', '2018-02-14 17:10:30'),
	(344, 'e0ec0fd32727da4056e82ca3eeba6458', 10, '107.77.104.95', 2, 0, '2018-02-14 17:10:38', '2018-02-14 19:12:23'),
	(345, '12c77677addee172f9315c50febe28be', 1, '203.187.247.198', 2, 0, '2018-02-14 17:37:38', '2018-02-15 10:22:10'),
	(346, 'bbb768452ad57a3ef1f6e26eda7dd9ea', 10, '23.125.48.149', 0, 0, '2018-02-14 19:12:23', '2018-02-14 19:18:06'),
	(347, '59bd0fabef80e34166e4d053f9d51318', 13, '23.125.48.149', 2, 0, '2018-02-14 19:18:13', '2018-02-15 16:33:10'),
	(348, 'cdd1b238fb4d33dc994cb0b91672a2d2', 1, '203.187.247.198', 0, 0, '2018-02-15 10:22:10', '2018-02-15 10:32:17'),
	(349, '48fe91431177a05890432ede33024ef3', 10, '23.125.48.149', 2, 0, '2018-02-15 10:36:27', '2018-02-15 13:50:04'),
	(350, 'b045b044e58a409d92c0a9c166c0ca2c', 1, '203.187.247.198', 0, 0, '2018-02-15 10:43:05', '2018-02-15 14:14:47'),
	(351, '9a55dcaa84c3ab664f5a9ee28da96098', 10, '100.12.249.53', 0, 0, '2018-02-15 13:50:04', '2018-02-15 14:35:29'),
	(352, '3a7085c7ef2109a9bb7326632acfd8d1', 10, '100.12.249.53', 2, 0, '2018-02-15 14:54:21', '2018-02-15 16:29:33'),
	(353, 'beb694ef8be124e5229116479bfbce5b', 10, '23.125.48.149', 0, 0, '2018-02-15 16:29:33', '2018-02-15 16:32:57'),
	(354, '30a96573521e44d4cdd18f4076aacb98', 13, '23.125.48.149', 2, 0, '2018-02-15 16:33:10', '2018-02-15 17:07:09'),
	(355, '9973187c81ee72d6089ba913aeab8bd1', 10, '100.12.249.53', 0, 0, '2018-02-15 17:06:42', '2018-02-15 17:06:54'),
	(356, 'b4bad525d36ea16a73df2f39fbf1d4ad', 13, '100.12.249.53', 1, 0, '2018-02-15 17:07:09', '2018-02-15 18:09:12'),
	(357, '05c440e5ac3ddfec92fd39dac237b3c9', 1, '203.187.247.198', 0, 0, '2018-02-15 17:36:57', '2018-02-15 17:45:26'),
	(358, '8c7216e899eb616d8456632314d18561', 1, '203.187.247.198', 0, 0, '2018-02-15 17:48:49', '2018-02-15 17:49:27'),
	(359, 'c7ff0bd4a58b18f936b77ebb776bd3e7', 1, '203.187.247.198', 0, 0, '2018-02-15 18:12:40', '2018-02-15 18:14:23'),
	(360, '79102c0fcba3736856e2bbf8af8a7a1d', 10, '23.125.48.149', 2, 0, '2018-02-16 10:38:02', '2018-02-16 13:57:29'),
	(361, 'cbde1ef0485b578c20781960c41349ce', 10, '23.125.48.149', 2, 0, '2018-02-16 13:57:29', '2018-02-19 16:59:26'),
	(362, '5faa4d37890726002edd745cf8e3cdcd', 67, '207.98.168.221', 0, 0, '2018-02-19 16:57:35', '2018-02-19 16:59:10'),
	(363, '9e02ef0755b33173a461fefd4ee56928', 10, '207.98.168.221', 0, 0, '2018-02-19 16:59:26', '2018-02-19 17:28:05'),
	(364, '59aba6ab0f1d859829d861e4a03b275d', 67, '207.98.168.221', 0, 0, '2018-02-19 17:47:25', '2018-02-19 17:53:52'),
	(365, '402be3ea6072c96dca84194304f2f3fb', 10, '207.98.168.221', 2, 0, '2018-02-19 17:54:11', '2018-02-19 18:15:50'),
	(366, '486f5830a18088852f0ebe1322e6a0e1', 10, '107.77.94.115', 0, 0, '2018-02-19 18:15:50', '2018-02-19 18:41:38'),
	(367, 'e821099dab2f669168a29c38c0f16cd9', 67, '207.98.168.221', 2, 0, '2018-02-19 18:20:40', '2018-02-19 18:45:14'),
	(368, 'e4147a8451e4b51323392adec9ef425f', 67, '107.77.94.115', 0, 0, '2018-02-19 18:45:14', '2018-02-19 18:49:44'),
	(369, 'a2cecac1a7024a9321f41f460e429cde', 10, '107.77.94.115', 2, 0, '2018-02-19 18:49:46', '2018-02-19 19:03:42'),
	(370, '103af9282f7ab62a3f90f44fcaf8a68f', 67, '207.98.168.221', 0, 0, '2018-02-19 18:57:08', '2018-02-19 19:03:35'),
	(371, 'd8d5a73c0a5cd75b737f99bc511127a4', 10, '207.98.168.221', 2, 0, '2018-02-19 19:03:42', '2018-02-19 19:04:13'),
	(372, 'e3760b81a29915cf99b9259a9d85b71b', 10, '107.77.94.115', 1, 0, '2018-02-19 19:04:13', '2018-02-19 21:04:04'),
	(373, '001aac48d557fff62872f849e1c99dca', 67, '207.98.168.221', 1, 0, '2018-02-19 19:18:20', '2018-02-19 20:09:02');
/*!40000 ALTER TABLE `user_session` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
