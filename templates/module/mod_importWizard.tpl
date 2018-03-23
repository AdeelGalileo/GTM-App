<script type="text/javascript">
var reqFieldArray = [{$reqFieldJSArray}];

$(document).ready(function(){
	
		 $('body').on('click', '.autoMap', function(){
			$('#field_0').chosen('destroy');
			$('#field_0').val('MARSHA');
			$('#field_0').chosen({ width:"100%"});
			$('#field_1').chosen('destroy');
			$('#field_1').val('Number of Pages');
			$('#field_1').chosen({ width:"100%"});
			$('#field_2').chosen('destroy');
			$('#field_2').val('Notes');
			$('#field_2').chosen({ width:"100%"});
			$('#field_3').chosen('destroy');
			$('#field_3').val('BOX Link');
			$('#field_3').chosen({ width:"100%"});
			$('#field_4').chosen('destroy');
			$('#field_4').val('Date Added to BOX');
			$('#field_4').chosen({ width:"100%"});
			$('#field_5').chosen('destroy');
			$('#field_5').val('Keyword File Set Up Due');
			$('#field_5').chosen({ width:"100%"});
			$('#field_6').chosen('destroy');
			$('#field_6').val('Keywords Due');
			$('#field_6').chosen({ width:"100%"});
		 });
		
		$('body').on('submit', '#frmImportCSV', function(event){
            var selectValues = $('.admin_select4');
            var valArr = [];
            selectValues.each(function(i){
                if($(this).val())
                    valArr.push($(this).val());
            });
            if(valArr.length == 0) {
                showMessage('Marsha Code Required');
				event.preventDefault();
                return false;
            }
            var sortedArr = valArr.sort(); 
            if(!checkRequiredFields(sortedArr)){
                showMessage("{$smarty.const.SELECT_ALL_REQUIRED_FIELDS} " + reqFieldArray);
				event.preventDefault();
                return false;
            }
            var results = [];
            var empty = 0;
            var duplicates = [];
            for (var i = 0; i < sortedArr.length; i++) {
                if (sortedArr[i + 1] != sortedArr[i]) {
                    results.push(sortedArr[i]);
                } else {
                    duplicates.push(sortedArr[i]);
                }
            }
            if(duplicates.length){
                showMessage('{$smarty.const.DUPLICATE_FIELDS} ' + duplicates);
				event.preventDefault();
                return false;
            }
            $('#frmImportCSV').hide();
            $('#loadImg').show();
            return true;
	});
	
	
	$.each($('.fieldMap'),function(){
		if(!$("#"+this.id+"_chosen").length){
            $('#'+this.id).chosen({ width:"100%"});
        }
	});
	
	
});

function checkRequiredFields(sortedArr){
    var totalReqFields = reqFieldArray.length;
    var slctFields = 0;
    var reqArr = reqFieldArray;
    for(recCnt=0; recCnt < reqArr.length; recCnt++){
        for(cnt = 0; cnt < sortedArr.length; cnt++){
            if(sortedArr[cnt] == reqArr[recCnt]){
                slctFields++;
            }
        }
    }
    if(totalReqFields <= slctFields)
        return true;
    return false;
}

</script>
{strip}
	<div class="box-header with-border">
	  <h3 class="box-title">MAP FIELDS</h3>
   </div>
   <div class="row">
	  <div class="col-sm-6">
		 UPLOADED RECORD COUNT: {$recCount}
	  </div>
	  
	  <div class="col-sm-6">
	  <button type="button" class="btn btn-primary pull-right margin autoMap P10">AUTO MAP</button>
	  </div>
	 
   </div>
   <div class="box-header text-center">
	  <h3 class="box-title" style="font-weight:bold;">MANUAL MAP</h3>
   </div>
     <div id="loadImg" class="hide"><img src="{$smarty.const.ROOT_HTTP_PATH}/images/loading.gif" alt="" title="" /></div>
   <form name="frmImportCSV" id="frmImportCSV" action="{$smarty.const.ROOT_HTTP_PATH}/importWizard.php" method="post">
   
   <input type="hidden" name="importOpt" id="importOpt" value="{$importOption}"  />
   <table id="example1" class="table table-bordered table-striped">
	  <thead>
		 <tr>
			<th>FIELD</th>
			<th>CVS HEADER DATA</th>
			<th>CVS DATA</th>
		 </tr>
	  </thead>
	  <tbody>
			{section start=0 loop=$fieldCount name=fields}
			<tr>
				<td>
				<select name="field[{$smarty.section.fields.index}]" id="field_{$smarty.section.fields.index}" class="admin_select4 fieldMap form-control P5" style="width:130px;">
				 <option value="">Select Field</option>
                 <option value="">Do Not Import</option>
				   {$fieldOptions}
				</select>
				</td>
				{foreach $record as $row}
					<td>{$row[{$smarty.section.fields.index}]}</td>
				{/foreach} 
			</tr>
			{/section}
			<tr>
				<td colspan="3">
					<input type="checkbox" id="firstRow" name="firstRow" value="1" />
					&nbsp;{$smarty.const.REMOVE_FIRST_ROW}
				</td>
			</tr>
	  </tbody>
   </table>
    <div class="box-footer">
	   <input type="submit" name="saveData" id="save" value="Import" class="btn btn-primary pull-right margin saveMapFields" />
   </div>
   </form>
  
{/strip}
