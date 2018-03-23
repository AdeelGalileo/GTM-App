DELIMITER //
DROP PROCEDURE IF EXISTS `getConsultantSkillList`//
CREATE PROCEDURE `getConsultantSkillList`(
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
	
END