<?php
class taskManagerKeywordListModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr, $adminReviewArray;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		$taskManagerKeywordObj = getObject('taskManagerKeyword');
		$taskManagerKeywordList = $taskManagerKeywordObj->getTaskManagerKeywordList($params);
		
		$page  = ($params['page']) ? $params['page']  : 1;
		$limit = (int) $params['recCount'];
		$start = ($params['page'] - 1) * $limit;
		
		$totalRecords = getTotalRecords($taskManagerKeywordList);

		if($limit > 0) {
			$page    = new page($totalRecords, $limit);
			$totalPages = $page->getTotalPages();
			$smarty->assign('totalPages', $totalPages);
			$pagination = $smarty->fetch(TEMPLATE_PATH.'/paginationNew.tpl');
		} else {
			$pagination = '';		
		}
		$recCountOptions = generateSelectOption($recCountArr, $limit);
		$smarty->assign('recCountOptions', $recCountOptions);
		
		$adminReviewArray = generateSelectOption($adminReviewArray,0);
		$smarty->assign('adminReviewArray', $adminReviewArray);
		
		$smarty->assign('totalRecords', $totalRecords);
		$smarty->assign('taskManagerKeywordList', $taskManagerKeywordList['taskManagerKeywordList']);
	
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent, 'pagination'=>$pagination, 'totalRecords'=>$totalRecords, 'totalPages' => $totalPages);
	}
}
?>