DELIMITER //
DROP PROCEDURE IF EXISTS `getAlertList`//
CREATE PROCEDURE `getAlertList`(
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
	
END