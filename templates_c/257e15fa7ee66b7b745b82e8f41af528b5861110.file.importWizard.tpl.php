<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:50:48
         compiled from "/home/galileotechmedia/public_html/app/templates/importWizard.tpl" */ ?>
<?php /*%%SmartyHeaderCode:19217131795a959a78a99a87-75073392%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '257e15fa7ee66b7b745b82e8f41af528b5861110' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/importWizard.tpl',
      1 => 1519124483,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '19217131795a959a78a99a87-75073392',
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
  'unifunc' => 'content_5a959a78ad0ed2_91079110',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959a78ad0ed2_91079110')) {function content_5a959a78ad0ed2_91079110($_smarty_tpl) {?><!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title><?php echo $_smarty_tpl->tpl_vars['SiteTitle']->value;?>
 - Import Wizard</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="description" content=""><?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

      
<style>
   .color-palette {
   height: 35px;
   line-height: 35px;
   text-align: center;
   }
   .color-palette-set {
   margin-bottom: 15px;
   }
   .color-palette span {
   display: none;
   font-size: 12px;
   }
   .color-palette:hover span {
   display: block;
   }
   .color-palette-box h4 {
   position: absolute;
   top: 100%;
   left: 25px;
   margin-top: -40px;
   color: rgba(255, 255, 255, 0.8);
   font-size: 12px;
   display: block;
   z-index: 7;
   }
   .ajax-upload-dragdrop{ width:auto !important;}
</style>
<script type="text/javascript">
   var taskKeywordDate;
   var importType;
   
   $(function () {
     //Initialize Select2 Elements
     $('.select2').select2()
   
     //Datemask dd/mm/yyyy
     $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
     //Datemask2 mm/dd/yyyy
     $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
     //Money Euro
     $('[data-mask]').inputmask()
   
     //Date range picker
     $('#reservation').daterangepicker()
     //Date range picker with time picker
     $('#reservationtime').daterangepicker({ timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A' })
     //Date range as a button
     $('#daterange-btn').daterangepicker(
       {
         ranges   : {
           'Today'       : [moment(), moment()],
           'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month'  : [moment().startOf('month'), moment().endOf('month')],
           'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
         },
         startDate: moment().subtract(29, 'days'),
         endDate  : moment()
       },
       function (start, end) {
         $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
       }
     )
   
   
   
     //iCheck for checkbox and radio inputs
     $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
       checkboxClass: 'icheckbox_minimal-blue',
       radioClass   : 'iradio_minimal-blue'
     })
     //Red color scheme for iCheck
     $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
       checkboxClass: 'icheckbox_minimal-red',
       radioClass   : 'iradio_minimal-red'
     })
     //Flat red color scheme for iCheck
     $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
       checkboxClass: 'icheckbox_flat-green',
       radioClass   : 'iradio_flat-green'
     })
   
     //Colorpicker
     $('.my-colorpicker1').colorpicker()
     //color picker with addon
     $('.my-colorpicker2').colorpicker()
   
     //Timepicker
     $('.timepicker').timepicker({
       showInputs: false
     })
   });
   
     $(document).ready(function(){
        
		
		$.each($('.fieldMap'),function(){
			if(!$("#"+this.id+"_chosen").length){
				$('#'+this.id).chosen({ width:"100%"});
			}
		});
		
		 //Date picker
	   $('#datepicker').datepicker({
			autoclose: true,
			format: "mm-yyyy",
			viewMode: "months", 
			minViewMode: "months"
		});
			
	   $('.saveFileFolder').click(function(event) {
			importType = $('.importType').val();
			taskKeywordDateVal = $('.taskKeywordDate').val();
			var dateTypeVar = $('#datepicker').datepicker('getDate');
			taskKeywordDate = $.datepicker.formatDate('yy-mm-dd', new Date(dateTypeVar));
			
			if(importType=='') {
				 showMessage('<?php echo @ERR_IMPORT_TYPE;?>
');
				 $('.importType').focus();
				 event.preventDefault();
				 return false;
			}
			if(taskKeywordDateVal=='') {
				 showMessage('<?php echo @ERR_MONTH_YEAR;?>
');
				 $('.taskKeywordDate').focus();
				 event.preventDefault();
				 return false;
			} 	
			var hasFile = document.getElementsByName('csvFile')[0].files.length;
			if(!hasFile){
				 showMessage("<?php echo @MSG_IMPORT_CHOOSE_FILE;?>
");
				 event.preventDefault();
				 return false;
			}
			
			var newData = "NEW DATA : I am importing data into this folder  for the first time";
			var appendingData = "APPENDING DATA: Append to this folder  by  updating existing and adding new records";
			
			$('.newData').text(newData);
			$('.appendingData').text(appendingData);
			$('.importWizardTabs li.active').removeClass('active');
			$('.importWizardTabs li.tab_2').addClass('active');
			$('#tab_1').hide();
			$('#tab_2').show();
		 
			
		});		
	   
	   $('.saveImportType').click(function(event) {
			$('.importWizardTabs li.active').removeClass('active');
			$('.importWizardTabs li.tab_3').addClass('active');
			$('#tab_2').hide();
			$('#tab_3').show();
			importOption = $('#importOpt').val();
			importType = $('.importType').val();
			unqiueField = $('#unqiueField').val();
			
			$.ajax({
				type : 'post',
				url: 'getModuleInfo.php?rand='+Math.random(),
				data : {  module: 'importWizard', importOption:importOption, importKeywordDate:taskKeywordDate, importType: importType, unqiueField: unqiueField},
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					$('.mappingTab').html("");
					$('.mappingTab').html(response.message.content);
				}
			});
		});	
		
		
	$('.minimal').on('ifChanged', function(event){
		var impId = parseInt($(this).attr('id').split('_')[1], 10);
		$('#importOpt').val(impId);
		if(impId > 0){
			$('#unique-field').show();
		} else {
			$('#unique-field').hide();
		}
	});
			
  });
   
   
</script>
<script type="text/javascript">
   
   $(document).ready(function(){
   var settings = {
   	url: "importWizard.php",
   	method: "POST",
             allowedTypes: "csv",
             fileName: "csvFile",
             multiple: false,
             dataType: "json",
             showStatusAfterSuccess: false,
   	showStatusAfterSuccess:false,
   	onSuccess:function(files,data,xhr){
   		$('#fileUpload').html('<span class="fa fa-check-circle-o m-r-5"></span><?php echo @MSG_FILE_UPLOAD_SUCCESS;?>
');
   	},
   	onError: function(files,status,errMsg){
   		$("#status").html("<font color='red'>Upload is Failed</font>");
   	}
   }
   $("#mulitplefileuploader").uploadFile(settings);
   });
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
<div class="row">
   <div class="col-md-12">
      <!-- Custom Tabs -->
      <div class="nav-tabs-custom">
         <ul class="nav nav-tabs importWizardTabs">
            <li class="active tab_1"><a href="javascript:void(0);" data-toggle="tab" class="fileTab">File & Folder Selection</a></li>
            <li class="tab_2"><a href="javascript:void(0);" data-toggle="tab" class="importTypeTab">Import Type Selection</a></li>
            <li class="tab_3"><a href="javascript:void(0);" data-toggle="tab" class="mapTab">Map Field</a></li>
         </ul>
         <div class="tab-content">
            <div class="tab-pane active" id="tab_1">
               <div class="box-header with-border">
                  <h3 class="box-title">FILE AND FOLDER SELECTION</h3>
               </div>
               <!-- /.box-header -->
               <!-- form start -->
               <form name="frmImportLead" id="frmImportLead" action="<?php echo @ROOT_HTTP_PATH;?>
/importWizard.php" method="post" enctype="multipart/form-data">
                  <div class="box-body">
                     <div class="row">
                        <div class="col-md-6">
                           <div class="form-group">
                              <label for="importAs">Import As</label>
                              <select name="importType" class="form-control importType" id="importType">
                                 <option value="<?php echo @IMPORT_TYPE_KEYWORD;?>
">Keyword</option>
                              </select>
                           </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-md-6">
                           <div class="form-group">
                              <label for="monthAndYear">Month & Year</label>
                              <div class="input-group date">
                                 <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                 </div>
                                 <input type="text" name="taskKeywordDate" class="form-control pull-right taskKeywordDate"  id="datepicker">
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-md-6">
                           <div class="form-group">
                              <label for="uploadCsvFile">Upload CSV File</label>
                              <span id="mulitplefileuploader">
                              <a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload CSV</a>
                              </span>
                              <span id="fileUpload" class="font14 bold blue"></span>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!-- /.box-body -->
                  <div class="box-footer">
                     <button type="button" class="btn btn-primary pull-right margin saveFileFolder">Next</button>
                     <a href="<?php echo @ROOT_HTTP_PATH;?>
/importWizard.php?sampleFile=Keyword_Delivery_Schedule.csv" title="Download Sample file for import" class="pull-left margin">Download Sample CSV 
                     <i class="fa fa-download"></i><span></span>
                     </a>
                  </div>
               </form>
            </div>
            <!-- /.tab-pane -->
            <div class="tab-pane" id="tab_2">
               <div class="box-header with-border">
                  <h3 class="box-title">IMPORT TYPE SELECTION</h3>
               </div>
               <!-- /.box-header -->
               <!-- form start -->
              
				<input type="hidden" name="importOpt" id="importOpt" value="0"  />
				
                  <div class="box-body">
                     <div class="row">
                        <div class="col-md-6">
                           <div class="form-group">
                              <label>
                              <input type="radio" name="importOption" class="minimal importOption" id="typeSel_0" checked value="1">&nbsp;&nbsp; <span class="newData"></span>
                              </label>
                           </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-md-6">
                           <div class="form-group">
                              <label>
                              <input type="radio" name="importOption" class="minimal importOption" id="typeSel_2" value="2">&nbsp;&nbsp; <span class="appendingData"></span>
                              </label>
                           </div>
                        </div>
                     </div>
					 <div class="row">
                        <div class="col-md-6">
                           <div class="form-group" id="unique-field" style="display:none;">
								 <select class="form-control fieldMap" name="unqiueField" id="unqiueField" title="Unique Field">
								 <option value="">Select Field</option>
								   <?php echo $_smarty_tpl->tpl_vars['fieldOptions']->value;?>

								</select>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!-- /.box-body -->
                  <div class="box-footer">
                     <button type="button" class="btn btn-primary pull-right margin saveImportType">Next</button>
                  </div>
             
            </div>
            <!-- /.tab-pane -->
            <div class="tab-pane" id="tab_3">
				<div class="mappingTab"> </div>
            </div>
            <!-- /.tab-pane -->
         </div>
         <!-- /.tab-content -->
      </div>
      <!-- nav-tabs-custom -->
   </div>
   <!-- /.col -->
</div>

</section></div><?php echo $_smarty_tpl->getSubTemplate ("layout/body_footer_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	</div>
   </body>
</html><?php }} ?>