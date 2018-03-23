   <script type="text/javascript">
   $(document).ready(function(){
	   $('#sessionClientId').chosen({ width:"100%"});
	   $('body').on('change', '.sessionClientId', function(){
		var sessionClientId = $( this ).val();
		var sessionClientName = $('option:selected', this).attr('attrClientName');
		if(sessionClientId==''){
				return false;
		 }
		 $.ajax({
				url: 'ajax/client.php?rand='+Math.random(),
				dataType: 'json',
				 data: { createClientSession:1, sessionDataClientId: sessionClientId, sessionClientName: sessionClientName },
				 success: function(response) {
						checkResponseRedirect(response);
						showMessage(response.message);
						location.reload();
				}	
		   });
	   });
	   
	   getAlertNotificationCount();
	   
	   setInterval(function(){ getAlertNotificationCount(); }, 10000);
	   
	   
   });
   
   
   function getAlertNotificationCount(){
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'alertNotificationCount' },
          success: function(response) {
              checkResponseRedirect(response);
				$('.alertNotificationCount').html("");
				$('.alertNotificationCount').html(response.message.content);
          }
      });	 
   }	
   
   </script> 
  <header class="main-header">
    <!-- Logo -->
    <a href="javascript:void(0);" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini text-black">GTM</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><img src="dist/img/galileo.png" width="113"/></span>
    </a>
   
	
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
	
		 
      <!-- Sidebar toggle button-->
       <div class="col-sm-1">
	   <a href="javascript:void(0);" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
	  </div>
	   <div class="col-sm-3 m-t-10">
			
				<select class="form-control sessionClientId" id="sessionClientId">
					 {*<option value="">--- Select Client ---</option>*}
					 {if $clientData}
						 {foreach $clientData as $key=> $value}
							<option attrClientName="{$value.client_name}" value="{$value.client_id}" {if $smarty.session.sessionClientId==$value.client_id }selected{/if}>{$value.client_name}</option>
						 {/foreach}
					 {/if}
				</select>
		    
		 </div>
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Notifications: style can be found in dropdown.less -->
          <li class="dropdown notifications-menu">
            <a href="{$smarty.const.ROOT_HTTP_PATH}/alertNotifications.php">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning"><div class="alertNotificationCount">0</div></span>
            </a>
          </li>
		  <li class="dropdown tasks-menu">
            <a href="{$smarty.const.ROOT_HTTP_PATH}/logout.php" class="dropdown-toggle" >
              <i class="fa fa-power-off"></i> &nbsp;Sign out
            </a>
            
          </li>
         
        </ul>
      </div>
    </nav>
  </header>