<?php
/*
* File: SimpleImage.php
* Author: Simon Jarvis
* Copyright: 2006 Simon Jarvis
* Date: 08/11/06
* Link: http://www.white-hat-web-design.co.uk/articles/php-image-resizing.php
* 
* This program is free software; you can redistribute it and/or 
* modify it under the terms of the GNU General Public License 
* as published by the Free Software Foundation; either version 2 
* of the License, or (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful, 
* but WITHOUT ANY WARRANTY; without even the implied warranty of 
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
* GNU General Public License for more details: 
* http://www.gnu.org/licenses/gpl.html
*
*/
//Set Maximum Memory limit
@ini_set('memory_limit', '120M');
class simpleImage {
   
   public $image;
   public $image_type;
   public $thumbImage;
   /* Load a image file to memory */
   function load($filename) {
      $image_info = getimagesize($filename);
      $this->image_type = $image_info[2];
      if( $this->image_type == IMAGETYPE_JPEG ) {
         $this->image = imagecreatefromjpeg($filename);
      } elseif( $this->image_type == IMAGETYPE_GIF ) {
         $this->image = imagecreatefromgif($filename);
      } elseif( $this->image_type == IMAGETYPE_PNG ) {
         $this->image = imagecreatefrompng($filename);
      } else {
	  	echo 'Error Reading input file';
	  }
   }
   /* Save the file into a directory */
   function save($filename, $image_type=IMAGETYPE_JPEG, $compression=100, $permissions=0755) {
      if( $this->image_type == IMAGETYPE_JPEG ) {
         imagejpeg($this->image,$filename,$compression);
      } elseif( $this->image_type == IMAGETYPE_GIF ) {
         imagegif($this->image,$filename);         
      } elseif( $this->image_type == IMAGETYPE_PNG ) {
         imagepng($this->image,$filename);
      }   
      if( $permissions != null) {
         //chmod($filename,$permissions);
      }
   }
   
   
   function resizeThumbnailImage($thumb_image_name, $image, $width, $height, $start_width, $start_height, $scale){
	$newImageWidth = ceil($width * $scale);
	$newImageHeight = ceil($height * $scale);
	$newImage = imagecreatetruecolor($newImageWidth,$newImageHeight);
	$source = imagecreatefromjpeg($image);
	imagecopyresampled($newImage,$source,0,0,$start_width,$start_height,$newImageWidth,$newImageHeight,$width,$height);
	imagejpeg($newImage,$thumb_image_name,90);
	chmod($thumb_image_name, 0777);
	return $thumb_image_name;
}
   /* Write the image to the screen */
   function output($image_type=IMAGETYPE_JPEG) {
      if( $this->image_type == IMAGETYPE_JPEG ) {
		  header("Content-type:  image/jpg");
          imagejpeg($this->image);
      } elseif( $this->image_type == IMAGETYPE_GIF ) {
		  header("Content-type:  image/gif");
          imagegif($this->image);         
      } elseif( $this->image_type == IMAGETYPE_PNG ) {
		  header("Content-type:  image/png");
          imagepng($this->image);
      }
	  exit;
   }
   /* Get the width of the image */
   function getWidth() {
      return imagesx($this->image);
   }
   /* Get the Height of the image */
   function getHeight() {
      return imagesy($this->image);
   }
   /* Resize the image to given Height (Width can vary)*/
   function resizeToHeight($height) {
      if($height > $this->getHeight())
	  	return;
	  $ratio = $height / $this->getHeight();
      $width = $this->getWidth() * $ratio;
      $this->resize($width,$height);
   }
   /* Resize the image to given Width (Height can vary)*/
   function resizeToWidth($width) {
   	  if($width > $this->getWidth())
	  	return;
      $ratio = $width / $this->getWidth();
      $height = $this->getheight() * $ratio;
      $this->resize($width,$height);
   }
   /* Scale the image in percentage */
   function scale($scale) {
      $width = $this->getWidth() * $scale/100;
      $height = $this->getheight() * $scale/100; 
      $this->resize($width,$height);
   }
   /* Resize the image to given height and width */
   function resize($width,$height) {
      $new_image = imagecreatetruecolor($width, $height);
	  if( $this->image_type == IMAGETYPE_PNG){
	  	imagealphablending($new_image, false);
	  }
      imagecopyresampled($new_image, $this->image, 0, 0, 0, 0, $width, $height, $this->getWidth(), $this->getHeight());
	  if( $this->image_type == IMAGETYPE_PNG){
	  	imagesavealpha($new_image, true);
	  }
      $this->image = $new_image;
   }
   /* Resize the image to given max width or max height depends on dimensions of the image */
   function resizeToFit($maxWidth, $maxHeight)
   {
		// original dimensions
		$w = $this->getWidth();
		$h = $this->getHeight();
		//Do nothing image is width & height less than max width & height
		if($w <= $maxWidth && $h <= $maxHeight) {
			return;
		}
	
		// Longest and shortest dimension
		$longestDimension = ($w > $h)? $w : $h;
		$shortestDimension = ($w < $h)? $w : $h;
	
		// propotionality
		$factor = ((float) $longestDimension) / $shortestDimension;
	
		// default width is greater than height
		$newWidth = $maxWidth;
		$newHeight = $maxWidth / $factor;
	
		// if height greater than width recalculate
		if ($w < $h )
		{
			$newWidth = $maxHeight / $factor;
			$newHeight = $maxHeight;
		}
		// Resize the image
		$this->resize($newWidth,$newHeight);
   }
   /* Return the Image for further use in any other classes */
   function getImage()
   {
   		return ($this->image);
   }
   /*Function to crop the images to given width and height*/
   function cropImage($width, $height, $centre=false)
   {
		$this->thumbImage = $this->resizeImage($width, $height, true, array(), $centre);
   }
   /* Function to create a thumbnail image as square */
   function createThumb($thumbSize, $crop=true)
   {
   		//$backgroundColor = array('red'=> 0, 'green' => 0, 'blue' => 0);
		$this->thumbImage = $this->resizeImage($thumbSize, $thumbSize, $crop);
		//To make image as transparent;
		//imagecolortransparent($this->thumbImage, $backgroundColor);
   }
   /* Function to save thumbnail image */
   function saveThumb($fileName, $fileType = 'jpg')
   {
   	  if($fileType == 'jpg') {
	  	$jpgFile = getJpgFileName($fileName);
		imagejpeg($this->thumbImage, $jpgFile, 100);
	  } else {
   	  	$pngFile = getPngFileName($fileName);
	  	imagepng($this->thumbImage, $pngFile, 9);
	  }
   }
   /* Function to display thumb image */
   function outputThumb()
   {
   		header("Content-type:  image/jpg");
        imagepng($this->thumbImage);
		exit;
   }

    function fitImage($destWidth, $destHeight)
   {
    // $type (true=crop to fit, false=letterbox)
		$srcWidth = imagesx($this->image);
		$srcHeight = imagesy($this->image);
		
		$source_aspect_ratio = $srcWidth / $srcHeight;
		$desired_aspect_ratio = $destWidth / $destHeight;
		
		if ($source_aspect_ratio > $desired_aspect_ratio) {
			/*
			 * Triggered when source image is wider
			 */
			$temp_height = $destHeight;
			$temp_width = ( int ) ($destHeight * $source_aspect_ratio);
		} else {
			/*
			 * Triggered otherwise (i.e. source image is similar or taller)
			 */
			$temp_width = $destWidth;
			$temp_height = ( int ) ($destWidth / $source_aspect_ratio);
		}
		
		/*
		 * Resize the image into a temporary GD image
		 */
		
		$temp_gdim = imagecreatetruecolor($temp_width, $temp_height);
		imagecopyresampled(
			$temp_gdim,
			$this->image,
			0, 0,
			0, 0,
			$temp_width, $temp_height,
			$srcWidth, $srcHeight
		);
		
		/*
		 * Copy cropped region from temporary image into the desired GD image
		 */
		
		$x0 = ($temp_width - $destWidth) / 2;
		$y0 = ($temp_height - $destHeight) / 2;
		$desired_gdim = imagecreatetruecolor($destWidth, $destHeight);
		imagecopy(
			$desired_gdim,
			$temp_gdim,
			0, 0,
			$x0, $y0,
			$destWidth, $destHeight
		);
		$this->thumbImage =  $desired_gdim;
	}
   
   
   function resizeImage($destWidth, $destHeight, $type = true, $backgroundColor = array(), $centre=false)
   {
    // $type (true=crop to fit, false=letterbox)
		$srcWidth = imagesx($this->image);
		$srcHeight = imagesy($this->image);
		
		$srcRatio = $srcWidth / $srcHeight;
		$destRatio = $destWidth / $destHeight;
		
		if ($type) {
			// crop to fit
			if ($srcRatio > $destRatio) {
				// source has a wider ratio
				$tempWidth = (int)($srcHeight * $destRatio);
				$tempHeight = $srcHeight;
				$srcX = (int)(($srcWidth - $tempWidth) / 2);
				$srcY = 0;
			} else {
				// source has a taller ratio
				$tempWidth = $srcWidth;
				$tempHeight = (int)($srcWidth * $destRatio);
				$srcX = 0;
				$srcY = (int)(($srcHeight - $tempHeight) / 2);
			}
			$destX = 0;
			$destY = 0;
			$srcWidth = $tempWidth;
			$srcHeight = $tempHeight;
			/* Get the image from top left other wise comment below line to get the image from centre. */
			if(!$centre) {
				$srcX = 0;
				$srcY = 0;
			}
			$newDestWidth = $destWidth;
			$newDestHeight = $destHeight;
			
		} else {
			// letterbox
			if ($srcRatio < $destRatio) {
				// source has a taller ratio
				$tempWidth = (int)($destHeight * $srcRatio);
				$tempHeight = $destHeight;
				$destX = (int)(($destWidth - $tempWidth) / 2);
				$destY = 0;
			} else {
				// source has a wider ratio
				$tempWidth = $destWidth;
				$tempHeight = (int)($destWidth / $srcRatio);
				$destX = 0;
				$destY = (int)(($destHeight - $tempHeight) / 2);
			}
			$srcX = 0;
			$srcY = 0;
			$newDestWidth = $tempWidth;
			$newDestHeight = $tempHeight;
		}
		$destImage = imagecreatetruecolor($destWidth, $destHeight);
		if (!$type) {
			$red = isset($backgroundColor['red']) ? $backgroundColor['red'] : 255;
			$green = isset($backgroundColor['green']) ? $backgroundColor['green'] : 255;
			$blue = isset($backgroundColor['blue']) ? $backgroundColor['blue'] : 255;
			imagefill($destImage, 0, 0, imagecolorallocate ($destImage, $red, $green, $blue));
		}
		
		imagecopyresampled($destImage, $this->image, $destX, $destY, $srcX, $srcY, $newDestWidth, $newDestHeight, $srcWidth, $srcHeight);
		$this->thumbImage =  $destImage;
		return $destImage;
	}
   
   function __destruct()
   {
   		if($this->thumbImage){
			@imagedestroy($this->thumbImage);
		}
		@imagedestroy($this->image);
   }
}
?>
