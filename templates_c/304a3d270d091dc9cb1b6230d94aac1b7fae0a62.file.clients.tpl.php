<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:49:34
         compiled from "/home/galileotechmedia/public_html/app/templates/clients.tpl" */ ?>
<?php /*%%SmartyHeaderCode:185088725a959a2ec3af79-59052601%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '304a3d270d091dc9cb1b6230d94aac1b7fae0a62' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/clients.tpl',
      1 => 1519124476,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '185088725a959a2ec3af79-59052601',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'lastPage' => 0,
    'pageLink' => 0,
    'messages' => 0,
    'content' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a959a2ec7b7b3_09556036',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959a2ec7b7b3_09556036')) {function content_5a959a2ec7b7b3_09556036($_smarty_tpl) {?><!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title><?php echo $_smarty_tpl->tpl_vars['SiteTitle']->value;?>
 - Clients</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="description" content=""><?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

      
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
   var clientStatusIdFilter = 0;
   
  $(document).ready(function(){
		
		
		$('.client_qb_associated_reference').chosen({ width:"100%"});
		
	    loadClientList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
		
		 $('#clientIdFilter').chosen({ width:"100%"});
		 $('#clientStatusIdFilter').chosen({ width:"100%"});
		
		$( ".clientFilterBy" ).change(function() {
			clientFilterBy =  $(this).val();
			
			if(clientFilterBy == 2){
				$('.clientFilter').show();
				$('.clientStatusFilter').hide();
			}
			else{
				if(clientFilterBy == 3){
					$('.clientFilter').hide();
					$('.clientStatusFilter').show();
					
				}
				else
				{
					$('.clientFilter').hide();
					$('.clientStatusFilter').hide();
				}
			}	
			
			if(clientFilterBy > 1){
				$('.resetFilters').show();
			}
			else{
				$('.resetFilters').hide();
			}
			
		});
		
		$( ".clientIdFilter" ).change(function() {
			 clientIdFilter =  $(this).val();
			 pageNo = 0;
			 loadClientList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
		});
		
		$( ".clientStatusIdFilter" ).change(function() {
			 clientStatusIdFilter =  $(this).val();
			 pageNo = 0;
			 loadClientList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
		});
		
	   
	     $('body').on('click', '.descendingClassClient', function(){
			orderIdClient = $(this).attr('id');
			sortIdClient = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassClients = 'descendingClassClient';
			var recCountValues = $('#clientPageListing').val();
			loadClientList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
		});
   
		$('body').on('click', '.ascendingClassClient', function(){
			orderIdClient = $(this).attr('id');
			sortIdClient = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassClients = 'ascendingClassClient';
			var recCountValues = $('#clientPageListing').val();
			loadClientList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
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
          loadClientList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
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
          loadClientList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
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
          loadClientList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
      });
      $('body').on('change', '#clientPageListing', function(){
          var recCount = $(this).val();
          $('#clientPageListingNew').val(recCount);
          pageNo = 0;
		  loadClientList(recCount,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
      });
      $('body').on('change', '#clientPageListingNew', function(){
          var recCount = $(this).val();
          $('#clientPageListing').val(recCount);
          pageNo = 0;
		  loadClientList(recCount,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
      });	
	   
	  
		
		 $('body').on('click', '.resetFiltersAction', function(){
			location.reload();
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
				url: 'ajax/client.php?rand='+Math.random(),
				data : { clientDelete: 1, clientDeleteId:fieldId },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmDelete');
					showMessage(response.message);
					loadClientList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
				}
			});
		});
		
		$('body').on('click', '.cancelClientDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		
		
		$('body').on('click', '.addClientSave', function(){
   	
			var client_name = $('.client_name').val();
			var client_street = $('.client_street').val();
			var client_city = $('.client_city').val();
			var client_state = $('.client_state').val();
			var client_zipcode = $('.client_zipcode').val();
			var client_country = $('.client_country').val();
			var client_qb_associated_reference = $('.client_qb_associated_reference').val();
			var client_record_status = $('.client_record_status').val();
			
			var clientUpateId = $('.clientUpateId').val();
			
		   
			if(client_name==''){
				  showMessage('<?php echo @ERR_CLIENT_NAME;?>
');
				  $('.client_name').focus();
				  return false;
			 }
			
		   
		   if(clientUpateId > 0){
				actionOperand = 2;
			}
			else{
				actionOperand = 1;
			}
		   
			$.ajax({
				url: 'ajax/client.php?rand='+Math.random(),
				type: 'post',
				dataType: 'json',
				data: { actionOperand: actionOperand, client_name: client_name, client_street: client_street, client_city: client_city, client_state: client_state, client_zipcode:  client_zipcode , client_country:  client_country , client_qb_associated_reference:client_qb_associated_reference, client_record_status:client_record_status, clientUpateId:  clientUpateId},
				success: function(response) {
					checkResponseRedirect(response);
					showMessage(response.message);
					$(".addClient").hide();
					$(".updateClient").hide();
					loadClientList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter,clientStatusIdFilter);
				}		
			});
            
      });
		
	  $('body').on('click', '.clientUpdateAction', function(){
		$('#loadingOverlayEditor').show();
		$(".addClient").hide();
		$(".updateClient").show();
		
		 $('html,body').animate({
        scrollTop: $(".updateClient").offset().top},
        'slow');
		
		var clientUpateId = $(this).attr('id').split('_')[1];
	   
		$.ajax({
			url: 'getModuleInfo.php?rand='+Math.random(),
			type:'post',
			dataType: 'json',
			data : { module: 'clientUpdate', clientUpateId: clientUpateId },
				  success: function(response) {
					checkResponseRedirect(response);
					$('#loadingOverlayEditor').hide();
					$('.updateClient').html("");
					$('.updateClient').html(response.message.content);
				  }
		});
	});	
		
		
  });
   
   function loadClientList(recCountValue,orderId="",sortId="",startDate="",endDate="",clientFilterBy="",clientIdFilter="", clientStatusIdFilter=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#clientPageListing').val(recordCount);
      $('#clientPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'clientList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,clientFilterBy:clientFilterBy, clientIdFilter: clientIdFilter, recordStatus:clientStatusIdFilter },
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
				$('#client_streets a').addClass('descendingClassClient');
				$('#client_citys a').addClass('descendingClassClient');
				$('#client_states a').addClass('descendingClassClient');
				$('#client_zipcodes a').addClass('descendingClassClient');
				$('#client_countrys a').addClass('descendingClassClient');
				$('#client_created_ons a').addClass('descendingClassClient');
			 }
          }
      });	 
   }	
</script>


   </head>
  <body class="skin-blue sidebar-mini sidebar-collapse">
<div class="wrapper">
      <?php echo $_smarty_tpl->getSubTemplate ("layout/body_header_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
<?php echo $_smarty_tpl->getSubTemplate ("layout/left_menu.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
<div class="content-wrapper"><section class="content-header"><h1><?php echo $_smarty_tpl->tpl_vars['lastPage']->value;?>
</h1><ol class="breadcrumb"><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/dashboard.php"><i class="fa fa-dashboard"></i> Home</a></li><?php if ($_smarty_tpl->tpl_vars['pageLink']->value){?><li><?php echo $_smarty_tpl->tpl_vars['pageLink']->value;?>
</li><?php }?><li class="active"><?php echo $_smarty_tpl->tpl_vars['lastPage']->value;?>
</li></ol></section><div id="Messages" style="<?php if (!$_smarty_tpl->tpl_vars['messages']->value){?>display:none;<?php }?>"><div id="inner_message"><?php echo $_smarty_tpl->tpl_vars['messages']->value;?>
</div></div><div id="MessagesAuto" style="<?php if (!$_smarty_tpl->tpl_vars['messages']->value){?>display:none;z-index:99999999;<?php }?>"><div id="inner_Auto" class="text-center"><?php echo $_smarty_tpl->tpl_vars['messages']->value;?>
</div></div><section class="content">

	<div id="loadingOverlayEditor" class="loadingOverlayEditor" style="display:none;">
		<img src="<?php echo @ROOT_HTTP_PATH;?>
/dist/img/gifload.gif" width="100px" height="100px"/>
	</div>

<div class="updateClient"></div>
<div class="row addClient" style="display:none;">
   <div class="col-md-12">
		
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
            <div class="form-group col-sm-3">
               <label >Client Name</label>
			   <input  class="form-control client_name" id="client_name" placeholder="">
            </div>
            <div class="form-group col-sm-3">
               <label >Street</label>
               <input  class="form-control client_street" id="client_street" placeholder="">
            </div>
            <div class="form-group col-sm-3">
               <label >City</label>
               <input type="text" class="form-control client_city" id="client_city" placeholder="">
            </div>
			 <div class="form-group col-sm-3">
                  <label >State</label>
                   <input type="text" class="form-control client_state" id="client_state" placeholder="">
            </div>
			 </div>
			 <div class="row">
				<div class="form-group col-sm-3">
				   <label >Zip Code</label>
				   <input type="text" class="form-control client_zipcode" id="client_zipcode" placeholder="">
				</div>
				<div class="form-group col-sm-3">
					<label >Country</label>
					<input type="text" class="form-control client_country" id="client_country" placeholder="">
				</div>
				<div class="form-group col-sm-3">
				   <label >QB Associated Client</label>
				   <select class="form-control client_qb_associated_reference" id="client_qb_associated_reference">
					<option value="">--- Select QB Associated Client ---</option>
					<?php if ($_smarty_tpl->tpl_vars['outputArray']->value){?>
						<?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['outputArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
							<option value="<?php echo $_smarty_tpl->tpl_vars['value']->value->Id;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value->DisplayName;?>
</option>
					<?php } ?>
					<?php }?>
					</select>
				</div>
			 </div>
			<div class="row">
				<div class="form-group col-sm-9"><p style="font-weight:bold;">Note :  If the Associated QB class and QB Id for this client is different for each divisions. Please update QB class & Qb Id for the divisions of this client.</p></div>
			</div>
            <button type="button" class="btn btn-default pull-right margin clientCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addClientSave">Done</button>
         </div>
      </div>
   </div>
</div>
<div class="row">
   <div class="col-sm-12">
		<?php if ($_smarty_tpl->tpl_vars['outputErrorArray']->value){?>
			<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['outputErrorArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
?>
				<P style="color:red;"><?php echo $_smarty_tpl->tpl_vars['val']->value;?>
<p>
			<?php } ?>
		<?php }?>
      <div class="box box-primary">
         <div class="box-header ">
         </div>
         <div class="row ">
            <div class="col-sm-3" >
               <div class="form-group" >
                  <div class="col-sm-4">
                     <label>Filter By</label>
                  </div>
                  <div class="col-sm-8">
                     <select class="form-control clientFilterBy" name="clientFilterBy">
                     <?php echo $_smarty_tpl->tpl_vars['clientFilterArray']->value;?>

                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-3">
			   <div class="form-group clientFilter" style="display:none;">
                  <div class="col-sm-2">
                     <label>Client</label>
                  </div>
                  <div class="col-sm-10">
                   <select class="form-control clientIdFilter" id="clientIdFilter">
                     <option value="">--- Select Client ---</option>
						<?php if ($_smarty_tpl->tpl_vars['clientData']->value){?>
						 <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['clientData']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
							<option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['client_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['client_name'];?>
</option>
						 <?php } ?>
					 <?php }?>
                  </select>
                  </div>
                  <!-- /.input group -->
               </div>
			   
			   <div class="form-group clientStatusFilter" style="display:none;">
                  <div class="col-sm-2">
                     <label>Status</label>
                  </div>
                  <div class="col-sm-10">
                   <select class="form-control clientStatusIdFilter" id="clientStatusIdFilter">
                     <option value="">--- Select Client Status---</option>
					 <option value="0">Active Clients</option>
					 <option value="1">Archived Clients</option>
                  </select>
                  </div>
                  <!-- /.input group -->
               </div>
			  
            </div>
			<div class="col-sm-3 m-b-20">
				<div class="form-group resetFilters" style="display:none;">
				   <button type="button" class="btn btn-primary pull-right m-r-10 resetFiltersAction"><i class="fa fa-minus"></i> Reset Filters</button>
				</div>
			</div>
            <div class="col-sm-3">
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewClient"><i class="fa fa-plus"></i> Add New Client</button>
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
							<h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_DELETE_CLIENT;?>
</h5>
							<table border="0" cellspacing="0" cellpadding="5" align="center">
								<tr>
									<td class="p-t-10">
										<a href="javascript:void(0);" class="btn btn-primary M2 okClientDelButton"><?php echo @LBL_YES;?>
</a>
										<a href="javascript:void(0);" class="btn btn-default M2 cancelClientDelButton"><?php echo @LBL_NO;?>
</a>
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
</section></div><?php echo $_smarty_tpl->getSubTemplate ("layout/body_footer_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	</div>
   </body>
</html><?php }} ?>