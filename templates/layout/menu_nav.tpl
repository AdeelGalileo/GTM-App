{strip}
<nav class="navbar" id="nav">
	 <ul id="menu">
		<li class="opened expanded has-sub">
			<a href="{$smarty.const.ROOT_HTTP_PATH}/dashboard/dashboard.php" alt="SAM Dashboard" title="SAM Dashboard">
				<i class="linecons-desktop"></i><span>Dashboard</span>
			</a>
			<ul>
				<li>
					<a href="{$smarty.const.ROOT_HTTP_PATH}/dashboard/dashboard.php">
						<img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/dashboard.png">
						SAM
					</a>
				</li>
				<li>
					<a href="{$smarty.const.ROOT_HTTP_PATH}/dashboard/croDashboard.php">
						<img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/salesdash.png">
						Sales
					</a>
				</li>
				{if $viewEmail || $viewMail || $viewAutomation || $viewSocial || $viewEvent}
				<li>
					<a href="{$smarty.const.ROOT_HTTP_PATH}/dashboard/cmoDashboard.php" {if $tutorialMode==1 && $totalUsers['total']==0 && $smarty.request.sales==''}oi-help-marketing{/if}">
						<img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/marketingdash.png">
						Marketing
					</a>
				</li>
				{/if}
			</ul>
		</li>
		<li class="opened expanded has-sub">
			<a href="{$smarty.const.ROOT_HTTP_PATH}/dashboard/croDashboard.php" alt="Sales Dashboard" title="Sales Dashboard">
				<i class="linecons-user"></i><span>Sales</span>
			</a>
			<ul>
			{foreach $importB2BArr as $businessCategoryKey => $businessCategoryVal}
				{if $businessCategoryKey==1}
					{assign var="currentBtype" value=' Leads'}
				{elseif $businessCategoryKey==2}
					{assign var="currentBtype" value=' Opportunities'}
				{elseif $businessCategoryKey==3}
					{assign var="currentBtype" value=' Accounts'}
				{elseif $businessCategoryKey=='4'} 
					{assign var="currentBtype" value=' Partners'}
				{elseif $businessCategoryKey=='5'} 
					{assign var="currentBtype" value=' Contacts'}
				{else}   
					{assign var="currentBtype" value='Lead'}
				{/if}
				{if $businessCategoryKey}
				<li class="has-sub subMenuClass">
					<a href="{$smarty.const.ROOT_HTTP_PATH}/leads.php?typeLead={$businessCategoryKey}" class="clearCookie">
						<img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/l_{$businessCategoryKey}.png">
						{$businessCategoryVal}
					</a>
					<ul>
					<li><a class="clearCookie" href="{$smarty.const.ROOT_HTTP_PATH}/leads.php?typeLead={$businessCategoryKey}" ><i class="fa fa-plus"></i>View {$currentBtype}</a></li>
					
					{if $importData}
						<li><a class="addLeadShow clearCookie" href="{$smarty.const.ROOT_HTTP_PATH}/addLead.php?typeLead={$businessCategoryKey}&addLead=1" ><i class="fa fa-plus"></i>Add {$currentBtype}</a></li>
					{/if}
						<li><a class="addFolderShow clearCookie" href="{$smarty.const.ROOT_HTTP_PATH}/addFolder.php?typeLead={$businessCategoryKey}&addFolder=1" id="strAddCategory"><i class="fa fa-plus"></i>Add a Folder</a></li>
					</ul>
				</li>
				{/if}
			{/foreach}
			</ul>
		</li>
		<li class="opened expanded has-sub">
			{if $viewEmail || $viewMail || $viewAutomation || $viewSocial || $viewEvent}
				<a href="{$smarty.const.ROOT_HTTP_PATH}/dashboard/cmoDashboard.php" alt="Marketing Dashboard" title="Marketing Dashboard">
				<i class="linecons-paper-plane"></i><span>Marketing</span>
			</a>
			{/if}
			<ul>
			{if $viewEmail}
				<li class="has-sub subMenuClass">
					<a href="{$smarty.const.ROOT_HTTP_PATH}/campaigns.php?email=1">
						<img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/email_marketing.png">
						Email Marketing
					</a>
					<ul>
                    	<li>
							<a href="{$smarty.const.ROOT_HTTP_PATH}/campaigns.php?email=1">
								<i class="fa fa-plus"></i>View Email Marketing
							</a>
						</li>
					{if $smarty.session.userClientId == 326}
						<li>
							<a href="{$smarty.const.ROOT_HTTP_PATH}/emailReporting.php?email=1&account=1" class="accountEmail">
								<i class="fa fa-eye"></i>Add Central Campaign
							</a>
						</li>
					{/if}
						<li>
							<a href="{$smarty.const.ROOT_HTTP_PATH}/abRecipient.php?testing=1">
								<i class="fa fa-plus"></i>Add A/B Testing
							</a>
						</li>
						<li>
							<a href="{$smarty.const.ROOT_HTTP_PATH}/emailReporting.php?email=1" >
								<i class="fa fa-plus"></i>Add Email Campaign
							</a>
						</li>
						<li>
							{if $smarty.session.userClientId == 1 || ($smarty.session.clientType==$smarty.const.CLIENT_CHANNEL && $smarty.session.clientCount > 1)}
							<a href="{$smarty.const.ROOT_HTTP_PATH}/emailReporting.php?email=1&channel=1" >
								<i class="fa fa-plus"></i>Add Channel Campaign
							</a>
							{/if}
						</li>
					</ul>
				</li>
			{/if}
			{if $viewSearch}
			<li>
				 <a href="{$smarty.const.ROOT_HTTP_PATH}/audit/">
				 <img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/seo.png">
				 Search Engine Optimization
				 </a>
			  </li>
			  {/if}
			  {if $viewSocial}                                
			  <li>
				 <a href="{$smarty.const.ROOT_HTTP_PATH}/social">
				 <img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/social_visiblity.png">
				 Social Visibility
				 </a>
			  </li>
			  {/if}
			  {if $viewWeb}
			  <li>
				 <a href="{$smarty.const.ROOT_HTTP_PATH}/campaigns.php?web=1">
				 <img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/web_manage.png">
				 Website Manager & Analytics
				 </a>
			  </li>
			  {/if}
			  {if $viewEvent}
			  <li class="has-sub subMenuClass">
				 <a href="{$smarty.const.ROOT_HTTP_PATH}/campaigns.php?event=1">
				 <img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/events_management.png">
				 Event Management
				 </a>
				 <ul>
					{if $roleObj->canCreateEmail()} 
					<li>
					   <a href="{$smarty.const.ROOT_HTTP_PATH}/createEvent.php?event=1" class="createNew">
					   <i class="fa fa-plus"></i>Add Event
					   </a>
					</li>
					{/if}
				 </ul>
			  </li>
			  {/if}
			  {if $viewMail}
			  <li class="has-sub subMenuClass">
				 <a href="{$smarty.const.ROOT_HTTP_PATH}/campaigns.php?letters=1" >
				 <img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/direct_mail.png">
				 Direct Mail
				 </a>
				 <ul>
					<li>
					   <a href="{$smarty.const.ROOT_HTTP_PATH}/manageLetter.php?letters=1" class="gNewLetter" >
					   Letters
					   </a>
					</li>
					<li>
					   <a href="{$smarty.const.ROOT_HTTP_PATH}/manageLetter.php?letternLabels=1" class="gNewLetter" >
					   Letters With Labels
					   </a>
					</li>
					<li>
					   <a href="{$smarty.const.ROOT_HTTP_PATH}/manageLetter.php?labels=1" class="gNewLetter" >
					   Labels Only
					   </a>
					</li>
				 </ul>
			  </li>
			  {/if}
				{if $smarty.session.userClientId == 1 || $smarty.session.userClientId == 99 || $smarty.session.userClientId == 483 
					|| $smarty.session.userClientId == 439 || $smarty.session.userClientId == 530}
			  <li class="has-sub subMenuClass">
				 <a href="{$smarty.const.ROOT_HTTP_PATH}/project/project.php" >
				 <img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/new/prj_management.png">
				 Project Management
				 </a>
				</li> 
				 {/if}
		   </ul>
		</li>
		
		   <li class="opened expanded has-sub">
			{if $viewEmail || $viewMail || $viewAutomation || $viewSocial || $viewEvent}
				<a href="{$smarty.const.ROOT_HTTP_PATH}/campaigns.php?automation=1" alt="Automation" title="Automation">
				<i class="linecons-paper-plane"></i><span>Automation</span>
			</a>
			{/if}
			<ul>
			  {if $viewAutomation}
			  <li class="has-sub subMenuClass">
				 <a href="{$smarty.const.ROOT_HTTP_PATH}/campaigns.php?automation=1">
				 <img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/automation.png">
				 Automation
				 </a>
				  <ul>
                  	<li>
					   <a href="{$smarty.const.ROOT_HTTP_PATH}/campaigns.php?automation=1">
					   <i class="fa fa-plus"></i>View Automation
					   </a>
					</li>
				 {if $roleObj->canCreateAutomation()}
				
					<li>
					   <a href="{$smarty.const.ROOT_HTTP_PATH}/newCustomRule.php">
					   <i class="fa fa-plus"></i>Add Automation
					   </a>
					</li>
					<li>
					   <a href="{$smarty.const.ROOT_HTTP_PATH}/newRuleCampaign.php">
					   <i class="fa fa-plus"></i>Automation For Email Campaign
					   </a>
					</li>
				 {/if} 
				 </ul>
			  </li>
			  {/if}
			  
			  {if $smarty.session.userClientId == 1 || $smarty.session.userClientId == 99 || $smarty.session.userClientId == 483 || $smarty.session.userClientId == 439
				|| $smarty.session.userClientId == 530}
			  <li class="has-sub subMenuClass">
				 <a href="{$smarty.const.ROOT_HTTP_PATH}/campaigns.php?automation=1">
				 <img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/automation.png">
				 Inference Engine
				 </a>
				  <ul>
					 <li>
					   <a href="{$smarty.const.ROOT_HTTP_PATH}/emailNotificationList.php" class="info" >
					   <i class="fa fa-eye"></i>View Engine
					   </a>
					</li>
				 {if $roleObj->canCreateAutomation()}
				
					<li>
					   <a href="{$smarty.const.ROOT_HTTP_PATH}/newEmailNotificationRule.php">
					   <i class="fa fa-plus"></i>Create Engine
					   </a>
					</li>
				   
				 {/if} 
					
				 </ul>
			  </li>
			  {/if}
		   </ul>
		   <li class="opened expanded has-sub">
		   <a href="javascript:void(0)" class="getRecentItem">
				 <img class="sub_icon_img" src="{$smarty.const.ROOT_HTTP_PATH}/images/dashboard/recent.png">
				 Recent
				 </a>
		   
		   <ul class="recentListItems">
		   
		   </ul>
		   </li>
		</li>
		
		<li class="opened expanded has-sub">
		   <a href="{$smarty.const.ROOT_HTTP_PATH}/tools.php" alt="Tools" title="Tools">
		   <i class="linecons-beaker"></i><span>Tools</span>
		   </a>
		</li>
		<li class="opened expanded has-sub"> 
		   <a href="{$smarty.const.ROOT_HTTP_PATH}/settingsManager.php" alt="Settings" title="Settings">
		   <i class="linecons-params"></i><span>Settings</span>
		   </a>
		</li>
		<li class="opened expanded has-sub">
		   <a href="javascript:void(0);" alt="Help" title="Help" onClick="MM_openBrWindow('{$smarty.const.ROOT_HTTP_PATH}/help.php','Help','width=730,height=650, directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no');" class="{if $smarty.request.tutorialDone==1} oi-help-video{/if}">
		   <i class="fa-info"></i><span>Help</span>
		   </a>
		</li>
		<li class="opened expanded has-sub">
		   <a href="javascript:void(0);" class="embeddedAllTrain" alt="Training" title="Training">
		   <i class="fa fa-graduation-cap"></i><span>Training</span>
		   {if $eventInfoCount}
		   <span class="label label-success pull-right" style="right:14px;border-radius: 50%;top:2px;font-size:12px;height:19px;line-height: 14px;display: block;background:none repeat scroll 0 0 #0e62c7 !important;"> 
		   {$eventInfoCount} 
		   </span>
		   {/if}
		   </a>                            
		</li>
		<li class="opened expanded has-sub">
		   <a href="{$smarty.const.ROOT_HTTP_PATH}/repDashboard.php?tab=app" class="saleAppoint" title="Appointment">
		   Appointment - 
		   <span class="num appoint-bg" style="color: #2a6496;"> 
		   {if $totalAppCount} {$totalAppCount} {else} 0 {/if} 
		   </span>
		   </a>
		</li>
		<li class="opened expanded has-sub">
		   <a href="{$smarty.const.ROOT_HTTP_PATH}/repDashboard.php?tab=task" class="saleTasks" title="Task">
		   Task - 
		   <span class="num task-bg" style="color: #2a6496;"> 
		   {if $totalTaskCount} {$totalTaskCount} {else} 0 {/if} 
		   </span>
		   </a>
		</li>
		<li class="opened expanded has-sub">
		   <a href="{$smarty.const.ROOT_HTTP_PATH}/repDashboard.php?tab=email" class="emailalert" title="Messages">
		   Messages - 
		   <span class="num email-bg" style="color: #2a6496;"> 
		   {if $gmailCount} {$gmailCount} {else} 0 {/if} 
		   </span>
		   </a>
		</li>
		<li class="opened expanded has-sub">
		   <a href="{$smarty.const.ROOT_HTTP_PATH}/logout.php" title="Logout" class="m-l-15 mobsignout">
		   Logout
		   </a>
		</li>
	 </ul>
<!-- Navigation End -->
</nav>
{/strip}