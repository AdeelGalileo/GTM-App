update task_keyword set task_keyword_qb_process = 0;
update task_content set task_content_qb_process = 0;
truncate table billing;
truncate table billing_task_reference;


update task_keyword set task_keyword_qb_inv_process = 0;
update task_content set task_content_qb_inv_process = 0;
truncate table invoice;
truncate table invoice_task_reference;


truncate table task_clone;
update task_keyword set task_is_sub_task = 0;
update task_keyword set task_keyword_service_type_id = 6;


truncate table task_keyword;
truncate table task_content;


truncate table task_keyword;
truncate table task_content;
truncate table task_content_admin_complete;
truncate table task_keyword_admin_complete;
truncate table alert_notification;
