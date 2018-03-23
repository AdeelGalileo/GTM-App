{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Admin{/block}
{block name=header}{/block}
{block name=content}
      	<div class="row">
        <div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/userManager.php">
		  <div class="info-box bg-aqua">
            <span class="info-box-icon"><i class="fa fa-user"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">User Manager</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        
        <!-- /.col -->
		  <div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/clients.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-user"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Clients</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		 <div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/skills.php">
		  <div class="info-box bg-aqua">
            <span class="info-box-icon"><i class="fa fa-tasks"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Skills</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/forms.php">
		  <div class="info-box bg-aqua">
            <span class="info-box-icon"><i class="fa fa-files-o"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Forms</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		</div>
		
		<hr style="border-top: 1px solid #fff;">
		<div class="row">
      
        <!-- /.col -->
       
        <!-- /.col -->
		
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
         <a href="{$smarty.const.ROOT_HTTP_PATH}/alerts.php">
		  <div class="info-box bg-red">
            <span class="info-box-icon"><i class="fa fa-bell"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Alerts Setup</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
		  <div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/consultantRate.php">
		  <div class="info-box bg-green">
            <span class="info-box-icon"><i class="fa fa-usd"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Bill Rate Override</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		{*<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/adminConsultant.php">
		  <div class="info-box bg-red">
            <span class="info-box-icon"><i class="fa fa-users"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Consultants</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>*}
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/serviceTypes.php">
		  <div class="info-box bg-green">
            <span class="info-box-icon"><i class="fa fa-cogs"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Service Types</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/qbClientToken.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-wrench"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Quick Book Setup</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
      </div>
	  <hr style="border-top: 1px solid #fff;">
		<div class="row">
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/division.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-list"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Division</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/clientEntity.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-tags"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">{$codeLabelData}</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/qbClassReference.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-cog"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Qb Class</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/clientDivision.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-users"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Client Class</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		
		
		
		
	  </div>
	 
{/block}