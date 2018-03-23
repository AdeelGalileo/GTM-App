<?php /* Smarty version Smarty-3.1.11, created on 2018-02-28 11:43:31
         compiled from "/home/galileotechmedia/public_html/app/templates/qbClientToken.tpl" */ ?>
<?php /*%%SmartyHeaderCode:17049528375a96dc33c9d409-80052439%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a490c9d765c1f1bdeead61a9fbf8a1742c42b4d3' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/qbClientToken.tpl',
      1 => 1519124490,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '17049528375a96dc33c9d409-80052439',
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
  'unifunc' => 'content_5a96dc33cdcfc4_96421431',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a96dc33cdcfc4_96421431')) {function content_5a96dc33cdcfc4_96421431($_smarty_tpl) {?><!DOCTYPE html>
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
		
		
	    loadClientQbTokenList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
	   
	     $('body').on('click', '.descendingClassClient', function(){
			orderIdClient = $(this).attr('id');
			sortIdClient = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassClients = 'descendingClassClient';
			var recCountValues = $('#clientPageListing').val();
			loadClientQbTokenList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
		});
   
		$('body').on('click', '.ascendingClassClient', function(){
			orderIdClient = $(this).attr('id');
			sortIdClient = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassClients = 'ascendingClassClient';
			var recCountValues = $('#clientPageListing').val();
			loadClientQbTokenList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
          loadClientQbTokenList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
          loadClientQbTokenList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
          loadClientQbTokenList(recCountValues,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
      });
      $('body').on('change', '#clientPageListing', function(){
          var recCount = $(this).val();
          $('#clientPageListingNew').val(recCount);
          pageNo = 0;
		  loadClientQbTokenList(recCount,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
      });
      $('body').on('change', '#clientPageListingNew', function(){
          var recCount = $(this).val();
          $('#clientPageListing').val(recCount);
          pageNo = 0;
		  loadClientQbTokenList(recCount,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
				loadClientQbTokenList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
			}
		});
		
		$( ".clientIdFilter" ).change(function() {
			 clientIdFilter =  $(this).val();
			 pageNo = 0;
			 loadClientQbTokenList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
		});
		
		
		
		$('body').on('click', '.applyBtn, .ranges', function(){
			clientFilterRangeVal =  $('.clientFilterRange').val();
			if(clientFilterRangeVal.length > 0){
				clientFilterRangeVal=clientFilterRangeVal.split('-');
				startDateParam = clientFilterRangeVal[0].trim();
				endDateParam = clientFilterRangeVal[1].trim();
				loadClientQbTokenList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
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
				url: 'ajax/qbClientToken.php?rand='+Math.random(),
				data : { classQbRefDelete: 1, classQbRefDeleteId:fieldId },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmDelete');
					showMessage(response.message);
					loadClientQbTokenList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
				}
			});
		});
		
		$('body').on('click', '.cancelClientDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		
		
		$('body').on('click', '.addClientSave', function(){
   	
			var qb_client_token_client_id = $('.qb_client_token_client_id').val();
			var qb_client_token_client_secret = $('.qb_client_token_client_secret').val();
			var qb_client_token_qbo_real_id = $('.qb_client_token_qbo_real_id').val();
			var qb_client_token_base_url = $('.qb_client_token_base_url').val();
			var qb_client_token_refresh_token = $('.qb_client_token_refresh_token').val();
			var qb_client_token_access_token = $('.qb_client_token_access_token').val();
			var clientQbTokenUpateId = $('.clientQbTokenUpateId').val();
			
			
			 if(qb_client_token_client_id==''){
				  showMessage('<?php echo @ERR_QB_CLIENT_TOKEN_CLIENT_ID;?>
');
				  $('.qb_client_token_client_id').focus();
				  return false;
			 }
			 if(qb_client_token_client_secret==''){
				  showMessage('<?php echo @ERR_QB_CLIENT_TOKEN_CLIENT_SECRET;?>
');
				  $('.qb_client_token_client_secret').focus();
				  return false;
			 }
			 if(qb_client_token_qbo_real_id==''){
				  showMessage('<?php echo @ERR_QB_CLIENT_TOKEN_CLIENT_REAL_ID;?>
');
				  $('.qb_client_token_qbo_real_id').focus();
				  return false;
			 }
			 if(qb_client_token_base_url==''){
				  showMessage('<?php echo @ERR_QB_CLIENT_TOKEN_CLIENT_BASE_URL;?>
');
				  $('.qb_client_token_base_url').focus();
				  return false;
			 }
			 if(qb_client_token_refresh_token==''){
				  showMessage('<?php echo @ERR_QB_CLIENT_TOKEN_REFRESH_TOKEN;?>
');
				  $('.qb_client_token_refresh_token').focus();
				  return false;
			 }
			 if(qb_client_token_access_token==''){
				  showMessage('<?php echo @ERR_QB_CLIENT_TOKEN_ACCESS_TOKEN;?>
');
				  $('.qb_client_token_access_token').focus();
				  return false;
			 }
			 
			actionOperand = 2;
		   
			$.ajax({
				url: 'ajax/qbClientToken.php?rand='+Math.random(),
				type: 'post',
				dataType: 'json',
				data: { actionOperand: actionOperand,  qb_client_token_client_secret: qb_client_token_client_secret, qb_client_token_client_id: qb_client_token_client_id, qb_client_token_qbo_real_id: qb_client_token_qbo_real_id,qb_client_token_base_url: qb_client_token_base_url,qb_client_token_refresh_token: qb_client_token_refresh_token,qb_client_token_access_token: qb_client_token_access_token, clientQbTokenUpateId:  clientQbTokenUpateId},
				success: function(response) {
					checkResponseRedirect(response);
					showMessage(response.message);
					$(".addClient").hide();
					$(".updateClient").hide();
					loadClientQbTokenList(50,orderIdClient,sortIdClient,startDateParam,endDateParam,clientFilterBy,clientIdFilter);
				}		
			});
            
      });
		
	  $('body').on('click', '.clientUpdateAction', function(){
		$(".addClient").hide();
		$(".updateClient").show();
		var clientQbTokenUpateId = $(this).attr('id').split('_')[1];
	   
		$.ajax({
			url: 'getModuleInfo.php?rand='+Math.random(),
			type:'post',
			dataType: 'json',
			data : { module: 'qbClientTokenUpdate', clientQbTokenUpateId: clientQbTokenUpateId },
				  success: function(response) {
					checkResponseRedirect(response);
					$('.updateClient').html("");
					$('.updateClient').html(response.message.content);
				  }
		});
	});	
		
		
  });
   
   function loadClientQbTokenList(recCountValue,orderId="",sortId="",startDate="",endDate="",clientFilterBy="",clientIdFilter=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#clientPageListing').val(recordCount);
      $('#clientPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'qbClientTokenList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,clientFilterBy:clientFilterBy, clientIdFilter: clientIdFilter },
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
				$('#qb_client_token_client_ids a').addClass('descendingClassClient').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#qb_client_token_client_secrets a').addClass('descendingClassClient');
				$('#qb_client_token_created_ons a').addClass('descendingClassClient');
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
<div class="updateClient"></div>

<div class="row">
   <div class="col-sm-12">
      <div class="box box-primary">
         <!-- /.box-header -->
         <div class="box-body">
            <div id="listingTabs"></div>
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