DELIMITER //
DROP PROCEDURE IF EXISTS `getConsultantRateList`//
CREATE PROCEDURE `getConsultantRateList`(
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
	
END