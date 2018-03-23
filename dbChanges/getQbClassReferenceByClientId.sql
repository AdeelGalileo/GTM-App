DELIMITER //
DROP PROCEDURE IF EXISTS `getQbClassReferenceByClientId`//
CREATE PROCEDURE `getQbClassReferenceByClientId`(IN `_clientId` INT(11))
BEGIN
	SELECT qb_class_reference.qb_cls_ref_id,qb_cls_ref_client_id,qb_cls_ref_class_id,qb_cls_ref_class_name,qb_cls_ref_record_status,qb_cls_ref_created_by,qb_cls_ref_created_on,qb_cls_ref_modified_by,qb_cls_ref_modified_on 
	FROM qb_class_reference  
	INNER JOIN client ON client.client_id = qb_class_reference.qb_cls_ref_client_id
	WHERE qb_class_reference.qb_cls_ref_record_status=0 AND client.client_record_status= 0 AND qb_cls_ref_client_id = _clientId;
END