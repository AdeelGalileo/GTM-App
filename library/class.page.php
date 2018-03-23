<?php
class page {
	private $totalPages;
	private $recPerPage;
	private $totalRecords;
	private $currentPage;
	function __construct($totRecords, $limit) {
		$this->totalRecords = $totRecords;
		$this->recPerPage   = $limit;
		$this->totalPages   = ceil($totRecords / $limit);
	}
	/* Function to get current page */
	function getCurrentPage() {
		$page = $_REQUEST['page'] ? $_REQUEST['page'] : 1;
		$this->currentPage = $page;
		return ($this->currentPage);
	}
	/* Function to get start offset */
	function getStartOffset() {
		$currentPage = $this->getCurrentPage();
		$start = ($currentPage-1) * $this->recPerPage;
		return $start;
	}
	/* Function to get records per page */
	function getRecordsPerPage() {
		return $this->recPerPage;
	}
	/* Function to get total pages */
	function getTotalPages() {
		return $this->totalPages;
	}
	/* Function to get Next Page */
	function getNextPage() {
		$currentPage = $this->getCurrentPage();
		if($this->totalPages == 1 || $currentPage == $this->totalPages ) {
			return 0; //No Next Page
		} else {
			return ($currentPage+1);
		}
	}
	/* Function to get Previous Page */
	function getPreviousPage() {
		$currentPage = $this->getCurrentPage();
		if($currentPage == 1 || $this->totalPages == 1)	{
			return 0; //No Previous Page
		} else {
			return ($currentPage-1);
		}
	}
	/* Get the display pages */
	function getDisplayPages($showPages) {
		$pageArr = array();
		for($cnt = 1; $cnt <= $this->totalPages; $cnt++){
			array_push($pageArr, $cnt);
		}
		return $pageArr;
	}
	
	/* Get the Surrounding Pages*/
	function getSurroundingPages($showPages=0) {
		$arr      = array();
		$pages    = array();
		$pageNum  = $this->getCurrentPage();
		$lastPage = $this->getTotalPages();
		//Get the next and previous page links
		$pages['next']     = $this->getNextPage();
		$pages['previous'] = $this->getPreviousPage();
		$pages['current']  = $pageNum;
		
		$showPages = ($showPages) ? $showPages : SHOW_PAGE_LIST;
		// at first
		if ($pageNum == 1) {
			// case of 1 page only
			// if ($lastPage == $pageNum) return array(1);
			for ($i = 0; $i < $showPages; $i++) {
				if ($i == $lastPage) break;
				array_push($arr, $i + 1);
			}
			$pages['pages']     = $arr;
			//$pages['showLast']  = ($arr[count($arr)-1] == $lastPage) ? 0 : $lastPage;
			$pages['showLast']  =  $lastPage;
			$pages['showFirst'] = 0;
			return $pages;
		}
		// at last
		if ($pageNum == $lastPage) {
			$start = $lastPage - $showPages;
			if ($start < 1) $start = 0;
			for ($i = $start; $i < $lastPage; $i++)	{
				array_push($arr, $i + 1);
			}
			$pages['pages']     = $arr;
			$pages['showLast']  = 0;
			//$pages['showFirst'] = ($arr[0] == 1) ? 0 : 1;
			$pages['showFirst'] =  1;
			return $pages;
		}
		// at middle
		$middle = floor($showPages/2);
		$remain = 0;
		$start  = $pageNum - $middle;
		if ($start < 1) {
			$remain -= ($start - 1);
			$start = 1;
		}
		if($showPages % 2 == 0) {
			$end = $pageNum + $middle - 1;
		} else {
			$end = $pageNum + $middle;
		}
		$end += $remain;
		if($end > $lastPage) {
			$remain = $end - $lastPage;
			$start -= $remain;
			$end = $lastPage;
			if ($start < 1) $start = 1;
		}
		for ($i = $start; $i <= $end; $i++) {
			array_push($arr, $i );
		}
		//$pages['showLast'] = ($arr[count($arr)-1] == $lastPage) ? 0 : $lastPage;
		$pages['showLast']  = $lastPage;
		//$pages['showFirst'] = ($arr[0] == 1) ? 0 : 1;
		$pages['showFirst'] =  1;
		$pages['pages'] 	= $arr;
		return $pages;
	}
	
	/* Get Page links */
	function getPaginationLinks($showPages=0, $pageUrl='') {
		$pages = $this->getSurroundingPages($showPages);
		global $url;
		if(!$pageUrl){
			$pageUrl = $url;
		}
		//Get URL for each link
		$pages['nextPage'] 	   = $pages['next'] ? $pages['next'] : 0;
		$pages['lastPage'] 	   = $pages['showLast'] ? $pages['showLast'] : 0;
		$pages['next'] 		   = $pages['next'] ? addUrlParams($pageUrl, array('page' => $pages['next'])) : 0;
		$pages['previousPage'] = $pages['previous'] ? $pages['previous'] : 0;
		$pages['previous'] 	   = $pages['previous'] ? addUrlParams($pageUrl, array('page' => $pages['previous'])) : 0;
		$pages['showLast'] 	   = $pages['showLast'] ? addUrlParams($pageUrl, array('page' => $pages['showLast'])) : 0;
		$pages['showFirst']    = $pages['showFirst'] ? addUrlParams($pageUrl, array('page' => $pages['showFirst'])) : 0;
		foreach($pages['pages'] as $key => $value) {
			$pages['pages'][$key] = array('link' =>addUrlParams($pageUrl, array('page' => $value)), 'page' => $value);
		}
		return $pages;
	}
}
?>