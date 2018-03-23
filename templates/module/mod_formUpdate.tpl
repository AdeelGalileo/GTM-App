
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
		$('#fileUploadW9').html('<span class="fa fa-check-circle-o m-r-5"></span>{$smarty.const.MSG_FILE_UPLOAD_SUCCESS}');
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
		$('#fileUploadResume').html('<span class="fa fa-check-circle-o m-r-5"></span>{$smarty.const.MSG_FILE_UPLOAD_SUCCESS}');
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
		$('#fileUploadAch').html('<span class="fa fa-check-circle-o m-r-5"></span>{$smarty.const.MSG_FILE_UPLOAD_SUCCESS}');
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
		$('#fileUploadAgreement').html('<span class="fa fa-check-circle-o m-r-5"></span>{$smarty.const.MSG_FILE_UPLOAD_SUCCESS}');
		},
		onError: function(files,status,errMsg){
			$("#status").html("<font color='red'>Upload is Failed</font>");
		}
   }
   
   $("#mulitplefileuploaderAgreement").uploadFile(agreementSettings);
   
  });
	
</script>

{strip}

<div class="row">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
           <div class="form-group col-sm-4">
               <label >Consultant</label>
					   <p>
							{$formData.user_fname} {$formData.user_lname}
					  </p>
            </div>
            <div class="form-group col-sm-4">
               <label >W9</label>
				<span id="mulitplefileuploaderW9">
				<a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a>
				</span>
				<span id="fileUploadW9" class="font14 bold blue"></span>
            </div>
           
			 <div class="form-group col-sm-4">
                <label >Resume</label>
				<span id="mulitplefileuploaderResume">
				<a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a>
				</span>
				<span id="fileUploadResume" class="font14 bold blue"></span>
            </div>
			 </div>
			 <div class="row">
				<div class="form-group col-sm-4">
					<label >ACH Form</label>
					<span id="mulitplefileuploaderAch">
					<a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a>
					</span>
					<span id="fileUploadAch" class="font14 bold blue"></span>
				</div>
				<div class="form-group col-sm-4">
					<label >Consultant Agreement</label>
					<span id="mulitplefileuploaderAgreement">
					<a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a>
					</span>
					<span id="fileUploadAgreement" class="font14 bold blue"></span>
				</div>
			 </div>
			
			  
            <button type="button" class="btn btn-default pull-right margin formUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addFormSave">Done</button>
         </div>
      </div>
   </div>
      	  <input type="hidden" name="formUpdateId" id="formUpdateId" class="formUpdateId" value="{$formUpdateId}">
      	  <input type="hidden" name="form_user_id" id="form_user_id" class="form_user_id" value="{$formData.form_user_id}">

</div>

{/strip}

<script>
  $(function () {

    //Date picker
    $('.datepicker').datepicker({
      autoclose: true,
	  format: "mm/dd/yyyy"
    });
	
  
  });
</script>
	  