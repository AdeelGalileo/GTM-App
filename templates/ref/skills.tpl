{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Skills{/block}
{block name=header}
<style>
.ajax-upload-dragdrop{ width:auto !important;}
</style>
<script type="text/javascript">
   var strClassSkills;
   var skillFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdSkill = 0;
   var sortIdSkill = 0;
   var userIdFilter = 0;
   
  $(document).ready(function(){
  
		$(".cons_service_type_id option[value=6]").remove();
		
	    loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,userIdFilter);
	   
	     $('body').on('click', '.descendingClassSkill', function(){
			orderIdSkill = $(this).attr('id');
			sortIdSkill = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassSkills = 'descendingClassSkill';
			var recCountValues = $('#skillPageListing').val();
			loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,userIdFilter);
		});
   
		$('body').on('click', '.ascendingClassSkill', function(){
			orderIdSkill = $(this).attr('id');
			sortIdSkill = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassSkills = 'ascendingClassSkill';
			var recCountValues = $('#skillPageListing').val();
			loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,userIdFilter);
		});
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#skillPageListing').val();
          loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,userIdFilter);
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
          var recCountValues = $('#skillPageListing').val();
          loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,userIdFilter);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#skillPageListing').val();
          loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,userIdFilter);
      });
      $('body').on('change', '#skillPageListing', function(){
          var recCount = $(this).val();
          $('#skillPageListingNew').val(recCount);
          pageNo = 0;
		  loadSkillList(recCount,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,userIdFilter);
      });
      $('body').on('change', '#skillPageListingNew', function(){
          var recCount = $(this).val();
          $('#skillPageListing').val(recCount);
          pageNo = 0;
		  loadSkillList(recCount,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,userIdFilter);
      });	
	   
	$('.skillFilterRangeStatus').hide();
	$('.searchByWriter').chosen({ width:"100%"});
	$('.cons_user_id').chosen({ width:"100%"});
	$(".cons_service_type_id").chosen({ width:"100%"});
	$(".skillFilterSkillBy").chosen({ width:"100%"});
   
   $( ".skillFilterBy" ).change(function() {
		skillFilterBy =  $(this).val();
		if(skillFilterBy == 2){
			$('.skillFilterRangeStatus').show();
			$('.skillFilterUser').hide();
			$(".skillFilterSkill .allFilterTop").removeClass("allFilterTopStyle");
			$('.skillFilterSkill').hide();
		}
		else{
			if(skillFilterBy == 3){
				$('.skillFilterRangeStatus').hide();
				$('.skillFilterUser').show();
				$(".skillFilterSkill .allFilterTop").removeClass("allFilterTopStyle");
				$('.skillFilterSkill').hide();
			}
			else if(skillFilterBy == 5){
				$('.skillFilterRangeStatus').hide();
				$('.skillFilterUser').hide();
				$('.skillFilterSkill').show();
				$(".skillFilterSkill .allFilterTop").removeClass("allFilterTopStyle");
			}
			else if(skillFilterBy == 4){
				$('.skillFilterUser').show();
				$('.skillFilterSkill').show();
				$(".skillFilterSkill .allFilterTop").addClass("allFilterTopStyle");
			}
			
			else
			{	
				$(".skillFilterSkill .allFilterTop").removeClass("allFilterTopStyle");
				$('.skillFilterRangeStatus').hide();
				$('.skillFilterUser').hide();
			}
		}
		
		if(skillFilterBy > 1){
			$('.resetFilters').show();
		}
	
		skillFilterRangeVal =  $('.skillFilterRange').val();
		if(skillFilterRangeVal.length > 0){
			skillFilterRangeVal=skillFilterRangeVal.split('-');
			startDateParam = skillFilterRangeVal[0].trim();
			endDateParam = skillFilterRangeVal[1].trim();
			loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy);
		}
   });
   
    $(".searchByWriter").change(function() {
		searchByWriter =  $(this).val();
		loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter);
    });
	
	$('body').on('change', '.roleFilterBy', function(){
		var roleId = $(this).val();
		
		if(roleId == ""){
			return;
		}
		loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,"",roleId);
    });
	
	$('body').on('click', '.resetFiltersAction', function(){
		location.reload();
    });	
   
	 $('body').on('click', '.applyBtn, .ranges', function(){
		skillFilterRangeVal =  $('.skillFilterRange').val();
		if(skillFilterRangeVal.length > 0){
			skillFilterRangeVal=skillFilterRangeVal.split('-');
			startDateParam = skillFilterRangeVal[0].trim();
			endDateParam = skillFilterRangeVal[1].trim();
			loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy);
		}
	 });
		
	 $('body').on('click', '.addNewSkill', function(){
			$(".addSkill").toggle();
			$(".updateSkill").hide();
	 });	
   
	   $('body').on('click', '.skillCancel', function(){
			location.reload();
	   });	
   
	   $('body').on('click', '.skillUpdateCancel', function(){
			location.reload();
	   });	

		$('body').on('click', '.skillDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
		});
		
		$('body').on('click', '.okSkillDelButton', function(){
			fieldId = $('#delFieldId').val();
			$.ajax({
				type : 'post',
				url: 'ajax/skills.php?rand='+Math.random(),
				data : { skillDelete: 1, skillDeleteId:fieldId },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmDelete');
					showMessage(response.message);
					loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy);
				}
			});
		});
		
		$('body').on('click', '.cancelSkillDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		
		
		$('body').on('click', '.addSkillSave', function(){
			
			var cons_user_id = $('.cons_user_id').val();
			var cons_service_type_id = $('.cons_service_type_id').val();
			var skillUpdateId = $('.skillUpdateId').val();
			
			
			if(cons_user_id==''){
				  showMessage('{$smarty.const.ERR_FORM_USER_ID}');
				  $('.cons_user_id').focus();
				  return false;
			 }
		   
			if(cons_service_type_id==''){
				  showMessage('{$smarty.const.ERR_SKILL_TYPE}');
				  $('.cons_service_type_id').focus();
				  return false;
			 }
			 
			 	
		   if(skillUpdateId > 0){
				actionOperand = 2;
			}
			else{
				actionOperand = 1;
			}
		   
			$.ajax({
				url: 'ajax/skills.php?rand='+Math.random(),
				type: 'post',
				dataType: 'json',
				data: { actionOperand: actionOperand, cons_user_id: cons_user_id, cons_service_type_id: cons_service_type_id, skillUpdateId: skillUpdateId},
				success: function(response) {
					checkResponseRedirect(response);
					showMessage(response.message);
					$(".addSkill").hide();
					$(".updateSkill").hide();
					loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy);
				}		
			});
            
      });
		
	  $('body').on('click', '.skillUpdateAction', function(){
		$(".addSkill").hide();
		$(".updateSkill").show();
		var skillUpateId = $(this).attr('id').split('_')[1];
	   
		$.ajax({
			url: 'getModuleInfo.php?rand='+Math.random(),
			type:'post',
			dataType: 'json',
			data : { module: 'skillUpdate', skillUpateId: skillUpateId },
				  success: function(response) {
					checkResponseRedirect(response);
					$('.updateSkill').html("");
					$('.updateSkill').html(response.message.content);
				  }
		});
	});	
	
	
  });
   
   
   function loadSkillList(recCountValue,orderId="",sortId="",startDate="",endDate="",skillFilterBy="",writerId="",roleId=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#skillPageListing').val(recordCount);
      $('#skillPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'skillList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,skillFilterBy:skillFilterBy, writerId: writerId, filterRoleId:roleId },
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
   		
   		
   		if(strClassSkills && strClassSkills!=''){
			  if(strClassSkills=='ascendingClassSkill'){
				  $('#'+orderId+'s a').removeClass('ascendingClassSkill');
				  $('#'+orderId+'s a').addClass('descendingClassSkill').prepend('<i class="fa fa-caret-up gray font13"></i>');
				  $('#overAllSkill th a').addClass('descendingClassSkill');
			  } else if(strClassSkills=='descendingClassSkill'){
				  $('#'+orderId+'s a').removeClass('descendingClassSkill');
				  $('#'+orderId+'s a').addClass('ascendingClassSkill').prepend('<i class="fa fa-caret-down gray font13"></i>');
				  $('#overAllSkill th a').addClass('ascendingClassSkill');
			  }
			  } else {
				$('#user_fnames a').addClass('descendingClassSkill').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#user_lnames a').addClass('descendingClassSkill');
				$('#user_role_names a').addClass('descendingClassSkill');
				$('#cons_created_ons a').addClass('descendingClassSkill');
			 }
          }
      });	 
   }	
</script>

{/block}
{block name=content}
<div class="updateSkill"></div>
<div class="row addSkill" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
			   <div class="form-group col-sm-4">
				   <label >Consultant</label>
				   <select class="form-control cons_user_id" id="cons_user_id">
					  <option value="">--- Select Consultant ---</option>
					  {if $userArray}
					  {foreach $userArray as $key=> $value}
						<option value="{$value.user_id}">{$value.user_fname} {$value.user_lname}</option>
					  {/foreach}
					  {/if}
				   </select>
				</div>
				<div class="form-group col-sm-6">
                  <label >Skills</label>
                  <select class="form-control cons_service_type_id" multiple data-placeholder="Choose a Skills" id="cons_service_type_id">
                     <option value="">--- Select Skills ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
                     <option value="{$value.serv_type_id}">{$value.serv_type_name}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
			 </div>
			
			
            <button type="button" class="btn btn-default pull-right margin skillCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addSkillSave">Done</button>
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
                     <select class="form-control skillFilterBy" name="skillFilterBy">
                     {$skillArray}
                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-4">
               <div class="form-group skillFilterRangeStatus" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Date Range</label>
                  </div>
                  <div class="col-sm-6">
                     <div class="input-group">
                        <div class="input-group-addon">
                           <i class="fa fa-calendar"></i>
                        </div>
                        <input type="text" readonly name="skillFilterRange" class="form-control pull-right  skillFilterRange" style="width:175px !important;">
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
			  <div class="form-group skillFilterSkill" style="display:none;">
					<div class="col-sm-6 allFilterTop allFilterTopStyle">
                     <label>Select Skill</label>
                  </div>
				   <div class="form-group col-sm-6 allFilterTop allFilterTopStyle">
					  <select class="form-control skillFilterSkillBy"  id="skillFilterSkillBy">
						 <option value="">--- Select Skill ---</option>
						 {if $serviceTypeClientArray}
						 {foreach $serviceTypeClientArray as $key=> $value}
						 <option value="{$value.serv_type_id}">{$value.serv_type_name}</option>
						 {/foreach}
						 {/if}
					  </select>
				   </div>
			   </div>
			   
            </div>
			<div class="col-sm-2">
				<div class="form-group resetFilters" style="display:none;">
						<button type="button" class="btn btn-primary pull-right  resetFiltersAction"><i class="fa fa-minus"></i> Reset Filters</button>
				</div>
			</div>
            <div class="col-sm-3">
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewSkill"><i class="fa fa-plus"></i> Add New Skill</button>
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
			{*<button type="button" class="btn btn-primary pull-right m-r-10 addNewSkill"><i class="fa fa-plus"></i> Add New Skill</button>*}
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
							<h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_DELETE_SKILL}</h5>
							<table border="0" cellspacing="0" cellpadding="5" align="center">
								<tr>
									<td class="p-t-10">
										<a href="javascript:void(0);" class="btn btn-primary M2 okSkillDelButton">{$smarty.const.LBL_YES}</a>
										<a href="javascript:void(0);" class="btn btn-default M2 cancelSkillDelButton">{$smarty.const.LBL_NO}</a>
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

    $('.skillFilterRange').daterangepicker({
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