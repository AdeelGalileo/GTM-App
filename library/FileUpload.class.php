<?php
/**
 * File uploader class (from qq_uploader)
 * User: ssergy
 * Date: 14.02.12
 * Time: 12:40
 *
 */


/**
 * Handle file uploads via regular form post (uses the $_FILES array)
 */
 
@ini_set('max_execution_time', 0);
class FileUpload
{
    private $allowedExtensions = array();
    private $sizeLimit = 5120000;
    private $file;
	private $fileName;
	private $isFirst;
	private $isLast;

    private $mSavedFile;

    function __construct(array $allowedExtensions = array(), $sizeLimit = 5120000)
    {
        $allowedExtensions = array_map("strtolower", $allowedExtensions);

        $this->allowedExtensions = $allowedExtensions;
        $this->sizeLimit = $sizeLimit;

        $this->checkServerSettings();
		
		$this->isFirst = true;
		$this->isLast = true;

        if (isset($_GET['qqfile']))
        {
            $this->file = new qqUploadedFileXhr();
        }
        elseif (isset($_FILES['qqfile']))
        {
            $this->file = new qqUploadedFileForm();
        } 
		elseif(isset($_REQUEST['ax-file-name']))
		{
			$this->file = new ajaxFileUploaderXhr();
			$this->isFirst = ($_REQUEST['ax-start-byte'] == 0);
			$this->isLast = $_REQUEST['isLast'];
		} elseif($_FILES['ax-files']){
			$this->file = new ajaxFileUploader();
		}
        else
        {
            $this->file = false;
        }
    }

    private function checkServerSettings()
    {
        $postSize = $this->toBytes(ini_get('post_max_size'));
        $uploadSize = $this->toBytes(ini_get('upload_max_filesize'));

        if ($postSize < $this->sizeLimit || $uploadSize < $this->sizeLimit)
        {
            $size = max(1, $this->sizeLimit / 1024 / 1024) . 'M';
            die("{'error':'increase post_max_size and upload_max_filesize to $size'}");
        }
    }

    private function toBytes($str)
    {
        $val = trim($str);
        $last = strtolower($str[strlen($str) - 1]);
        switch ($last)
        {
            case 'g':
                $val *= 1024;
            case 'm':
                $val *= 1024;
            case 'k':
                $val *= 1024;
        }
        return $val;
    }

    /**
     * Returns array('success'=>true) or array('error'=>'error message')
     */
    function handleUpload($uploadDirectory, $replaceOldFile = FALSE)
    {
        if (!is_writable($uploadDirectory))
        {
			$error = "Server error. Upload directory isn't writable.";
            return array('error' => $error, 'info'=>$error, 'status'=>'error');
        }

        if (!$this->file)
        {
			$error = 'No files were uploaded.';
            return array('error' => $error, 'info'=>$error, 'status'=>'error');
        }

        $size = $this->file->getSize();

        if ($size == 0)
        {
			$error = 'File is empty';
            return array('error' => $error, 'info'=>$error, 'status'=>'error');
        }

        if ($size > $this->sizeLimit)
        {
            $error = 'File is too large';
            return array('error' => $error, 'info'=>$error, 'status'=>'error');
        }
		if(!$this->fileName) {
			$this->fileName = $this->file->getName();
		}
        $pathinfo = pathinfo($this->fileName);
        $filename = $this->safeFile($pathinfo['filename']);
        //$filename = md5(uniqid());
        $ext = $pathinfo['extension'];
		
		//in_array(strtolower($ext), $this->allowedExtensions)
		//echo strtolower($ext);
		
		//deb($this->allowedExtensions);

        if ($this->allowedExtensions && !in_array(strtolower($ext), $this->allowedExtensions))
        {
            $these = implode(', ', $this->allowedExtensions);
			$error = 'File has an invalid extension, it should be one of ' . $these . '.';
			return array('error' => $error, 'info'=>$error, 'status'=>'error');
        }
		
		$isFirst = $this->isFirst;

        if (!$replaceOldFile && $isFirst)
        {
            /// don't overwrite previous files that were uploaded
            while (file_exists($uploadDirectory . $filename . '.' . $ext))
            {
                $filename .= rand(10, 99);
            }
        }
		
		$fullName = $filename . '.' . $ext;

        if ($this->file->save($uploadDirectory . $fullName))
        {
            $this->mSavedFile = $uploadDirectory . $fullName;
            return array('success' => true, 'name'=> $fullName, 'status'=>'uploaded', 'size'=> $size);
        }
        else
        {
			$error = 'Could not save uploaded file. The upload was cancelled, or server error encountered';
            return array('error' => $error, 'status'=>'error', 'info' => $error);
        }

    }


    public function GetSavedFile()
    {
        return $this->mSavedFile;
    }
	
	//Function to make the upload file as safe file
	public function safeFile($fileName)
	{
		//skip the special characters other than dot(.) and _
		$find = array('/[^a-z0-9\_\.]/i', '/[\_]+/');
		$repl = array('_', '_');
		$fileName = preg_replace ($find, $repl, $fileName);
		return (strtolower($fileName));
	}
}

class ajaxFileUploaderXhr
{
	function save($path)
	{
		$currByte	= $_REQUEST['ax-start-byte'];
		$html5fsize	= $_REQUEST['ax-fileSize'];
		$flag			= ($currByte==0) ? 0:FILE_APPEND;
		$receivedBytes	= file_get_contents('php://input');
		//strange bug on very fast connections like localhost, some times cant write on file
		//TODO future version save parts on different files and then make join of parts
	    while(@file_put_contents($path, $receivedBytes, $flag) === false)
	    {
	    	usleep(50);
	    }
		return true;
	}
		
	function getName()
    {
        return $_GET['ax-file-name'];
    }
	function getSize() {
		return ($_REQUEST['ax-fileSize']);
	}
}

class ajaxFileUploader
{
	function save($path)
	{
		foreach ($_FILES['ax-files']['error'] as $key => $error)
		{
			if ($error != UPLOAD_ERR_OK) return false;
			if(!move_uploaded_file($_FILES['ax-files']['tmp_name'][$key], $path))
			{
				return false;
			}
			return true;
		}
	}
		
	function getName()
    {
        return $_GET['ax-file-name'];
    }
	function getSize() {
		return ($_REQUEST['ax-fileSize']);
	}
}


/**
 * Handle file uploads via XMLHttpRequest
 */
class qqUploadedFileXhr
{
    /**
     * Save the file to the specified path
     * @return boolean TRUE on success
     */
    function save($path)
    {
        $input = fopen("php://input", "r");
        $temp = tmpfile();
        $realSize = stream_copy_to_stream($input, $temp);
        fclose($input);

        if ($realSize != $this->getSize())
        {
            return false;
        }

        $target = fopen($path, "w");
        fseek($temp, 0, SEEK_SET);
        stream_copy_to_stream($temp, $target);
        fclose($target);

        return true;
    }
	
    function getName()
    {
        return $_GET['qqfile'];
    }
	function getSize()
    {
        if (isset($_SERVER["CONTENT_LENGTH"]))
        {
            return (int)$_SERVER["CONTENT_LENGTH"];
        } else
        {
            throw new Exception('Getting content length is not supported.');
        }
    }
}
/**
 * Handle file uploads via regular form post (uses the $_FILES array)
 */
class qqUploadedFileForm
{
    /**
     * Save the file to the specified path
     * @return boolean TRUE on success
     */
    function save($path)
    {
        if(!move_uploaded_file($_FILES['qqfile']['tmp_name'], $path))
        {
            return false;
        }
        return true;
    }

    function getName()
    {
        return $_FILES['qqfile']['name'];
    }
    
    function getSize()
    {
        return $_FILES['qqfile']['size'];
    }
}