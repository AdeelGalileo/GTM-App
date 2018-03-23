{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Alerts{/block}
{block name=header}
<script type="text/javascript">
   var strClassAlert;
   var alertFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdAlert = 0;
   var sortIdAlert = 0;
   $(document).ready(function(){
   
   loadAlertList(50,orderIdAlert,sortIdAlert);
   	
   $('body').on('click', '.descendingClassAlert', function(){
   orderIdAlert = $(this).attr('id');
   sortIdAlert = 2;
   pageNo = $('#pageDropDownValue').val();
   strClassAlert = 'descendingClassAlert';
   var recCountValues = $('#alertPageListing').val();
   loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
    });
   
    $('body').on('click', '.ascendingClassAlert', function(){
   orderIdAlert = $(this).attr('id');
   sortIdAlert = 1;
   pageNo = $('#pageDropDownValue').val();
   strClassAlert = 'ascendingClassAlert';
   var recCountValues = $('#alertPageListing').val();
   loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
    });
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#alertPageListing').val();
          loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
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
          var recCountValues = $('#alertPageListing').val();
          loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#alertPageListing').val();
          loadAlertList(recCountValues,orderIdAlert,sortIdAlert);
      });
      $('body').on('change', '#alertPageListing', function(){
          var recCount = $(this).val();
          $('#alertPageListingNew').val(recCount);
          pageNo = 0;
          loadAlertList(recCount,orderIdAlert,sortIdAlert);
      });
      $('body').on('change', '#alertPageListingNew', function(){
          var recCount = $(this).val();
          $('#alertPageListing').val(recCount);
          pageNo = 0;
          loadAlertList(recCount,orderIdAlert,sortIdAlert);
      });	
   
   
   
   
    $('body').on('change', '.notification_module_id', function(){
   	var modulesIp = $( this ).val();
   	if(modulesIp==''){
   			return false;
   	 }
	 
	 if(modulesIp==5){
		$(".userNotification").hide();
		$(".userNotificationEmail").hide();
		$(".userNotificationForConsultant").show();
	 }
	 else{
		 $(".userNotification").show();
		 $(".userNotificationEmail").show();
		 $(".userNotificationForConsultant").hide();
		 
	 }
	 
   	 $.ajax({
   			url: 'ajax/modules.php?rand='+Math.random(),
   			dataType: 'json',
   			 data: { getModuleByModuleId:1, modulesIp: modulesIp },
   			 success: function(response) {
   					checkResponseRedirect(response);
					$('.module_desc').html("");
   					$('.module_desc').html(response.message.modules_desc);
   				}	
   	   });
   });
   

   
 
   
   });
   
   function loadAlertList(recCountValue,orderId="",sortId="",startDate="",endDate="",alertFilterBy=""){
   
   var page = pageNo ? pageNo : 1;
   
      var recordCount = recCountValue ? recCountValue : 50;
      $('#alertPageListing').val(recordCount);
      $('#alertPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
   
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'alertNotificationList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,alertFilterBy:alertFilterBy },
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
   		
			   if(strClassAlert && strClassAlert!=''){
				  if(strClassAlert=='ascendingClassAlert'){
					  $('#'+orderId+'s a').removeClass('ascendingClassAlert');
					  $('#'+orderId+'s a').addClass('descendingClassAlert').prepend('<i class="fa fa-caret-up gray font13"></i>');
					  $('#overAllAlert th a').addClass('descendingClassAlert');
				  } else if(strClassAlert=='descendingClassAlert'){
					  $('#'+orderId+'s a').removeClass('descendingClassAlert');
					  $('#'+orderId+'s a').addClass('ascendingClassAlert').prepend('<i class="fa fa-caret-down gray font13"></i>');
					 $('#overAllAlert th a').addClass('ascendingClassAlert');
				  }
				} 
				else {
					$('#alert_notification_created_ons a').addClass('descendingClassAlert').prepend('<i class="fa fa-caret-up gray font13"></i>');
					$('#modules_names a').addClass('descendingClassAlert');
					$('#alert_notification_messages a').addClass('descendingClassAlert');
					$('#user_fnames a').addClass('descendingClassAlert');
					$('#user_lnames a').addClass('descendingClassAlert');
				}
          }
      });	 
   }	
</script> 
{/block}
{block name=content}

<div class="row">
   <div class="col-sm-12">
      <div class="box box-primary">
         <div class="box-header ">
         </div>
       
         <!-- /.box-header -->
         <div class="box-body">
            <div id="listingTabs"></div>
         </div>
        
      </div>
      <!-- /.box -->
   </div>
   <!-- /.col -->
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