<?php
class cache
{
	private $scanDir;
	private $cacheDir;
	private $cacheTime;
	function __construct($cacheDir='', $cacheTime=0){
		$this->cacheDir = $cahcheDir ? $cacheDir : CACHE_PATH.DS;
		$this->cacheTime = $cacheTime? $cacheTime : 20*60;//20 Mins
	}
	//Function to write contents in a cache file
	function writeCache($cacheFile, $content)
	{
		$fp = fopen($this->cacheDir.$cacheFile,'w');
		if($fp){
			fwrite($fp, serialize($content));
			fclose($fp);
			return true;
		}
		return false;
	}
	//Function to read cache file
	function readCache($cacheFile)
	{
		$res = '';
		if(file_exists($this->cacheDir.$cacheFile)){
			$currentTime = time();
			$stat = stat($this->cacheDir.$cacheFile);
			//$fileTime = filectime($this->cacheDir.$cacheFile);
			$fileTime = $stat[9];
			if (($currentTime - $fileTime) <= $this->cacheTime){
				$res = file_get_contents($this->cacheDir.$cacheFile);
				return unserialize($content);
			} else {
				@unlink($this->cacheDir.$cacheFile);
			}
		} 
		return $res;
	}
	//Function to delete a cache file
	function deleteCache($cacheFile)
	{
		if(@unlink($this->cacheDir.$cacheFile)) {
			return true;
		} else {
			return false;
		}
	}
	//Get the Files in Cache Directory
	function scanDirectory($cacheDir)
	{
		$files = scandir(cacheDir);
		if(is_array($files)) {
			if(count($files)>2) {
				array_shift($files);
				array_shift($files);
				return $this->scanDir = $files;
			} else {
				return false; 
			} 
		} else {
			return; 
		}
	}
	//Function to Delete Files in cache Directory
	public function deleteDirecotry($cacheDir, $pattern = '')
	{
		if($this->scanDirectory($cacheDir)){
			if($this->scanDir) {
				foreach($this->scanDir as $k=>$v) {
					if($pattern && preg_match($pattern, $v, $matches))
						@unlink($v);
					else if(!$pattern) 
						@unlink($v); 
				}
				return true;
			} else {
				return false;
			}
		}
		return false;
	}
	
	function __destruct(){
		unset($this->scanDir);
	}
	
}
?>