{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Clients{/block}
{block name=header}
<style>

</style>
<script type="text/javascript">
   var strClassClients;
   var clientFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdClient = 0;
   var sortIdClient = 0;
   var clientIdFilter = 0;
   
  $(document).ready(function(){
		
		 $('.client_qb_ref_qb_id').chosen({ width:"100%"});
		
	    loadClientQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
	   
	     $('body').on('click', '.descendingClassClient', function(){
			orderIdClient = $(this).attr('id');
			sortIdClient = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassClients = 'descendingClassClient';
			var recCountValues = $('#clientPageListing').val();
			loadClientQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
		});
   
		$('body').on('click', '.ascendingClassClient', function(){
			orderIdClient = $(this).attr('id');
			sortIdClient = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassClients = 'ascendingClassClient';
			var recCountValues = $('#clientPageListing').val();
			loadClientQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
		});
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#clientPageListing').val();
          loadClientQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
          var recCountValues = $('#clientPageListing').val();
          loadClientQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#clientPageListing').val();
          loadClientQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
      });
      $('body').on('change', '#clientPageListing', function(){
          var recCount = $(this).val();
          $('#clientPageListingNew').val(recCount);
          pageNo = 0;
		  loadClientQbRefList(recCount,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
      });
      $('body').on('change', '#clientPageListingNew', function(){
          var recCount = $(this).val();
          $('#clientPageListing').val(recCount);
          pageNo = 0;
		  loadClientQbRefList(recCount,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
      });	
	   
	   $('#clientIdFilter').chosen({ width:"100%"});
	   $('#divisionFilterBy').chosen({ width:"100%"});
	   
	   $('#client_qb_ref_division_id').chosen({ width:"100%"});
	   $('#client_qb_ref_qb_class').chosen({ width:"100%"});
		
	   	$('.clientFilterRangeStatus').hide();
		
		$( ".clientFilterBy" ).change(function() {
			clientFilterBy =  $(this).val();
			
			if(clientFilterBy == 2){
				 
				$('.clientFilterRangeStatus').show();
				$('.clientFilter').hide();
				$('.divisionFilter').hide();
			}
			else if(clientFilterBy == 4){
				$('.divisionFilter').show();
				$('.clientFilterRangeStatus').hide();
				$('.clientFilter').hide();
			}
			else{
				if(clientFilterBy == 3){
					$('.clientFilterRangeStatus').hide();
					$('.clientFilter').show();
					$('.divisionFilter').hide();
				}
				else
				{
					$('.clientFilterRangeStatus').hide();
					$('.clientFilter').hide();
					$('.divisionFilter').hide();
				}
			}	
			
			clientFilterRangeVal =  $('.clientFilterRange').val();
			if(clientFilterRangeVal.length > 0){
				clientFilterRangeVal=clientFilterRangeVal.split('-');
				startDateParam = clientFilterRangeVal[0].trim();
				endDateParam = clientFilterRangeVal[1].trim();
				loadClientQbRefList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
			}
		});
		
		$( ".clientIdFilter" ).change(function() {
			 clientIdFilter =  $(this).val();
			 pageNo = 0;
			 loadClientQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
		});
		
		
		
		$('body').on('click', '.applyBtn, .ranges', function(){
			clientFilterRangeVal =  $('.clientFilterRange').val();
			if(clientFilterRangeVal.length > 0){
				clientFilterRangeVal=clientFilterRangeVal.split('-');
				startDateParam = clientFilterRangeVal[0].trim();
				endDateParam = clientFilterRangeVal[1].trim();
				loadClientQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
			}
		});
		
		$('body').on('click', '.addNewClient', function(){
			$(".addClient").toggle();
			$(".updateClient").hide();
		});	
   
	   $('body').on('click', '.clientCancel', function(){
			location.reload();
	   });	
   
	   $('body').on('click', '.clientUpdateCancel', function(){
			location.reload();
	   });	

		$('body').on('click', '.clientDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
		});
		
		$('body').on('click', '.okClientDelButton', function(){
			fieldId = $('#delFieldId').val();
			$.ajax({
				type : 'post',
				url: 'ajax/clientDivision.php?rand='+Math.random(),
				data : { clientQbRefDelete: 1, clientQbRefDeleteId:fieldId },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmDelete');
					showMessage(response.message);
					loadClientQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
				}
			});
		});
		
		$('body').on('click', '.cancelClientDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		
		
		$('body').on('click', '.addClientSave', function(){
   	
			var client_qb_ref_division_id = $('.client_qb_ref_division_id').val();
			var client_qb_ref_qb_class = $('.client_qb_ref_qb_class').val();
			var client_qb_ref_qb_id = $('.client_qb_ref_qb_id').val();
			var clientQbRefUpdateId = $('.clientQbRefUpdateId').val();
			
			
			if(client_qb_ref_division_id==''){
				  showMessage('{$smarty.const.ERR_DIVISION}');
				  $('.client_qb_ref_division_id').focus();
				  return false;
			 }
			 if(client_qb_ref_qb_class==''){
				  showMessage('{$smarty.const.ERR_CLIENT_QB_REF_QB_CLASS}');
				  $('.client_qb_ref_qb_class').focus();
				  return false;
			 }
			 if(client_qb_ref_qb_id==''){
				  showMessage('{$smarty.const.ERR_CLIENT_QB_REF_QB_ID}');
				  $('.client_qb_ref_qb_id').focus();
				  return false;
			 }
			 
		   
		   if(clientQbRefUpdateId > 0){
				actionOperand = 2;
			}
			else{
				actionOperand = 1;
			}
		   
			$.ajax({
				url: 'ajax/clientDivision.php?rand='+Math.random(),
				type: 'post',
				dataType: 'json',
				data: { actionOperand: actionOperand,  client_qb_ref_division_id: client_qb_ref_division_id, client_qb_ref_qb_id: client_qb_ref_qb_id, client_qb_ref_qb_class: client_qb_ref_qb_class, clientQbRefUpdateId:  clientQbRefUpdateId},
				success: function(response) {
					checkResponseRedirect(response);
					showMessage(response.message);
					$(".addClient").hide();
					$(".updateClient").hide();
					loadClientQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
				}		
			});
            
      });
		
	  $('body').on('click', '.clientUpdateAction', function(){
		$('#loadingOverlayEditor').show();
		$(".addClient").hide();
		$(".updateClient").show();
		var clientQbRefUpdateId = $(this).attr('id').split('_')[1];
	   
		$.ajax({
			url: 'getModuleInfo.php?rand='+Math.random(),
			type:'post',
			dataType: 'json',
			data : { module: 'clientDivisionUpdate', clientQbRefUpdateId: clientQbRefUpdateId },
				  success: function(response) {
					checkResponseRedirect(response);
					$('#loadingOverlayEditor').hide();
					$('.updateClient').html("");
					$('.updateClient').html(response.message.content);
				  }
		});
	});	
		
		
  });
   
   function loadClientQbRefList(recCountValue,orderId="",sortId="",startDate="",endDate="",clientFilterBy="",clientIdFilter=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#clientPageListing').val(recordCount);
      $('#clientPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'clientDivisionList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,clientFilterBy:clientFilterBy, clientIdFilter: clientIdFilter },
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
   		
   		
   		if(strClassClients && strClassClients!=''){
			  if(strClassClients=='ascendingClassClient'){
				  $('#'+orderId+'s a').removeClass('ascendingClassClient');
				  $('#'+orderId+'s a').addClass('descendingClassClient').prepend('<i class="fa fa-caret-up gray font13"></i>');
				  $('#overAllClient th a').addClass('descendingClassClient');
			  } else if(strClassClients=='descendingClassClient'){
				  $('#'+orderId+'s a').removeClass('descendingClassClient');
				  $('#'+orderId+'s a').addClass('ascendingClassClient').prepend('<i class="fa fa-caret-down gray font13"></i>');
				  $('#overAllClient th a').addClass('ascendingClassClient');
			  }
			  } else {
				$('#client_names a').addClass('descendingClassClient').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#division_codes a').addClass('descendingClassClient');
				$('#client_qb_ref_qb_ids a').addClass('descendingClassClient');
				$('#qb_cls_ref_class_names a').addClass('descendingClassClient');
				$('#client_qb_ref_created_ons a').addClass('descendingClassClient');
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
<div class="updateClient"></div>
<div class="row addClient" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
				<div class="form-group col-sm-3">
					<label >Division</label>
					 <select class="form-control client_qb_ref_division_id" id="client_qb_ref_division_id">
					 <option value="">--- Select Division ---</option>
						{if $divisionArray}
						 {foreach $divisionArray as $key=> $value}
							<option value="{$value.division_id}">{$value.division_code}</option>
						 {/foreach}
					 {/if}
					</select>
				</div>
				<div class="form-group col-sm-3">
					<label >Client QB Class</label>
					<select class="form-control client_qb_ref_qb_class" id="client_qb_ref_qb_class">
					 <option value="">--- Select Qb Class ---</option>
						{if $qbClassNamesArray}
						 {foreach $qbClassNamesArray as $key=> $value}
							<option value="{$value.qb_cls_ref_id}">{$value.qb_cls_ref_class_name}</option>
						 {/foreach}
					 {/if}
					</select>
				</div>
				<div class="form-group col-sm-3">
				   <label >QB Associated Client</label>
				   {*<input type="text" class="form-control client_qb_ref_qb_id" id="client_qb_ref_qb_id" placeholder="">*}
				   <select class="form-control client_qb_ref_qb_id" id="client_qb_ref_qb_id">
					<option value="">--- Select QB Associated Client ---</option>
					{if $outputArray}
						{foreach $outputArray as $key=> $value}
							<option value="{$value->Id}">{$value->DisplayName}</option>
					{/foreach}
					{/if}
					</select>
				</div>
			 </div>
            <button type="button" class="btn btn-default pull-right margin clientCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addClientSave">Done</button>
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
            <div class="col-sm-3" >
               <div class="form-group" style="display:none;">
                  <div class="col-sm-6">
                     <label>Filter By</label>
                  </div>
                  <div class="col-sm-6">
					 <select class="form-control clientFilterBy" name="clientFilterBy">
						 <option value="1">--Select Filter--</option>
						 <option value="2">Created On</option>
						 <option value="3">Client</option>
						 {if $smarty.session.sessionClientId == $smarty.const.MARRIOTT_CLIENT_ID}
							 {*<option value="4">Division</option>*}
						 {/if}
                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-4">
               <div class="form-group clientFilterRangeStatus" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Date Range</label>
                  </div>
                  <div class="col-sm-6">
                     <div class="input-group">
                        <div class="input-group-addon">
                           <i class="fa fa-calendar"></i>
                        </div>
                        <input type="text" readonly name="clientFilterRange" class="form-control pull-right  clientFilterRange" style="width:175px !important;">
                     </div>
                  </div>
                  <!-- /.input group -->
               </div>
			   <div class="form-group clientFilter" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Client</label>
                  </div>
                  <div class="col-sm-6">
                   <select class="form-control clientIdFilter" id="clientIdFilter">
                     <option value="">--- Select Client ---</option>
						{if $clientData}
						 {foreach $clientData as $key=> $value}
							<option value="{$value.client_id}">{$value.client_name}</option>
						 {/foreach}
					 {/if}
                  </select>
                  </div>
                  <!-- /.input group -->
               </div>
			   <div class="form-group divisionFilter" style="display:none;">
                     <select class="form-control divisionFilterBy" id="divisionFilterBy" name="divisionFilterBy">
                     {$divisionArray}
                     </select>
                </div>
            </div>
			
            <div class="col-sm-5">
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewClient"><i class="fa fa-plus"></i> Add New Client Division</button>
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
               {*<button type="button" class="btn btn-primary pull-right m-r-10 addNewClient"><i class="fa fa-plus"></i> Add New Client</button>*}
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
							<h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_DELETE_CLIENT_DIVISION}</h5>
							<table border="0" cellspacing="0" cellpadding="5" align="center">
								<tr>
									<td class="p-t-10">
										<a href="javascript:void(0);" class="btn btn-primary M2 okClientDelButton">{$smarty.const.LBL_YES}</a>
										<a href="javascript:void(0);" class="btn btn-default M2 cancelClientDelButton">{$smarty.const.LBL_NO}</a>
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

    $('.clientFilterRange').daterangepicker({
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