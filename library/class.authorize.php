<?php
    require_once(SITE_PATH.DS.'library/AuthNet/autoload.php');

    use net\authorize\api\contract\v1 as AnetAPI;
    use net\authorize\api\controller as AnetController;
    define("AUTHORIZENET_LOG_FILE", "phplog.log");

    define('AUTHORIZE_LOGIN_ID','563XcynE4sQ');//Test
    //define('AUTHORIZE_LOGIN_ID','32KyWn9Hw');//Live
    define('AUTHORIZE_TRANSACTION_KEY','38q5Vt2CgJz66hC5');//Test
    //define('AUTHORIZE_TRANSACTION_KEY','3X9W98jz42M82Sn6');//Live 
    define('API_MODE', \net\authorize\api\constants\ANetEnvironment::SANDBOX);//Test
    //define('API_MODE', \net\authorize\api\constants\ANetEnvironment::PRODUCTION);//Live
    define('MERCHANT_ID', '');
	

    class AuthorizePayment {
        public $params;
        public $merchantAuthentication;
        
        /**
        * Function to construct Merchant Authentication
        */
        function __construct() {
            $this->merchantAuthentication = new AnetAPI\MerchantAuthenticationType();
            $this->merchantAuthentication->setName(AUTHORIZE_LOGIN_ID);
            $this->merchantAuthentication->setTransactionKey(AUTHORIZE_TRANSACTION_KEY);
        }
        
        /**
        * Function to authorize credit card
        * @params: $cardNumber - string
        * @params: $exprityDate - string
        * @params: $payment - float
        */
        function auhtorizeCreditCard($cardNumber, $expiryDate, $payment) {
            $creditCard = new AnetAPI\CreditCardType();
            $creditCard->setCardNumber($cardNumber);
            $creditCard->setExpirationDate($expiryDate);
            $paymentOne = new AnetAPI\PaymentType();
            $paymentOne->setCreditCard($creditCard);
            $transactionRequestType = new AnetAPI\TransactionRequestType();
            $transactionRequestType->setTransactionType( "authOnlyTransaction"); 
            $transactionRequestType->setAmount($payment);
            $transactionRequestType->setPayment($paymentOne);

            $request = new AnetAPI\CreateTransactionRequest();
            $request->setMerchantAuthentication($this->merchantAuthentication);
            $request->setRefId($refId);
            $request->setTransactionRequest($transactionRequestType);

            $controller = new AnetController\CreateTransactionController($request);
            $response = $controller->executeWithApiResponse( API_MODE );
            if ($response != null) {
                $tresponse = $response->getTransactionResponse();
                if (($tresponse != null) && ($tresponse->getResponseCode()=="1") ) {
                    return array('success'=>true, 'authCode' => $tresponse->getAuthCode(), 'transactionId'=> $tresponse->getTransId());
                }  elseif ($tresponse != null && $tresponse->getResponseCode()=="2") {
					$errorTextObj = $tresponse->getErrors();
					$errorText = $errorTextObj[0]->getErrorText();
					return array('success'=>false, 'code' => $tresponse->getResponseCode(), 'message' => $errorText);
				} else {
                    $strErrorTxtObj = $response->getMessages()->getMessage();
                    $strErrorText = $strErrorTxtObj[0]->getText();
                    return array('success'=>false, 'code' => $response->getMessages()->getResultCode(), 'message' => $strErrorText);
                }
            } else {
                return array('success'=>false, 'message' => 'Invalid Card');
            }
        }
            
        /**
        * Function to add customer 
        * @params: $cardNumber - string
        * @params: $expiryDate - string
        * @params: $ccv - string
        * @params: $firstName - string
        * @params: $lastName - string
        * @params: $company - string
        * @params: $address - string
        * @params: $city - string
        * @params: $state - string
        * @params: $zip - string
        * @params: $country - string
        * @params: $email - string
        * @return: array with status and profile ids.
        */
        function addCustomer($cardNumber, $expirtyDate, $ccv, $firstName, $lastName, $company, $address, $city, $state, $zip, $country, $email) {
            $creditCard = new AnetAPI\CreditCardType();
            $creditCard->setCardNumber($cardNumber);
            $creditCard->setExpirationDate( $expirtyDate );
            $creditCard->setCardCode($ccv);
            $paymentCreditCard = new AnetAPI\PaymentType();
            $paymentCreditCard->setCreditCard($creditCard);

            // Create the Bill To info
            $billto = new AnetAPI\CustomerAddressType();
            $billto->setFirstName($firstName);
            $billto->setLastName($lastName);
            $billto->setCompany($company);
            $billto->setAddress($address);
            $billto->setCity($city);
            $billto->setState($state);
            $billto->setZip($zip);
            $billto->setCountry($country);

            // Create a Customer Profile Request
            // 1. create a Payment Profile
            // 2. create a Customer Profile   
            // 3. Submit a CreateCustomerProfile Request
            // 4. Validate Profiiel ID returned

            $paymentprofile = new AnetAPI\CustomerPaymentProfileType();
            $paymentprofile->setCustomerType('individual');
            $paymentprofile->setBillTo($billto);
            $paymentprofile->setPayment($paymentCreditCard);
            $paymentprofiles[] = $paymentprofile;
            $customerprofile = new AnetAPI\CustomerProfileType();
            //$customerprofile->setDescription("Customer 2 Test PHP");
            $merchantCustomerId = time().rand(1,150);
            $customerprofile->setMerchantCustomerId($merchantCustomerId);
            $customerprofile->setEmail($email);
            $customerprofile->setPaymentProfiles($paymentprofiles);

            $request = new AnetAPI\CreateCustomerProfileRequest();
            $request->setMerchantAuthentication($this->merchantAuthentication);
            $request->setRefId( $refId);
            $request->setProfile($customerprofile);
            $controller = new AnetController\CreateCustomerProfileController($request);
            $response = $controller->executeWithApiResponse(API_MODE);
            if (($response != null) && ($response->getMessages()->getResultCode() == "Ok") ) {
                $customerPaymentObj = $response->getCustomerPaymentProfileIdList();
                $customerPaymentText = $customerPaymentObj[0];
                return array('success'=>true, 'customerId' =>$response->getCustomerProfileId(), 'profileId' => $customerPaymentText);
                //return array('success'=>true, 'customerId' =>$response->getCustomerProfileId(), 'profileId' => $response->getCustomerPaymentProfileIdList()[0]);
            } else {
                $strGetMessageObj = $response->getMessages()->getMessage();
                $strGetMessageText = $strGetMessageObj[0]->getText();
                $strGetCodeText = $strGetMessageObj[0]->getCode();
                return array('success'=>false, 'message'=> $strGetMessageText, 'code' => $strGetCodeText);
                //return array('success'=>false, 'message'=> $response->getMessages()->getMessage()[0]->getText(), 'code' => $response->getMessages()->getMessage()[0]->getCode());
            }
        }

        /**
        * Get customer profile by id
        * @params: $id - int
        * @return: array
        */
        function getCustomerProfile($id) {
            $request = new AnetAPI\GetCustomerProfileRequest();
            $request->setMerchantAuthentication($this->merchantAuthentication);
            $request->setCustomerProfileId($id);
            $controller = new AnetController\GetCustomerProfileController($request);
            $response = $controller->executeWithApiResponse(API_MODE);
            if (($response != null) && ($response->getMessages()->getResultCode() == "Ok") ) {
                $profileSelected = $response->getProfile();
                $paymentProfilesSelected = $profileSelected->getPaymentProfiles();
                return array('success'=>true, 'response' => $response);
            }  else  {
                $strGetCustomerMessageObj = $response->getMessages()->getMessage();
                $strGetCustomerMessageText = $strGetCustomerMessageObj[0]->getText();
                $strGetCustomerCodeText = $strGetCustomerMessageObj[0]->getCode();
                return array('success'=>false, 'message'=> $strGetCustomerMessageText, 'code' => $strGetCustomerCodeText);
                /*return array('success'=>false, 'message'=> $response->getMessages()->getMessage()[0]->getText(), 
                        'code' => $response->getMessages()->getMessage()[0]->getCode());*/
            }
        }

        function chargeCustomerProfile($profileId, $paymentProfileId, $price) {
            $refId = 'ref' . time();
            $profileToCharge = new AnetAPI\CustomerProfilePaymentType();
            $profileToCharge->setCustomerProfileId($profileId);
            $paymentProfile = new AnetAPI\PaymentProfileType();
            $paymentProfile->setPaymentProfileId($paymentProfileId);
            $profileToCharge->setPaymentProfile($paymentProfile);

            $transactionRequestType = new AnetAPI\TransactionRequestType();
            $transactionRequestType->setTransactionType( "authCaptureTransaction"); 
            $transactionRequestType->setAmount($price);
            $transactionRequestType->setProfile($profileToCharge);

            $request = new AnetAPI\CreateTransactionRequest();
            $request->setMerchantAuthentication($this->merchantAuthentication);
            $request->setRefId( $refId);
            $request->setTransactionRequest( $transactionRequestType);
            $controller = new AnetController\CreateTransactionController($request);
            $response = $controller->executeWithApiResponse(API_MODE);
            if ($response != null) {
                $tresponse = $response->getTransactionResponse();
                if (($tresponse != null) && ($tresponse->getResponseCode()=="1") ) {
                    return array('success'=>true, 'authCode' => $tresponse->getAuthCode(), 'transactionId'=> $tresponse->getTransId(), 
                                'cardNumber'=>$tresponse->getAccountNumber());
                } elseif (($tresponse != null) && ($tresponse->getResponseCode()=="2") ) {
                    return array('success'=>false, 'message' => 'Error in charging');
                } elseif (($tresponse != null) && ($tresponse->getResponseCode()=="4") ) {
                    return array('success'=>false, 'message' => 'Error: Held for review');
                }
           } else {
                return array('success'=>false, 'message' => 'No Response');
           }
        }

        // Delete an existing customer profile
        function deleteExistingCustomerProfile($profileId){
            $refId = 'ref' . time();                      
            $request = new AnetAPI\DeleteCustomerProfileRequest();
            $request->setMerchantAuthentication($this->merchantAuthentication);
            $request->setCustomerProfileId($profileId);

            $controller = new AnetController\DeleteCustomerProfileController($request);
            $response = $controller->executeWithApiResponse( API_MODE );

            if(($response != null) && ($response->getMessages()->getResultCode() == "Ok") ) {
                //echo "DeleteCustomerProfile SUCCESS : " .  "\n";
                return array('success'=>true, 'message' => 'Deleted successfully');
            } else {
                //echo "ERROR : DeleteCustomerProfile: Invalid response\n";
                //echo "Response : " . $response->getMessages()->getMessage()[0]->getCode() . "  " .$response->getMessages()->getMessage()[0]->getText() . "\n";
                $strGetCustomerDeleteMessageObj = $response->getMessages()->getMessage();
                $strGetCustomerDeleteMessageText = $strGetCustomerDeleteMessageObj[0]->getText();
                $strGetCustomerDeleteCodeText = $strGetCustomerDeleteMessageObj[0]->getCode();
                return array('success'=>false, 'message'=> $strGetCustomerDeleteMessageText, 'code' => $strGetCustomerDeleteCodeText);
            }         
        }
    }