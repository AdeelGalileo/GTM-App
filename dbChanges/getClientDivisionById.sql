DELIMITER //
DROP PROCEDURE IF EXISTS `getClientDivisionById`//
CREATE PROCEDURE `getClientDivisionById`(
	IN `_clientQbRefId` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	SELECT client_qb_reference.client_qb_ref_id,client_qb_ref_client_id,client_qb_ref_division_id,client_qb_ref_qb_id,client_qb_ref_qb_class,client_qb_ref_record_status,client_qb_ref_created_by,client_qb_ref_created_on,client_qb_ref_modified_by,client_qb_ref_modified_on,division_code,division_name,client_name,client_id FROM client_qb_reference  
	INNER JOIN client ON client.client_id = client_qb_reference.client_qb_ref_client_id
	INNER JOIN division ON division.division_id = client_qb_reference.client_qb_ref_division_id
	WHERE client_qb_ref_record_status = 0 AND client_qb_ref_id = _clientQbRefId;
END