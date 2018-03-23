<?php
class multiplePreview{
	
	public function setUpSelectedClients($userName, $password, $clientList){
            
            $url ='https://previews-api.litmus.com/api/v1/EmailTests';  
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_USERPWD, "$userName:$password");
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/json","Accept: application/json", "Content-length: ".strlen($clientList)));
            curl_setopt($ch, CURLOPT_POSTFIELDS, $clientList);   
            curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
            curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

            $output = curl_exec($ch);
            $result = json_decode($output);
            curl_close($ch);
            return $result;
        }
        
        public function getImagePreviewUrls($userName, $password, $apiUniqueId){
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL,"https://previews-api.litmus.com/api/v1/EmailTests/".$apiUniqueId);
            curl_setopt($ch, CURLOPT_USERPWD, $userName.":".$password);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/xml","Accept: application/xml")); 
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER,false );
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false );
            $contents = curl_exec($ch);

            $result = simplexml_load_string($contents);
            curl_close($ch);
            return $result;
        }
}
?>