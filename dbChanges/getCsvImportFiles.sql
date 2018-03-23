DELIMITER //
DROP PROCEDURE IF EXISTS getCsvImportFiles//
CREATE  PROCEDURE `getCsvImportFiles`(
	IN `_status` int
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
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
END