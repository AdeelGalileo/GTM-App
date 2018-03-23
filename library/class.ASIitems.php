<?php
class ASIproducts{
	
	public function getASIcategories($userName, $password, $terms){
            $terms = $terms ? $terms : 'ac';
            $url ='http://api.asicentral.com/v1/lists/auto_complete/category.json?term='.$terms;  
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_URL, $url);

            $output = curl_exec($ch);
            $result = json_decode($output);
            curl_close($ch);
            return $result;
        }
        
        public function getASIProductByCategory($clientId, $client_secret, $category){
        $userAgent = $_SERVER['HTTP_USER_AGENT'];
        $category = rawurlencode(':'.$category);
        $headers = array(
              "Content-Type: application/json","Accept: application/json","Host: api.asicentral.com","User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36","Authorization: AsiMemberAuth client_id=$clientId&client_secret=$client_secret"
        );

            $url ='http://api.asicentral.com/v1/products/search.json?q=category'.$category;  
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_USERAGENT, $userAgent);
            curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
            curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

            $output = curl_exec($ch);
            $result = json_decode($output);
            curl_close($ch);
            return $result;
        }
        
        public function getASIProductById($clientId, $client_secret, $productId){
        $userAgent = $_SERVER['HTTP_USER_AGENT'];
        $headers = array(
              "Content-Type: application/json","Accept: application/json","Host: api.asicentral.com","User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36","Authorization: AsiMemberAuth client_id=$clientId&client_secret=$client_secret"
        );

            $url ='http://api.asicentral.com/v1/products/search.json?q=id:'.$productId;  
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_USERAGENT, $userAgent);
            curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
            curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

            $output = curl_exec($ch);
            $result = json_decode($output);
            curl_close($ch);
            return $result;
        }
}
?>