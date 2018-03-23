{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Task Manager Keyword{/block}
{block name=header}
{strip}
<script type="text/javascript">
   var strClassTask;
   var taskKeyFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdTask = 0;
   var sortIdTask = 0;
    var d;
	
   $(document).ready(function(){
   
	d = new Date();
	 
	$('body').on('keydown', '.task_content_no_of_units', function(){
            if (event.shiftKey) {
                event.preventDefault();
            }

            if (event.keyCode == 46 || event.keyCode == 8) {
            }
            else {
                if (event.keyCode < 95) {
                    if (event.keyCode < 48 || event.keyCode > 57) {
                        event.preventDefault();
                    }
                }
                else {
                    if (event.keyCode < 96 || event.keyCode > 105) {
                        event.preventDefault();
                    }
                }
            }
      });
	 
	
	
	$('.task_content_added_box_date').datepicker({
	format: "mm/dd/yyyy"
	}).on('changeDate',function(e){
	 d = new Date(e.date);
	 
	 configDate= {$smarty.const.TACTIC_DUE_BUSINESS_DAY_FOR_OTHERS};
	 
	 /*tacticDateVal = (startDate.getMonth() + 1) + '/' + (startDate.getDate() + configDate) + '/' +  startDate.getFullYear();*/
	 
	  tacticDateVal = addBusinessDays(d, configDate);
	 
	 $('.task_content_due_date').val(tacticDateVal);
	});
		   
	
	$('.completeDateDiv').hide();
   $('body').on('change', '.task_content_is_complete', function(){
		var thisVal = $('.task_content_is_complete');
		if (thisVal.is(':checked')) {
			$('.completeDateDiv').show();
			$(".task_content_proj_com_date.datepicker").datepicker("setDate", new Date());
		}
		else{
			$('.completeDateDiv').hide();
		}
   });
	
  {if $smarty.session.sessionClientId == $smarty.const.MARRIOTT_CLIENT_ID }
  
   $(".task_content_service_type_id option[value=6]").remove();
   
  {/if}
   
   loadTaskContentList(50,orderIdTask,sortIdTask);
   	
   $('body').on('click', '.descendingClassTask', function(){
          orderIdTask = $(this).attr('id');
          sortIdTask = 2;
   	pageNo = $('#pageDropDownValue').val();
          strClassTask = 'descendingClassTask';
   	var recCountValues = $('#taskPageListing').val();
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
      });
   
    $('body').on('click', '.ascendingClassTask', function(){
          orderIdTask = $(this).attr('id');
          sortIdTask = 1;
   	pageNo = $('#pageDropDownValue').val();
   	strClassTask = 'ascendingClassTask';
   	var recCountValues = $('#taskPageListing').val();
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
      });
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#taskPageListing').val();
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
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
          var recCountValues = $('#taskPageListing').val();
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#taskPageListing').val();
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
      });
      $('body').on('change', '#taskPageListing', function(){
          var recCount = $(this).val();
          $('#taskPageListingNew').val(recCount);
          pageNo = 0;
          loadTaskContentList(recCount,orderIdTask,sortIdTask);
      });
      $('body').on('change', '#taskPageListingNew', function(){
          var recCount = $(this).val();
          $('#taskPageListing').val(recCount);
          pageNo = 0;
          loadTaskContentList(recCount,orderIdTask,sortIdTask);
      });
	
	var task_complete;	
	$('body').on('click', '.taskContentCompleteAction', function(){
			$('#loadingOverlayEditor').show();
            var fieldId = $(this).attr('id').split('_')[1];
			var task_complete_val = $('#completeTask_'+fieldId);
			var attrCode = $(this).attr('attrCode');
			var attrDivCode = $(this).attr('attrDivCode');
			var attrUser = $(this).attr('attrUser');
			var attrServiceTypeName = $(this).attr('attrServiceTypeName');
			
			if (task_complete_val.is(':checked')) {
				task_complete = 1;
			}
			else{
				task_complete = 0;
			}
            $('#completeFieldId').val(fieldId);
			$('#attrCode').val(attrCode);
			$('#attrDivCode').val(attrDivCode);
			$('#attrUser').val(attrUser);
			$('#attrServiceTypeName').val(attrServiceTypeName);
			
			$( ".okTaskCompButton" ).trigger( "click");
            /*$('#confirmComplete .uiContent').html($('#confirmCompletePop').html());
            uiPopupOpen('confirmComplete', 500, 125);*/
			
	});
	
	var task_admin_complete;	
	$('body').on('change', '.taskContentCompleteAdminAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
			var task_complete_admin_val = $('#completeAdminTask_'+fieldId).val();
			var currentUserId = $(this).attr('currentUserId');
			var currentServiceTypeId = $(this).attr('currentServiceTypeId');
			
			
			if (task_complete_admin_val == 1) {
				  task_admin_complete = 1;
				  $('#completeAdminFieldId').val(fieldId);
				  $('#confirmAdminComplete .uiContent').html($('#confirmAdminCompletePop').html());
				  uiPopupOpen('confirmAdminComplete', 500, 125);
			}
			else if(task_complete_admin_val == 2){
				
				$.ajax({
				url: 'getModuleInfo.php?rand='+Math.random(),
				dataType: 'json',
				data: {  module: 'getConsultantBySkill', serviceIdIp: currentServiceTypeId, taskContentId:  fieldId },
				success: function(response) {
					checkResponseRedirect(response);
					$('.writerSkillReassign').html("");
					$('.writerSkillReassign').html(response.message.content);
				}	
				});
				
				  task_admin_complete = 2;
				  $('#completeAdminFieldId').val(fieldId);
				  $('#confirmAdminReassign .uiContent').html($('#confirmAdminReassignPop').html());
				  uiPopupOpen('confirmAdminReassign', 500, 250);
			}
			
	});	

	$('body').on('click', '.cancelAdminTaskCompButton', function(){
          uiPopClose('confirmAdminComplete');
		  loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
	});
	
	$('body').on('click', '.cancelAdminTaskReassignButton', function(){
          uiPopClose('confirmAdminReassign');
		  loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
	});
	
	$('body').on('click', '.okTaskCompButton', function(){
		$('#loadingOverlayEditor').show();
		fieldId = $('#completeFieldId').val();
		attrCode = $('#attrCode').val();
		attrDivCode = $('#attrDivCode').val();
		attrUser = $('#attrUser').val();
		attrServiceTypeName = $('#attrServiceTypeName').val();
		
		$.ajax({
			type : 'post',
			url: 'ajax/taskManagerContent.php?rand='+Math.random(),
			data : { taskContentComplete: 1, taskContentCompId:fieldId, taskContentCompVal : task_complete, attrCode:attrCode, attrDivCode:attrDivCode, attrUser:attrUser,attrServiceTypeName:attrServiceTypeName  },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmComplete');
				showMessage(response.message);
				$('#loadingOverlayEditor').hide();
				loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
	
	$('body').on('click', '.okAdminTaskCompButton', function(){
		$('#loadingOverlayEditor').show();
		fieldId = $('#completeAdminFieldId').val();
		
		$.ajax({
			type : 'post',
			url: 'ajax/taskManagerContent.php?rand='+Math.random(),
			data : { taskContentAdminComplete: 1, taskContentCompId:fieldId, taskContentCompVal : task_admin_complete },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmAdminComplete');
				showMessage(response.message);
				$('#loadingOverlayEditor').hide();
				loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
	
	$('body').on('click', '.okAdminTaskReassignButton', function(){
			$('#loadingOverlayEditor').show();
			fieldId = $('#completeAdminFieldId').val();
			adminNotes = $('.task_content_admin_notes').val();
			task_content_user_id_reassign = $('.task_content_reassign_user_id').val();
			
			$.ajax({
				type : 'post',
				url: 'ajax/taskManagerContent.php?rand='+Math.random(),
				data : { taskContentAdminReassign: 1, taskContentCompId:fieldId, taskContentCompVal : task_admin_complete, taskContentAdminNotes:adminNotes, task_content_user_id_reassign:task_content_user_id_reassign },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmAdminReassign');
					showMessage(response.message);
					$('#loadingOverlayEditor').hide();
					loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
				}
			});
	});
		
   
   $('.taskKeyFilterRangeStatus').hide();
   $('#divisionFilterBy').chosen({ width:"100%"});
   
   $( ".taskKeyFilterBy" ).change(function() {
   	taskKeyFilterBy =  $(this).val();
   if(taskKeyFilterBy == 2){
   		$('.taskKeyFilterRangeStatus').show();
		$('.taskKeyFilterUser').hide();
		$('.divisionFilter').hide();
   	}
	else if(taskKeyFilterBy == 4){
		$('.taskKeyFilterRangeStatus').hide();
		$('.divisionFilter').show();
		$('.taskKeyFilterUser').hide();
	}
   	else{
		if(taskKeyFilterBy == 3){
			$('.taskKeyFilterRangeStatus').hide();
			$('.taskKeyFilterUser').show();
			$('.divisionFilter').hide();
		}
		else
		{
			$('.taskKeyFilterRangeStatus').hide();
			$('.taskKeyFilterUser').hide();
			$('.divisionFilter').hide();
		}
   	}
   	
	if(taskKeyFilterBy > 1){
		$('.resetFilters').show();
	}
	
   	taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
   	if(taskKeyFilterRangeVal.length > 0){
   		taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
   		startDateParam = taskKeyFilterRangeVal[0].trim();
   		endDateParam = taskKeyFilterRangeVal[1].trim();
   		loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   	}
   });
   
    $( ".searchByWriter" ).change(function() {
		searchByWriter =  $(this).val();
		loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,searchByWriter);
    });
	
	 $('body').on('change', '.divisionFilterBy', function(){
		var divisionId = $( this ).val();
		loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,"",divisionId);
    });
   
   $('body').on('click', '.applyBtn, .ranges', function(){
   	taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
   	if(taskKeyFilterRangeVal.length > 0){
   		taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
   		startDateParam = taskKeyFilterRangeVal[0].trim();
   		endDateParam = taskKeyFilterRangeVal[1].trim();
   		loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   	}
   });
   
   $('body').on('click', '.addNewTask', function(){
   	$(".addTaskManagerContent").toggle();
   });	
   
    $('body').on('click', '.resetFiltersAction', function(){
		location.reload();
    });	
   
   $('body').on('click', '.taskContentCancel', function(){
		location.reload();
   });	
   
   $('body').on('click', '.taskContentUpdateCancel', function(){
		location.reload();
   });	
   
   {if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }
   
		$('#task_content_user_id').chosen({ width:"100%"});
   
   {/if}
   
   $('#task_content_marsha_code').chosen({ width:"100%"});
   $('#task_content_service_type_id').chosen({ width:"100%"});
   $('#searchByWriter').chosen({ width:"auto"});
   
   $('body').on('change', '.task_content_marsha_code', function(){
   	var marshaCodeIp = $( this ).val();
   	if(marshaCodeIp==''){
   			return false;
   	 }
   	 $.ajax({
   			url: 'ajax/clientEntity.php?rand='+Math.random(),
   			dataType: 'json',
   			 data: { getDivisionByMarshaCode:1, marshaCodeIp: marshaCodeIp },
   			 success: function(response) {
   					checkResponseRedirect(response);
   					$('.task_content_division').val(response.message.division_code);
   				}	
   	   });
   });
   
   $('body').on('change', '.task_content_user_id', function(){
	    var userIdIp = $( this ).val();
		if(userIdIp==''){
   			return false;
   	    }
		$('#task_content_user_id_hidden').remove();
	});   
   
   {if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }
   
   
   $('body').on('change', '.task_content_service_type_id', function(){
	    $('.existWriterSkillUser').show();
	    var serviceIdIp = $( this ).val();
		var taskContentId = $('.taskContentId').val();
		if(serviceIdIp==''){
			$('.writerSkill').html("");
			$('.writerSkillDefault').show();
			var task_content_user_id_val = $('.task_content_user_id_val').val();
			$('#task_content_user_id_hidden').val(task_content_user_id_val);
   			return false;
   	    }
		else{
			$('#task_content_user_id_hidden').val("");
		}
		
		$('.existWriterSkillUser').hide();
		$.ajax({
   			url: 'getModuleInfo.php?rand='+Math.random(),
   			dataType: 'json',
   			 data: {  module: 'getConsultantBySkill', serviceIdIp: serviceIdIp, taskContentId:  taskContentId },
   			 success: function(response) {
   					checkResponseRedirect(response);
					$('.writerSkillDefault').hide();
					$('.writerSkill').html("");
   					$('.writerSkill').html(response.message.content);
   				}	
   	   });
   });
   
   {/if}
   
   $('body').on('click', '.taskContentDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
	});
   
   $('body').on('click', '.cancelTaskDelButton', function(){
            uiPopClose('confirmDelete');
	});
	
	$('body').on('click', '.okTaskDelButton', function(){
		fieldId = $('#delFieldId').val();
		$.ajax({
			type : 'post',
			url: 'ajax/taskManagerContent.php?rand='+Math.random(),
			data : { taskContentDelete: 1, taskContentDeleteId:fieldId },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmDelete');
				showMessage(response.message);
				loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
   
   
   $('body').on('click', '.taskContentSave', function(){
   	
   	var task_content_marsha_code = $('.task_content_marsha_code').val();
   	var task_content_service_type_id = $('.task_content_service_type_id').val();
   	var task_content_tire = $('.task_content_tire').val();
	var task_content_no_of_units = $('.task_content_no_of_units').val();
	var task_content_added_box_date = $('.task_content_added_box_date').val();
	var task_content_link_to_file = $('.task_content_link_to_file').val();

	var task_content_priority_val = $('.task_content_priority');
	var task_content_priority;
	
	if (task_content_priority_val.is(':checked')) {
		task_content_priority = 1;
	}
	else{
		task_content_priority = 0;
	}
	var task_content_due_date = $('.task_content_due_date').val();
	var task_content_is_complete;
	var task_content_is_complete_val = $('.task_content_is_complete');
	
	if (task_content_is_complete_val.is(':checked')) {
		task_content_is_complete = 1;
		var task_content_added_box_due_date = $.datepicker.formatDate('mm/dd/yy', new Date());
	}
	else{
		task_content_is_complete = 0;
		var task_content_added_box_due_date = "";
	}
	var task_content_upload_link = $('.task_content_upload_link').val();
	
	var task_content_rev_req = $('.task_content_rev_req').val();
	var task_content_proj_com_date = $('.task_content_proj_com_date').val();
	
	var task_content_rev_com;
	var task_content_rev_com_val = $('.task_content_rev_com');
	if (task_content_rev_com_val.is(':checked')) {
		task_content_rev_com = 1;
	}
	else{
		task_content_rev_com = 0;
	}
	
   	var task_content_user_id = $('.task_content_user_id').val();
	
	var task_content_notes = $('.task_content_notes').val();
	var taskContentId = $('.taskContentId').val();
	
   
   	if(task_content_marsha_code==''){
              showMessage('{$codeLabelData} is Required');
              $('.task_content_marsha_code').focus();
              return false;
          }
   	

   
   
   if(taskContentId > 0){
   		actionOperand = 2;
   	}
   	else{
   		actionOperand = 1;
   	}
   
   	$.ajax({
   		url: 'ajax/taskManagerContent.php?rand='+Math.random(),
   		type: 'post',
   		dataType: 'json',
   		data: { actionOperand: actionOperand, marshaCodeData: task_content_marsha_code, serviceTypeIdData: task_content_service_type_id, tireData: task_content_tire, priorityData: task_content_priority, addedBoxData:  task_content_added_box_date , dueData:  task_content_due_date, addedBoxDueData:  task_content_added_box_due_date, revReqData:  task_content_rev_req , revComData:  task_content_rev_com,   isCompleteData:  task_content_is_complete, writerIdData:  task_content_user_id, noUnitsData:  task_content_no_of_units, linkToFileData:  task_content_link_to_file, notesData:  task_content_notes, taskContentUpdateId:  taskContentId, task_content_upload_link:task_content_upload_link, task_content_proj_com_date:task_content_proj_com_date },
   		success: function(response) {
   			checkResponseRedirect(response);
   			showMessage(response.message);
				$(".addTaskManagerContent").hide();
				$(".updateTaskManagerContent").hide();
   			loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   		}		
   	});
            
      });	
   
   $('body').on('click', '.taskContentUpdateAction', function(){
   	$(".addTaskManagerContent").hide();
   	$(".updateTaskManagerContent").show();
   	var taskContentId = $(this).attr('id').split('_')[1];
   
          $.ajax({
   		url: 'getModuleInfo.php?rand='+Math.random(),
   		type:'post',
   		dataType: 'json',
   		data : { module: 'taskManagerContentUpdate', taskContentId: taskContentId },
              success: function(response) {
                  checkResponseRedirect(response);
   			$('.updateTaskManagerContent').html("");
   			$('.updateTaskManagerContent').html(response.message.content);
              }
          });
   });	
   
   
   });
   
   function loadTaskContentList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerId="",divisionId){
   
   var page = pageNo ? pageNo : 1;
   
      var recordCount = recCountValue ? recCountValue : 50;
      $('#taskPageListing').val(recordCount);
      $('#taskPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
   
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'taskManagerContentList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy, writerId: writerId,divisionId:divisionId },
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
   		
   		
   		if(strClassTask && strClassTask!=''){
                  if(strClassTask=='ascendingClassTask'){
                      $('#'+orderId+'s a').removeClass('ascendingClassTask');
                      $('#'+orderId+'s a').addClass('descendingClassTask').prepend('<i class="fa fa-caret-up gray font13"></i>');
   				$('#overAllTask th a').addClass('descendingClassTask');
                  } else if(strClassTask=='descendingClassTask'){
                      $('#'+orderId+'s a').removeClass('descendingClassTask');
                      $('#'+orderId+'s a').addClass('ascendingClassTask').prepend('<i class="fa fa-caret-down gray font13"></i>');
   				$('#overAllTask th a').addClass('ascendingClassTask');
                  }
              } else {
   			$('#client_entity_marsha_codes a').addClass('descendingClassTask').prepend('<i class="fa fa-caret-up gray font13"></i>');
   			$('#division_codes a').addClass('descendingClassTask');
   			$('#serv_type_names a').addClass('descendingClassTask');
   			$('#task_content_tires a').addClass('descendingClassTask');
			$('#task_content_no_of_unitss a').addClass('descendingClassTask');
   			$('#task_content_link_to_files a').addClass('descendingClassTask');
   			$('#task_content_added_box_dates a').addClass('descendingClassTask');
			$('#task_content_proj_com_dates a').addClass('descendingClassTask');
			$('#task_content_rev_reqs a').addClass('descendingClassTask');
			$('#task_content_rev_coms a').addClass('descendingClassTask');
			$('#task_content_upload_links a').addClass('descendingClassTask');
   			$('#task_content_due_dates a').addClass('descendingClassTask');
			$('#task_content_prioritys a').addClass('descendingClassTask');
   			$('#user_fnames a').addClass('descendingClassTask');
			$('#user_lnames a').addClass('descendingClassTask');
			$('#task_content_is_completes a').addClass('descendingClassTask');
              }
   		
   		
          }
      });	 
   }

function addBusinessDays(d,n) {
		d = new Date(d.getTime());
		var day = d.getDay();
		d.setDate(d.getDate() + n + (day === 6 ? 2 : +!day) + (Math.floor((n - 1 + (day % 6 || 1)) / 5) * 2));
		d = (d.getMonth() + 1) + '/' + (d.getDate()) + '/' +  d.getFullYear();
		return d;
	}   
</script> 
{/strip}
{/block}
{block name=content}
	<div id="loadingOverlayEditor" class="loadingOverlayEditor" style="display:none;">
		<img src="{$smarty.const.ROOT_HTTP_PATH}/dist/img/gifload.gif" width="100px" height="100px"/>
	</div>

<div class="updateTaskManagerContent"> </div>
<div class="row addTaskManagerContent" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
            <div class="row">
               <div class="form-group col-sm-3">
                 <label >{$codeLabelData}</label>
                  <select class="form-control task_content_marsha_code" id="task_content_marsha_code">
                     <option value="">--- Enter {$codeLabelData} ---</option>
                     {if $marshaCodesArray}
                     {foreach $marshaCodesArray as $key=> $value}
                     <option value="{$value.client_entity_id}">{$value.client_entity_marsha_code}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
               <div class="form-group col-sm-3">
                  <label >Division</label>
                  <input readonly class="form-control task_content_division" id="task_content_division" placeholder="">
               </div>
               <div class="form-group col-sm-3">
                  <label >Service Type</label>
                  <select class="form-control task_content_service_type_id" id="task_content_service_type_id">
                     <option value="">--- Select Service Type ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
                     <option value="{$value.serv_type_id}">{$value.serv_type_name}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
               <div class="form-group col-sm-3">
                  <label >Tier</label>
                  <input type="text" class="form-control task_content_tire" id="task_content_tire" placeholder="">
               </div>
            </div>
            <div class="row">
				  <div class="form-group col-sm-3">
                  <label ># Pages</label>
                  <input type="text" class="form-control task_content_no_of_units" id="task_content_no_of_units" placeholder="">
               </div>
             
               <div class="form-group col-sm-3">
                  <label >Start Date</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_added_box_date datepicker" id="task_content_added_box_date">
                  </div>
               </div>
			     <div class="form-group col-sm-3">
                  <label >Source Link</label>
                  <input type="text" class="form-control task_content_link_to_file" id="task_content_link_to_file" placeholder="">
               </div>
			     <div class="form-group col-sm-3" >
                  <label >Priority</label>
                  <br/>
                  <input type="checkbox" class="task_content_priority" id="task_content_priority" >
               </div>
             
               
            </div>
            <div class="row">
				  <div class="form-group col-sm-3">
                  <label >Tactic Due</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_due_date datepicker" id="task_content_due_date">
                  </div>
               </div>
			    <div class="form-group col-sm-3">
                  <label >Complete</label>
                  <br/>
                  <input type="checkbox" class="task_content_is_complete" id="task_content_is_complete" >
               </div>
			   <div class="form-group col-sm-3 completeDateDiv">
               <label >Complete Date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_content_proj_com_date datepicker" id="task_content_proj_com_date">
               </div>
				</div>
			    <div class="form-group col-sm-3">
                  <label >Upload Link</label>
                  <input type="text" class="form-control task_content_upload_link" id="task_content_upload_link" placeholder="">
               </div>
				
              
            </div>
            <div class="row">
				 <div class="form-group col-sm-3">
                  <label >Date Revision Requested</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_rev_req datepicker" id="task_content_rev_req">
                  </div>
               </div>
				 <div class="form-group col-sm-3">
                  <label >1st Revision Complete</label>
				   <br/>
				  <input type="checkbox" class="task_content_rev_com" id="task_content_rev_com" >
               </div>
               <div class="form-group col-sm-3">
                  <label >Consultant</label>
				   {if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }
					 <div class="writerSkill"></div>
					 
					  <div class="writerSkillDefault">
					  <select class="form-control task_content_user_id" id="task_content_user_id">
						  <option value="">--- Select Consultant ---</option>
						  {if $userArray}
						  {foreach $userArray as $key=> $value}
						  <option value="{$value.user_id}">{$value.user_fname} {$value.user_lname}</option>
						  {/foreach}
						  {/if}
						</select>
						</div>
					 
				{else}
					<p>{$smarty.session.userName}</p>
					<input type="hidden" name="task_content_user_id" id="task_content_user_id" class="task_content_user_id" value="{$smarty.session.userId}">
			    {/if}
               </div>
				 <div class="form-group col-sm-3">
                  <label >Notes</label>
                  <textarea class="form-control pull-right task_content_notes" id="task_content_notes"></textarea>
               </div>
            </div>
            
            <button type="button" class="btn btn-default pull-right margin taskContentCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin taskContentSave">Done</button>
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
               <div class="form-group">
                  <div class="col-sm-6">
                     <label>Filter By</label>
                  </div>
                  <div class="col-sm-6">
                     <select class="form-control taskKeyFilterBy" name="taskKeyFilterBy">
                     {$filterByContentArray}
                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-3">
               <div class="form-group taskKeyFilterRangeStatus" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Date Range</label>
                  </div>
                  <div class="col-sm-6">
                     <div class="input-group">
                        <div class="input-group-addon">
                           <i class="fa fa-calendar"></i>
                        </div>
                        <input type="text" readonly name="taskKeyFilterRange" class="form-control pull-right  taskKeyFilterRange" style="width:175px !important;">
                     </div>
                  </div>
                  <!-- /.input group -->
               </div>
			    <div class="form-group taskKeyFilterUser" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Consultant</label>
                  </div>
                  <div class="col-sm-6">
                   <select class="form-control searchByWriter" id="searchByWriter">
                     <option value="">--- Select Consultant ---</option>
                     {if $userArray}
                     {foreach $userArray as $key=> $value}
                     <option value="{$value.user_id}">{$value.user_fname} {$value.user_lname}</option>
                     {/foreach}
                     {/if}
                  </select>
                  </div>
                  <!-- /.input group -->
               </div>
			   <div class="form-group divisionFilter" style="display:none;">
                     <select class="form-control divisionFilterBy" id="divisionFilterBy" name="divisionFilterBy">
						 {if $divisionArray}
							 {foreach $divisionArray as $key=> $value}
							 <option value="{$value.division_id}">{$value.division_code}</option>
							 {/foreach}
						 {/if}
                     </select>
			   </div>
			   
            </div>
			<div class="col-sm-3">
				<div class="form-group resetFilters" style="display:none;">
						<button type="button" class="btn btn-primary pull-right  resetFiltersAction"><i class="fa fa-minus"></i> Reset Filters</button>
				</div>
			</div>
            <div class="col-sm-3">
               <button type="button" class="btn btn-primary pull-right m-r-10  addNewTask"><i class="fa fa-plus"></i> Add New Task</button>
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
			{*<button type="button" class="btn btn-primary pull-right m-r-10 addNewTask"><i class="fa fa-plus"></i> Add New Task</button>*}
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
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_DELETE_TASK_CONTENT}</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okTaskDelButton">{$smarty.const.LBL_YES}</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelTaskDelButton">{$smarty.const.LBL_NO}</a>
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

<input type="hidden" name="completeFieldId" id="completeFieldId" value=""/>
<div id="confirmComplete">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
                <div class="dialog notitle" id="confirmCompletePop" style="display:none;">
                    <div class="inner">
						<input type="hidden" name="completeFieldId" id="completeFieldId" value=""/>
						<input type="hidden" name="attrCode" id="attrCode" value=""/>
						<input type="hidden" name="attrDivCode" id="attrDivCode" value=""/>
						<input type="hidden" name="attrUser" id="attrUser" value=""/>
						<input type="hidden" name="attrServiceTypeName" id="attrServiceTypeName" value=""/>
						
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_COMP_TASK_KEYWORD}</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okTaskCompButton">{$smarty.const.LBL_YES}</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelTaskCompButton">{$smarty.const.LBL_NO}</a>
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

<div id="confirmAdminComplete">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
                <div class="dialog notitle" id="confirmAdminCompletePop" style="display:none;">
                    <div class="inner">
                        <input type="hidden" name="completeAdminFieldId" id="completeAdminFieldId" value=""/>
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_COMP_ADMIN_TASK_CONTENT}</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okAdminTaskCompButton">{$smarty.const.LBL_YES}</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelAdminTaskCompButton">{$smarty.const.LBL_NO}</a>
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

<div id="confirmAdminReassign">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
                <div class="dialog notitle" id="confirmAdminReassignPop" style="display:none;">
                    <div class="inner">
                        <input type="hidden" name="completeAdminFieldId" id="completeAdminFieldId" value=""/>
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_REASSIGN_TASK_CONTENT}</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
							<tr>
                                <td class="p-t-10">
                                   <div class="writerSkillReassign"></div>
                                </td>
                            </tr>
							<tr>
                                <td class="p-t-10">
                                    <label>Notes</label> <textarea class="form-control task_content_admin_notes" id="task_content_admin_notes"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okAdminTaskReassignButton">{$smarty.const.LBL_YES}</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelAdminTaskReassignButton">{$smarty.const.LBL_NO}</a>
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