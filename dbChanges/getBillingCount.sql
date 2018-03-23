DELIMITER //
DROP PROCEDURE IF EXISTS `getBillingCount`//
CREATE PROCEDURE `getBillingCount`(
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
	
END