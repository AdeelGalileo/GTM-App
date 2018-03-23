<?php /* Smarty version Smarty-3.1.11, created on 2018-03-07 17:20:20
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_formUpdate.tpl" */ ?>
<?php /*%%SmartyHeaderCode:19798067625aa065a45163b8-10718603%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '218f6df7062f607a436115be753874735cd1ff6b' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_formUpdate.tpl',
      1 => 1519124689,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '19798067625aa065a45163b8-10718603',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'formData' => 0,
    'formUpdateId' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5aa065a453ab95_44883955',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5aa065a453ab95_44883955')) {function content_5aa065a453ab95_44883955($_smarty_tpl) {?>
<script type="text/javascript">
   
  $(document).ready(function(){
	
	var settings = {
		url: "forms.php",
		method: "POST",
		allowedTypes: "jpg,jpeg,png,pdf,doc,docx",
		fileName: "w9Form",
		multiple: false,
		dataType: "json",
		showStatusAfterSuccess: false,
		showStatusAfterSuccess:false,
		onSuccess:function(files,data,xhr){
		$('#fileUploadW9').html('<span class="fa fa-check-circle-o m-r-5"></span><?php echo @MSG_FILE_UPLOAD_SUCCESS;?>
');
		},
		onError: function(files,status,errMsg){
			$("#status").html("<font color='red'>Upload is Failed</font>");
		}
   }
   
   $("#mulitplefileuploaderW9").uploadFile(settings);
		
	var resumeSettings = {
		url: "forms.php",
		method: "POST",
		allowedTypes: "jpg,jpeg,png,pdf,doc,docx",
		fileName: "resumeForm",
		multiple: false,
		dataType: "json",
		showStatusAfterSuccess: false,
		showStatusAfterSuccess:false,
		onSuccess:function(files,data,xhr){
		$('#fileUploadResume').html('<span class="fa fa-check-circle-o m-r-5"></span><?php echo @MSG_FILE_UPLOAD_SUCCESS;?>
');
		},
		onError: function(files,status,errMsg){
			$("#status").html("<font color='red'>Upload is Failed</font>");
		}
   }
   
   $("#mulitplefileuploaderResume").uploadFile(resumeSettings);
   
   var achFormSettings = {
		url: "forms.php",
		method: "POST",
		allowedTypes: "jpg,jpeg,png,pdf,doc,docx",
		fileName: "achForm",
		multiple: false,
		dataType: "json",
		showStatusAfterSuccess: false,
		showStatusAfterSuccess:false,
		onSuccess:function(files,data,xhr){
		$('#fileUploadAch').html('<span class="fa fa-check-circle-o m-r-5"></span><?php echo @MSG_FILE_UPLOAD_SUCCESS;?>
');
		},
		onError: function(files,status,errMsg){
			$("#status").html("<font color='red'>Upload is Failed</font>");
		}
   }
   
   $("#mulitplefileuploaderAch").uploadFile(achFormSettings);
   
   var agreementSettings = {
		url: "forms.php",
		method: "POST",
		allowedTypes: "jpg,jpeg,png,pdf,doc,docx",
		fileName: "agreementForm",
		multiple: false,
		dataType: "json",
		showStatusAfterSuccess: false,
		showStatusAfterSuccess:false,
		onSuccess:function(files,data,xhr){
		$('#fileUploadAgreement').html('<span class="fa fa-check-circle-o m-r-5"></span><?php echo @MSG_FILE_UPLOAD_SUCCESS;?>
');
		},
		onError: function(files,status,errMsg){
			$("#status").html("<font color='red'>Upload is Failed</font>");
		}
   }
   
   $("#mulitplefileuploaderAgreement").uploadFile(agreementSettings);
   
  });
	
</script>

<div class="row"><div class="col-md-12"><div class="box box-primary"><div class="box-body"><div class="row"><div class="form-group col-sm-4"><label >Consultant</label><p><?php echo $_smarty_tpl->tpl_vars['formData']->value['user_fname'];?>
 <?php echo $_smarty_tpl->tpl_vars['formData']->value['user_lname'];?>
</p></div><div class="form-group col-sm-4"><label >W9</label><span id="mulitplefileuploaderW9"><a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a></span><span id="fileUploadW9" class="font14 bold blue"></span></div><div class="form-group col-sm-4"><label >Resume</label><span id="mulitplefileuploaderResume"><a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a></span><span id="fileUploadResume" class="font14 bold blue"></span></div></div><div class="row"><div class="form-group col-sm-4"><label >ACH Form</label><span id="mulitplefileuploaderAch"><a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a></span><span id="fileUploadAch" class="font14 bold blue"></span></div><div class="form-group col-sm-4"><label >Consultant Agreement</label><span id="mulitplefileuploaderAgreement"><a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a></span><span id="fileUploadAgreement" class="font14 bold blue"></span></div></div><button type="button" class="btn btn-default pull-right margin formUpdateCancel">Cancel</button><button type="button" class="btn btn-info pull-right margin addFormSave">Done</button></div></div></div><input type="hidden" name="formUpdateId" id="formUpdateId" class="formUpdateId" value="<?php echo $_smarty_tpl->tpl_vars['formUpdateId']->value;?>
"><input type="hidden" name="form_user_id" id="form_user_id" class="form_user_id" value="<?php echo $_smarty_tpl->tpl_vars['formData']->value['form_user_id'];?>
"></div>

<script>
  $(function () {

    //Date picker
    $('.datepicker').datepicker({
      autoclose: true,
	  format: "mm/dd/yyyy"
    });
	
  
  });
</script>
	  <?php }} ?>