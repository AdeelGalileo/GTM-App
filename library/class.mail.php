<?php
class mail
{
	var $sendTo = array();	// To Address Email Details - Array
	var $acc = array();	// CC Email Details - Array
	var $abcc = array();	// BCC Email Details - Array
	var $aattach = array();	// Paths of Attached Files to be attachment along with the mail
	var $xheaders = array();	// List of Message Headers
	var $priorities = array( '1 (Highest)', '2 (High)', '3 (Normal)', '4 (Low)', '5 (Lowest)' );	// prirority of the message for reference
	// Character set of the message
	//var $charset = "iso-8859-1";
	var $charset = "utf-8";
	var $ctencoding = "8bit";
	var $receipt = 0;
	var $contentType = 'text/html';
	//Content-type: text/html; charset=iso-8859-1' . "\r\n";

	/**********************************************************************************************
	** Function : mail
	** Description : construct class - initialize takes part
	** Parameters : N/A
	** Return Type : N/A
	**********************************************************************************************/
	function mail()
	{
        $this->autoCheck( false );
        $this->boundary= "--" . md5( uniqid("myboundary") );
	}
	
	/**********************************************************************************************
	** Function : contentType
	** Description : initialize the content type of the attachment
	** Parameters : $contentType : string
	** Return Type : N/A
	**********************************************************************************************/
	function contentType($contentType)
	{	
	    $this->contentType = $contentType;	   
	}

	/**********************************************************************************************
	** Function : contentType
	** Description : To set the email validation to be checked or not i.e whether email address validation has to be
	**                      activated or devativated
	** Parameters : $bool
	** Return Type : N/A
	**********************************************************************************************/	
	function autoCheck($bool)
	{
        if ($bool)
        	$this->checkAddress = true;
        else
            $this->checkAddress = false;
	}

	/**********************************************************************************************
	** Function : subject
	** Description : defines the subject of the corresponding email	
	** Parameters : $subject : string
	** Return Type : N/A
	**********************************************************************************************/	
	function subject($subject)
	{
		$this->xheaders['Subject'] = strtr( $subject, "\r\n" , "  " );
	}

	/**********************************************************************************************
	** Function : fromEmail
	** Description : defines the send email address detail present in the mail
	** Parameters : $from : string, $fromName : string
	** Return Type : N/A
	**********************************************************************************************/	
	function fromEmail($from, $fromName='')
	{	
        if (! is_string($from)) {
                echo "Class mail: error, From is not a string";
                exit;
        }       
        if ($fromName != "")        	        
        	$this->xheaders["From"] = '"'.$fromName.'" <'.$from.'>';
        else
			$this->xheaders['From'] = $from;		
	}

	/**********************************************************************************************
	** Function : replyTo
	** Description : defines the reply-to email address detail present in the mail
	** Parameters : $address : string
	** Return Type : N/A
	**********************************************************************************************/	
	function replyTo($address)
	{	
        if (! is_string($address))
     	   return false;
        $this->xheaders["Reply-To"] = $address;	
	}

	/**********************************************************************************************
	** Function : receipt
	** Description : add a receipt to the mail ie.  a confirmation is returned to the "From" address )
	**               (or "ReplyTo" if defined when the receiver opens the message.
	** Parameters : N/A
	** Return Type : N/A
	** Warning : this functionality is *not* a standard, thus only some mail clients are compliants.
	**********************************************************************************************/	
	function receipt()
	{
		$this->receipt = 1;
	}

	/**********************************************************************************************
	** Function : toEmail
	** Description : defines the recipient mail address information, accept both a single address or an array of addresses
	** Parameters : toAddress : string
	** Return Type : N/A	
	**********************************************************************************************/	
	function toEmail( $toAddress )
	{	
        $this->sendTo =array();
       // TODO : test validité sur to
        if (is_array( $toAddress ))
        	$this->sendTo= $toAddress;
        else
            $this->sendTo[] = $toAddress;
        if ($this->checkAddress == true)
            $this->checkEmailAddresses( $this->sendTo );	
	}
	
	/**********************************************************************************************
	** Function : ccEmail
	** Description : defines the cc headers (carbon copy) email address(es), accept both array and string	
	** Parameters : toAddress : string/array
	** Return Type : N/A	
	**********************************************************************************************/	
	function ccEmail( $ccEmailAddress )
	{
        if (is_array($ccEmailAddress))
        	$this->acc= $ccEmailAddress;
        else
            $this->acc[]= $ccEmailAddress;
        if ($this->checkAddress == true)
            $this->checkEmailAddresses( $this->acc );	
	}

	/**********************************************************************************************
	** Function : ccEmail
	** Description : defines the Bcc headers ( blank carbon copy ) email address(es), accept both array and string	
	** Parameters : toAddress : string/array
	** Return Type : N/A	
	**********************************************************************************************/	
	function bccEmail( $bccEmailAddress )
	{
        if (is_array($bccEmailAddress)) {
        	$this->abcc = $bccEmailAddress;
        } else {
            $this->abcc[]= $bccEmailAddress;
        }
        if ($this->checkAddress == true)
            $this->checkEmailAddresses( $this->abcc );
	}

	/**********************************************************************************************
	** Function : bodyMessage
	** Description : set the body (message) of the mail, define the charset if the message contains extended
	**                      characters (accent). **Default to us-ascii.
	** Parameters : $body: text, $charset : string
	** Return Type : N/A	
	**********************************************************************************************/	
	function bodyMessage( $body, $charset="" )
	{
        $this->body = $body;
        if ($charset != "") {
        	$this->charset = strtolower($charset);
            if ($this->charset != "us-ascii")
            	$this->ctencoding = "8bit";
        }
	}

	/**********************************************************************************************
	** Function : organization
	** Description : set the organization header
	** Parameters : $org : string
	** Return Type : N/A	
	**********************************************************************************************/	
	function organization( $org )
	{
        if( trim( $org != "" )  )
        	$this->xheaders['Organization'] = $org;
	}

	/**********************************************************************************************
	** Function : organization
	** Description : set the priority of the corresponding mail, integer taken between 1 (highest) and 5 ( lowest )
	** Parameters : $priority : numeric
	** Return Type : N/A	
	**********************************************************************************************/	
	function setPriority( $priority )
	{
        if( ! intval( $priority ) )
                return false;

        if( ! isset( $this->priorities[$priority-1]) )
                return false;

        $this->xheaders["X-Priority"] = $this->priorities[$priority-1];

        return true;
	
	}


	/**********************************************************************************************
	** Function : mailAttach
	** Description : attaches a file to the mail
	** Parameters : $filename : (string) path of the file to attach,
	**                       $filetype : (string) MIME-type of the file. default to 'application/x-unknown-content-type'
	**                       $disposition : instruct the Mailclient to display the file if possible ("inline") or 
	**                                             always as a link ("attachment") possible values are "inline", "attachment"
	** Return Type : N/A	
	**********************************************************************************************/		
	function mailAttach($filename,$filetype = "",$disposition = "inline")
	{	
	        if( $filetype == "" )
	                $filetype = "application/x-unknown-content-type";
	                //$filetype = "text/plain";
	                
	        $this->aattach[] = $filename;
	
	        $this->actype[] = $filetype;
	        $this->adispo[] = $disposition;	
	}

	/**********************************************************************************************
	** Function : buildMail
	** Description : builds the email message
	** Parameters : N/A
	** Return Type : N/A	
	**********************************************************************************************/		
	function buildMail()
	{
	
	        // build the headers
	        $this->headers = "";
	//        $this->xheaders['To'] = implode( ", ", $this->sendTo );
	
	        if( count($this->acc) > 0 )
	                $this->xheaders['CC'] = implode( ", ", $this->acc );
	
	        if( count($this->abcc) > 0 )
	                $this->xheaders['BCC'] = implode( ", ", $this->abcc );
	
	
	        if( $this->receipt ) {
	                if( isset($this->xheaders["Reply-To"] ) )
	                        $this->xheaders["Disposition-Notification-To"] = $this->xheaders["Reply-To"];
	                else
	                        $this->xheaders["Disposition-Notification-To"] = $this->xheaders['From'];
	        }
	
	        if( $this->charset != "" ) {
	                //global $contenttype;
	                $contentType=$this->contentType;
	                $this->xheaders["Mime-Version"] = "1.0";
	                $this->xheaders["Content-Type"] = "$contentType; charset=$this->charset";
	                $this->xheaders["Content-Transfer-Encoding"] = $this->ctencoding;
	        }
	
	        $this->xheaders["X-Mailer"] =  'PHP/'. phpversion();;
	
	        // include attached files
	        if( count( $this->aattach ) > 0 ) {
	
	                $this->buildAttachment();
	        } else {
	                $this->fullBody = $this->body;
	        }
	
	        reset($this->xheaders);
	        while( list( $hdr,$value ) = each( $this->xheaders )  ) {
	                if( $hdr != "Subject" )
	                        $this->headers .= "$hdr: $value\r\n";
	        }
	}

	/**********************************************************************************************
	** Function : sendMail
	** Description : formats the message and sent the mail
	** Parameters : N/A
	** Return Type : N/A	
	**********************************************************************************************/		
	function sendMail()
	{
	        $this->buildMail();
	
	        $this->strTo = implode( ", ", $this->sendTo );
	
	        $res = @mail( $this->strTo, $this->xheaders['Subject'], $this->fullBody, $this->headers,'-f alert@abovelive.com' );	
	}
	
	/**********************************************************************************************
	** Function : sendMail
	** Description : return the whole e-mail , headers + message, can be used for displaying 
	**                       the message in plain text or logging it
	** Parameters : N/A
	** Return Type : N/A	
	**********************************************************************************************/		
	function displayMail()
	{
	        $this->buildMail();
	        $this->strTo = implode( ", ", $this->sendTo );
	        $mail = "To: " . $this->strTo . "\r\n";
	        $mail .= $this->headers . "\r\n";
	        $mail .= $this->fullBody;
	        return $mail;
	}

	/**********************************************************************************************
	** Function : sendMail
	** Description : checks the email address is valid or not
	** Parameters : $address : string
	** Return Type : N/A	
	**********************************************************************************************/		
	function validEmail($address)
	{
	        if( ereg( ".*<(.+)>", $address, $regs ) ) {
	                $address = $regs[1];
	        }
	         if(ereg( "^[^@  ]+@([a-zA-Z0-9\-]+\.)+([a-zA-Z0-9\-]{2}|net|com|gov|mil|org|edu|int|co.uk|co.in|in|de)\$",$address) )
	                 return true;
	         else
	                 return false;
	}

	/**********************************************************************************************
	** Function : checkEmailAddresses
	** Description : check validity of email addresses, returns if unvalid, output an error message and exit,
	**                            this may -should- be customized
	** Parameters : $aad : array
	** Return Type : N/A	
	**********************************************************************************************/		
	function checkEmailAddresses( $aad )
	{
	        for($i=0;$i< count( $aad); $i++ ) {
	                if( ! $this->validEmail( $aad[$i]) ) {
	                        echo "Class Mail, method Mail : invalid address $aad[$i]";
	                        exit;
	                }
	        }
	}

	/**********************************************************************************************
	** Function : buildAttachment()
	** Description : check and encode attach file(s) . internal use only
	** Parameters : N/A
	** Return Type : N/A	
	**********************************************************************************************/		
	function buildAttachment()
	{
	
	        $this->xheaders["Content-Type"] = "multipart/mixed;\r\n boundary=\"$this->boundary\"";
	
	        $this->fullBody = "This is a multi-part message in MIME format.\r\n--$this->boundary\r\n";
	        $this->fullBody .= "Content-Type: text/html; charset=$this->charset\r\nContent-Transfer-Encoding: $this->ctencoding\r\n\r\n" . $this->body ."\r\n";
	
	        $sep= chr(13) . chr(10);
	
	        $ata= array();
	        $k=0;
	        // for each attached file, do...
	        for( $i=0; $i < count( $this->aattach); $i++ ) {
	
	                $filename = $this->aattach[$i];
	                $basename = basename($filename);
	                $ctype = $this->actype[$i];        // content-type
	                $disposition = $this->adispo[$i];
	                /*getting the original name of the file */
	
	                //echo $original_filename;
	
	                if( ! file_exists( $filename) ) {
	                        echo "Class Mail, method attach : file $filename can't be found"; exit;
	                }
	
	               /* echo 'filename--'.$filename;
	                  echo '<br>';
	               */
	
	                /*	
	                   the semicolon after the Content-type : $basename is important
	                   since it was not there.This mail program
	                   was not able to see the attachment for the past 1 month
	               */
	
	                $subhdr= "--$this->boundary\r\nContent-Type: $ctype;\r\n name=\"$basename\";\r\nContent-Transfer-Encoding: base64\r\nContent-Disposition: $disposition;\r\n  filename=\"$basename\"\r\n";
	                //$subhdr= "--$this->boundary\r\nContent-type: $ctype;\r\n name=\"$filename\"\r\nContent-Transfer-Encoding: base64\r\nContent-Disposition: $disposition;\r\n  filename=\"$filename\"\r\n";
	                $ata[$k++] = $subhdr;
	                // non encoded line length
	                $linesz= filesize( $filename)+1;
	                $fp= fopen( $filename, 'r' );
	                $ata[$k++] = chunk_split(base64_encode(fread( $fp, $linesz)));
	
	                fclose($fp);
	
	        }
	
	        $this->fullBody .= implode($sep, $ata);
	
	        //echo $this->fullBody;
	}


} // class mail

?>