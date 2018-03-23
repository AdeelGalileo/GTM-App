{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Invoice{/block}
{block name=header}
<style>

</style>
<script type="text/javascript">
   var strClassTaskInvoice;
   var strClassTaskOutInvoice;
   var taskKeyFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdTaskInvoice = 0;
   var sortIdTaskInvoice = 0;
   var orderIdTaskOutInvoice = 0;
   var sortIdTaskOutInvoice = 0;
   var writerIdFilter = 0;
   var divisionId = 0;
   var searchByServiceType = 0;
   var searchByLocationCode=0;
   var invNoFilter=0;
   var currentTabActive = "tabId_3";
   var isComplete = 0;
   $(document).ready(function(){
   
   
     loadInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
    
	
	$('.writerIdFilter').chosen({ width:"100%"});
	$('#divisionFilterBy').chosen({ width:"100%"});
	$('#searchByServiceType').chosen({ width:"100%"});
	$('#searchByLocationCode').chosen({ width:"100%"});
	$('.taskKeyFilterRangeStatus').hide();
   
   
	$('body').on('change', '.taskKeyFilterBy', function(){
		taskKeyFilterBy =  $(this).val();
	    if(taskKeyFilterBy == 2){
			$('.taskKeyFilterRangeStatus').show();
			$('.taskKeyFilterUser').hide();
			$('.divisionFilter').hide();
			$('.serviceFilterLocationCode').hide();
			$('.serviceFilterServiceType').hide();
			$('.qbIdFilter').hide();
			$('.moveMultipleQb').hide();
		}
	   else if(taskKeyFilterBy == 4){
			$('.taskKeyFilterRangeStatus').hide();
			$('.divisionFilter').show();
			$('.taskKeyFilterUser').hide();
			$('.serviceFilterLocationCode').hide();
			$('.serviceFilterServiceType').hide();
			$('.qbIdFilter').hide();
			
			if(divisionId > 0){
				$('.moveMultipleQb').show();
			}
			else{
				$('.moveMultipleQb').hide();
			}
	   }
	   else if(taskKeyFilterBy == 5){
			$('.taskKeyFilterRangeStatus').hide();
			$('.divisionFilter').hide();
			$('.serviceFilterLocationCode').show();
			$('.taskKeyFilterUser').hide();
			$('.serviceFilterServiceType').hide();
			$('.qbIdFilter').hide();
			$('.moveMultipleQb').hide();

	   }
	   else if(taskKeyFilterBy == 6){
		    $('.serviceFilterServiceType').show();
			$('.serviceFilterLocationCode').hide();
			$('.taskKeyFilterRangeStatus').hide();
			$('.divisionFilter').hide();
			$('.taskKeyFilterUser').hide();
			$('.qbIdFilter').hide();
			$('.moveMultipleQb').hide();
	   }
	   else if(taskKeyFilterBy == 7){
		    $('.qbIdFilter').show();
		    $('.serviceFilterServiceType').hide();
			$('.serviceFilterLocationCode').hide();
			$('.taskKeyFilterRangeStatus').hide();
			$('.divisionFilter').hide();
			$('.taskKeyFilterUser').hide();
			$('.moveMultipleQb').hide();
	   }
	   else{
		   if(taskKeyFilterBy == 3){
				$('.taskKeyFilterRangeStatus').hide();
				$('.serviceFilterLocationCode').hide();
				$('.taskKeyFilterUser').show();
				$('.divisionFilter').hide();
				$('.serviceFilterServiceType').hide();
				$('.qbIdFilter').hide();
				$('.moveMultipleQb').hide();
		    }
			else
			{
			   $('.taskKeyFilterRangeStatus').hide();
			   $('.serviceFilterLocationCode').hide();
			   $('.taskKeyFilterUser').hide();
			   $('.divisionFilter').hide();
			   $('.serviceFilterServiceType').hide();
			   $('.qbIdFilter').hide();
			   $('.moveMultipleQb').hide();
			}
		}
		
	   if(taskKeyFilterBy > 1){
			$('.resetFilters').show();
	   }
	   
		taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
		if(taskKeyFilterRangeVal.length > 0){
			taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
			startDateParam = taskKeyFilterRangeVal[0].trim();
			endDateParam = taskKeyFilterRangeVal[1].trim();
			loadInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
		}
   });	
   
    $('body').on('click', '.resetFiltersAction', function(){
		location.reload();
    });	
   
    $('body').on('change', '.divisionFilterBy', function(){
		divisionId = $( this ).val();
		
		pageNo = 0;
		if(currentTabActive == 'tabId_3'){
			loadInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
		}
		else{
			loadOutstandingInvoiceList(50,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId);
		}
		
    });
	
	
	$('body').on('change', '.writerIdFilter', function(){
		 writerIdFilter =  $(this).val();
		 pageNo = 0;
		 if(currentTabActive == 'tabId_3'){
			loadInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
		 }
		 else{
			loadOutstandingInvoiceList(50,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId);
		}
	});
	
	$('body').on('change', '.searchByServiceType', function(){
		 searchByServiceType =  $(this).val();
		 pageNo = 0;
		 if(currentTabActive == 'tabId_3'){
			loadInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
		 }
		 else{
			loadOutstandingInvoiceList(50,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
		}
	});
	
	$('body').on('change', '.searchByLocationCode', function(){
		 searchByLocationCode =  $(this).val();
		 pageNo = 0;
		  if(currentTabActive == 'tabId_3'){
			loadInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
		  }
		  else{
			loadOutstandingInvoiceList(50,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
		}
	});
	
	$('body').on('click', '.qbIdFilterBySearch', function(){
		invNoFilter = $('#qbIdFilterBy').val();
		if(invNoFilter == ''){
			return;
		}
		loadInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
	});
	
	$('body').on('click', '.applyBtn, .ranges', function(){
		taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
		if(taskKeyFilterRangeVal.length > 0){
			taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
			startDateParam = taskKeyFilterRangeVal[0].trim();
			endDateParam = taskKeyFilterRangeVal[1].trim();
			loadInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
		}
	});
	
   
   $('body').on('click', '.descendingClassTaskInvoice', function(){
	   orderIdTaskInvoice = $(this).attr('id');
	   sortIdTaskInvoice = 2;
	   pageNo = $('#pageDropDownValue').val();
	   strClassTaskInvoice = 'descendingClassTaskInvoice';
	   var recCountValues = $('#invoicePageListing').val();
	   loadInvoiceTaskList(recCountValues,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
   });
   
   $('body').on('click', '.ascendingClassTaskInvoice', function(){
	   orderIdTaskInvoice = $(this).attr('id');
	   sortIdTaskInvoice = 1;
	   pageNo = $('#pageDropDownValue').val();
	   strClassTaskInvoice = 'ascendingClassTaskInvoice';
	   var recCountValues = $('#invoicePageListing').val();
	   loadInvoiceTaskList(recCountValues,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
   });
   
   $('body').on('click', '.descendingClassTaskOutInvoice', function(){
	   orderIdTaskOutInvoice = $(this).attr('id');
	   sortIdTaskOutInvoice = 2;
	   pageNo = $('#pageDropDownValue').val();
	   strClassTaskOutInvoice = 'descendingClassTaskOutInvoice';
	   var recCountValues = $('#outInvoicePageListing').val();
	   loadOutstandingInvoiceList(recCountValues,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
   });
   
   $('body').on('click', '.ascendingClassTaskOutInvoice', function(){
	   orderIdTaskOutInvoice = $(this).attr('id');
	   sortIdTaskOutInvoice = 1;
	   pageNo = $('#pageDropDownValue').val();
	   strClassTaskOutInvoice = 'ascendingClassTaskOutInvoice';
	   var recCountValues = $('#outInvoicePageListing').val();
	   loadOutstandingInvoiceList(recCountValues,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
   });
   
   $('body').on('click', '#paginationInvoiceAuto .pagination-nav .rightArrowClass, #paginationInvoiceAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationInvoiceAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationInvoiceAuto .pageDropDown" ).val(pageNo);
          $( "#paginationInvoiceAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#invoicePageListing').val();
          loadInvoiceTaskList(recCountValues,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
      });
   
      $('body').on('click', '#paginationInvoiceAuto .pagination-nav .leftArrowClass, #paginationInvoiceAutoNew .pagination-nav .leftArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationInvoiceAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo-1;
          $( "#paginationInvoiceAuto .pageDropDown" ).val(pageNo);
          $( "#paginationInvoiceAutoNew .pageDropDown" ).val(pageNo);
          document.getElementById('currPageAutoInvoiceID').value = '';
          $('#currPageAutoInvoiceID').val(links);
          var recCountValues = $('#invoicePageListing').val();
          loadInvoiceTaskList(recCountValues,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
      });
   
      $('body').on('change', '#paginationInvoiceAuto .pagination-nav .pageDropDown, #paginationInvoiceAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoInvoiceID').value = '';
          $('#currPageAutoInvoiceID').val(links);
          var recCountValues = $('#invoicePageListing').val();
          loadInvoiceTaskList(recCountValues,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
      });
   
      $('body').on('change', '#invoicePageListing', function(){
          var recCount = $(this).val();
          $('#invoicePageListingNew').val(recCount);
          pageNo = 0;
		  loadInvoiceTaskList(recCount,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
      });
   
      $('body').on('change', '#invoicePageListingNew', function(){
          var recCount = $(this).val();
          $('#invoicePageListing').val(recCount);
          pageNo = 0;
		  loadInvoiceTaskList(recCount,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
      });	
   
   
   $('body').on('click', '#paginationOutInvoiceAuto .pagination-nav .rightArrowClass, #paginationOutInvoiceAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationOutInvoiceAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationOutInvoiceAuto .pageDropDown" ).val(pageNo);
          $( "#paginationOutInvoiceAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#outInvoicePageListing').val();
          loadOutstandingInvoiceList(recCountValues,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
      });
	  
      $('body').on('click', '#paginationOutInvoiceAuto .pagination-nav .leftArrowClass, #paginationOutInvoiceAutoNew .pagination-nav .leftArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationOutInvoiceAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo-1;
          $( "#paginationOutInvoiceAuto .pageDropDown" ).val(pageNo);
          $( "#paginationOutInvoiceAutoNew .pageDropDown" ).val(pageNo);
          document.getElementById('currPageAutoOutInvoiceID').value = '';
          $('#currPageAutoOutInvoiceID').val(links);
          var recCountValues = $('#outInvoicePageListing').val();
          loadOutstandingInvoiceList(recCountValues,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
      });
	  
      $('body').on('change', '#paginationOutInvoiceAuto .pagination-nav .pageDropDown, #paginationOutInvoiceAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoOutInvoiceID').value = '';
          $('#currPageAutoOutInvoiceID').val(links);
          var recCountValues = $('#outInvoicePageListing').val();
          loadOutstandingInvoiceList(recCountValues,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
      });
	  
      $('body').on('change', '#outInvoicePageListing', function(){
          var recCount = $(this).val();
          $('#outInvoicePageListingNew').val(recCount);
          pageNo = 0;
		  loadOutstandingInvoiceList(recCount,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
      });
	  
      $('body').on('change', '#outInvoicePageListingNew', function(){
          var recCount = $(this).val();
          $('#outInvoicePageListing').val(recCount);
          pageNo = 0;
		  loadOutstandingInvoiceList(recCount,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
      });	
    

   $(".taskKeyFilterBy").append('<option value=2>Invoice Date</option>');
   $(".taskKeyFilterBy").append('<option value=7>Qb Id</option>');
   
   $('.submittedInvoiceTab').click(function(event) {
	   $('.taskKeyFilterBy').prop('selectedIndex',0);
	   $(".taskKeyFilterBy option[value=2]").remove();
	   $(".taskKeyFilterBy option[value=7]").remove();
	   if(taskKeyFilterBy == 7){
		$('.qbIdFilter').show();
	   }
	   $(".taskKeyFilterBy").append('<option value=2>Invoice Date</option>');
	   $(".taskKeyFilterBy").append('<option value=7>Qb Id</option>');
	   $('.consultantTabs li.active').removeClass('active');
	   $('.consultantTabs li.tab_3').addClass('active');
	   $('#tab_3').show();
	   $('#tab_4').hide();
	   currentTabActive= "tabId_3";
	   pageNo = 0;
	   loadInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice);
   });	
   
   $('.outstandingInvoiceTab').click(function(event) {
	   $(".taskKeyFilterBy option[value=2]").remove();
	   $(".taskKeyFilterBy option[value=7]").remove();
	   $('.taskKeyFilterBy').prop('selectedIndex',0);
	   $('.qbIdFilter').hide();
	   $('.consultantTabs li.active').removeClass('active');
	   $('.consultantTabs li.tab_4').addClass('active');
	   $('#tab_3').hide();
	   $('#tab_4').show();
	   currentTabActive= "tabId_4";
	   pageNo = 0;
	   loadOutstandingInvoiceList(50,orderIdTaskOutInvoice,sortIdTaskOutInvoice);
   });	
   
   
   
   $('body').on('change', '.chkqbTransfer', function(){
			var leng = $(".chkqbTransfer:checked").length;
			 
			if(leng==0)
			{
				$( ".chkqbTransfer" ).removeAttr("disabled");
				return;
			}
			if($(this).is(":checked")) 
			{
				var checledvalue =$(this).attr('divisionType');
				$( ".chkqbTransfer" ).each(function( index ) {
					if($(this).attr('divisionType')!=checledvalue)
					{
						$(this).attr("disabled", true);
					}
					else
					{
						$(this).removeAttr("disabled");
					}
				});
            
			}
			else
			{
				var checledvalue =$(this).attr('divisionType');
				$( ".chkqbTransfer" ).each(function( index ) {
				if($(this).attr('divisionType')!=checledvalue)
					{
						$(this).attr("disabled", true);
					}
					else
					{
						$(this).removeAttr("disabled");
					}
				});
			}
		 });
   
   $('body').on('click', '.ckbCheckAll', function(){	
		$(".qbTransfer").attr('checked', this.checked);
	});	      
   
   $('body').on('click', '.moveToQb', function(){
	   $('#loadingOverlayEditor').show();
	   var qbTransferIds = $('.qbTransfer:checked').map(function(_, el) {
	   var taskType = $(this).attr('taskType');
	   var fieldId = $(this).attr('id').split('_')[1]+'_'+$(this).attr('id').split('_')[2]+'_'+$(this).attr('id').split('_')[3];
	   return fieldId;
	   }).get();
   
	   var idsLength = qbTransferIds.length;

	   if(idsLength > 0){
	   
		   $.ajax({
			type : 'post',
			url: 'ajax/qbTransfer.php?rand='+Math.random(),
			data : { qbTransferForInvoice: 1, qbTransferIds:qbTransferIds },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				 $('#loadingOverlayEditor').hide();
				showMessage(response.message);
				loadOutstandingInvoiceList(50,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
			}
		   });
	   }
	   else{
			showMessage('{$smarty.const.ERR_QB_SELECT}');
			$('#loadingOverlayEditor').hide();
	   }
   });
    
	
	$('body').on('click', '.exportOutstandingData', function(){
		exportOutstandingInvoiceList(50,orderIdTaskOutInvoice,sortIdTaskOutInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode);
	});
	
	$('body').on('click', '.exportSubmittedData', function(){
		exportInvoiceTaskList(50,orderIdTaskInvoice,sortIdTaskInvoice,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId,searchByServiceType,searchByLocationCode,invNoFilter);
	});
	
   
   });
   
   
    function loadInvoiceTaskList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter="",divisionId="",searchByServiceType="",searchByLocationCode="",invNoFilter=""){
   
   var page = pageNo ? pageNo : 1;
   
      var recordCount = recCountValue ? recCountValue : 50;
      $('#invoicePageListing').val(recordCount);
      $('#invoicePageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	
		isComplete=2;
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'invoiceTaskList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete,divisionId:divisionId, serviceTypeFilter:searchByServiceType,locationCodeFilter:searchByLocationCode,invNoFilter:invNoFilter},
          success: function(response) {
              checkResponseRedirect(response);
			 $('#listingTab3').html("");
			 $('#listingTab3').html(response.message.content);
     
              $('#paginationInvoiceAuto').html(response.message.pagination);
              $('#paginationInvoiceAutoNew').html(response.message.pagination);
              $('#totalInvoiceTask').html(response.message.totalRecords);
              $('#totalInvoiceTaskNew').html(response.message.totalRecords);
   
              if(page==1 && page <= response.message.totalPages){
                  $('#paginationInvoiceAuto .fa-angle-left').hide();
                  $('#paginationInvoiceAutoNew .fa-angle-left').hide();	
                  $('#paginationInvoiceAuto .fa-angle-right').show();
                  $('#paginationInvoiceAutoNew .fa-angle-right').show();
              } else if(page > 1  && page < response.message.totalPages){
                  $('#paginationInvoiceAuto .fa-angle-left').show();
                  $('#paginationInvoiceAutoNew .fa-angle-left').show();
                  $('#paginationInvoiceAuto .fa-angle-right').show();
                  $('#paginationInvoiceAutoNew .fa-angle-right').show();
              } else if(page == response.message.totalPages){
                  $('#paginationInvoiceAuto .fa-angle-right').hide();
                  $('#paginationInvoiceAutoNew .fa-angle-right').hide();
                  $('#paginationInvoiceAuto .fa-angle-left').show();
                  $('#paginationInvoiceAuto .fa-angle-left').css("padding", "3px 10px 0px 0px");
                  $('#paginationInvoiceAutoNew .fa-angle-left').show();	
                  $('#paginationInvoiceAutoNew .fa-angle-left').css("padding", "3px 10px 0px 0px");
              }
   		
   		
   		if(strClassTaskInvoice && strClassTaskInvoice!=''){
     if(strClassTaskInvoice=='ascendingClassTaskInvoice'){
   	  $('#'+orderId+'s a').removeClass('ascendingClassTaskInvoice');
   	  $('#'+orderId+'s a').addClass('descendingClassTaskInvoice').prepend('<i class="fa fa-caret-up gray font13"></i>');
   	  $('#overAllInvoice th a').addClass('descendingClassTaskInvoice');
     } else if(strClassTaskInvoice=='descendingClassTaskInvoice'){
   	  $('#'+orderId+'s a').removeClass('descendingClassTaskInvoice');
   	  $('#'+orderId+'s a').addClass('ascendingClassTaskInvoice').prepend('<i class="fa fa-caret-down gray font13"></i>');
   	  $('#overAllInvoice th a').addClass('ascendingClassTaskInvoice');
     }
     } else {
   	$('#invoice_reference_user_fnames a').addClass('descendingClassTaskInvoice').prepend('<i class="fa fa-caret-up gray font13"></i>');
	$('#invoice_reference_user_lnames a').addClass('descendingClassTaskInvoice');
   	$('#invoice_reference_marsha_codes a').addClass('descendingClassTaskInvoice');
   	$('#invoice_reference_division_codes a').addClass('descendingClassTaskInvoice');
   	$('#invoice_reference_service_type_names a').addClass('descendingClassTaskInvoice');
   	$('#invoice_reference_rate_per_units a').addClass('descendingClassTaskInvoice');
   	$('#invoice_reference_no_of_unitss a').addClass('descendingClassTaskInvoice');
   	$('#invoice_reference_tires a').addClass('descendingClassTaskInvoice');
   	$('#invoice_reference_created_ons a').addClass('descendingClassTaskInvoice');
	$('#invoice_reference_doc_numbers a').addClass('descendingClassTaskInvoice');
    }
          }
      });	 
   }
  
  
function exportInvoiceTaskList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter="",divisionId="",searchByServiceType="",searchByLocationCode="",invNoFilter=""){
	
	 var page = pageNo ? pageNo : 1;
     var recordCount = recCountValue ? recCountValue : 50;
	 isComplete=2;
	 
	   $.ajax({
          url: 'invoiceExcel.php',
          type:'post',
          data : { page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete,divisionId:divisionId, serviceTypeFilter:searchByServiceType,locationCodeFilter:searchByLocationCode,invNoFilter:invNoFilter},
          success: function(response) {
			   url = "invoiceExcel.php?page="+page+"&recCount="+recordCount+"&orderId="+orderId+"&sortId="+sortId+"&fromDate="+startDate+"&toDate="+endDate+"&taskKeyFilterBy="+taskKeyFilterBy+"&writerId="+writerIdFilter+"&isCompleteData="+isComplete+"&divisionId="+divisionId+"&serviceTypeFilter="+searchByServiceType+"&locationCodeFilter="+searchByLocationCode+"&invNoFilter="+invNoFilter;
           window.open(url,'_blank');
		  }
     });
	
}  
	
function exportOutstandingInvoiceList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter="",divisionId,searchByServiceType="",searchByLocationCode="") {
	 var page = pageNo ? pageNo : 1;
      var recordCount = recCountValue ? recCountValue : 50;
	  
	  isComplete=2;
	  
    $.ajax({
        type: 'post',
        data : { page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete,divisionId:divisionId, serviceTypeFilter:searchByServiceType,locationCodeFilter:searchByLocationCode, exportData: 1 },
        url: 'outstandingInvoiceExcel.php',
        success: function(response){
		   url = "outstandingInvoiceExcel.php?page="+page+"&recCount="+recordCount+"&orderId="+orderId+"&sortId="+sortId+"&fromDate="+startDate+"&toDate="+endDate+"&taskKeyFilterBy="+taskKeyFilterBy+"&writerId="+writerIdFilter+"&isCompleteData="+isComplete+"&divisionId="+divisionId+"&serviceTypeFilter="+searchByServiceType+"&locationCodeFilter="+searchByLocationCode;
           window.open(url,'_blank');
        }
    });
	
	
}
	
	
   function loadOutstandingInvoiceList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter="",divisionId,searchByServiceType="",searchByLocationCode=""){
   
   var page = pageNo ? pageNo : 1;
   
      var recordCount = recCountValue ? recCountValue : 50;
      $('#outInvoicePageListing').val(recordCount);
      $('#outInvoicePageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
    if(currentTabActive == 'tabId_4'){
   	isComplete=1;
   }
   
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'outstandingInvoiceTaskList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete,divisionId:divisionId, serviceTypeFilter:searchByServiceType,locationCodeFilter:searchByLocationCode },
          success: function(response) {
              checkResponseRedirect(response);
			$('#listingTab4').html("");
			$('#listingTab3').html("");
			$('#listingTab4').html(response.message.content);
    
              $('#paginationOutInvoiceAuto').html(response.message.pagination);
              $('#paginationOutInvoiceAutoNew').html(response.message.pagination);
              $('#totalOutInvoiceTask').html(response.message.totalRecords);
              $('#totalOutInvoiceTaskNew').html(response.message.totalRecords);
   
              if(page==1 && page <= response.message.totalPages){
                  $('#paginationOutInvoiceAuto .fa-angle-left').hide();
                  $('#paginationOutInvoiceAutoNew .fa-angle-left').hide();	
                  $('#paginationOutInvoiceAuto .fa-angle-right').show();
                  $('#paginationOutInvoiceAutoNew .fa-angle-right').show();
              } else if(page > 1  && page < response.message.totalPages){
                  $('#paginationOutInvoiceAuto .fa-angle-left').show();
                  $('#paginationOutInvoiceAutoNew .fa-angle-left').show();
                  $('#paginationOutInvoiceAuto .fa-angle-right').show();
                  $('#paginationOutInvoiceAutoNew .fa-angle-right').show();
              } else if(page == response.message.totalPages){
                  $('#paginationOutInvoiceAuto .fa-angle-right').hide();
                  $('#paginationOutInvoiceAutoNew .fa-angle-right').hide();
                  $('#paginationOutInvoiceAuto .fa-angle-left').show();
                  $('#paginationOutInvoiceAuto .fa-angle-left').css("padding", "3px 10px 0px 0px");
                  $('#paginationOutInvoiceAutoNew .fa-angle-left').show();	
                  $('#paginationOutInvoiceAutoNew .fa-angle-left').css("padding", "3px 10px 0px 0px");
              }
   		
   		
				if(strClassTaskOutInvoice && strClassTaskOutInvoice!=''){
					 if(strClassTaskOutInvoice=='ascendingClassTaskOutInvoice'){
					  $('#'+orderId+'s a').removeClass('ascendingClassTaskOutInvoice');
					  $('#'+orderId+'s a').addClass('descendingClassTaskOutInvoice').prepend('<i class="fa fa-caret-up gray font13"></i>');
					  $('#overAllOutInvoice th a').addClass('descendingClassTaskOutInvoice');
					 } else if(strClassTaskOutInvoice=='descendingClassTaskOutInvoice'){
					  $('#'+orderId+'s a').removeClass('descendingClassTaskOutInvoice');
					  $('#'+orderId+'s a').addClass('ascendingClassTaskOutInvoice').prepend('<i class="fa fa-caret-down gray font13"></i>');
					  $('#overAllOutInvoice th a').addClass('ascendingClassTaskOutInvoice');
					 }
				} else {
					$('#userNames a').addClass('descendingClassTaskOutInvoice').prepend('<i class="fa fa-caret-up gray font13"></i>');  
					$('#userLNames a').addClass('descendingClassTaskOutInvoice');
					$('#marshaCodes a').addClass('descendingClassTaskOutInvoice');
					$('#divisionCodes a').addClass('descendingClassTaskOutInvoice');
					$('#servTypeNames a').addClass('descendingClassTaskOutInvoice');
					$('#tires a').addClass('descendingClassTaskOutInvoice');
					$('#servTypeGalRates a').addClass('descendingClassTaskOutInvoice');
					$('#unitNos a').addClass('descendingClassTaskOutInvoice');
				}
          }
      });	 
   }
</script>
{/block}
{block name=content}
<!-- Main content -->
<section class="content">

	<div id="loadingOverlayEditor" class="loadingOverlayEditor" style="display:none;">
		<img src="{$smarty.const.ROOT_HTTP_PATH}/dist/img/gifload.gif" width="100px" height="100px"/>
	</div>

   <div class="updateTaskManagerContent"> </div>
   {*
   <div class="row">
      <div class="col-xs-12">
         <button type="submit" class="btn btn-info pull-right margin"><i class="fa fa-bell"></i> Alerts(10)</button>
         <a href="javascript:void(0);" class="btn btn-primary pull-right margin"><i class="fa fa-user"></i> Profile</a>	
      </div>
   </div>
   *}
   <div class="box box-primary filterStatus">
      <div class="row ">
         <div class="col-sm-3 m-t-20 m-b-20">
            <div class="form-group ">
               <div class="col-sm-6">
                  <label>Filter By</label>
               </div>
               <div class="col-sm-6">
                  <select class="form-control taskKeyFilterBy" name="taskKeyFilterBy">
                  {$invoiceFilterArray}
                  </select>
               </div>
               <!-- /.input group -->
            </div>
         </div>
         <div class="col-sm-5 m-t-20 m-b-20">
            <div class="form-group taskKeyFilterRangeStatus" style="display:none;">
               <div class="col-sm-7">
                  <label>Select Date Range</label>
               </div>
               <div class="col-sm-5">
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
                  <label>Select Consultant</label>
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
            <div class="form-group divisionFilter" style="display:none;">
               <select class="form-control divisionFilterBy" id="divisionFilterBy" name="divisionFilterBy">
						 {if $divisionArray}
							 {foreach $divisionArray as $key=> $value}
							 <option value="{$value.division_id}">{$value.division_code}</option>
							 {/foreach}
						 {/if}
                     </select>
            </div>
			<div class="form-group serviceFilterServiceType" style="display:none;">
                  <div class="col-sm-4">
                     <label>Select Service Type</label>
                  </div>
                  <div class="col-sm-8">
                  <select class="form-control searchByServiceType" id="searchByServiceType">
                     <option value="">--- Select Service Type ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
						<option value="{$value.serv_type_name}">{$value.serv_type_name}</option>
                     {/foreach}
                     {/if}
                  </select>
                  </div>
                  <!-- /.input group -->
               </div>
			   <div class="form-group serviceFilterLocationCode" style="display:none;">
                  <div class="col-sm-4">
                     <label>Select {$codeLabelData}</label>
                  </div>
                  <div class="col-sm-8">
                  <select class="form-control searchByLocationCode" id="searchByLocationCode">
                     <option value="">--- Select {$codeLabelData} ---</option>
                     {if $marshaCodesArray}
                     {foreach $marshaCodesArray as $key=> $value}
						<option value="{$value.client_entity_marsha_code}">{$value.client_entity_marsha_code}</option>
                     {/foreach}
                     {/if}
                  </select>
                  </div>
                  <!-- /.input group -->
               </div>
			   
			   <div class="form-group qbIdFilter" style="display:none;">
					 <div class="col-sm-6">
						<input type="text" class="form-control qbIdFilterBy" placeholder="QB Id" id="qbIdFilterBy" name="qbIdFilterBy"/>
					 </div>
					  <div class="col-sm-6">
						<button type="button" class="btn btn-primary pull-right qbIdFilterBySearch"><i class="fa fa-search"></i> Search</button>
					 </div>
                </div>
			   
         </div>
         <div class="col-sm-3 m-b-20">
            <div class="form-group resetFilters" style="display:none;">
               <button type="button" class="btn btn-primary pull-right m-r-10 m-t-20 resetFiltersAction"><i class="fa fa-minus"></i> Reset Filters</button>
            </div>
         </div>
      </div>
   </div>
   <div class="row">
      <div class="col-md-12">
         <!-- Custom Tabs -->
         <div class="nav-tabs-custom">
            <ul class="nav nav-tabs consultantTabs">
               <li data-tabId ="tabId_3" class="active tab_3" ><a href="javascript:void(0);" data-toggle="tab" class="submittedInvoiceTab">Submitted Invoice</a></li>
               <li data-tabId ="tabId_4" class="tab_4" ><a href="javascript:void(0);" data-toggle="tab" class="outstandingInvoiceTab">Outstanding Invoice</a></li>
            </ul>
            <div class="tab-content">
               <div class="tab-pane active" id="tab_3">
                  <div class="box-header with-border">
                     <div id="listingTab3"></div>
                  </div>
               </div>
               <div class="tab-pane loadingClass" id="tab_4">
                  <div class="box-header with-border">
                     <div id="listingTab4"></div>
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
<div id="confirmComplete">
   <div class="pop-up-overlay " style="display:none;">
      <div class="pop-close">X</div>
      <div class="container " style="display:none;">
         <div class="uiContent">
            <div class="dialog notitle" id="confirmCompletePop" style="display:none;">
               <div class="inner">
                  <input type="hidden" name="completeFieldId" id="completeFieldId" value=""/>
                  <input type="hidden" name="completeTaskType" id="completeTaskType" value=""/>
                  <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_COMP_TASK_KEYWORD}</h5>
                  <table border="0" cellspacing="0" cellpadding="5" align="center">
                     <tr>
                        <td class="p-t-10">
                           <a href="javascript:void(0);" class="btn btn-primary M2 okTaskCompButton">{$smarty.const.LBL_YES}</a>
                           <a href="javascript:void(0);" class="btn btn-default M2 cancelTaskCompButton">{$smarty.const.LBL_NO}</a>
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
<div id="confirmPriority">
   <div class="pop-up-overlay " style="display:none;">
      <div class="pop-close">X</div>
      <div class="container " style="display:none;">
         <div class="uiContent">
            <div class="dialog notitle" id="confirmPriorityPop" style="display:none;">
               <div class="inner">
                  <input type="hidden" name="priorityFieldId" id="priorityFieldId" value=""/>
                  <input type="hidden" name="priorityAdminTaskType" id="priorityAdminTaskType" value=""/>
                  <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_PRIRORITY_TASK}</h5>
                  <table border="0" cellspacing="0" cellpadding="5" align="center">
                     <tr>
                        <td class="p-t-10">
                           <a href="javascript:void(0);" class="btn btn-primary M2 okPriorityButton">{$smarty.const.LBL_YES}</a>
                           <a href="javascript:void(0);" class="btn btn-default M2 cancelPriorityButton">{$smarty.const.LBL_NO}</a>
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
<div id="confirmAdminComplete">
   <div class="pop-up-overlay " style="display:none;">
      <div class="pop-close">X</div>
      <div class="container " style="display:none;">
         <div class="uiContent">
            <div class="dialog notitle" id="confirmAdminCompletePop" style="display:none;">
               <div class="inner">
                  <input type="hidden" name="completeAdminFieldId" id="completeAdminFieldId" value=""/>
                  <input type="hidden" name="completeAdminTaskType" id="completeAdminTaskType" value=""/>
                  <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_COMP_ADMIN_TASK_CONTENT}</h5>
                  <table border="0" cellspacing="0" cellpadding="5" align="center">
                     <tr>
                        <td class="p-t-10">
                           <a href="javascript:void(0);" class="btn btn-primary M2 okAdminTaskCompButton">{$smarty.const.LBL_YES}</a>
                           <a href="javascript:void(0);" class="btn btn-default M2 cancelAdminTaskCompButton">{$smarty.const.LBL_NO}</a>
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
<div id="confirmAdminReassign">
   <div class="pop-up-overlay " style="display:none;">
      <div class="pop-close">X</div>
      <div class="container " style="display:none;">
         <div class="uiContent">
            <div class="dialog notitle" id="confirmAdminReassignPop" style="display:none;">
               <div class="inner">
                  <input type="hidden" name="completeAdminFieldId" id="completeAdminFieldId" value=""/>
                  <input type="hidden" name="completeAdminTaskType" id="completeAdminTaskType" value=""/>
                  <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_REASSIGN_TASK_CONTENT}</h5>
                  <table border="0" cellspacing="0" cellpadding="5" align="center">
                     <tr>
                        <td class="p-t-10">
                           <label>Notes</label> <textarea class="form-control task_content_admin_notes" id="task_content_admin_notes"></textarea>
                        </td>
                     </tr>
                     <tr>
                        <td class="p-t-10">
                           <a href="javascript:void(0);" class="btn btn-primary M2 okAdminTaskReassignButton">{$smarty.const.LBL_YES}</a>
                           <a href="javascript:void(0);" class="btn btn-default M2 cancelAdminTaskReassignButton">{$smarty.const.LBL_NO}</a>
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