DELIMITER //
DROP PROCEDURE IF EXISTS `getAlertCount`//
CREATE PROCEDURE `getAlertCount`(
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
	
END