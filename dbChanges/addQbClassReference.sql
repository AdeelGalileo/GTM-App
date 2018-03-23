DELIMITER //
DROP PROCEDURE IF EXISTS addQbClassReference//
CREATE PROCEDURE `addQbClassReference`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_classQbRefUpateId` INT(11),
	IN `_classQbRefQbClassId` VARCHAR(100),
	IN `_classQbRefQbClassName` VARCHAR(255),
	IN `_dateTime` datetime

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update qb_class_reference'
BEGIN
		IF(_classQbRefUpateId > 0) THEN
			UPDATE qb_class_reference SET  qb_cls_ref_class_id = _classQbRefQbClassId,qb_cls_ref_class_name = _classQbRefQbClassName, qb_cls_ref_modified_by= _userId,qb_cls_ref_modified_on =  _dateTime WHERE qb_cls_ref_id = _classQbRefUpateId;
		ELSE
				INSERT INTO qb_class_reference(qb_cls_ref_client_id,qb_cls_ref_class_id,qb_cls_ref_class_name,qb_cls_ref_record_status,qb_cls_ref_created_by,qb_cls_ref_created_on,qb_cls_ref_modified_by,qb_cls_ref_modified_on)
			VALUES (_clientId, _classQbRefQbClassId,_classQbRefQbClassName, 0,_userId,_dateTime,_userId,_dateTime);
		END IF;
END