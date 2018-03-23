<?php
class templateImage {
	/* Create html file for the template */
	public function uploadHtmlTemplate($file, $tmpContent)
	{
		touch($file);
		$filename = $file;
		$fp = fopen($filename, "w+");
		$string = str_replace('/\r\n/','',$tmpContent);
		$write = fputs($fp, $string);
		fclose($fp);	
	}

	/* Convert Image from url*/
	public function convertImage($url)
	{
		$ch = curl_init(); 
		curl_setopt($ch, CURLOPT_URL, $url); 
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
		$output = curl_exec($ch); 
		curl_close($ch);
		return $output;
	}
	
	/* Store the converted image in system */
	function createTemplateImages($imgURL, $uploadFolder)
	{
		require_once(ROOT_PATH.'/library/class.image.php');

		$imgName = basename($imgURL);
		
		$imageData = file_get_contents($imgURL);
		
		if (!is_dir($uploadFolder)) {
			mkdir($uploadFolder);         
		}
		$localName = $uploadFolder.'/'.$imgName;
		file_put_contents($localName, $imageData);
		$thumbImage = new simpleImage();
		$thumbImage->load($localName);
		$thumbImage->createThumb(1000);
		$localJpegName = getJpgFileName($localName);
		$thumbImage->saveThumb($localJpegName);
		$dbJpgName = getJpgFileName($imgName);
		@unlink($localName);
		return $dbJpgName;
	}

}
?>