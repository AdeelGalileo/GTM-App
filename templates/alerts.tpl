{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Alerts{/block}
{block name=header}
<script type="text/javascript">
   var strClassAlert;
   var alertFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdAlert = 0;
   var sortIdAlert = 0;
   $(document).ready(function(){
   
   loadAlertList(50,orderIdAlert,sortIdAlert);
   	
   $('body').on('click', '.descendingClassAlert', function(){
   orderIdAlert = $(this).attr('id');
   sortIdAlert = 2;
   pageNo = $('#pageDropDownValue').val();
   strClassAlert = 'descendingClassAlert';
   var recCountValues = $('#alertPageListing').val();
   loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
    });
   
    $('body').on('click', '.ascendingClassAlert', function(){
   orderIdAlert = $(this).attr('id');
   sortIdAlert = 1;
   pageNo = $('#pageDropDownValue').val();
   strClassAlert = 'ascendingClassAlert';
   var recCountValues = $('#alertPageListing').val();
   loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
    });
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#alertPageListing').val();
          loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
      });
      $('body').on('click', '#paginationAuto .pagination-nav .leftArrowClass, #paginationAutoNew .pagination-nav .leftArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo-1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#alertPageListing').val();
          loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#alertPageListing').val();
          loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
      });
      $('body').on('change', '#alertPageListing', function(){
          var recCount = $(this).val();
          $('#alertPageListingNew').val(recCount);
          pageNo = 0;
          loadAlertList(recCount,orderIdAlert,sortIdAlert);
      });
      $('body').on('change', '#alertPageListingNew', function(){
          var recCount = $(this).val();
          $('#alertPageListing').val(recCount);
          pageNo = 0;
          loadAlertList(recCount,orderIdAlert,sortIdAlert);
      });	
   
   
   
   $('body').on('click', '.addNewAlert', function(){
   $(".addAlert").toggle();
   $(".updateAlert").hide();
   });	
   
   $('body').on('click', '.alertCancel', function(){
		location.reload();
   });	
   
   $('body').on('click', '.alertUpdateCancel', function(){
		location.reload();
   });	
   
   $('#notification_user_id').chosen({ width:"100%"});
   $('#notification_module_id').chosen({ width:"100%"});
   
   
    $('body').on('click', '.alertDeleteAction', function(){
	   var fieldId = $(this).attr('id').split('_')[1];
	   $('#delFieldId').val(fieldId);
	   $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
	   uiPopupOpen('confirmDelete', 500, 125);
   });
   
    $('body').on('click', '.cancelAlertDelButton', function(){
        uiPopClose('confirmDelete');
   });
   
   $('body').on('click', '.okAlertDelButton', function(){
   fieldId = $('#delFieldId').val();
   $.ajax({
   type : 'post',
   url: 'ajax/alert.php?rand='+Math.random(),
   data : { alertDelete: 1, alertDeleteId:fieldId },
   dataType:'json', 
   success: function(response){
   	checkResponseRedirect(response);
   	uiPopClose('confirmDelete');
   	showMessage(response.message);
   	loadAlertList(50,orderIdAlert,sortIdAlert,startDateParam,endDateParam,alertFilterBy);
   }
   });
   });
   
   
    $('body').on('change', '.notification_module_id', function(){
   	var modulesIp = $( this ).val();
   	if(modulesIp==''){
   			return false;
   	 }
	 
	 if(modulesIp > {$smarty.const.ALERT_SHOW_ADMIN_USER_ID} ){
		$(".userNotification").hide();
		$(".userNotificationEmail").hide();
		$(".userNotificationForConsultant").show();
	 }
	 else{
		 $(".userNotification").show();
		 $(".userNotificationEmail").show();
		 $(".userNotificationForConsultant").hide();
		 
	 }
	 
   	 $.ajax({
   			url: 'ajax/modules.php?rand='+Math.random(),
   			dataType: 'json',
   			 data: { getModuleByModuleId:1, modulesIp: modulesIp },
   			 success: function(response) {
   					checkResponseRedirect(response);
					$('.module_desc').html("");
   					$('.module_desc').html(response.message.modules_desc);
   				}	
   	   });
   });
   
   
   $('body').on('click', '.alertSave', function(){
   	
   	var notification_user_id = $('.notification_user_id').val();
   	var notification_module_id = $('.notification_module_id').val();
    var notification_email = $('.notification_email').val();
    var notificationId = $('.alertUpdateId').val();
   	
   
   	if(notification_module_id==''){
              showMessage('{$smarty.const.ERR_ALERT_MODULE}');
              $('.notification_module_id').focus();
              return false;
          }
   	
	if(notification_module_id<= {$smarty.const.ALERT_SHOW_ADMIN_USER_ID} ){
		if(notification_user_id==''){
              showMessage('{$smarty.const.ERR_ALERT_USER}');
              $('.notification_user_id').focus();
              return false;
		}
		if(! validateEmail(notification_email)){
		 showMessage('{$smarty.const.ERR_INVALID_USER_EMAIL}');
		 $('.notification_email').focus();
		 return false;
		}
	}
	
	
   	if(notificationId > 0){
   		actionOperand = 2;
   	}
   	else{
   		actionOperand = 1;
   	}
   	
   	$.ajax({
   		url: 'ajax/alert.php?rand='+Math.random(),
   		type: 'post',
   		dataType: 'json',
   		data: { actionOperand: actionOperand, notification_user_id: notification_user_id, notification_module_id: notification_module_id, notification_email: notification_email, notificationUpdateId:  notificationId },
   		success: function(response) {
   			checkResponseRedirect(response);
   			showMessage(response.message);
			$(".addAlert").hide();
			$(".updateAlert").hide();
   			loadAlertList(50,orderIdAlert,sortIdAlert,startDateParam,endDateParam,alertFilterBy);
   		}		
   	});
            
      });	
   
   $('body').on('click', '.alertUpdateAction', function(){
   	$(".addAlert").hide();
   	$(".updateAlert").show();
   	var alertId = $(this).attr('id').split('_')[1];
   
          $.ajax({
   		url: 'getModuleInfo.php?rand='+Math.random(),
   		type:'post',
   		dataType: 'json',
   		data : { module: 'alertUpdate', alertId: alertId },
              success: function(response) {
                  checkResponseRedirect(response);
   			$('.updateAlert').html("");
   			$('.updateAlert').html(response.message.content);
              }
          });
   });	
   
   
   $('body').on('change', '.notification_user_id', function(){
   	var userIdIp = $( this ).val();
   	if(userIdIp==''){
   			return false;
   	 }
   	 $.ajax({
   			url: 'ajax/adminPersonnel.php?rand='+Math.random(),
   			dataType: 'json',
   			 data: { getUserById:1, userDataId: userIdIp },
   			 success: function(response) {
   					checkResponseRedirect(response);
   					$('.notification_email').val(response.message.user_email);
   				}	
   	   });
   });
   
   
   });
   
   function loadAlertList(recCountValue,orderId="",sortId="",startDate="",endDate="",alertFilterBy=""){
   
   var page = pageNo ? pageNo : 1;
   
      var recordCount = recCountValue ? recCountValue : 50;
      $('#alertPageListing').val(recordCount);
      $('#alertPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
   
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'alertList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,alertFilterBy:alertFilterBy },
          success: function(response) {
              checkResponseRedirect(response);
			  $('#listingTabs').html("");
              $('#listingTabs').html(response.message.content);
              $('#paginationAuto').html(response.message.pagination);
              $('#paginationAutoNew').html(response.message.pagination);
              $('#totalAutomation').html(response.message.totalRecords);
              $('#totalAutomationNew').html(response.message.totalRecords);
   
              if(page==1 && page <= response.message.totalPages){
                  $('#paginationAuto .fa-angle-left').hide();
                  $('#paginationAutoNew .fa-angle-left').hide();	
                  $('#paginationAuto .fa-angle-right').show();
                  $('#paginationAutoNew .fa-angle-right').show();
              } else if(page > 1  && page < response.message.totalPages){
                  $('#paginationAuto .fa-angle-left').show();
                  $('#paginationAutoNew .fa-angle-left').show();
                  $('#paginationAuto .fa-angle-right').show();
                  $('#paginationAutoNew .fa-angle-right').show();
              } else if(page == response.message.totalPages){
                  $('#paginationAuto .fa-angle-right').hide();
                  $('#paginationAutoNew .fa-angle-right').hide();
                  $('#paginationAuto .fa-angle-left').show();
                  $('#paginationAuto .fa-angle-left').css("padding", "3px 10px 0px 0px");
                  $('#paginationAutoNew .fa-angle-left').show();	
                  $('#paginationAutoNew .fa-angle-left').css("padding", "3px 10px 0px 0px");
              }
   		
			   if(strClassAlert && strClassAlert!=''){
				  if(strClassAlert=='ascendingClassAlert'){
					  $('#'+orderId+'s a').removeClass('ascendingClassAlert');
					  $('#'+orderId+'s a').addClass('descendingClassAlert').prepend('<i class="fa fa-caret-up gray font13"></i>');
					  $('#overAllAlert th a').addClass('descendingClassAlert');
				  } else if(strClassAlert=='descendingClassAlert'){
					  $('#'+orderId+'s a').removeClass('descendingClassAlert');
					  $('#'+orderId+'s a').addClass('ascendingClassAlert').prepend('<i class="fa fa-caret-down gray font13"></i>');
					 $('#overAllAlert th a').addClass('ascendingClassAlert');
				  }
				} 
				else {
					$('#user_fnames a').addClass('descendingClassAlert').prepend('<i class="fa fa-caret-up gray font13"></i>');
					$('#user_lnames a').addClass('descendingClassAlert');
					$('#modules_names a').addClass('descendingClassAlert');
					$('#modules_descs a').addClass('descendingClassAlert');
					$('#notification_emails a').addClass('descendingClassAlert');
					$('#notification_created_ons a').addClass('descendingClassAlert');
				}
          }
      });	 
   }	
</script> 
{/block}
{block name=content}
<div class="updateAlert"> </div>
<div class="row addAlert" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
            <div class="row">
              
               <div class="form-group col-sm-3">
                  <label >Module</label>
                  <select class="form-control notification_module_id" id="notification_module_id">
                     <option value="">--- Select Module ---</option>
                     {if $modulesArray}
                     {foreach $modulesArray as $key=> $value}
                     <option value="{$value.modules_id}">{$value.modules_name}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
			    <div class="form-group col-sm-3 userNotification" style="display:none;">
                  <label >User</label>
                  <select class="form-control notification_user_id" id="notification_user_id">
                     <option value="">--- Select User ---</option>
                     {if $userArray}
                     {foreach $userArray as $key=> $value}
                     <option value="{$value.user_id}">{$value.user_fname} {$value.user_lname}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
               <div class="form-group col-sm-3 userNotificationEmail" style="display:none;">
                  <label >Email</label>
                  <input type="text" class="form-control notification_email" id="notification_email" placeholder="">
               </div>
			 
            </div>
			 <div class="row">
				<div class="form-group col-sm-9"><p class="module_desc" style="font-weight:bold;"></p></div>
			  </div>
            <button type="button" class="btn btn-default pull-right margin alertCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin alertSave">Done</button>
         </div>
      </div>
   </div>
</div>
<div class="row">
   <div class="col-sm-12">
      <div class="box box-primary">
         <div class="box-header ">
         </div>
         <div class="row ">
            <div class="col-sm-3">
            </div>
            <div class="col-sm-4">
            </div>
            <div class="col-sm-5">
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewAlert"><i class="fa fa-plus"></i> Add New Alert</button>
            </div>
         </div>
         <!-- /.box-header -->
         <div class="box-body">
            <div id="listingTabs"></div>
         </div>
         <!-- /.box-body -->
         <div class="row">
            <div class="col-sm-3">
            </div>
            <div class="col-sm-4">
            </div>
            <div class="col-sm-5">
			{*<button type="button" class="btn btn-primary pull-right m-r-10 addNewAlert"><i class="fa fa-plus"></i> Add New Alert</button>*}
            </div>
         </div>
      </div>
      <!-- /.box -->
   </div>
   <!-- /.col -->
</div>
<div id="confirmDelete">
   <div class="pop-up-overlay " style="display:none;">
      <div class="pop-close">X</div>
      <div class="container " style="display:none;">
         <div class="uiContent">
            <div class="dialog notitle" id="confirmDeletePop" style="display:none;">
               <div class="inner">
                  <input type="hidden" name="delFieldId" id="delFieldId" value=""/>
                  <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_DELETE_ALERT}</h5>
                  <table border="0" cellspacing="0" cellpadding="5" align="center">
                     <tr>
                        <td class="p-t-10">
                           <a href="javascript:void(0);" class="btn btn-primary M2 okAlertDelButton">{$smarty.const.LBL_YES}</a>
                           <a href="javascript:void(0);" class="btn btn-default M2 cancelAlertDelButton">{$smarty.const.LBL_NO}</a>
                        </td>
                     </tr>
                  </table>
                  <div class="clear"></div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<script>
   $(function () {
   
     $('[data-mask]').inputmask();
   
     //Date range picker
   
   
   var start = moment().subtract(29, 'days');
    var end = moment();
   
    function cb(start, end) {
       
    }
   
    $('.taskKeyFilterRange').daterangepicker({
        startDate: start,
        endDate: end,
   autoclose: false,
        ranges: {
           'Today': [moment(), moment()],
           'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month': [moment().startOf('month'), moment().endOf('month')],
           'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    }, cb);
   
    cb(start, end);
   
   
     //Date picker
     $('.datepicker').datepicker({
       autoclose: true,
    format: "mm/dd/yyyy"
     });
   
     //iCheck for checkbox and radio inputs
     $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
       checkboxClass: 'icheckbox_minimal-blue',
       radioClass   : 'iradio_minimal-blue'
     });
   
     //Red color scheme for iCheck
     $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
       checkboxClass: 'icheckbox_minimal-red',
       radioClass   : 'iradio_minimal-red'
     });
   
     //Flat red color scheme for iCheck
     $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
       checkboxClass: 'icheckbox_flat-green',
       radioClass   : 'iradio_flat-green'
     });
   
     //Colorpicker
     $('.my-colorpicker1').colorpicker();
     //color picker with addon
     $('.my-colorpicker2').colorpicker();
   
     //Timepicker
     $('.timepicker').timepicker({
       showInputs: false
     });
   });
</script>
{/block}