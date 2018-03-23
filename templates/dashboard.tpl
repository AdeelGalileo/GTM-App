{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Dashboard {/block}
{block name=header}{/block}
{block name=content}
<div class="row">

		
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3>{$billingCount}</h3>
              <p>Total Submitted Bill</p>
            </div>
            <div class="icon">
              <i class="fa fa-table"></i>
            </div>
			<a href="{$smarty.const.ROOT_HTTP_PATH}/adminConsultant.php?dashboard=submittedBillingTab" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
		
		{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-green">
            <div class="inner">
              <h3>{$invoiceCount}</h3>
              <p>Total Submitted Invoice</p>
            </div>
            <div class="icon">
              <i class="fa fa-files-o"></i>
            </div>
			<a href="{$smarty.const.ROOT_HTTP_PATH}/invoice.php" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
		{/if}
		
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3>{$pendingTaskCount}</h3>
              <p>Pending Task</p>
            </div>
            <div class="icon">
              <i class="fa fa-tasks"></i>
            </div>
			<a href="{$smarty.const.ROOT_HTTP_PATH}/adminConsultant.php?dashboard=pendingTaskTab" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
		
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3>{$completedTaskCount}</h3>
              <p>Completed Task</p>
            </div>
            <div class="icon">
              <i class="fa fa-check"></i>
            </div>
			<a href="{$smarty.const.ROOT_HTTP_PATH}/adminConsultant.php" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
		<!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3 class="alertNotificationCount">0</h3>
              <p>Notifications</p>
            </div>
            <div class="icon">
              <i class="fa fa-bell-o"></i>
            </div>
            <a href="{$smarty.const.ROOT_HTTP_PATH}/alertNotifications.php" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
</div>
{/block}