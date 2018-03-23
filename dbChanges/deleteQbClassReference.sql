DELIMITER //
DROP PROCEDURE IF EXISTS `deleteQbClassReference`//
CREATE PROCEDURE `deleteQbClassReference`(
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

END