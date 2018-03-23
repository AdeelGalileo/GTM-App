{strip}
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p title="{$smarty.session.userName}">{$smarty.session.userName|truncate:"15"}</p>
        </div>
      </div>
      <!-- search form -->
      <!--<form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
          <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>-->
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
        <!--<li class="header">MAIN NAVIGATION</li>-->
        <li class="active">
          <a href="{$smarty.const.ROOT_HTTP_PATH}/dashboard.php">
            <i class="fa fa-dashboard"></i> <span>Dashboard</span>
          </a>
        </li>
		{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN || $smarty.session.userRole == $smarty.const.USER_ROLE_PROJECT_MANAGER}
        <li>
        <a href="{$smarty.const.ROOT_HTTP_PATH}/importWizard.php">
            <i class="fa fa-files-o"></i> <span>Import Wizard</span>
          </a>
        </li>
		{/if}
        <li>
          <a href="{$smarty.const.ROOT_HTTP_PATH}/taskManagerKeyword.php">
            <i class="fa fa-file-text-o"></i> <span>Task Manager Keyword <br>Research</span>
           
          </a>
        </li>
		<li>
          <a href="{$smarty.const.ROOT_HTTP_PATH}/taskManagerContent.php">
            <i class="fa fa-file-text"></i> <span>Task Manager Content</span>
           
          </a>
        </li>
		{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
			<li>
			  <a href="{$smarty.const.ROOT_HTTP_PATH}/adminConsultant.php">
				<i class="fa fa-commenting"></i> <span>Task Review & Billing</span>
			   
			  </a>
			</li>
			<li>
			  <a href="{$smarty.const.ROOT_HTTP_PATH}/admin.php">
				<i class="fa fa-users"></i> <span>Admin</span>
			   
			  </a>
			</li>
		{/if}
		{if $smarty.session.userRole == $smarty.const.USER_ROLE_CONSULTANT}
		<li>
         <a href="{$smarty.const.ROOT_HTTP_PATH}/adminConsultant.php">
            <i class="fa fa-commenting"></i> <span>Task Review & Billing</span>
           
          </a>
        </li>
		{/if}
		{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
			<li>
			  <a href="{$smarty.const.ROOT_HTTP_PATH}/invoice.php">
				<i class="fa fa-newspaper-o"></i> <span>Invoice</span>
			  </a>
			</li>
		{/if}
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
{/strip}