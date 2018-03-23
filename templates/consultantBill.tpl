{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Admin{/block}
{block name=header}{/block}
{block name=content}
      <div class="row">
        <!-- right column -->
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Hotel Name: </h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form class="form-horizontal">
              <div class="box-body">
				<div class="row">
                <div class="form-group col-sm-6">
                  <label for="inputEmail3" class="col-sm-2 control-label">DATE</label>

                  <div class="col-sm-10">
                    <div class="form-group">
					  <div class="input-group date">
					  <div class="input-group-addon">
						<i class="fa fa-calendar"></i>
					  </div>
					  <input type="text" class="form-control pull-right" id="datepicker">
					</div>
					</div>
                  </div>
                </div>
                <div class="form-group col-sm-6">
                  <label for="inputPassword3" class="col-sm-2 control-label">DIVISION</label>

                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" placeholder="">
                  </div>
                </div>
				</div>
				<div class="row">
				<div class="form-group col-sm-6">
                  <label for="inputEmail3" class="col-sm-2 control-label">PROJECT</label>

                  <div class="col-sm-10">
                    <select class="form-control">
                    <option>option 1</option>
                    <option>option 2</option>
                    <option>option 3</option>
                    <option>option 4</option>
                    <option>option 5</option>
                  </select>
                  </div>
                </div>
                <div class="form-group col-sm-6">
                  <label for="inputPassword3" class="col-sm-2 control-label">SERVICE TYPE</label>

                  <div class="col-sm-10">
                    <select class="form-control">
                    <option>option 1</option>
                    <option>option 2</option>
                    <option>option 3</option>
                    <option>option 4</option>
                    <option>option 5</option>
                  </select>
                  </div>
                </div>
				</div>
				<div class="row">
				<div class="form-group col-sm-6">
                  <label for="inputEmail3" class="col-sm-2 control-label">RATE PER UNIT</label>

                  <div class="col-sm-10">
                   <input type="text" class="form-control" id="inputPassword3" placeholder="">
                  </div>
                </div>
                <div class="form-group col-sm-6">
                  <label for="inputPassword3" class="col-sm-2 control-label">NUMBER OF UNITS</label>

                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" placeholder="">
                  </div>
                </div>
				</div>
				<div class="row">
				<div class="form-group col-sm-6">
                  <label for="inputEmail3" class="col-sm-2 control-label">NOTES</label>

                  <div class="col-sm-10">
                    <textarea class="form-control"></textarea>	
                  </div>
                </div>
				</div>
              </div>
              <!-- /.box-body -->
             
			  <div class="row ">
		 <div class="col-xs-12 ">
			<a class="btn btn-default pull-right margin" href="{$smarty.const.ROOT_HTTP_PATH}/consultantBill.php">Cancel</a>
			<button type="button" class="btn btn-info pull-right margin clientFormSave">Done</button>
		 </div>
	  </div>
              <!-- /.box-footer -->
            </form>
          </div>
          <!-- /.box -->
          
        </div>
        <!--/.col (right) -->
      </div>
{/block}