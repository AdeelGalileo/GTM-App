{strip}
  <select class="form-control task_content_user_id task_content_reassign_user_id" id="task_content_user_id">
	 <option value="">--- Select Consultant ---</option>
		 {if $consultantList}
		 {foreach $consultantList as $key=> $value}
		 <option value="{$value.user_id}" {if $taskContentData.task_content_user_id==$value.user_id }selected{/if} >{$value.user_fname} {$value.user_lname}</option>
		 {/foreach}
	 {/if}
  </select>
{/strip}

<script>
  $(function () {
	$('#task_content_user_id').chosen({ width:"100%"});
  });
</script>