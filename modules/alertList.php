<?php
class alertListModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		$alertObj = getObject('alert');
		$alertList = $alertObj->getAlertList($params);
		
		$page  = ($params['page']) ? $params['page']  : 1;
		$limit = (int) $params['recCount'];
		$start = ($params['page'] - 1) * $limit;
		
		$totalRecords = getTotalRecords($alertList);

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
		
		$smarty->assign('totalRecords', $totalRecords);
		$smarty->assign('alertList', $alertList['alertList']);
	
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent, 'pagination'=>$pagination, 'totalRecords'=>$totalRecords, 'totalPages' => $totalPages);
	}
}
?>