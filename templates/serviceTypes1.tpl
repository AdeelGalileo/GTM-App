{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Service Types{/block}
{block name=header}
<script type="text/javascript">
   var strClassServiceType;
   var serviceFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdServiceType = 0;
   var sortIdServiceType = 0;
   var searchByServiceType=0;
   $(document).ready(function(){
   
   $('.serv_type_qb_id').chosen({ width:"100%"});
   
   loadServiceTypesList(50,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
   	
	$('.searchByServiceType').chosen({ width:"100%"});
   
    $( ".serviceFilterBy" ).change(function() {
		serviceFilterBy =  $(this).val();
		if(serviceFilterBy == 2){
			$('.serviceFilterRangeStatus').show();
			$('.serviceFilterServiceType').hide();
		}
		else{
			if(serviceFilterBy == 3){
				$('.serviceFilterRangeStatus').hide();
				$('.serviceFilterServiceType').show();
			}
			else
			{
				$('.serviceFilterRangeStatus').hide();
				$('.serviceFilterServiceType').hide();
			}
		}
		
		if(serviceFilterBy > 1){
			$('.resetFilters').show();
		}
	
		serviceFilterRangeVal =  $('.serviceFilterRange').val();
		if(serviceFilterRangeVal.length > 0){
			serviceFilterRangeVal=serviceFilterRangeVal.split('-');
			startDateParam = serviceFilterRangeVal[0].trim();
			endDateParam = serviceFilterRangeVal[1].trim();
			pageNo = 0;
			loadServiceTypesList(50,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
		}
   });
   
   $('body').on('click', '.resetFiltersAction', function(){
		location.reload();
    });	
   
	$('body').on('click', '.applyBtn, .ranges', function(){
		serviceFilterRangeVal =  $('.serviceFilterRange').val();
		if(serviceFilterRangeVal.length > 0){
			serviceFilterRangeVal=serviceFilterRangeVal.split('-');
			startDateParam = serviceFilterRangeVal[0].trim();
			endDateParam = serviceFilterRangeVal[1].trim();
			pageNo = 0;
			loadServiceTypesList(50,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
		}
	 });
   
    $(".searchByServiceType").change(function() {
		searchByServiceType =  $(this).val();
		pageNo = 0;
		loadServiceTypesList(50,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
    });
	
	
   $('body').on('click', '.descendingClassServiceType', function(){
   orderIdServiceType = $(this).attr('id');
   sortIdServiceType = 2;
   pageNo = $('#pageDropDownValue').val();
   strClassServiceType = 'descendingClassServiceType';
   var recCountValues = $('#serviceTypePageListing').val();
   loadServiceTypesList(recCountValues,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
    });
   
    $('body').on('click', '.ascendingClassServiceType', function(){
   orderIdServiceType = $(this).attr('id');
   sortIdServiceType = 1;
   pageNo = $('#pageDropDownValue').val();
   strClassServiceType = 'ascendingClassServiceType';
   var recCountValues = $('#serviceTypePageListing').val();
   loadServiceTypesList(recCountValues,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
    });
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#serviceTypePageListing').val();
          loadServiceTypesList(recCountValues,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
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
          var recCountValues = $('#serviceTypePageListing').val();
          loadServiceTypesList(recCountValues,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#serviceTypePageListing').val();
          loadServiceTypesList(recCountValues,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
      });
      $('body').on('change', '#serviceTypePageListing', function(){
          var recCount = $(this).val();
          $('#serviceTypePageListingNew').val(recCount);
          pageNo = 0;
          loadServiceTypesList(recCount,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
      });
      $('body').on('change', '#serviceTypePageListingNew', function(){
          var recCount = $(this).val();
          $('#serviceTypePageListing').val(recCount);
          pageNo = 0;
          loadServiceTypesList(recCount,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
      });	
   
   
   
   $('body').on('click', '.addNewServiceType', function(){
   $(".addServiceType").toggle();
   $(".updateServiceType").hide();
   });	
   
   $('body').on('click', '.serviceTypeCancel', function(){
		location.reload();
   });	
   
   $('body').on('click', '.serviceTypeUpdateCancel', function(){
		location.reload();
   });	
   
   
    $('body').on('click', '.serviceTypeDeleteAction', function(){
		var fieldId = $(this).attr('id').split('_')[1];
		$('#delFieldId').val(fieldId);
		$('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
		uiPopupOpen('confirmDelete', 500, 125);
   });
   
    $('body').on('click', '.cancelServiceTypeDelButton', function(){
        uiPopClose('confirmDelete');
   });
   
   $('body').on('click', '.okServiceTypeDelButton', function(){
    fieldId = $('#delFieldId').val();
    $.ajax({
    type : 'post',
    url: 'ajax/serviceType.php?rand='+Math.random(),
    data : { serviceTypeDelete: 1, serviceTypeDeleteId:fieldId },
    dataType:'json', 
    success: function(response){
   checkResponseRedirect(response);
   uiPopClose('confirmDelete');
   showMessage(response.message);
   loadServiceTypesList(50,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
    }
    });
   });
   

	$('body').on('keydown', '.serv_type_gal_rate,.serv_type_freel_rate', function(event){
		if (event.shiftKey == true) {
			event.preventDefault();
		}
		if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190) {

		} else {
			event.preventDefault();
		}
		
		if($(this).val().indexOf('.') !== -1 && event.keyCode == 190){
			event.preventDefault();
		}
	});
	
   
   $('body').on('click', '.serviceTypeSave', function(){
   	
   	var serv_type_name = $('.serv_type_name').val();
   	var serv_type_gal_rate = $('.serv_type_gal_rate').val();
    var serv_type_freel_rate = $('.serv_type_freel_rate').val();
	var serv_type_qb_id = $('.serv_type_qb_id').val();
	var serv_type_task_type = $('.serv_type_task_type').val();
    var servTypeId = $('.servTypeUpdateId').val();
   	
   	if(serv_type_name==''){
              showMessage('{$smarty.const.ERR_SERVICE_TYPE}');
              $('.serv_type_name').focus();
              return false;
          }
   	
   	if(serv_type_gal_rate==''){
              showMessage('{$smarty.const.ERR_GAL_RATE}');
              $('.serv_type_gal_rate').focus();
              return false;
          }
		  
   	if(serv_type_freel_rate==''){
              showMessage('{$smarty.const.ERR_FREEL_RATE}');
              $('.serv_type_freel_rate').focus();
              return false;
          }
   
	if(serv_type_task_type==''){
              showMessage('{$smarty.const.ERR_SERVICE_TYPE}');
              $('.serv_type_task_type').focus();
              return false;
          }
	
    if(! isNumeric(serv_type_gal_rate)){
				showMessage('{$smarty.const.INVALID_GAL_RATE}');
				$('.serv_type_gal_rate').focus();
				return false;
			}
			
	 if(! isNumeric(serv_type_freel_rate)){
				showMessage('{$smarty.const.INVALID_FREEL_RATE}');
				$('.serv_type_freel_rate').focus();
				return false;
			}
	
	{*
	
		if(Number(serv_type_gal_rate)<Number(serv_type_freel_rate)){
              showMessage('{$smarty.const.ERR_FREEL_GAL_RATE}');
              $('.serv_type_freel_rate').focus();
              return false;
		}
	
	*}
	
   	if(servTypeId > 0){
   		actionOperand = 2;
   	}
   	else{
   		actionOperand = 1;
   	}
   	
   	$.ajax({
   		url: 'ajax/serviceType.php?rand='+Math.random(),
   		type: 'post',
   		dataType: 'json',
   		data: { actionOperand: actionOperand, serv_type_name: serv_type_name, serv_type_gal_rate: serv_type_gal_rate, serv_type_freel_rate: serv_type_freel_rate, serv_type_qb_id:serv_type_qb_id, serv_type_task_type:serv_type_task_type,  servTypeUpdateId:  servTypeId },
   		success: function(response) {
   			checkResponseRedirect(response);
   			showMessage(response.message);
			$(".addServiceType").hide();
			$(".updateServiceType").hide();
   			loadServiceTypesList(50,orderIdServiceType,sortIdServiceType,startDateParam,endDateParam,serviceFilterBy,searchByServiceType);
   		}		
   	});
            
      });	
   
   $('body').on('click', '.serviceTypeUpdateAction', function(){
	$('#loadingOverlayEditor').show();
   	$(".addServiceType").hide();
   	$(".updateServiceType").show();
	
	 $('html,body').animate({
        scrollTop: $(".updateServiceType").offset().top},
        'slow');
	
   	var serviceTypeId = $(this).attr('id').split('_')[1];
   
        $.ajax({
   		url: 'getModuleInfo.php?rand='+Math.random(),
   		type:'post',
   		dataType: 'json',
   		data : { module: 'serviceTypeUpdate', serviceTypeId: serviceTypeId },
              success: function(response) {
                  checkResponseRedirect(response);
				  $('#loadingOverlayEditor').hide();
				  $('.updateServiceType').html("");
				  $('.updateServiceType').html(response.message.content);
              }
          });
   });	
   
   
   
   
   
   });
   
   function loadServiceTypesList(recCountValue,orderId="",sortId="",startDate="",endDate="",serviceFilterBy="",searchByServiceTypeId=""){
   
   var page = pageNo ? pageNo : 1;
   
      var recordCount = recCountValue ? recCountValue : 50;
      $('#serviceTypePageListing').val(recordCount);
      $('#serviceTypePageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
   
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'serviceTypesList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,serviceFilterBy:serviceFilterBy,searchByServiceTypeId:searchByServiceTypeId },
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
   		
      if(strClassServiceType && strClassServiceType!=''){
   	  if(strClassServiceType=='ascendingClassServiceType'){
   		  $('#'+orderId+'s a').removeClass('ascendingClassServiceType');
   		  $('#'+orderId+'s a').addClass('descendingClassServiceType').prepend('<i class="fa fa-caret-up gray font13"></i>');
   		  $('#overAllServiceType th a').addClass('descendingClassServiceType');
   	  } else if(strClassServiceType=='descendingClassServiceType'){
   		  $('#'+orderId+'s a').removeClass('descendingClassServiceType');
   		  $('#'+orderId+'s a').addClass('ascendingClassServiceType').prepend('<i class="fa fa-caret-down gray font13"></i>');
   		 $('#overAllServiceType th a').addClass('ascendingClassServiceType');
   	  }
   	} 
   	else {
   		$('#serv_type_names a').addClass('descendingClassServiceType').prepend('<i class="fa fa-caret-up gray font13"></i>');
   		$('#serv_type_gal_rates a').addClass('descendingClassServiceType');
   		$('#serv_type_freel_rates a').addClass('descendingClassServiceType');
   		$('#serv_type_created_ons a').addClass('descendingClassServiceType');
   	}
          }
      });	 
   }	
</script> 
{/block}
{block name=content}
	<div id="loadingOverlayEditor" class="loadingOverlayEditor" style="display:none;">
		<img src="{$smarty.const.ROOT_HTTP_PATH}/dist/img/gifload.gif" width="100px" height="100px"/>
	</div>
<div class="updateServiceType"> </div>
<div class="row addServiceType" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
            <div class="row">
				<div class="form-group col-sm-3">
					<label >QB Associated Service Type Name</label>
					{*<input type="text" class="form-control serv_type_qb_id" id="serv_type_qb_id" value="">*}
					<select class="form-control serv_type_qb_id" id="serv_type_qb_id">
					<option value="">--- Select QB Associated Service Type Name ---</option>
					{if $outputArray}
						{foreach $outputArray as $key=> $value}
							<option value="{$value->Id}">{$value->Name}</option>
					{/foreach}
					{/if}
					</select>
					
				</div>
               <div class="form-group col-sm-3">
                  <label >Service Type</label>
                   <input type="text" class="form-control serv_type_name" id="serv_type_name" placeholder="">
               </div>
               <div class="form-group col-sm-3">
                  <label >Invoice Rate</label>
				   <input type="text" class="form-control serv_type_gal_rate" id="serv_type_gal_rate" placeholder="">
               </div>
               <div class="form-group col-sm-3">
                  <label >Bill Rate</label>
                  <input type="text" class="form-control serv_type_freel_rate" id="serv_type_freel_rate" placeholder="">
               </div>
			  
            </div>
			 <div class="row">
               <div class="form-group col-sm-3">
                  <label >Service Task Type</label>
                     <select class="form-control serv_type_task_type" name="serv_type_task_type">
						 <option value="">--Select Service Task Type--</option>
						 <option value="1">Task Keyword</option>
						 <option value="2">Task Content</option>
                     </select>
               </div>
			  </div>
            <button type="button" class="btn btn-default pull-right margin serviceTypeCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin serviceTypeSave">Done</button>
         </div>
      </div>
   </div>
</div>
<div class="row">
   <div class="col-sm-12">
	   {if $outputErrorArray}
			{foreach $outputErrorArray as $val}
				<P style="color:red;">{$val}<p>
			{/foreach}
		{/if}
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
                     <select class="form-control serviceFilterBy" name="serviceFilterBy">
                     {$serviceTypeFilterArray}
                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-4">
               <div class="form-group serviceFilterRangeStatus" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Date Range</label>
                  </div>
                  <div class="col-sm-6">
                     <div class="input-group">
                        <div class="input-group-addon">
                           <i class="fa fa-calendar"></i>
                        </div>
                        <input type="text" readonly name="serviceFilterRange" class="form-control pull-right  serviceFilterRange" style="width:175px !important;">
                     </div>
                  </div>
                  <!-- /.input group -->
               </div>
			    <div class="form-group serviceFilterServiceType" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Service Type</label>
                  </div>
                  <div class="col-sm-6">
                  <select class="form-control searchByServiceType" id="searchByServiceType">
                     <option value="">--- Select Service Type ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
						<option value="{$value.serv_type_id}">{$value.serv_type_name}</option>
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
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewServiceType"><i class="fa fa-plus"></i> Add New Service Type</button>
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
               {*<button type="button" class="btn btn-primary pull-right m-r-10 addNewServiceType"><i class="fa fa-plus"></i> Add New Service Type</button>*}
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
                  <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_DELETE_SERVICE_TYPE}</h5>
                  <table border="0" cellspacing="0" cellpadding="5" align="center">
                     <tr>
                        <td class="p-t-10">
                           <a href="javascript:void(0);" class="btn btn-primary M2 okServiceTypeDelButton">{$smarty.const.LBL_YES}</a>
                           <a href="javascript:void(0);" class="btn btn-default M2 cancelServiceTypeDelButton">{$smarty.const.LBL_NO}</a>
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
   
    $('.serviceFilterRange').daterangepicker({
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