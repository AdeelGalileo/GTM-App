<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 15:17:28
         compiled from "/home/galileotechmedia/public_html/app/templates/qbClassReference.tpl" */ ?>
<?php /*%%SmartyHeaderCode:10732400405a95bcd8905ef5-31776344%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '8621a1774e4ab912e06e0b370478bd66c0cc470d' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/qbClassReference.tpl',
      1 => 1519124489,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '10732400405a95bcd8905ef5-31776344',
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
  'unifunc' => 'content_5a95bcd8949e73_78990322',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a95bcd8949e73_78990322')) {function content_5a95bcd8949e73_78990322($_smarty_tpl) {?><!DOCTYPE html>
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
   
  $(document).ready(function(){
	  
	  
		 $('.qb_cls_ref_class_id').chosen({ width:"100%"});
		
	    loadClassQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
	   
	     $('body').on('click', '.descendingClassClient', function(){
			orderIdClient = $(this).attr('id');
			sortIdClient = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassClients = 'descendingClassClient';
			var recCountValues = $('#clientPageListing').val();
			loadClassQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
		});
   
		$('body').on('click', '.ascendingClassClient', function(){
			orderIdClient = $(this).attr('id');
			sortIdClient = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassClients = 'ascendingClassClient';
			var recCountValues = $('#clientPageListing').val();
			loadClassQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
          loadClassQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
          loadClassQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
          loadClassQbRefList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
      });
      $('body').on('change', '#clientPageListing', function(){
          var recCount = $(this).val();
          $('#clientPageListingNew').val(recCount);
          pageNo = 0;
		  loadClassQbRefList(recCount,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
      });
      $('body').on('change', '#clientPageListingNew', function(){
          var recCount = $(this).val();
          $('#clientPageListing').val(recCount);
          pageNo = 0;
		  loadClassQbRefList(recCount,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
      });	
	   
	   $('#clientIdFilter').chosen({ width:"100%"});
	   
	   
	   	$('.clientFilterRangeStatus').hide();
		
		$( ".clientFilterBy" ).change(function() {
			clientFilterBy =  $(this).val();
			
			if(clientFilterBy == 2){
				 
				$('.clientFilterRangeStatus').show();
				$('.clientFilter').hide();
			}
			else if(clientFilterBy == 4){
				$('.clientFilterRangeStatus').hide();
				$('.clientFilter').hide();
			}
			else{
				if(clientFilterBy == 3){
					$('.clientFilterRangeStatus').hide();
					$('.clientFilter').show();
				}
				else
				{
					$('.clientFilterRangeStatus').hide();
					$('.clientFilter').hide();
				}
			}	
			
			clientFilterRangeVal =  $('.clientFilterRange').val();
			if(clientFilterRangeVal.length > 0){
				clientFilterRangeVal=clientFilterRangeVal.split('-');
				startDateParam = clientFilterRangeVal[0].trim();
				endDateParam = clientFilterRangeVal[1].trim();
				loadClassQbRefList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
			}
		});
		
		$( ".clientIdFilter" ).change(function() {
			 clientIdFilter =  $(this).val();
			 pageNo = 0;
			 loadClassQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
		});
		
		
		
		$('body').on('click', '.applyBtn, .ranges', function(){
			clientFilterRangeVal =  $('.clientFilterRange').val();
			if(clientFilterRangeVal.length > 0){
				clientFilterRangeVal=clientFilterRangeVal.split('-');
				startDateParam = clientFilterRangeVal[0].trim();
				endDateParam = clientFilterRangeVal[1].trim();
				loadClassQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
				url: 'ajax/qbClassReference.php?rand='+Math.random(),
				data : { classQbRefDelete: 1, classQbRefDeleteId:fieldId },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmDelete');
					showMessage(response.message);
					loadClassQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
				}
			});
		});
		
		$('body').on('click', '.cancelClientDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		
		
		$('body').on('click', '.addClientSave', function(){
   	
			var qb_cls_ref_class_id = $('.qb_cls_ref_class_id').val();
			var qb_cls_ref_class_name = $('.qb_cls_ref_class_name').val();
			var classQbRefUpateId = $('.classQbRefUpateId').val();
			
			
			 if(qb_cls_ref_class_id==''){
				  showMessage('<?php echo @ERR_CLIENT_QB_REF_QB_CLASS_ID;?>
');
				  $('.qb_cls_ref_class_id').focus();
				  return false;
			 }
			 if(qb_cls_ref_class_name==''){
				  showMessage('<?php echo @ERR_CLIENT_QB_REF_QB_CLASS_NAME;?>
');
				  $('.qb_cls_ref_class_name').focus();
				  return false;
			 }
			 
		   
		   if(classQbRefUpateId > 0){
				actionOperand = 2;
			}
			else{
				actionOperand = 1;
			}
		   
			$.ajax({
				url: 'ajax/qbClassReference.php?rand='+Math.random(),
				type: 'post',
				dataType: 'json',
				data: { actionOperand: actionOperand,  qb_cls_ref_class_name: qb_cls_ref_class_name, qb_cls_ref_class_id: qb_cls_ref_class_id, classQbRefUpateId:  classQbRefUpateId},
				success: function(response) {
					checkResponseRedirect(response);
					showMessage(response.message);
					$(".addClient").hide();
					$(".updateClient").hide();
					loadClassQbRefList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
				}		
			});
            
      });
		
	  $('body').on('click', '.clientUpdateAction', function(){
	   $('#loadingOverlayEditor').show();
		$(".addClient").hide();
		$(".updateClient").show();
		var classQbRefUpateId = $(this).attr('id').split('_')[1];
	   
		$.ajax({
			url: 'getModuleInfo.php?rand='+Math.random(),
			type:'post',
			dataType: 'json',
			data : { module: 'qbClassReferenceUpdate', classQbRefUpateId: classQbRefUpateId },
				  success: function(response) {
					checkResponseRedirect(response);
					$('#loadingOverlayEditor').hide();
					$('.updateClient').html("");
					$('.updateClient').html(response.message.content);
				  }
		});
	});	
		
		
  });
   
   function loadClassQbRefList(recCountValue,orderId="",sortId="",startDate="",endDate="",clientFilterBy="",clientIdFilter=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#clientPageListing').val(recordCount);
      $('#clientPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'qbClassReferenceList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,clientFilterBy:clientFilterBy, clientIdFilter: clientIdFilter },
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
				$('#qb_cls_ref_class_ids a').addClass('descendingClassClient').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#qb_cls_ref_class_names a').addClass('descendingClassClient');
				$('#qb_cls_ref_created_ons a').addClass('descendingClassClient');
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
					<label >QB Associated Class Name</label>
					
					<select class="form-control qb_cls_ref_class_id" id="qb_cls_ref_class_id">
					<option value="">--- Select QB Associated Service Type Name ---</option>
					<?php if ($_smarty_tpl->tpl_vars['outputArray']->value){?>
						<?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['outputArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
							<option value="<?php echo $_smarty_tpl->tpl_vars['value']->value->Id;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value->Name;?>
</option>
					<?php } ?>
					<?php }?>
					</select>
				</div>
				<div class="form-group col-sm-3">
				   <label >Class Name</label>
				   <input type="text" class="form-control qb_cls_ref_class_name" id="qb_cls_ref_class_name" placeholder="">
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
               <div class="form-group" style="display:none;">
                  <div class="col-sm-6">
                     <label>Filter By</label>
                  </div>
                  <div class="col-sm-6">
					 <select class="form-control clientFilterBy" name="clientFilterBy">
						 <option value="1">--Select Filter--</option>
						 <option value="2">Created On</option>
						 <option value="3">Client</option>
						 <?php if ($_SESSION['sessionClientId']==@MARRIOTT_CLIENT_ID){?>
							 
						 <?php }?>
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
			   <div class="form-group divisionFilter" style="display:none;">
                     <select class="form-control divisionFilterBy" id="divisionFilterBy" name="divisionFilterBy">
						 <?php if ($_smarty_tpl->tpl_vars['divisionArray']->value){?>
							 <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['divisionArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
							 <option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['division_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['division_code'];?>
</option>
							 <?php } ?>
						 <?php }?>
                     </select>
                </div>
            </div>
			
            <div class="col-sm-5">
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewClient"><i class="fa fa-plus"></i> Add New Class</button>
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
							<h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_DELETE_QB_CLASS;?>
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