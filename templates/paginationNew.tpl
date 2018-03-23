{strip}
{if $totalPages > 1}
	<span class="pagination-nav {$modelClass}">
        <select class="pageDropDown pull-left form-control P5" name="pageDropDownValue" id="pageDropDownValue" style="width:60px !important;">
        {for $start = 1 to $totalPages}
            <option value="{$start}" title="{$start}" id="{$start}" {if $smarty.post.page eq $start || $pageArr.current == $start} selected {/if}>{$start}</option>
        {/for} 
        </select>
        <a class="fa fa-angle-left font26 gray m-l-10 leftArrowClass pointer" title="Previous" style="{if ($smarty.post.page eq 1 || $pageArr.current == 1)}display:none;{else}{if ($smarty.post.page eq $totalPages || $pageArr.current == $totalPages)}padding:3px 10px 0px 0px{/if}{/if}"></a>
        <a class="fa fa-angle-right font26 gray m-l-10 m-r-10 m-t-2 rightArrowClass pointer" title="Next" style="{if ($smarty.post.page eq $totalPages || $pageArr.current == $totalPages)}display:none;{/if}"></a>
    </span>
{/if}
{/strip}