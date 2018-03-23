{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Consultant{/block}
{block name=header}
<style>

</style>
<script type="text/javascript">
   var strClassTask;
   var taskKeyFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdTask = 0;
   var sortIdTask = 0;
   var writerIdFilter = 0;
   var currentTabActive = "tabId_3";
   var isComplete = 0;
  $(document).ready(function(){
		
		

		if(currentTabActive == 'tabId_3'){
			var date = new Date();
			var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
			var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
			startDateParam = (firstDay.getMonth() + 1) + '/' + (firstDay.getDate()) + '/' + firstDay.getFullYear();
			endDateParam =   (lastDay.getMonth() + 1) + '/' + (lastDay.getDate()) + '/' + lastDay.getFullYear();
			taskKeyFilterBy = 2;
		}
	    loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
	   
	     $('body').on('click', '.descendingClassTask', function(){
			orderIdTask = $(this).attr('id');
			sortIdTask = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassTask = 'descendingClassTask';
			var recCountValues = $('#taskPageListing').val();
			loadTaskContentList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
		});
   
		$('body').on('click', '.ascendingClassTask', function(){
			orderIdTask = $(this).attr('id');
			sortIdTask = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassTask = 'ascendingClassTask';
			var recCountValues = $('#taskPageListing').val();
			loadTaskContentList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
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
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
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
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
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
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#taskPageListing', function(){
          var recCount = $(this).val();
          $('#taskPageListingNew').val(recCount);
          pageNo = 0;
		  loadTaskContentList(recCount,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#taskPageListingNew', function(){
          var recCount = $(this).val();
          $('#taskPageListing').val(recCount);
          pageNo = 0;
		  loadTaskContentList(recCount,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });	
	   
	   $('.writerIdFilter').chosen({ width:"100%"});

	   $(".taskKeyFilterBy option[value=2]").remove();
	   
	   	$('.taskKeyFilterRangeStatus').hide();
		
		$( ".taskKeyFilterBy" ).change(function() {
			taskKeyFilterBy =  $(this).val();
			if(taskKeyFilterBy == 2){
				 
				$('.taskKeyFilterRangeStatus').show();
				$('.taskKeyFilterUser').hide();
			}
			else{
				if(taskKeyFilterBy == 3){
					$('.taskKeyFilterRangeStatus').hide();
					$('.taskKeyFilterUser').show();
				}
				else
				{
					$('.taskKeyFilterRangeStatus').hide();
					$('.taskKeyFilterUser').hide();
				}
			}	
			 currentTab = $('ul.consultantTabs').find('li.active');
			 currentTabActive = currentTab.attr('data-tabId');
			
			if(taskKeyFilterBy == 3){
				if(currentTabActive == 'tabId_3'){
					taskKeyFilterRangeVal =  startDateParam+ ' - ' +endDateParam;
					/*taskKeyFilterBy=2;*/
				}
				else{
					taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
				}
			}
			else {
				if(currentTabActive == 'tabId_3'){
					taskKeyFilterRangeVal =  startDateParam+ ' - ' +endDateParam;
					taskKeyFilterBy=2;
				}
				else{
					taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
				}
			}
			
			if(taskKeyFilterRangeVal.length > 0){
				taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
				startDateParam = taskKeyFilterRangeVal[0].trim();
				endDateParam = taskKeyFilterRangeVal[1].trim();
				loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
			}
		});
   
		$( ".writerIdFilter" ).change(function() {
			 writerIdFilter =  $(this).val();
			 pageNo = 0;
			 loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
		});
		
		$('body').on('click', '.applyBtn, .ranges', function(){
			taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
			if(taskKeyFilterRangeVal.length > 0){
				taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
				startDateParam = taskKeyFilterRangeVal[0].trim();
				endDateParam = taskKeyFilterRangeVal[1].trim();
				loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
			}
		});
		
	   $('.activeProjectTab').click(function(event) {
		    $(".taskKeyFilterBy option[value=2]").remove();
		    $('<option/>').attr("value","2").text("Due Date").appendTo(".taskKeyFilterBy");
			$('.consultantTabs li.active').removeClass('active');
			$('.consultantTabs li.tab_1').addClass('active');
			$('#tab_1').show();
			$('#tab_2').hide();
			$('#tab_3').hide();
			currentTabActive= "tabId_1";
			pageNo = 0;
			loadTaskContentList(50,orderIdTask,sortIdTask,"","","","");
		});	
		
		$('.closedProjectTab').click(function(event) {
			$(".taskKeyFilterBy option[value=2]").remove();
			$('<option/>').attr("value","2").text("Due Date").appendTo(".taskKeyFilterBy");
			$('.consultantTabs li.active').removeClass('active');
			$('.consultantTabs li.tab_2').addClass('active');
			$('#tab_1').hide();
			$('#tab_2').show();
			$('#tab_3').hide();
			currentTabActive= "tabId_2";
			pageNo = 0;
			loadTaskContentList(50,orderIdTask,sortIdTask,"","","","");
		});	
		
		$('.dueProjectTab').click(function(event) {
			$('.taskKeyFilterBy').prop('selectedIndex',0);
			$(".taskKeyFilterBy option[value=2]").remove();
			$('.consultantTabs li.active').removeClass('active');
			$('.consultantTabs li.tab_3').addClass('active');
			$('#tab_1').hide();
			$('#tab_2').hide();
			$('#tab_3').show();
			var date = new Date();
			var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
			var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
			startDateParam = (firstDay.getMonth() + 1) + '/' + (firstDay.getDate()) + '/' + firstDay.getFullYear();
			endDateParam =   (lastDay.getMonth() + 1) + '/' + (lastDay.getDate()) + '/' + lastDay.getFullYear();
			taskKeyFilterBy = 2;
			currentTabActive= "tabId_3";
			pageNo = 0;
			loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
		});	
		
		 $('body').on('click', '.taskContentDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
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
					loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
				}
			});
		});
		
		$('body').on('click', '.cancelTaskDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		$('body').on('click', '.taskContentUpdateCancel', function(){
			location.reload();
		});
		
		   $('body').on('click', '.taskContentSave', function(){
   	
   	var task_content_marsha_code = $('.task_content_marsha_code').val();
   	var task_content_service_type_id = $('.task_content_service_type_id').val();
   	var task_content_tire = $('.task_content_tire').val();
	
	var task_content_priority_val = $('.task_content_priority');
	var task_content_priority;
	
	if (task_content_priority_val.is(':checked')) {
		task_content_priority = 1;
	}
	else{
		task_content_priority = 0;
	}
	
   	var task_content_added_box_date = $('.task_content_added_box_date').val();
	var task_content_due_date = $('.task_content_due_date').val();
   	/*var task_content_added_box_due_date = $('.task_content_added_box_due_date').val();*/
	var task_content_rev_req = $('.task_content_rev_req').val();
	var task_content_rev_com = $('.task_content_rev_com').val();
	var task_content_rev_sec_req = $('.task_content_rev_sec_req').val();
	var task_content_rev_sec_com = $('.task_content_rev_sec_com').val();
   	var task_content_ass_writer_date = $('.task_content_ass_writer_date').val();
	var task_content_is_complete;
	
	var task_content_is_complete_val = $('.task_content_is_complete');
	
	if (task_content_is_complete_val.is(':checked')) {
		task_content_is_complete = 1;
		var task_content_added_box_due_date = $.datepicker.formatDate('mm/dd/yy', new Date());
		console.log(task_content_added_box_due_date);
	}
	else{
		task_content_is_complete = 0;
		var task_content_added_box_due_date = "";
	}
	
	
	var task_content_proj_com_date = $('.task_content_proj_com_date').val();
   	var task_content_user_id = $('.task_content_user_id').val();
	var task_content_no_of_units = $('.task_content_no_of_units').val();
   	var task_content_link_to_file = $('.task_content_link_to_file').val();
	var task_content_notes = $('.task_content_notes').val();
	var taskContentId = $('.taskContentId').val();
	
   
   	if(task_content_marsha_code==''){
              showMessage('{$smarty.const.ERR_MARSHA_CODE}');
              $('.task_content_marsha_code').focus();
              return false;
          }
   	
  
   	if(task_content_user_id==''){
              showMessage('{$smarty.const.ERR_TASK_CONTENT_USER_ID}');
              $('.task_content_user_id').focus();
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
   		data: { actionOperand: actionOperand, marshaCodeData: task_content_marsha_code, serviceTypeIdData: task_content_service_type_id, tireData: task_content_tire, priorityData: task_content_priority, addedBoxData:  task_content_added_box_date , dueData:  task_content_due_date, addedBoxDueData:  task_content_added_box_due_date, revReqData:  task_content_rev_req , revComData:  task_content_rev_com, revSecReqData:  task_content_rev_sec_req, revComSecData:  task_content_rev_sec_com, assWriterData:  task_content_ass_writer_date, isCompleteData:  task_content_is_complete, projComData:  task_content_proj_com_date, writerIdData:  task_content_user_id, noUnitsData:  task_content_no_of_units, linkToFileData:  task_content_link_to_file, notesData:  task_content_notes, taskContentUpdateId:  taskContentId},
   		success: function(response) {
   			checkResponseRedirect(response);
   			showMessage(response.message);
   			loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
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
   
   function loadTaskContentList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#taskPageListing').val(recordCount);
      $('#taskPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	  
	   if(currentTabActive == 'tabId_3'){
				isComplete=0;
		}
		else if(currentTabActive == 'tabId_2'){
				isComplete=1;
		}
		else if(currentTabActive == 'tabId_1'){
				isComplete=2;
		}
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'consultantTaskManagerContentList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete },
          success: function(response) {
              checkResponseRedirect(response);
			  $('#listingTab3').html("");
			  $('#listingTab2').html("");
			  $('#listingTab1').html("");

			  if(currentTabActive == 'tabId_3'){
				$('#listingTab3').html(response.message.content);
			  }
			  else if(currentTabActive == 'tabId_2'){
				$('#listingTab2').html(response.message.content);
			  }
			  else if(currentTabActive == 'tabId_1'){
				$('#listingTab1').html(response.message.content);
			  }
			  
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
				$('#client_names a').addClass('descendingClassTask');
				$('#task_content_link_to_files a').addClass('descendingClassTask');
				$('#task_content_added_box_dates a').addClass('descendingClassTask');
				$('#task_content_due_dates a').addClass('descendingClassTask');
				$('#task_content_prioritys a').addClass('descendingClassTask');
				$('#user_fnames a').addClass('descendingClassTask');
				$('#task_content_is_completes a').addClass('descendingClassTask');
			 }
          }
      });	 
   }	
</script>

{/block}
{block name=content}
  
    <!-- Main content -->
    <section class="content">
		<div class="updateTaskManagerContent"> </div>
		{*<div class="row">
			 <div class="col-xs-12">
				<button type="submit" class="btn btn-info pull-right margin"><i class="fa fa-bell"></i> Alerts(10)</button>
				<a href="javascript:void(0);" class="btn btn-primary pull-right margin"><i class="fa fa-user"></i> Profile</a>	
			 </div>
		</div>*}
		   <div class="box box-primary filterStatus">
		   
		  <div class="row ">
            <div class="col-sm-3 m-t-20 m-b-20">
               <div class="form-group ">
                  <div class="col-sm-6">
                     <label>Filter By</label>
                  </div>
                  <div class="col-sm-6">
                     <select class="form-control taskKeyFilterBy" name="taskKeyFilterBy">
                     {$filterByContentConsultantArray}
                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-4 m-t-20 m-b-20">
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
                     <label>Select Client</label>
                  </div>
                  <div class="col-sm-6">
                   <select class="form-control writerIdFilter" id="writerIdFilter">
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
			   
            </div>
           
         </div>
</div>		 
			 
      <div class="row">
        <div class="col-md-12">
          <!-- Custom Tabs -->
          <div class="nav-tabs-custom">
			<ul class="nav nav-tabs consultantTabs">
				<li data-tabId ="tabId_1" class="tab_1" ><a href="javascript:void(0);" data-toggle="tab" class="activeProjectTab">Active Projects</a></li>
				<li data-tabId ="tabId_2" class="tab_2" ><a href="javascript:void(0);" data-toggle="tab" class="closedProjectTab">Closed Projects</a></li>
				<li data-tabId ="tabId_3" class="active tab_3" ><a href="javascript:void(0);" data-toggle="tab" class="dueProjectTab">Project Due This Month</a></li>
			 </ul>
			
            <div class="tab-content">
              <div class="tab-pane" id="tab_1">
					<div class="box-header with-border">
						 <div id="listingTab1"></div>
					</div>
              </div>
			  <div class="tab-pane" id="tab_2">
					<div class="box-header with-border">
						 <div id="listingTab2"></div>
					</div>
              </div>
              <div class="tab-pane active" id="tab_3">
					<div class="box-header with-border">
						 <div id="listingTab3"></div>
					</div>
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
          <!-- nav-tabs-custom -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
      <!-- END CUSTOM TABS -->
      

    </section>

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