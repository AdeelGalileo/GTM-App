{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Consultant Rate{/block}
{block name=header}
<style>
.ajax-upload-dragdrop{ width:auto !important;}
</style>
<script type="text/javascript">
   var strClassRate;
   var rateFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdRate = 0;
   var sortIdRate = 0;
   var userIdFilter = 0;
   
  $(document).ready(function(){
		
		
	    loadConsultantRateList(50,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,userIdFilter);
	   
	     $('body').on('click', '.descendingClassRate', function(){
			orderIdRate = $(this).attr('id');
			sortIdRate = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassRate = 'descendingClassRate';
			var recCountValues = $('#ratePageListing').val();
			loadConsultantRateList(recCountValues,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,userIdFilter);
		});
   
		$('body').on('click', '.ascendingClassRate', function(){
			orderIdRate = $(this).attr('id');
			sortIdRate = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassRate = 'ascendingClassRate';
			var recCountValues = $('#ratePageListing').val();
			loadConsultantRateList(recCountValues,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,userIdFilter);
		});
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#ratePageListing').val();
          loadConsultantRateList(recCountValues,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,userIdFilter);
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
          var recCountValues = $('#ratePageListing').val();
          loadConsultantRateList(recCountValues,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,userIdFilter);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#ratePageListing').val();
          loadConsultantRateList(recCountValues,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,userIdFilter);
      });
      $('body').on('change', '#ratePageListing', function(){
          var recCount = $(this).val();
          $('#ratelPageListingNew').val(recCount);
          pageNo = 0;
		  loadConsultantRateList(recCount,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,userIdFilter);
      });
      $('body').on('change', '#ratelPageListingNew', function(){
          var recCount = $(this).val();
          $('#ratePageListing').val(recCount);
          pageNo = 0;
		  loadConsultantRateList(recCount,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,userIdFilter);
      });	
	   
	$('.ratelFilterRangeStatus').hide();
	$('.searchByWriter').chosen({ width:"100%"});
	$('.cons_rate_user_id').chosen({ width:"100%"});
	$('.cons_rate_service_type_id').chosen({ width:"100%"});
	$(".cons_service_type_id").chosen({ width:"100%"});
   
   $( ".rateFilterBy" ).change(function() {
		rateFilterBy =  $(this).val();
		if(rateFilterBy == 2){
			$('.ratelFilterRangeStatus').show();
			$('.skillFilterUser').hide();
		}
		else{
			if(rateFilterBy == 3){
				$('.ratelFilterRangeStatus').hide();
				$('.skillFilterUser').show();
			}
			else
			{
				$('.ratelFilterRangeStatus').hide();
				$('.skillFilterUser').hide();
			}
		}
		
		if(rateFilterBy > 1){
			$('.resetFilters').show();
		}
	
		rateFilterRangeVal =  $('.ratelFilterRange').val();
		if(rateFilterRangeVal.length > 0){
			rateFilterRangeVal=rateFilterRangeVal.split('-');
			startDateParam = rateFilterRangeVal[0].trim();
			endDateParam = rateFilterRangeVal[1].trim();
			loadConsultantRateList(50,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy);
		}
   });
   
    $(".searchByWriter").change(function() {
		searchByWriter =  $(this).val();
		loadConsultantRateList(50,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,searchByWriter);
    });
	
	$('body').on('change', '.roleFilterBy', function(){
		var roleId = $(this).val();
		
		if(roleId == ""){
			return;
		}
		loadConsultantRateList(50,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy,"",roleId);
    });
	
	$('body').on('click', '.resetFiltersAction', function(){
		location.reload();
    });	
   
	 $('body').on('click', '.applyBtn, .ranges', function(){
		rateFilterRangeVal =  $('.ratelFilterRange').val();
		if(rateFilterRangeVal.length > 0){
			rateFilterRangeVal=rateFilterRangeVal.split('-');
			startDateParam = rateFilterRangeVal[0].trim();
			endDateParam = rateFilterRangeVal[1].trim();
			loadConsultantRateList(50,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy);
		}
	 });
		
	 $('body').on('click', '.addNewRate', function(){
			$(".addRate").toggle();
			$(".updateRate").hide();
	 });	
   
	   $('body').on('click', '.rateCancel', function(){
			location.reload();
	   });	
   
	   $('body').on('click', '.rateUpdateCancel', function(){
			location.reload();
	   });	

		$('body').on('click', '.rateDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
		});
		
		$('body').on('click', '.okRatelDelButton', function(){
			fieldId = $('#delFieldId').val();
			$.ajax({
				type : 'post',
				url: 'ajax/consultantRate.php?rand='+Math.random(),
				data : { rateDelete: 1, rateDeleteId:fieldId },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmDelete');
					showMessage(response.message);
					loadConsultantRateList(50,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy);
				}
			});
		});
		
		$('body').on('click', '.cancelRatelDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		
		
		$('body').on('click', '.addRateSave', function(){
			
			var cons_rate_user_id = $('.cons_rate_user_id').val();
			var cons_rate_service_type_id = $('.cons_rate_service_type_id').val();
			var cons_rate_per_unit = $('.cons_rate_per_unit').val();
			var rateUpdateId = $('.rateUpdateId').val();
			
			
			if(cons_rate_user_id==''){
				  showMessage('{$smarty.const.ERR_FORM_USER_ID}');
				  $('.cons_rate_user_id').focus();
				  return false;
			 }
			if(cons_rate_service_type_id==''){
				  showMessage('{$smarty.const.ERR_TASK_CONTENT_SERVICE_TYPE_ID}');
				  $('.cons_rate_service_type_id').focus();
				  return false;
			 }
			if(cons_rate_per_unit==''){
				  showMessage('{$smarty.const.ERR_CONS_RATE_PER_UNIT}');
				  $('.cons_rate_per_unit').focus();
				  return false;
			 }
			 
			 if(! isNumeric(cons_rate_per_unit)){
				showMessage('{$smarty.const.ERR_INVALID_CONS_RATE_PER_UNIT}');
				$('.cons_rate_per_unit').focus();
				return false;
			}
			 	
		   if(rateUpdateId > 0){
				actionOperand = 2;
			}
			else{
				actionOperand = 1;
			}
		   
			$.ajax({
				url: 'ajax/consultantRate.php?rand='+Math.random(),
				type: 'post',
				dataType: 'json',
				data: { actionOperand: actionOperand, cons_rate_user_id: cons_rate_user_id, cons_rate_service_type_id : cons_rate_service_type_id, cons_rate_per_unit: cons_rate_per_unit, rateUpdateId: rateUpdateId},
				success: function(response) {
					checkResponseRedirect(response);
					showMessage(response.message);
					$(".addRate").hide();
					$(".updateRate").hide();
					loadConsultantRateList(50,orderIdRate,sortIdRate,startDateParam,endDateParam,rateFilterBy);
				}		
			});
            
      });
		
	  $('body').on('click', '.rateUpdateAction', function(){
		$(".addRate").hide();
		$(".updateRate").show();
		var rateUpdateId = $(this).attr('id').split('_')[1];
	   
		$.ajax({
			url: 'getModuleInfo.php?rand='+Math.random(),
			type:'post',
			dataType: 'json',
			data : { module: 'consultantRateUpdate', rateUpdateId: rateUpdateId },
				  success: function(response) {
					checkResponseRedirect(response);
					$('.updateRate').html("");
					$('.updateRate').html(response.message.content);
				  }
		});
	});	
	
	
  });
   
   
   function loadConsultantRateList(recCountValue,orderId="",sortId="",startDate="",endDate="",rateFilterBy="",writerId=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#ratePageListing').val(recordCount);
      $('#ratelPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'consultantRateList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,rateFilterBy:rateFilterBy, writerId: writerId},
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
   		
   		
   		if(strClassRate && strClassRate!=''){
			  if(strClassRate=='ascendingClassRate'){
				  $('#'+orderId+'s a').removeClass('ascendingClassRate');
				  $('#'+orderId+'s a').addClass('descendingClassRate').prepend('<i class="fa fa-caret-up gray font13"></i>');
				  $('#overAllRate th a').addClass('descendingClassRate');
			  } else if(strClassRate=='descendingClassRate'){
				  $('#'+orderId+'s a').removeClass('descendingClassRate');
				  $('#'+orderId+'s a').addClass('ascendingClassRate').prepend('<i class="fa fa-caret-down gray font13"></i>');
				  $('#overAllRate th a').addClass('ascendingClassRate');
			  }
			  } else {
				$('#user_fnames a').addClass('descendingClassRate').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#user_lnames a').addClass('descendingClassRate');
				$('#serv_type_names a').addClass('descendingClassRate');
				$('#cons_rate_per_units a').addClass('descendingClassRate');
				$('#cons_rate_created_ons a').addClass('descendingClassRate');
			 }
          }
      });	 
   }	
</script>

{/block}
{block name=content}
<div class="updateRate"></div>
<div class="row addRate" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
			   <div class="form-group col-sm-4">
				   <label >Consultant</label>
				   <select class="form-control cons_rate_user_id" id="cons_rate_user_id">
					  <option value="">--- Select Consultant ---</option>
					  {if $userArray}
					  {foreach $userArray as $key=> $value}
						<option value="{$value.user_id}">{$value.user_fname} {$value.user_lname}</option>
					  {/foreach}
					  {/if}
				   </select>
				</div>
				<div class="form-group col-sm-6">
                  <label >Service Type</label>
                  <select class="form-control cons_rate_service_type_id" id="cons_rate_service_type_id">
                     <option value="">--- Select Service Type ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
                     <option value="{$value.serv_type_id}">{$value.serv_type_name}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
				<div class="form-group col-sm-2">
                  <label >Rate Per Unit</label>
				   <input type="text" class="form-control cons_rate_per_unit" id="cons_rate_per_unit" placeholder="">
               </div>
			 </div>
			
			
            <button type="button" class="btn btn-default pull-right margin rateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addRateSave">Done</button>
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
                     <select class="form-control rateFilterBy" name="rateFilterBy">
                     {$rateArray}
                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-4">
               <div class="form-group ratelFilterRangeStatus" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Date Range</label>
                  </div>
                  <div class="col-sm-6">
                     <div class="input-group">
                        <div class="input-group-addon">
                           <i class="fa fa-calendar"></i>
                        </div>
                        <input type="text" readonly name="ratelFilterRange" class="form-control pull-right  ratelFilterRange" style="width:175px !important;">
                     </div>
                  </div>
                  <!-- /.input group -->
               </div>
			    <div class="form-group skillFilterUser" style="display:none;">
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
            </div>
			<div class="col-sm-2">
				<div class="form-group resetFilters" style="display:none;">
						<button type="button" class="btn btn-primary pull-right  resetFiltersAction"><i class="fa fa-minus"></i> Reset Filters</button>
				</div>
			</div>
            <div class="col-sm-3">
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewRate"><i class="fa fa-plus"></i> Add New Rate</button>
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
               {*<button type="button" class="btn btn-primary pull-right m-r-10 addNewRate"><i class="fa fa-plus"></i> Add New Rate</button>*}
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
							<h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_DELETE_CONSULTANT_RATE}</h5>
							<table border="0" cellspacing="0" cellpadding="5" align="center">
								<tr>
									<td class="p-t-10">
										<a href="javascript:void(0);" class="btn btn-primary M2 okRatelDelButton">{$smarty.const.LBL_YES}</a>
										<a href="javascript:void(0);" class="btn btn-default M2 cancelRatelDelButton">{$smarty.const.LBL_NO}</a>
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

    $('.ratelFilterRange').daterangepicker({
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