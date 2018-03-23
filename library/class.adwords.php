<?php
/**
 * Class to manage adwords API Functionalities
 */
require_once UTIL_PATH . '/ErrorUtils.php';

class adwordsAPI 
{
	public $user;
	public $customerId;
	
	function __construct($customerId)
	{
		$this->user = new AdWordsUser();
		$this->user->LogAll();
		$this->user->SetClientCustomerId($customerId);
		$this->customerId = $customerId;
	}
	/**
	 * add Budget in adwords api
	 * @params: amount - float
	 * @name: budget name - char
	 * @result: Budget object
	 * $apiObj->addBudget(25, 'checker', )
	 */
	public function addBudget($amount, $name='', $deliveryMethod = '')
	{
		$budgetService = $this->user->GetService('BudgetService', ADWORDS_VERSION);
		$budget = new Budget();
		$budget->name = $name ? $name : 'Budget #' . uniqid();
		$budget->period = 'DAILY';
		$budget->amount = new Money($amount*AdWordsConstants::MICROS_PER_DOLLAR);
		$budget->deliveryMethod = ($deliveryMethod) ? $deliveryMethod : 'STANDARD';
		$budget->isExplicitlyShared = false;
		$operations = array();
		// Create operation.
		  $operation = new BudgetOperation();
		  $operation->operand = $budget;
		  $operation->operator = 'ADD';
		  $operations[] = $operation;
		// Make the mutate request.
		try {
			$result = $budgetService->mutate($operations);
		} catch(Exception $e) {
			throw $e;
		}
		$budget = $result->value[0];
		return $budget;
	}
	/**
	 * add Budget in adwords api
	 * @params: budget Id - long
	 * @params: amount - float
	 * @params: deliveryMethod - string
	 * @result: Budget object
	 * $apiObj->editBudget(25112120, 25.2, 'STANDARD')
	 */
	public function editBudget($budgetId, $amount, $deliveryMethod ='')
	{
		$budgetService = $this->user->GetService('BudgetService', ADWORDS_VERSION);
		$budget = new Budget();
		$budget->budgetId = $budgetId;
		$budget->deliveryMethod = $deliveryMethod ? $deliveryMethod : 'STANDARD';
		$budget->amount = new Money($amount*AdWordsConstants::MICROS_PER_DOLLAR);
		$operations = array();
		// Create operation.
		$operation = new BudgetOperation();
		$operation->operand = $budget;
		$operation->operator = 'SET';
		$operations[] = $operation;
		try {
			$result = $budgetService->mutate($operations);
		} catch(Exception $e) {
			
			throw $e;
		}
		$budget = $result->value[0];
		return $budget;
	}
	/**
	 * add new Campaign
	 * @params: $params: array of user inputs
	 * @params: $budget: budget Information for new campaign
	 * @result : return array of new created campaign List
	 * $apiObj->addCampaign($params, $budget)
	 */
	 public function addCampaign($params, $budget)
	 {
		$campaignService = $this->user->GetService('CampaignService', ADWORDS_VERSION);
	  	$campaign = new Campaign();
		$campaign->name = $params['txtCampaign'];// . uniqid();
		if($params['slctCampaingType'] == SHOPPING){
			$campaign->advertisingChannelType = 'SHOPPING';
		}else if($params['slctCampaingType'] == DISPLAY_ONLY){
			$campaign->advertisingChannelType = 'DISPLAY';	
		} else {
			$campaign->advertisingChannelType = 'SEARCH';
		}
		//$campaign->displaySelect = false;
		$campaign->budget = new Budget();
		$campaign->budget->budgetId = $budget->budgetId;
		$campaign->adServingOptimizationStatus = $params['adServeSetting'];
		/*$keywordSetting = $params['keywordSetting'] ? true : false;
		$keywordMatchSetting = new KeywordMatchSetting();
		$keywordMatchSetting->optIn = $keywordSetting;
		$campaign->settings[] = $keywordMatchSetting;*/
		
		$geoTargetTypeSetting = new GeoTargetTypeSetting();
		$geoTargetTypeSetting->positiveGeoTargetType = 'DONT_CARE';
		$geoTargetTypeSetting->negativeGeoTargetType = 'DONT_CARE';
		$campaign->settings[] = $geoTargetTypeSetting;
		
		if($params['rdFocus'] == 1 && $params['rdBidId']){
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			$biddingStrategyConfiguration->biddingStrategyId = $params['rdBidId'];
		} else if($params['rdManual'] == 0) {
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			$biddingStrategyConfiguration->biddingStrategyType = 'MANUAL_CPC';
			$biddingScheme = new ManualCpcBiddingScheme();
			$biddingStrategyConfiguration->biddingScheme = $biddingScheme;
		}else if($params['rdManual'] == 1) {
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			$biddingStrategyConfiguration->biddingStrategyId = $params['bidId'];
		}
		$campaign->biddingStrategyConfiguration = $biddingStrategyConfiguration;
		
		if($params['txtDomainName']) {
			$domain = trim(str_replace(array('http://', 'https://'), '', $params['txtDomainName']));
			if($domain){
				$dynamicSearchAdsSetting = new DynamicSearchAdsSetting();
				$dynamicSearchAdsSetting->domainName = $domain;
				$dynamicSearchAdsSetting->languageCode = $params['slctLanguage'];
				$campaign->settings[] = $dynamicSearchAdsSetting;
			}
		}
		$networkSetting = new NetworkSetting();
		$targetSearchNetwork = $params['chkPartner'] ? true : false;
		if($params['slctCampaingType'] == DISPLAY_ONLY) {
			$networkSetting->targetGoogleSearch = false;
			$networkSetting->targetSearchNetwork = false;
			$networkSetting->targetContentNetwork = true;
			$networkSetting->targetPartnerSearchNetwork = false;
		} else if($params['slctCampaingType'] == SEARCH_AND_DISPLAY){
			$networkSetting->targetGoogleSearch = true;
			$networkSetting->targetSearchNetwork = $targetSearchNetwork;
			$networkSetting->targetContentNetwork = true;
			$networkSetting->targetPartnerSearchNetwork = false;
		} else if($params['slctCampaingType'] == SEARCH_ONLY){
			$networkSetting->targetGoogleSearch = true;
			$networkSetting->targetSearchNetwork = $targetSearchNetwork;
			$networkSetting->targetContentNetwork = false;
			$networkSetting->targetPartnerSearchNetwork = false;
		} else {
			$networkSetting->targetGoogleSearch = true;
			$networkSetting->targetSearchNetwork = $targetSearchNetwork;
			$networkSetting->targetContentNetwork = false;
			$networkSetting->targetPartnerSearchNetwork = false;
		}
		$campaign->networkSetting = $networkSetting;
		if($params['txtStartDate']){
			$campaign->startDate = date('Ymd', strtotime($params['txtStartDate']));
		}
		if($params['rdEndDate']) {
			$campaign->endDate = date('Ymd', strtotime($params['txtEndDate']));
		}
		$operations = array();
		$operation = new CampaignOperation();
		$operation->operand = $campaign;
		$operation->operator = 'ADD';
		$operations[] = $operation;
		try {
			$result = $campaignService->mutate($operations);
		} catch(Exception $e) {
			throw $e;
		}
		$campaignRslt = $result->value;
		return $campaignRslt;
	 }
	 /**
	 * add new Campaign
	 * @params: $campaignId: Long
	 * @params: $params: array of user inputs
	 * @params: $budget: budget Information for new campaign
	 * @result : return array of new created campaign List
	 * $apiObj->editCampaign(1211212120, $params)
	 */
	 public function editCampaign($campaignId, $params)
	 {
		$campaignService = $this->user->GetService('CampaignService', ADWORDS_VERSION);
	  	$campaign = new Campaign();
		$campaign->id = $campaignId;
		$campaign->name = $params['txtCampaign'];
		$campaign->status = $params['slctCampStatus'];
		if($params['slctCampaingType'] == SHOPPING){
			$campaign->advertisingChannelType = 'SHOPPING';
		}else if($params['slctCampaingType'] == DISPLAY_ONLY){
			$campaign->advertisingChannelType = 'DISPLAY';	
		} else {
			$campaign->advertisingChannelType = 'SEARCH';
		}
		if($params['budgetId']){
			$campaign->budget = new Budget();
			$campaign->budget->budgetId = $params['budgetId'];
		}
		$campaign->adServingOptimizationStatus = $params['adServeSetting'];
		/*$keywordSetting = $params['keywordSetting'] ? true : false;
		$keywordMatchSetting = new KeywordMatchSetting();
		$keywordMatchSetting->optIn = $keywordSetting;
		$campaign->settings[] = $keywordMatchSetting;*/
		if($params['rdFocus'] == 1 && $params['rdBidId']){
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			$biddingStrategyConfiguration->biddingStrategyId = $params['rdBidId'];
			$campaign->biddingStrategyConfiguration = $biddingStrategyConfiguration;
		} else if($params['rdManual'] == 0) {
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			$biddingStrategyConfiguration->biddingStrategyType = 'MANUAL_CPC';
			$biddingScheme = new ManualCpcBiddingScheme();
			$biddingStrategyConfiguration->biddingScheme = $biddingScheme;
			$campaign->biddingStrategyConfiguration = $biddingStrategyConfiguration;
		}else if($params['rdManual'] == 1) {
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			$biddingStrategyConfiguration->biddingStrategyId = $params['bidId'];
			$campaign->biddingStrategyConfiguration = $biddingStrategyConfiguration;
		} else if($params['rdManual'] == 2){
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			$biddingStrategyConfiguration->biddingStrategyType = 'CONVERSION_OPTIMIZER';
			$biddingScheme = new ConversionOptimizerBiddingScheme();
			$biddingStrategyConfiguration->biddingScheme = $biddingScheme;
			$campaign->biddingStrategyConfiguration = $biddingStrategyConfiguration;
		}
		$geoTargetTypeSetting = new GeoTargetTypeSetting();
		$geoTargetTypeSetting->positiveGeoTargetType = 'DONT_CARE';
		$geoTargetTypeSetting->negativeGeoTargetType = 'DONT_CARE';
		$campaign->settings[] = $geoTargetTypeSetting;
		if($params['txtDomainName']) {
			$txtDomainName = trim($params['txtDomainName']);
			$domain = trim(str_replace(array('http://', 'https://'), '', $txtDomainName));
			if($domain){
				$dynamicSearchAdsSetting = new DynamicSearchAdsSetting();
				$dynamicSearchAdsSetting->domainName = $domain;
				$dynamicSearchAdsSetting->languageCode = $params['slctLanguage'];
				$campaign->settings[] = $dynamicSearchAdsSetting;
			}
		}
		$networkSetting = new NetworkSetting();
		$targetSearchNetwork = $params['chkPartner'] ? true : false;
		if($params['slctCampaignType'] == DISPLAY_ONLY) {
			$networkSetting->targetGoogleSearch = false;
			$networkSetting->targetSearchNetwork = false;
			$networkSetting->targetContentNetwork = true;
			$networkSetting->targetPartnerSearchNetwork = false;
			$campaign->networkSetting = $networkSetting;
		} else if($params['slctCampaignType'] == SEARCH_AND_DISPLAY){
			$networkSetting->targetGoogleSearch = true;
			$networkSetting->targetSearchNetwork = $targetSearchNetwork;
			$networkSetting->targetContentNetwork = true;
			$networkSetting->targetPartnerSearchNetwork = false;
			$campaign->networkSetting = $networkSetting;
		} else if($params['slctCampaignType'] == SEARCH_ONLY){
			$networkSetting->targetGoogleSearch = true;
			$networkSetting->targetSearchNetwork = $targetSearchNetwork;
			$networkSetting->targetContentNetwork = false;
			$networkSetting->targetPartnerSearchNetwork = false;
			$campaign->networkSetting = $networkSetting;
		} else {
			$networkSetting->targetGoogleSearch = true;
			$networkSetting->targetSearchNetwork = $targetSearchNetwork;
			$networkSetting->targetContentNetwork = false;
			$networkSetting->targetPartnerSearchNetwork = false;
			$campaign->networkSetting = $networkSetting;
		}
		//$campaign->startDate = date('Ymd', $params['txtStartDate']);
		if($params['rdEndDate']) {
			$campaign->endDate = date('Ymd', strtotime($params['txtEndDate']));
		} else {
			$campaign->endDate = '20371230';
		}
		$operations = array();
		$operation = new CampaignOperation();
		$operation->operand = $campaign;
		$operation->operator = 'SET';
		$operations[] = $operation;
		try {
			$result = $campaignService->mutate($operations);
		} catch(Exception $e) {
			throw $e;
		}
		$campaignRslt = $result->value;
		return $campaignRslt;
	 }
	 /**
	  * Function add Proximity for a campaign
	  * @params : $params: array of user inputs
	  * @return : array of campaign criterions
	  */
	 function addProximity($params)
	 {
	 	$geoLocationService = $this->user->GetService('GeoLocationService', ADWORDS_VERSION);
		$campaignCriterionServiceService = $this->user->GetService('CampaignCriterionService', ADWORDS_VERSION);
	 	$campaignId = $params['id'];
		$address1Arr = array_values($params['newAddress1']);
		$address2Arr = array_values($params['newAddress2']);
		$cityArr = array_values($params['newCity']);
		$provicneArr = array_values($params['newState']);
		$zipCodeArr = array_values($params['newPostCode']);
    	$countryArr = array_values($params['newCountry']);
		$radiusDistanceUnitArr = array_values($params['newDistanceUnit']);
    	$radiusDistanceArr = array_values($params['newDistance']);
		$bidModifierArr = array_values($params['newBidModifier']);
		$addressArr = array();
		$operations = array();
		foreach($cityArr as $indexKey => $cityVal){
			$address = new Address();
			if($address1Arr[$indexKey] || $address2Arr[$indexKey] || $cityArr[$indexKey] || $provicneArr[$indexKey]){
				$address->streetAddress = $address1Arr[$indexKey] ? $address1Arr[$indexKey] : null;
				$address->streetAddress2 = $address2Arr[$indexKey] ? $address2Arr[$indexKey] : null;
				$address->cityName = $cityArr[$indexKey] ? $cityArr[$indexKey] : null;
				$address->provinceName = $provicneArr[$indexKey] ? $provicneArr[$indexKey] : null;
				$address->provinceCode = null;
				$address->postalCode = $zipCodeArr[$indexKey] ? $zipCodeArr[$indexKey]: null;
				$address->countryCode = $countryArr[$indexKey] ? $countryArr[$indexKey]: null;
				$addressArr[$indexKey] = $address;
			}
		}
		if($addressArr){
			$selector = new GeoLocationSelector();
			$addreesArrKeys = array_keys($addressArr);
			$selector->addresses = array_values($addressArr);
			try{
				$result = $geoLocationService->get($selector);
				foreach($result as $rsltKey => $geoLocation){
					if($geoLocation->GeoLocationType != 'InvalidGeoLocation'){
						$proximity = new Proximity();
						$proximity->address = $geoLocation->address;
						$proximity->geoPoint = $geoLocation->geoPoint;
						$arrKey = $addreesArrKeys[$rsltKey];
						$proximity->radiusDistanceUnits = $radiusDistanceUnitArr[$arrKey];
						$proximity->radiusInUnits = $radiusDistanceArr[$arrKey];
						$campaignCriterion =  new CampaignCriterion();
						$campaignCriterion->campaignId =  $campaignId;
						$campaignCriterion->criterion = $proximity;
						$bidAdjustment = $bidModifierArr[$arrKey];
						$bidModifier = ($bidAdjustment*1 + 100)/100;	
						$campaignCriterion->bidModifier = $bidModifier;
						// Create operation.
						$operation = new CampaignCriterionOperation();
						$operation->operand = $campaignCriterion;
						$operation->operator = 'ADD';
						$operations[] = $operation;
					} else {
						$errMsg[] = sprintf("Address with street '%s' could not be found.\n",$address->streetAddress);
						continue;
					}
				}
			}catch(Exception $e){
				return false;
			}
		}
		if($operations){
			try{
				$operationCount = count($operations);
				$campCriteriaResult = $campaignCriterionServiceService->mutate($operations);
				return $campCriteriaResult->value;
			} catch(Exception $e){
				return false;
			}
		} else{
			return array();	
		}
	 }
	 /**
	  * Delete Campaign based on campaign id
	  * @params: $params - array of user inputs
	  * @result: array of campaigns list with updated status
	  */
	 public function updateCamapignStatus($params)
	 {
		$campaignService = $this->user->GetService('CampaignService', ADWORDS_VERSION);
		$campStatus = $params['campStatus'];
		$campList = $params['camp'];
		$operations = array();
		foreach($campList as $campaignId){
			$campaign = new Campaign();
			$campaign->id = $campaignId;
			$campaign->status = $campStatus;
			$operation = new CampaignOperation();
			$operation->operand = $campaign;
			$operation->operator = 'SET';
			$operations[] = $operation;	
		}
		try {
			if($operations){
				$result = $campaignService->mutate($operations);
				$campaignRslt = $result->value;
				return $campaignRslt;
			}
		} catch(Exception $e) {
			throw $e;
		}
	 }
	 /**
	  * Add Locations for campaign with initial criterions
	  * @params: $campaignId: long
	  * @params: $locationArr : array of positive locations for campaign
	  * @params: $negativeLocationArr: array of negative locations for campaign
	  * @params: $languageArr: array of languages for the campaign
	  * @result: return the list of criterions added for the campaign
	  * $apiObj->addLocationForCampaign(1112121202, array(10000, 32000), array(), array(1000), 90, array(2840=>10))
	  */
	 public function addLocationForCampaign($campaignId, $locationArr=array(), $negativeLocationArr=array(), $languageArr=array(), $mobileBidAdjustment=0, $locationBidModifierArr = array(),$radiusUnit='', $radiusDistance=0)
	 {
		$campaignCriterionServiceService = $this->user->GetService('CampaignCriterionService', ADWORDS_VERSION);
		$operations = array();
		if($locationArr){
			foreach($locationArr as $locationId) {
				$campaignCriterionNetwork =  new CampaignCriterion();
				$campaignCriterionNetwork->campaignId =  $campaignId;
				$location = new Location();
				$location->id = $locationId;
				$campaignCriterionNetwork->criterion = $location;
				$bidAdjustment = $locationBidModifierArr[$locationId] ? $locationBidModifierArr[$locationId] : 0;
				$bidModifier = ($bidAdjustment + 100)/100;
				$campaignCriterionNetwork->bidModifier = $bidModifier;
				$operation = new CampaignCriterionOperation();
				$operation->operand = $campaignCriterionNetwork;
				$operation->operator = 'ADD';
				$operations[] = $operation;
			}
		}
		if($negativeLocationArr){
			foreach($negativeLocationArr as $locationId => $negativeLocation)	{
				  $campaignCriterionNetwork =  new NegativeCampaignCriterion();
				  $campaignCriterionNetwork->campaignId =  $campaignId;
				  $location = new Location();
				  $location->id = $locationId;
				  $campaignCriterionNetwork->criterion = $location;	
				  $operation = new CampaignCriterionOperation();
				  $operation->operand = $campaignCriterionNetwork;
				  $operation->operator = 'ADD';
				  $operations[] = $operation;
			}
		}
		if($languageArr){
			foreach($languageArr as $langCode =>$langName){
				  $campaignCriterion =  new CampaignCriterion();
				  $campaignCriterion->campaignId =  $campaignId;
				  $language = new Language();
				  $language->id = $langCode;
				  $campaignCriterion->criterion = $language;
				  $operation = new CampaignCriterionOperation();
				  $operation->operand = $campaignCriterion;
				  $operation->operator = 'ADD';
				  $operations[] = $operation;
			}
		}
		if($radiusDistance){
			$radius = new ConstantOperand();
			$radius->type = 'DOUBLE';
			$radius->unit = $radiusUnit;
			$radius->doubleValue = $radiusDistance;
			$distance = new LocationExtensionOperand($radius);
			$thirdGroup = new LocationGroups();
			$thirdGroup->matchingFunction = new FeedFunction('IDENTITY', $distance);
			$campaignCriterion = new CampaignCriterion($campaignId, null, $thirdGroup);
			$operation = new CampaignCriterionOperation();
			$operation->operand = $campaignCriterion;
			$operation->operator = 'ADD';
			$operations[] = $operation;
		}
		$mobileBidModifier = ($mobileBidAdjustment + 100)/100;
		$campaignCriterion =  new CampaignCriterion();
		$campaignCriterion->campaignId =  $campaignId;
		$mobilePlatform = new Platform();
		$mobilePlatform->id = MOBILE_PLATFORM_ID;
		$campaignCriterion->criterion = $mobilePlatform;
		$campaignCriterion->bidModifier = $mobileBidModifier;
		$operation = new CampaignCriterionOperation();
		$operation->operand = $campaignCriterion;
		$operation->operator = 'SET';
		$operations[] = $operation;
		
		try{
			$operationCount = count($operations);
			$campCriteriaResult = $campaignCriterionServiceService->mutate($operations);
		} catch(Exception $e){
			throw $e;
		}
		return $campCriteriaResult->value;
	 }
	 /**
	  * Add Locations for campaign with initial criterions
	  * @params: $campaignId: long
	  * @params: $locationArr : array of positive locations for campaign
	  * @params: $negativeLocationArr: array of negative locations for campaign
	  * @params: $languageArr: array of languages for the campaign
	  * @result: return the list of criterions added for the campaign
	  * $apiObj->editCampaignCriterion(1112121202, array(10000, 32000), array(), array(1000))
	  */
	 public function editCampaignCriterion($campaignId, $newLocationArr=array(), $newNegativeLocationArr=array(), $newLanguageArr=array(), $delLocationArr = array(), $delNegativeLocationArr = array(), $delLangArr=array(), $mobileBidAdjustment=0, $locationBidModifierArr = array(), $currentPositiveLocationArr = array(), $radiusUnit = '', $radiusDistance=0, $radiusTargetList = array(), $removeRadiusTarget=array(), $proximityArr=array(), $proximityDelArr=array())
	 {

		$campaignCriterionServiceService = $this->user->GetService('CampaignCriterionService', ADWORDS_VERSION);
		$operations = array();
		if($proximityArr){
			foreach($proximityArr as $proximityId){
				if($proximityDelArr[$proximityId])continue;
				$proximity = new Proximity();
				$proximity->id = $proximityId;
				$campaignCriterion =  new CampaignCriterion();
				$campaignCriterion->campaignId =  $campaignId;
				$campaignCriterion->criterion = $proximity;
				$bidAdjustment = $locationBidModifierArr[$proximityId];
				$bidModifier = ($bidAdjustment + 100)/100;	
				$campaignCriterion->bidModifier = $bidModifier;
				$operation = new CampaignCriterionOperation();
				$operation->operand = $campaignCriterion;
				$operation->operator = 'SET';
				$operations[] = $operation;
			}
		}
		if($proximityDelArr){
			foreach($proximityDelArr as $proximityId => $toDelete){
				if($toDelete){
					$proximity = new Proximity();
					$proximity->id = $proximityId;
					$campaignCriterion =  new CampaignCriterion();
					$campaignCriterion->campaignId =  $campaignId;
					$campaignCriterion->criterion = $proximity;
					$operation = new CampaignCriterionOperation();
					$operation->operand = $campaignCriterion;
					$operation->operator = 'REMOVE';
					$operations[] = $operation;
				}
			}
		}
		if($delLocationArr){
			foreach($delLocationArr as $locationId) {
				$campaignCriterionNetwork =  new CampaignCriterion();
				$campaignCriterionNetwork->campaignId =  $campaignId;
				$location = new Location();
				$location->id = $locationId;
				$campaignCriterionNetwork->criterion = $location;	
				$operation = new CampaignCriterionOperation();
				$operation->operand = $campaignCriterionNetwork;
				$operation->operator = 'REMOVE';
				$operations[] = $operation;
			}
		}
		if($delNegativeLocationArr){
			foreach($delNegativeLocationArr as $locationId)	{
				  $campaignCriterionNetwork = new NegativeCampaignCriterion();
				  $campaignCriterionNetwork->campaignId =  $campaignId;
				  $location = new Location();
				  $location->id = $locationId;
				  $campaignCriterionNetwork->criterion = $location;	
				  $operation = new CampaignCriterionOperation();
				  $operation->operand = $campaignCriterionNetwork;
				  $operation->operator = 'REMOVE';
				  $operations[] = $operation;
			}
		}
		if($delLangArr){
			foreach($delLangArr as $langCode){
				  $campaignCriterion =  new CampaignCriterion();
				  $campaignCriterion->campaignId =  $campaignId;
				  $language = new Language();
				  $language->id = $langCode;
				  $campaignCriterion->criterion = $language;
				  $operation = new CampaignCriterionOperation();
				  $operation->operand = $campaignCriterion;
				  $operation->operator = 'REMOVE';
				  $operations[] = $operation;
			}
		}
		if($currentPositiveLocationArr){
			foreach($currentPositiveLocationArr as $locationId){
				if(in_array($locationId, $delLocationArr)) continue;
				$campaignCriterionNetwork =  new CampaignCriterion();
				$campaignCriterionNetwork->campaignId =  $campaignId;
				$location = new Location();
				$location->id = $locationId;
				$campaignCriterionNetwork->criterion = $location;
				$bidAdjustment = $locationBidModifierArr[$locationId];
				$bidModifier = ($bidAdjustment + 100)/100;	
				$campaignCriterionNetwork->bidModifier = $bidModifier;
				$operation = new CampaignCriterionOperation();
				$operation->operand = $campaignCriterionNetwork;
				$operation->operator = 'SET';
				$operations[] = $operation;
			}
		}
		if($newLocationArr){
			foreach($newLocationArr as $locationId) {
				$campaignCriterionNetwork =  new CampaignCriterion();
				$campaignCriterionNetwork->campaignId =  $campaignId;
				$location = new Location();
				$location->id = $locationId;
				$campaignCriterionNetwork->criterion = $location;
				if($locationBidModifierArr) {
					$bidAdjustment = $locationBidModifierArr[$locationId];
					if($bidAdjustment){
						$bidModifier = ($bidAdjustment + 100)/100;	
						$campaignCriterionNetwork->bidModifier = $bidModifier;
					}
				}	
				$operation = new CampaignCriterionOperation();
				$operation->operand = $campaignCriterionNetwork;
				$operation->operator = 'ADD';
				$operations[] = $operation;
			}
		}
		if($newNegativeLocationArr){
			foreach($newNegativeLocationArr as $locationId)	{
				  $campaignCriterionNetwork =  new NegativeCampaignCriterion();
				  $campaignCriterionNetwork->campaignId =  $campaignId;
				  $location = new Location();
				  $location->id = $locationId;
				  $campaignCriterionNetwork->criterion = $location;	
				  $operation = new CampaignCriterionOperation();
				  $operation->operand = $campaignCriterionNetwork;
				  $operation->operator = 'ADD';
				  $operations[] = $operation;
			}
		}
		if($newLanguageArr){
			foreach($newLanguageArr as $langCode){
				  $campaignCriterion =  new CampaignCriterion();
				  $campaignCriterion->campaignId =  $campaignId;
				  $language = new Language();
				  $language->id = $langCode;
				  $campaignCriterion->criterion = $language;
				  $operation = new CampaignCriterionOperation();
				  $operation->operand = $campaignCriterion;
				  $operation->operator = 'ADD';
				  $operations[] = $operation;
			}
		}
		if($mobileBidAdjustment!=0) {
			$mobileBidModifier = ($mobileBidAdjustment + 100)/100;
			$campaignCriterion =  new CampaignCriterion();
			$campaignCriterion->campaignId =  $campaignId;
			$mobilePlatform = new Platform();
			$mobilePlatform->id = MOBILE_PLATFORM_ID;
			$campaignCriterion->criterion = $mobilePlatform;
			$campaignCriterion->bidModifier = $mobileBidModifier;
			$operation = new CampaignCriterionOperation();
			$operation->operand = $campaignCriterion;
			$operation->operator = 'SET';
			$operations[] = $operation;
		}
		if($radiusDistance){
			$radius = new ConstantOperand();
			$radius->type = 'DOUBLE';
			$radius->unit = $radiusUnit;
			$radius->doubleValue = $radiusDistance;
			$distance = new LocationExtensionOperand($radius);
			$thirdGroup = new LocationGroups();
			$thirdGroup->matchingFunction = new FeedFunction('IDENTITY', $distance);
			$campaignCriterion = new CampaignCriterion($campaignId, null, $thirdGroup);
			$operation = new CampaignCriterionOperation();
			$operation->operand = $campaignCriterion;
			$operation->operator = 'ADD';
			$operations[] = $operation;
		}
		if($removeRadiusTarget){
			foreach($removeRadiusTarget as $critId => $deleted){
				if($deleted){
					$campaignCriterion =  new CampaignCriterion();
					$campaignCriterion->campaignId =  $campaignId;
					$locationGroup = new LocationGroups();
					$locationGroup->id = $critId;
					$campaignCriterion->criterion = $locationGroup;
					$operation = new CampaignCriterionOperation();
					$operation->operand = $campaignCriterion;
					$operation->operator = 'REMOVE';
					$operations[] = $operation;
				}
			}
		}
		if($radiusTargetList){
			foreach($radiusTargetList as $criterionId => $critVal){
				if($removeRadiusTarget[$criterionId] == 0){
					$bidModiferObj =  new CampaignCriterion();
					$bidModiferObj->campaignId =  $campaignId;
					$locationGroup = new LocationGroups();
					$locationGroup->id = $criterionId;
					$bidModiferObj->criterion = $locationGroup;
					$bidAdjustment = $locationBidModifierArr[$criterionId];
					$bidModifier = ($bidAdjustment + 100)/100;	
					$bidModiferObj->bidModifier = $bidModifier;
					$operation = new CampaignCriterionOperation();
					$operation->operand = $bidModiferObj;
					$operation->operator = 'SET';
					$operations[] = $operation;
				}
			}
		}
		if($operations){
			try{
				$operationCount = count($operations);
				$campCriteriaResult = $campaignCriterionServiceService->mutate($operations);
				return $campCriteriaResult->value;
			} catch(Exception $e){
				throw $e;
			}
		} else{
			return array();	
		}
		
	 }
	 /**
	  * Add adGroup object
	  * @params: $groupName: string
	  * @params: $bid: float
	  * @result: array of new AdGroups
	  * $api->addNewAdGroup('tester', 12220)
	  */
	  function addNewAdGroup($campaignId, $groupName, $bid)
	  {
			$adGroupService = $this->user->GetService('AdGroupService', ADWORDS_VERSION);
			$operations = array();
			$adGroup = new AdGroup();
			$adGroup->campaignId = $campaignId;
			$adGroup->name = $groupName;
			$bid = new CpcBid();
			$defaultBid = $bid;
			$bid->bid = new Money($defaultBid * AdWordsConstants::MICROS_PER_DOLLAR);
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			$biddingStrategyConfiguration->bids[] = $bid;
			$adGroup->biddingStrategyConfiguration = $biddingStrategyConfiguration;
			$adGroup->status = 'ENABLED';
			$operation = new AdGroupOperation();
			$operation->operand = $adGroup;
			$operation->operator = 'ADD';
			$operations[] = $operation;
			try{
				$result = $adGroupService->mutate($operations);
				$adGroups = $result->value;
			} catch(Exception $ex){
				throw $ex;	
			}
			return $adGroups;
	  }
	 /**
	  * Update the adgroup status
	  * @params: $params - array of user inputs
	  * @result: List of adgroup lists
	  */
	 public function updateAdgroupStatus($params)
	 {
		$adGroupService = $this->user->GetService('AdGroupService', ADWORDS_VERSION);
		$adGroupStatus = $params['slctAdGroupStatus'];
		$adGroupList = $params['chkAdgroup'];
		$operations = array();
		foreach($adGroupList as $adGroupId){
			$adGroup = new AdGroup();
			$adGroup->campaignId = $params['id'];
			$adGroup->id = $adGroupId;
			$adGroup->status = $adGroupStatus;
			$operation = new AdGroupOperation();
			$operation->operand = $adGroup;
			$operation->operator = 'SET';
			$operations[] = $operation;	
		}
		try {
			if($operations){
				$result = $adGroupService->mutate($operations);
				$adGroupList = $result->value;
				return $adGroupList;
			}
		} catch(Exception $e) {
			throw $e;
		}
	 }
	  /**
	   * Function to add keywords for given adgroup
	   * $params: $adGroupId - long
	   * $params: $keywordArr - array of keywords
	   * $result: return array of adwordCriterions
	   */
	   function addNewKeyword($adGroupId, $keywordArr)
	   {
			$operations = array();
			$adGroupCriterionService = $this->user->GetService('AdGroupCriterionService', ADWORDS_VERSION);
			foreach($keywordArr as $keyword){
				if(trim($keyword) == '') continue;
				$keywordObj = new Keyword();
				$keyword = trim($keyword);
				$keywordLen = strlen($keyword);
				$firstChar = $keyword[0];
				$lastChar = $keyword[$keywordLen-1];
				if($firstChar == '"' && $lastChar =='"'){
					$matchType = 'PHRASE';
					$keyword = trim($keyword,'"');
				} elseif($firstChar == '[' && $lastChar ==']') {
					$matchType = 'EXACT';
					$keyword = trim($keyword,'[');
					$keyword = trim($keyword,']');
				} else {
					$matchType = 'BROAD';
				}
				$keywordObj->matchType = $matchType;
				$keywordObj->text = trim($keyword);
				
				$adGroupCriterion = new BiddableAdGroupCriterion();
				$adGroupCriterion->adGroupId = $adGroupId;
				$adGroupCriterion->criterion = $keywordObj;
				$adGroupCriteria[] = $adGroupCriterion;
				// Create operation.
				$operation = new AdGroupCriterionOperation();
				$operation->operand = $adGroupCriterion;
				$operation->operator = 'ADD';
				$operations[] = $operation;
			}
			try{
				$result = $adGroupCriterionService->mutate($operations);
			} catch(Exception $ex){
				throw $ex;
			}
			return $result->value;
	   }
	   /**
	    * Function to add new text ad
	    */
		function addNewTextAd($adGroupId, $headLine, $description1, $description2, $displayUrl, $destUrl, $devicePreference)
		{
			$adGroupAdService = $this->user->GetService('AdGroupAdService', ADWORDS_VERSION);
			$operations = array();
			$textAd = new TextAd();
			$textAd->headline = $headLine;//. uniqid();
			$textAd->description1 = $description1;
			$textAd->description2 = $description2;
			$textAd->displayUrl = $displayUrl;
			//$textAd->url = $destUrl;
			$textAd->finalUrls = array($destUrl);
			$textAd->devicePreference = $devicePreference;
		
			// Create ad group ad.
			$adGroupAd = new AdGroupAd();
			$adGroupAd->adGroupId = $adGroupId;
			$adGroupAd->ad = $textAd;
		
			// Set additional settings (optional).
			//$adGroupAd->status = 'PAUSED';
		
			// Create operation.
			$operation = new AdGroupAdOperation();
			$operation->operand = $adGroupAd;
			$operation->operator = 'ADD';
			$operations[] = $operation;
			try{
				$result = $adGroupAdService->mutate($operations);
			} catch(Exception $ex){
				throw $ex;
			}
			return $result->value;
		}
		/**
		  * Update the Ad status
		  * @params: $params - array of user inputs
		  * @result: List of Ads
		  */
		function updateTextAdStatus($params)
		{
			$adGroupAdService = $this->user->GetService('AdGroupAdService', ADWORDS_VERSION);
			$adStatus = $params['txtAdStatus'];
			$adList = $params['chkTextAd'];
			$operations = array();
			foreach($adList as $adId){
				$textAd = new TextAd();
				$textAd->id = $adId;
				// Create ad group ad.
				$adGroupAd = new AdGroupAd();
				$adGroupAd->adGroupId = $params['id'];
				$adGroupAd->ad = $textAd;
				$adGroupAd->status = $adStatus;
				// Create operation.
				$operation = new AdGroupAdOperation();
				$operation->operand = $adGroupAd;
				$operation->operator = 'SET';
				$operations[] = $operation;
			}
			try {
				if($operations){
					$result = $adGroupAdService->mutate($operations);
					$adGroupList = $result->value;
					return $adGroupList;
				}
			} catch(Exception $e) {
				throw $e;
			}
		}
		/**
		  * Update the Ad status
		  * @params: $params - array of user inputs
		  * @result: List of Ads
		  */
		function updateDynamicAdStatus($params)
		{
			$adGroupAdService = $this->user->GetService('AdGroupAdService', ADWORDS_VERSION);
			$adStatus = $params['dynamicAdStatus'];
			$adList = $params['chkDynamicAd'];
			$operations = array();
			foreach($adList as $adId){
				$dynamicSearchAd = new DynamicSearchAd();
				$dynamicSearchAd->id = $adId;
				// Create ad group ad.
				$adGroupAd = new AdGroupAd();
				$adGroupAd->adGroupId = $params['id'];
				$adGroupAd->ad = $dynamicSearchAd;
				$adGroupAd->status = $adStatus;
				// Create operation.
				$operation = new AdGroupAdOperation();
				$operation->operand = $adGroupAd;
				$operation->operator = 'SET';
				$operations[] = $operation;
			}
			try {
				if($operations){
					$result = $adGroupAdService->mutate($operations);
					$adGroupList = $result->value;
					return $adGroupList;
				}
			} catch(Exception $e) {
				throw $e;
			}
		}
		/**
		 * Function to edit text ads
		 * @params: $adgroupId - long
		 * @params: $params - array of user inputs
		 */
		function editTextAds($adGroupId, $params=array())
		{
			$adGroupAdService = $this->user->GetService('AdGroupAdService', ADWORDS_VERSION);
			$operations = array();
			$editAdArr = $params['editAd'];
			$deleteAdArr = $params['deleteAd'];
			$headLineArr = $params['headline'];
			$description1Arr = $params['description1'];
			$description2Arr = $params['description2'];
			$displayUrlArr = $params['displayUrl'];
			$destUrlArr  =$params['destURL'];
			$deviceArr = $params['device'];
			$statusArr = $params['status'];
			$newHeadLineArr = $params['newHeadline'];
			$newDesc1Arr = $params['newDescription1'];
			$newDesc2Arr = $params['newDescription2'];
			$newDisplayUrlArr = $params['newDisplayUrl'];
			$newDestURLArr = $params['newDestURL'];
			$newStatusArr = $params['newStatus'];
			$newDeviceArr = array_values($params['newDevice']);
			if($newHeadLineArr){
				foreach($newHeadLineArr as $newKey => $newHeadLine){
					$textAd = new TextAd();
					$textAd->headline = $newHeadLine;//. uniqid();
					$textAd->description1 = $newDesc1Arr[$newKey];
					$textAd->description2 = $newDesc2Arr[$newKey];
					$textAd->displayUrl = $newDisplayUrlArr[$newKey];
					$textAd->finalUrls = array($newDestURLArr[$newKey]);
					$textAd->devicePreference = $newDeviceArr[$newKey] ? $newDeviceArr[$newKey]: NULL;
					// Create ad group ad.
					$adGroupAd = new AdGroupAd();
					$adGroupAd->adGroupId = $adGroupId;
					$adGroupAd->ad = $textAd;
					$adGroupAd->status = $newStatusArr[$newKey];
					// Create operation.
					$operation = new AdGroupAdOperation();
					$operation->operand = $adGroupAd;
					$operation->operator = 'ADD';
					$operations[] = $operation;
				}
			}
			foreach($editAdArr as $editAdId=>$editable){
				if(!$editable){
					continue;
				}
				$textAd = new TextAd();
				$textAd->headline = $headLineArr[$editAdId];//. uniqid();
				$textAd->description1 = $description1Arr[$editAdId];
				$textAd->description2 = $description2Arr[$editAdId];
				$textAd->displayUrl = $displayUrlArr[$editAdId];
				$textAd->finalUrls = array($destUrlArr[$editAdId]);
				$textAd->devicePreference = $deviceArr[$editAdId] ? $deviceArr[$editAdId]: NULL;
				// Create ad group ad.
				$adGroupAd = new AdGroupAd();
				$adGroupAd->adGroupId = $adGroupId;
				$adGroupAd->ad = $textAd;
				$adGroupAd->status = $statusArr[$editAdId];
				// Create operation.
				$operation = new AdGroupAdOperation();
				$operation->operand = $adGroupAd;
				$operation->operator = 'ADD';
				$operations[] = $operation;
			}
			foreach($deleteAdArr as $deleteAdId => $deletable){
				$editable = $editAdArr[$deleteAdId];
				if($deletable == 0 && $editable == 0){
					continue;
				}
				$textAd = new TextAd();
				$textAd->id = $deleteAdId;
				$adGroupAd = new AdGroupAd();
				$adGroupAd->adGroupId = $adGroupId;
				$adGroupAd->ad = $textAd;
				$operation = new AdGroupAdOperation();
				$operation->operand = $adGroupAd;
				$operation->operator = 'REMOVE';
				$operations[] = $operation;
			}
			try{
				if($operations){
					$result = $adGroupAdService->mutate($operations);
					return $result->value;
				}
			} catch(Exception $ex){
				throw $ex;
			}
		}
		
		/**
		 * Function to get keyword ideas
		 */
		function getKeywordIdeas($keyword, $params=array())
		{
			$resultArr = array();
			$targetingIdeaService = $this->user->GetService('TargetingIdeaService', ADWORDS_VERSION);
			$selector = new TargetingIdeaSelector();
			$selector->requestType = 'IDEAS';
			$selector->ideaType = 'KEYWORD';
			  
			$selector->requestedAttributeTypes = array('KEYWORD_TEXT', 'SEARCH_VOLUME', 'AVERAGE_CPC', 'COMPETITION');
			
			$languageParameter = new LanguageSearchParameter();
			$english = new Language();
			$english->id = $params['slctLanguage'];
			$languageParameter->languages = array($english);
			
			$locationArr = array();
			if($params['inLocation']) {
				foreach($params['inLocation'] as $locationId=>$locationName) {
					$locationObj = new Location();
					$locationObj->id = $locationId;
					$locationArr[] = $locationObj;
				}
				$locationSearchParameter = new LocationSearchParameter();
				$locationSearchParameter->locations = $locationArr;
			}
			
			// Create related to query search parameter.
			$relatedToQuerySearchParameter = new RelatedToQuerySearchParameter();
			$relatedToQuerySearchParameter->queries = array($keyword);
			$selector->searchParameters[] = $relatedToQuerySearchParameter;
			$selector->searchParameters[] = $languageParameter;
			if($locationArr){
				$selector->searchParameters[] = $locationSearchParameter;
			}
			// Set selector paging (required by this service).
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			
			do {
				$page = $targetingIdeaService->get($selector);
				if (isset($page->entries)) {
				  foreach ($page->entries as $targetingIdea) {
					$data = MapUtils::GetMap($targetingIdea->data);
					$keyword = $data['KEYWORD_TEXT']->value;
					$searchVolume = isset($data['SEARCH_VOLUME']->value)? $data['SEARCH_VOLUME']->value : 0;
					$avgCpc = $data['AVERAGE_CPC']->value->microAmount/AdWordsConstants::MICROS_PER_DOLLAR;
					$competition = $data['COMPETITION']->value;
					if($searchVolume >0) {
						$competitionLevel = ($competition <= 0.3333) ? 'Low': ($competition <= 0.6667) ? 'Medium' : 'High';
						$resultArr[] = array('keyword'=>$keyword, 'search'=>$searchVolume, 'avgCPC'=>$avgCpc, 'competition'=>$competition, 'level'=>$competitionLevel);
					}
				  }
				} 
				$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
			} while ($page->totalNumEntries > $selector->paging->startIndex);
			return $resultArr;
		}
		/**
		 * Function to create Callout Feed
		 * @params: $feedName - string
		 * @result: return Feed Object
		 */
		function createCalloutFeed($feedName)
		{
			$feedService = $this->user->GetService('FeedService', ADWORDS_VERSION);
			
			// Create attributes.
			$callOutTextAttribute = new FeedAttribute();
			$callOutTextAttribute->type = 'STRING';
			$callOutTextAttribute->name = 'Callout Text';
			
			// Create the feed.
			$callOutFeed = new Feed();
			$callOutFeed->name = $feedName ? $feedName : 'Feed For Callouts';
			$callOutFeed->attributes = array($callOutTextAttribute);
			$sitelinksFeed->origin = 'USER';
			
			// Create operation.
			$operation = new FeedOperation();
			$operation->operator = 'ADD';
			$operation->operand = $callOutFeed;
			
			$operations = array($operation);
			// Add the feed.
			try{
				$result = $feedService->mutate($operations);
				//Return the Feed
				return $result->value;
			} catch(Exception $ex){
				throw $ex;	
			}
		}
		
		/**
		 * function to create Feed callout mapping for given feed
		 * @params: $feed - Feed object
		 * @result: return the array of feed mapping items
		 */
		function createCalloutFeedMapping($feed) {
		  // Get the FeedMappingService, which loads the required classes.
		  $feedMappingService = $this->user->GetService('FeedMappingService', ADWORDS_VERSION);
		  // Get the Feed attributes
		  $feedAttrArr = $feed->attributes;
		  
		  $feedId = $feed->id;
		  // Map the FeedAttributeIds to the fieldId constants.
		  $callOutTextMapping = new AttributeFieldMapping();
		  $callOutTextMapping->feedAttributeId = $feedAttrArr[0]->id;
		  $callOutTextMapping->fieldId = PLACEHOLDER_FIELD_CALLOUT_TEXT;
		
		  // Create the FieldMapping and operation.
		  $feedMapping = new FeedMapping();
		  $feedMapping->placeholderType = PLACEHOLDER_CALLOUT;
		  $feedMapping->feedId = $feedId;
		  $feedMapping->attributeFieldMappings = array($callOutTextMapping);
		  $operation = new FeedMappingOperation();
		  $operation->operand = $feedMapping;
		  $operation->operator = 'ADD';
		
		  $operations = array($operation);
		
		  // Save the field mapping.
		  try{
			  $result = $feedMappingService->mutate($operations);
			  return $result->value;
		  }catch(Exception $ex){
		  	  throw $ex;
		  }
		}
		/**
		 * Function to update Callout with given array values
		 * @params: $feedId: long
		 * @params: $feedListArr: Array of new feed Items
		 * @params: $editFeedArr: Array of Feed item values to be edited
		 * @params: $editItemArr: Array of Edit items says to be editable or not
		 * @params: $delItemArr: Array of delete items says to be deletabel or not
		 * @result: array of feed items
		 */
		 public function updateCalloutFeed($feedId, $feedListArr, $editFeedArr=array(), $editItemArr=array(), $delItemArr=array()) {
			// Create the FeedItemAttributeValues for our text values.
			$feedItemService = $this->user->GetService('FeedItemService', ADWORDS_VERSION);
			$operations = array();
			if($editItemArr){
				foreach($editItemArr as $editItemId => $editable){
					if(!$editable) continue;
					$editFeedItem = $editFeedArr[$editItemId];
					$feedAttr = array();
					foreach($editFeedItem as $feedAttrId => $feedAttrVal){
						$feedAttrObj = new FeedItemAttributeValue();
						$feedAttrObj->feedAttributeId = $feedAttrId;
						$feedAttrObj->stringValue = $feedAttrVal;
						$feedAttr[] = $feedAttrObj;
					}
					$feedItemObj = new FeedItem();
					$feedItemObj->feedId = $feedId;
					$feedItemObj->feedItemId = $editItemId;
					$feedItemObj->attributeValues = $feedAttr;
					$operation = new FeedItemOperation();
					$operation->operand = $feedItemObj;
					$operation->operator = 'SET';
					$operations[] = $operation;
				}
			}
			if($delItemArr){
				foreach($delItemArr as $delItemId => $deletable){
					if(!$deletable) continue;
					$feedItemObj = new FeedItem();
					$feedItemObj->feedId = $feedId;
					$feedItemObj->feedItemId = $editItemId;
					$operation = new FeedItemOperation();
					$operation->operand = $feedItemObj;
					$operation->operator = 'REMOVE';
					$operations[] = $operation;
				}
			}
			foreach($feedListArr as  $feedListItem){
				$feedAttrValues = array_keys($feedListItem);
				//0- Callout Text
				$callOutText = trim($feedListItem[$feedAttrValues[0]]);
				if($callOutText){
					$feedItemObj = new FeedItem();
					$feedItemObj->feedId = $feedId;
					$feedItemObj->attributeValues = array();
					foreach($feedAttrValues as $attributeId){
						$feedAttrributeValue = new FeedItemAttributeValue();
						$feedAttrributeValue->feedAttributeId = $attributeId;
						$feedAttrributeValue ->stringValue = $feedListItem[$attributeId];
						$feedItemObj->attributeValues[] = $feedAttrributeValue;
					}
					$operation = new FeedItemOperation();
					$operation->operand = $feedItemObj;
					$operation->operator = 'ADD';
					$operations[] = $operation;
				}
			}
			try{
				if($operations){
					$result = $feedItemService->mutate($operations);
					return $result->value;
				}
			} catch(Exception $ex) {
				throw $ex;
			}
		}
		/**
		 * Function to create Location Feed
		 * @params: $feedName - string
		 * @result: return Feed Object
		 */
		function createLocationFeed($feedName)
		{
			$feedService = $this->user->GetService('FeedService', ADWORDS_VERSION);
			
			// Create attributes.
			$businessAttribute = new FeedAttribute();
			$businessAttribute->type = 'STRING';
			$businessAttribute->name = 'Business Name';
			$line1Attribute = new FeedAttribute();
			$line1Attribute->type = 'STRING';
			$line1Attribute->name = 'Address Line1';
			$line2Attribute = new FeedAttribute();
			$line2Attribute->type = 'STRING';
			$line2Attribute->name = 'Address Line2';
			$cityAttribute = new FeedAttribute();
			$cityAttribute->type = 'STRING';
			$cityAttribute->name = 'City';
			$provinceAttribute = new FeedAttribute();
			$provinceAttribute->type = 'STRING';
			$provinceAttribute->name = 'Province';
			$postCodeAttribute = new FeedAttribute();
			$postCodeAttribute->type = 'STRING';
			$postCodeAttribute->name = 'Postal Code';
			$countryCodeAttribute = new FeedAttribute();
			$countryCodeAttribute->type = 'STRING';
			$countryCodeAttribute->name = 'Country Code';
			$phoneNumberAttribute = new FeedAttribute();
			$phoneNumberAttribute->type = 'STRING';
			$phoneNumberAttribute->name = 'Phone Number';
			
			// Create the feed.
			$sitelinksFeed = new Feed();
			$sitelinksFeed->name = $feedName ? $feedName : 'Feed For Location';
			$sitelinksFeed->attributes = array($businessAttribute, $line1Attribute, $line2Attribute, $cityAttribute, $provinceAttribute, $postCodeAttribute, 
				$countryCodeAttribute, $phoneNumberAttribute);
			$sitelinksFeed->origin = 'USER';
			
			// Create operation.
			$operation = new FeedOperation();
			$operation->operator = 'ADD';
			$operation->operand = $sitelinksFeed;
			
			$operations = array($operation);
			// Add the feed.
			try{
				$result = $feedService->mutate($operations);
				//Return the Feed
				return $result->value;
			} catch(Exception $ex){
				throw $ex;	
			}
		}
		
		/**
		 * function to create Feed location mapping for given feed
		 * @params: $feed - Feed object
		 * @result: return the array of feed mapping items
		 */
		function createLocationFeedMapping($feed) {
		  // Get the FeedMappingService, which loads the required classes.
		  $feedMappingService = $this->user->GetService('FeedMappingService', ADWORDS_VERSION);
		  // Get the Feed attributes
		  $feedAttrArr = $feed->attributes;
		  
		  $feedId = $feed->id;
		  // Map the FeedAttributeIds to the fieldId constants.
		  $businessFieldMapping = new AttributeFieldMapping();
		  $businessFieldMapping->feedAttributeId = $feedAttrArr[0]->id;
		  $businessFieldMapping->fieldId = PLACEHOLDER_FIELD_BUSINESS_NAME;
		  
		  $line1FieldMapping = new AttributeFieldMapping();
		  $line1FieldMapping->feedAttributeId = $feedAttrArr[1]->id;
		  $line1FieldMapping->fieldId = PLACEHOLDER_FIELD_ADDRESS_1;
		  
		  $line2FieldMapping = new AttributeFieldMapping();
		  $line2FieldMapping->feedAttributeId = $feedAttrArr[2]->id;
		  $line2FieldMapping->fieldId = PLACEHOLDER_FIELD_ADDRESS_2;
		  
		  $cityFieldMapping = new AttributeFieldMapping();
		  $cityFieldMapping->feedAttributeId = $feedAttrArr[3]->id;
		  $cityFieldMapping->fieldId = PLACEHOLDER_FIELD_CITY;
		  
		  $provinceFieldMapping = new AttributeFieldMapping();
		  $provinceFieldMapping->feedAttributeId = $feedAttrArr[4]->id;
		  $provinceFieldMapping->fieldId = PLACEHOLDER_FIELD_PROVINCE;
		  
		  $postCodeFieldMapping = new AttributeFieldMapping();
		  $postCodeFieldMapping->feedAttributeId = $feedAttrArr[5]->id;
		  $postCodeFieldMapping->fieldId = PLACEHOLDER_FIELD_POSTAL_CODE;
		  
		  $countryCodeFieldMapping = new AttributeFieldMapping();
		  $countryCodeFieldMapping->feedAttributeId = $feedAttrArr[6]->id;
		  $countryCodeFieldMapping->fieldId = PLACEHOLDER_FIELD_COUNTRY_CODE;
		  
		  $phoneNumberFieldMapping = new AttributeFieldMapping();
		  $phoneNumberFieldMapping->feedAttributeId = $feedAttrArr[7]->id;
		  $phoneNumberFieldMapping->fieldId = PLACEHOLDER_FIELD_PHONE_NUMBER;
		
		  // Create the FieldMapping and operation.
		  $feedMapping = new FeedMapping();
		  $feedMapping->placeholderType = PLACEHOLDER_LOCATION;
		  $feedMapping->feedId = $feedId;
		  $feedMapping->attributeFieldMappings =
			  array($businessFieldMapping, $line1FieldMapping, $line2FieldMapping, $cityFieldMapping, $provinceFieldMapping, $postCodeFieldMapping,
			  $countryCodeFieldMapping, $phoneNumberFieldMapping);
		  $operation = new FeedMappingOperation();
		  $operation->operand = $feedMapping;
		  $operation->operator = 'ADD';
		
		  $operations = array($operation);
		
		  // Save the field mapping.
		  try{
			  $result = $feedMappingService->mutate($operations);
			  return $result->value;
		  }catch(Exception $ex){
		  	  throw $ex;
		  }
		}
		/**
		 * Function to update Location with given array values
		 * @params: $feedId: long
		 * @params: $feedListArr: Array of new feed Items
		 * @params: $editFeedArr: Array of Feed item values to be edited
		 * @params: $editItemArr: Array of Edit items says to be editable or not
		 * @params: $delItemArr: Array of delete items says to be deletabel or not
		 * @result: array of feed items
		 */
		 public function updateLocationFeed($feedId, $feedListArr, $editFeedArr=array(), $editItemArr=array(), $delItemArr=array()) {
			// Create the FeedItemAttributeValues for our text values.
			$feedItemService = $this->user->GetService('FeedItemService', ADWORDS_VERSION);
			$operations = array();
			if($editItemArr){
				foreach($editItemArr as $editItemId => $editable){
					if(!$editable) continue;
					$editFeedItem = $editFeedArr[$editItemId];
					$feedAttr = array();
					foreach($editFeedItem as $feedAttrId => $feedAttrVal){
						$feedAttrObj = new FeedItemAttributeValue();
						$feedAttrObj->feedAttributeId = $feedAttrId;
						$feedAttrObj->stringValue = $feedAttrVal;
						$feedAttr[] = $feedAttrObj;
					}
					$feedItemObj = new FeedItem();
					$feedItemObj->feedId = $feedId;
					$feedItemObj->feedItemId = $editItemId;
					$feedItemObj->attributeValues = $feedAttr;
					$operation = new FeedItemOperation();
					$operation->operand = $feedItemObj;
					$operation->operator = 'SET';
					$operations[] = $operation;
				}
			}
			if($delItemArr){
				foreach($delItemArr as $delItemId => $deletable){
					if(!$deletable) continue;
					$feedItemObj = new FeedItem();
					$feedItemObj->feedId = $feedId;
					$feedItemObj->feedItemId = $editItemId;
					$operation = new FeedItemOperation();
					$operation->operand = $feedItemObj;
					$operation->operator = 'REMOVE';
					$operations[] = $operation;
				}
			}
			foreach($feedListArr as  $feedListItem){
				$feedAttrValues = array_keys($feedListItem);
				//0- Business Name, 1- Address1, 2- Address2, 3- City, 4 - Province, 5- PostalCode, 6-Country Code, 7 - Phone Number
				$businessName = trim($feedListItem[$feedAttrValues[0]]);
				$address1 = trim($feedListItem[$feedAttrValues[1]]);
				if($businessName && $address1){
					$feedItemObj = new FeedItem();
					$feedItemObj->feedId = $feedId;
					$feedItemObj->attributeValues = array();
					foreach($feedAttrValues as $attributeId){
						$feedAttrributeValue = new FeedItemAttributeValue();
						$feedAttrributeValue->feedAttributeId = $attributeId;
						$feedAttrributeValue ->stringValue = $feedListItem[$attributeId];
						$feedItemObj->attributeValues[] = $feedAttrributeValue;
					}
					$operation = new FeedItemOperation();
					$operation->operand = $feedItemObj;
					$operation->operator = 'ADD';
					$operations[] = $operation;
				}
			}
			try{
				if($operations){
					$result = $feedItemService->mutate($operations);
					return $result->value;
				}
			} catch(Exception $ex) {
				throw $ex;
			}
		}
		/**
		 * Function to create customer feed
		 * @params: $feedId : int
		 * @params: $feedItemIdList : array
		 * @params: $feedOperator : string
		 */
		function createCustomerFeed($feedId, $feedItemIdList, $feedOperator='ADD', $placeHolderType=0)
		{
			$customerFeedService = $this->user->GetService('CustomerFeedService', ADWORDS_VERSION);
			if($placeHolderType == 0) $placeHolderType = PLACEHOLDER_LOCATION;
			$customerFeed = new CustomerFeed();
			$customerFeed->feedId = $feedId;
			$customerFeed->placeholderTypes = array($placeHolderType);
			$customerMatchingFunction = new FeedFunction();
			$constOperand = new ConstantOperand();
			$constOperand->type = 'BOOLEAN';
			$constOperand->booleanValue = true;
			$customerMatchingFunction->lhsOperand = array($constOperand);
			$customerMatchingFunction->operator = 'IDENTITY';
			$customerFeed->matchingFunction = $customerMatchingFunction;
			$operation = new CustomerFeedOperation();
			$operation->operand = $customerFeed;
			$operation->operator = $feedOperator;
			$operations = array($operation);
			try{
				$result = $customerFeedService->mutate($operations);
				return $result->value;
			} catch(Exception $ex){
				throw $ex;
			}
		}
		/**
		 * Function to create Site Link Feed
		 * @params: $feedName - string
		 * @result: return Feed Object
		 */
		function createSiteLinksFeed($feedName)
		{
			$sitelinksData = array();
			$feedService = $this->user->GetService('FeedService', ADWORDS_VERSION);
			
			// Create attributes.
			$textAttribute = new FeedAttribute();
			$textAttribute->type = 'STRING';
			$textAttribute->name = 'Link Text';
			$urlAttribute = new FeedAttribute();
			$urlAttribute->type = 'URL';
			$urlAttribute->name = 'Link URL';
			$line1Attribute = new FeedAttribute();
			$line1Attribute->type = 'STRING';
			$line1Attribute->name = 'Line 1 Description';
			$line2Attribute = new FeedAttribute();
			$line2Attribute->type = 'STRING';
			$line2Attribute->name = 'Line 2 Description';
			
			// Create the feed.
			$sitelinksFeed = new Feed();
			$sitelinksFeed->name = $feedName ? $feedName : 'Feed For Site Links';
			$sitelinksFeed->attributes = array($textAttribute, $urlAttribute, $line1Attribute, $line2Attribute);
			$sitelinksFeed->origin = 'USER';
			
			// Create operation.
			$operation = new FeedOperation();
			$operation->operator = 'ADD';
			$operation->operand = $sitelinksFeed;
			
			$operations = array($operation);
			// Add the feed.
			try{
				$result = $feedService->mutate($operations);
				//Return the Feed
				return $result->value;
			} catch(Exception $ex){
				throw $ex;	
			}
		}
		/**
		 * function to create Feed site link mapping for given feed
		 * @params: $feed - Feed object
		 * @result: return the array of feed mapping items
		 */
		function createSiteLinksFeedMapping($feed) {
		  // Get the FeedMappingService, which loads the required classes.
		  $feedMappingService = $this->user->GetService('FeedMappingService', ADWORDS_VERSION);
		  // Get the Feed attributes
		  $feedAttrArr = $feed->attributes;
		  
		  $feedId = $feed->id;
		
		  // Map the FeedAttributeIds to the fieldId constants.
		  $linkTextFieldMapping = new AttributeFieldMapping();
		  $linkTextFieldMapping->feedAttributeId = $feedAttrArr[0]->id;
		  $linkTextFieldMapping->fieldId = PLACEHOLDER_FIELD_SITELINK_LINK_TEXT;
		  $linkUrlFieldMapping = new AttributeFieldMapping();
		  $linkUrlFieldMapping->feedAttributeId = $feedAttrArr[1]->id;
		  $linkUrlFieldMapping->fieldId = PLACEHOLDER_FIELD_SITELINK_URL;
		  $line1FieldMapping = new AttributeFieldMapping();
		  $line1FieldMapping->feedAttributeId = $feedAttrArr[2]->id;
		  $line1FieldMapping->fieldId = PLACEHOLDER_FIELD_LINE_1_TEXT;
		  $line2FieldMapping = new AttributeFieldMapping();
		  $line2FieldMapping->feedAttributeId = $feedAttrArr[3]->id;
		  $line2FieldMapping->fieldId = PLACEHOLDER_FIELD_LINE_2_TEXT;
		
		  // Create the FieldMapping and operation.
		  $feedMapping = new FeedMapping();
		  $feedMapping->placeholderType = PLACEHOLDER_SITELINKS;
		  $feedMapping->feedId = $feedId;
		  $feedMapping->attributeFieldMappings =
			  array($linkTextFieldMapping, $linkUrlFieldMapping, $line1FieldMapping,
				  $line2FieldMapping);
		  $operation = new FeedMappingOperation();
		  $operation->operand = $feedMapping;
		  $operation->operator = 'ADD';
		
		  $operations = array($operation);
		
		  // Save the field mapping.
		  try{
			  $result = $feedMappingService->mutate($operations);
			  return $result->value;
		  }catch(Exception $ex){
		  	  throw $ex;
		  }
		}
		/**
		 * Create New Site Link with given array values
		 * @params: $feedId: long
		 * @params: $feedListArr: Array of new feed Items
		 * @params: $editFeedArr: Array of Feed item values to be edited
		 * @params: $editItemArr: Array of Edit items says to be editable or not
		 * @params: $delItemArr: Array of delete items says to be deletabel or not
		 * @result: array of feed items
		 */
		 public function newSiteLink($feedId, $feedListArr, $editFeedArr=array(), $editItemArr=array(), $delItemArr=array()) {
			// Create the FeedItemAttributeValues for our text values.
			$feedItemService = $this->user->GetService('FeedItemService', ADWORDS_VERSION);
			$operations = array();
			if($editItemArr){
				foreach($editItemArr as $editItemId => $editable){
					if(!$editable) continue;
					$editFeedItem = $editFeedArr[$editItemId];
					$feedAttr = array();
					foreach($editFeedItem as $feedAttrId => $feedAttrVal){
						$feedAttrObj = new FeedItemAttributeValue();
						$feedAttrObj->feedAttributeId = $feedAttrId;
						$feedAttrObj->stringValue = $feedAttrVal;
						$feedAttr[] = $feedAttrObj;
					}
					$feedItemObj = new FeedItem();
					$feedItemObj->feedId = $feedId;
					$feedItemObj->feedItemId = $editItemId;
					$feedItemObj->attributeValues = $feedAttr;
					$operation = new FeedItemOperation();
					$operation->operand = $feedItemObj;
					$operation->operator = 'SET';
					$operations[] = $operation;
				}
			}
			if($delItemArr){
				foreach($delItemArr as $delItemId => $deletable){
					if(!$deletable) continue;
					$feedItemObj = new FeedItem();
					$feedItemObj->feedId = $feedId;
					$feedItemObj->feedItemId = $editItemId;
					$operation = new FeedItemOperation();
					$operation->operand = $feedItemObj;
					$operation->operator = 'REMOVE';
					$operations[] = $operation;
				}
			}
			foreach($feedListArr as  $feedListItem){
				$feedAttrValues = array_keys($feedListItem);
				//0- Text AttributeId, 1- URL Attribute, 2- Line1 Description, 3- Line2 Description
				$linkText = trim($feedListItem[$feedAttrValues[0]]);
				$urlText = trim($feedListItem[$feedAttrValues[1]]);
				if($linkText && $urlText){
					$linkTextAttributeValue = new FeedItemAttributeValue();
					$linkTextAttributeValue->feedAttributeId = $feedAttrValues[0];
					$linkTextAttributeValue->stringValue = $linkText;
					$linkUrlAttributeValue = new FeedItemAttributeValue();
					$linkUrlAttributeValue->feedAttributeId = $feedAttrValues[1];
					$linkUrlAttributeValue->stringValue = $feedListItem[$feedAttrValues[1]];
					$line1AttributeValue = new FeedItemAttributeValue();
					$line1AttributeValue->feedAttributeId = $feedAttrValues[2];
					$line1AttributeValue->stringValue = $feedListItem[$feedAttrValues[2]];
					$line2AttributeValue = new FeedItemAttributeValue();
					$line2AttributeValue->feedAttributeId =  $feedAttrValues[3];
					$line2AttributeValue->stringValue = $feedListItem[$feedAttrValues[3]];
					$feedItemObj = new FeedItem();
					$feedItemObj->feedId = $feedId;
					$feedItemObj->attributeValues = array($linkTextAttributeValue, $linkUrlAttributeValue, 
							$line1AttributeValue, $line2AttributeValue);
					$operation = new FeedItemOperation();
					$operation->operand = $feedItemObj;
					$operation->operator = 'ADD';
					$operations[] = $operation;
				}
			}
			try{
				if($operations){
					$result = $feedItemService->mutate($operations);
					return $result->value;
				}
			} catch(Exception $ex) {
				throw $ex;
			}
		}
		/**
		 * Create Site links for a campaign
		 * @params: $feedItemIdList - array of feed Items
		 * @params: $campaignId - long - campaign id
		 * @params: $feedId - long - Feed Id
		 * @params: $feedOperator - String 'ADD' or 'SET'
		 * @result: Campaign Feed Match Array
		 */
		public function createSiteLinksCampaignFeed($feedItemIdList, $campaignId, $feedId, $feedOperator, $placeHolderType=0){
			$campaignFeedService = $this->user->GetService('CampaignFeedService', ADWORDS_VERSION);
			$feedFunctionRequestContextOperand = new RequestContextOperand();
			$feedFunctionRequestContextOperand->contextType = 'FEED_ITEM_ID';
			
			$feedItemFunction = new FeedFunction();
			$feedItemFunction->lhsOperand = array($feedFunctionRequestContextOperand);
			$feedItemFunction->operator = 'IN';
			
			$operands = array();
			foreach ($feedItemIdList as $feedItemId) {
				$constantOperand = new ConstantOperand();
				$constantOperand->longValue = $feedItemId;
				$constantOperand->type = 'LONG';
				$operands[] = $constantOperand;
			}
			$feedItemFunction->rhsOperand = $operands;
			
			if($placeHolderType == 0) $placeHolderType = PLACEHOLDER_SITELINKS;
			
			$campaignFeed = new CampaignFeed();
			$campaignFeed->feedId = $feedId;
			$campaignFeed->campaignId = $campaignId;
			$campaignFeed->matchingFunction = $feedItemFunction;
			$campaignFeed->placeholderTypes = array($placeHolderType);
			
			$operation = new CampaignFeedOperation();
			$operation->operand = $campaignFeed;
			$operation->operator = $feedOperator;
			
			$operations = array($operation);
			try{
				$result = $campaignFeedService->mutate($operations);
				return $result->value;
			} catch(Exception $ex){
				throw $ex;
			}
		}
		/**
		 * Function to remove campaign feed
		 * @params: $campaignId - long
		 * @params: $feedId - long
		 * @result: array of Campaign feed items
		 */
		public function removeCampaignFeed($campaignId, $feedId)
		{
			$campaignFeedService = $this->user->GetService('CampaignFeedService', ADWORDS_VERSION);
			$campaignFeed = new CampaignFeed();
			$campaignFeed->feedId = $feedId;
			$campaignFeed->campaignId = $campaignId;
			
			$operation = new CampaignFeedOperation();
			$operation->operand = $campaignFeed;
			$operation->operator = 'REMOVE';
			$operations = array($operation);
			try{
				$result = $campaignFeedService->mutate($operations);
				return $result->value;
			}catch(Exception $ex){
				throw $ex;
			}
		}
		/**
		 * Create Site links for a adgroup
		 * @params: $feedItemIdList - array of feed Items
		 * @params: $adgroupId - long - campaign id
		 * @params: $feedId - long - Feed Id
		 * @params: $feedOperator - String 'ADD' or 'SET'
		 * @result: Campaign Feed Match Array
		 */
		public function createSiteLinksAdGroupFeed($feedItemIdList, $adgroupId, $feedId, $feedOperator, $placeHolderType=0){
			$adGroupFeedService = $this->user->GetService('AdGroupFeedService', ADWORDS_VERSION);
			$feedFunctionRequestContextOperand = new RequestContextOperand();
			$feedFunctionRequestContextOperand->contextType = 'FEED_ITEM_ID';
			
			$feedItemFunction = new FeedFunction();
			$feedItemFunction->lhsOperand = array($feedFunctionRequestContextOperand);
			$feedItemFunction->operator = 'IN';
			
			$operands = array();
			foreach ($feedItemIdList as $feedItemId) {
				$constantOperand = new ConstantOperand();
				$constantOperand->longValue = $feedItemId;
				$constantOperand->type = 'LONG';
				$operands[] = $constantOperand;
			}
			$feedItemFunction->rhsOperand = $operands;
			
			if($placeHolderType == 0) $placeHolderType = PLACEHOLDER_SITELINKS;
			
			$adGroupFeed = new AdGroupFeed();
			$adGroupFeed->feedId = $feedId;
			$adGroupFeed->adGroupId = $adgroupId;
			$adGroupFeed->matchingFunction = $feedItemFunction;
			$adGroupFeed->placeholderTypes = array($placeHolderType);
			
			$operation = new AdGroupFeedOperation();
			$operation->operand = $adGroupFeed;
			$operation->operator = $feedOperator;
			$operations = array($operation);
			try{
				$result = $adGroupFeedService->mutate($operations);
				return $result->value;
			} catch(Exception $ex){
				throw $ex;
			}
		}
		/**
		 *
		 */
		public function removeAdgroupFeed($adGroupId, $feedId)
		{
			$adGroupFeedService = $this->user->GetService('AdGroupFeedService', ADWORDS_VERSION);
			$adGroupFeed = new AdGroupFeed();
			$adGroupFeed->feedId = $feedId;
			$adGroupFeed->adGroupId = $adGroupId;
			$operation = new AdGroupFeedOperation();
			$operation->operand = $adGroupFeed;
			$operation->operator = 'REMOVE';
			$operations = array($operation);
			try{
				$result = $adGroupFeedService->mutate($operations);
				return $result->value;
			}catch(Exception $ex){
				throw $ex;
			}
		}
		/**
		 * Update Feed Item
		 */
		function updateFeedItem($feedAttrArr, $feedItemId, $feedId)
		{
			$count =0;
			$feedItemAttrArr = array();
			$feedItemService = $this->user->GetService('FeedItemService', ADWORDS_VERSION);
			$operations = array();
			foreach($feedAttrArr as $key=>$value){
				$linkTextAttributeValue = new FeedItemAttributeValue();
				$linkTextAttributeValue->feedAttributeId = $key;
				$linkTextAttributeValue->stringValue = $value;
				$feedItemAttrArr[] = $linkTextAttributeValue;
			}
			$feedItemObj = new FeedItem();
			$feedItemObj->feedId = $feedId;
			$feedItemObj->feedItemId = $feedItemId;
			$feedItemObj->attributeValues = $feedItemAttrArr;
			$operation = new FeedItemOperation();
			$operation->operand = $feedItemObj;
			$operation->operator = 'SET';
			$operations[] = $operation;
			try {
				$result = $feedItemService->mutate($operations);
				return $result->value;
			} catch(Exception $ex){
				throw $ex;
			}
		}
		/**
		 * Get Campaign feed matches from given match function. 
		 * $matchFunction - FeedFunction() object
		 * $campaignId - long
		 * $feedId - long
		 */
		function getCampaignFeedMatches($matchFunction, $campaignId, $feedId) {
			$feedAttrId = 0;
			$operator = $matchFunction->operator;
			$idArr = array();
			$platform = '';
			foreach($matchFunction->lhsOperand as $innerOperand){
				$lhsOperand = $innerOperand->FunctionArgumentOperandType;
				if($innerOperand instanceof RequestContextOperand){
					$lhsOperandName = $innerOperand->contextType;
				}
				if($innerOperand instanceof FeedAttributeOperand){
					$feedId = $innerOperand->feedId;
					$feedAttrId = $innerOperand->feedAttributeId;
				}
			}
			
			foreach($matchFunction->rhsOperand as $innerRhsOperand){
				if($innerRhsOperand instanceof ConstantOperand){
					$rhsType = strtolower($innerRhsOperand->type);
					$valueType = $rhsType.'Value';
					if($rhsType == 'boolean' || $rhsType == 'long' || $rhsType == 'double') {
						$idArr[] = $innerRhsOperand->$valueType;
					} else {
						$platform = $innerRhsOperand->$valueType;
					}
				}
			}
			
			$adwCampFeedMatchObj = getObject('adwCampFeedMatch');
			if($idArr){
				foreach($idArr as $feedItemId){
					$newCfmId = $adwCampFeedMatchObj->addCampaignFeedMatch($campaignId, $feedId, $lhsOperand, $lhsOperandName, $operator, 
									$feedItemId, $platform, $feedAttrId, 1, 1);
				}
			} else {
				$feedItemId = 0;
				$newCfmId = $adwCampFeedMatchObj->addCampaignFeedMatch($campaignId, $feedId, $lhsOperand, $lhsOperandName, $operator, 
								$feedItemId, $platform, $feedAttrId, 1, 1);
			}
		}
		/**
		 * Get Adgroup feed matches from given match function. 
		 * $matchFunction - FeedFunction() object
		 * $adgroupId - long
		 * $feedId - long
		 */
		function getAdgroupMatches($matchFunction, $adGroupId, $feedId)
		{
			$feedAttrId = 0;
			$operator = $matchFunction->operator;
			$idArr = array();
			$platform = '';
			foreach($matchFunction->lhsOperand as $innerOperand){
				$lhsOperand = $innerOperand->FunctionArgumentOperandType;
				if($innerOperand instanceof RequestContextOperand){
					$lhsOperandName = $innerOperand->contextType;
				}
				if($innerOperand instanceof FeedAttributeOperand){
					$feedId = $innerOperand->feedId;
					$feedAttrId = $innerOperand->feedAttributeId;
				}
			}
			
			foreach($matchFunction->rhsOperand as $innerRhsOperand){
				if($innerRhsOperand instanceof ConstantOperand){
					$rhsType = strtolower($innerRhsOperand->type);
					$valueType = $rhsType.'Value';
					if($rhsType == 'boolean' || $rhsType == 'long' || $rhsType == 'double') {
						$idArr[] = $innerRhsOperand->$valueType;
					} else {
						$platform = $innerRhsOperand->$valueType;
					}
				}
			}
			
			$adwAdgroupFeedMatchObj = getObject('adwAdgroupFeedMatch');
			if($idArr){
				foreach($idArr as $feedItemId){
					$newCfmId = $adwAdgroupFeedMatchObj->addAdgroupFeedMatch($adGroupId, $feedId, $lhsOperand, $lhsOperandName, $operator, 
									$feedItemId, $platform, $feedAttrId, 1, 1);
				}
			} else {
				$feedItemId = 0;
				$newCfmId = $adwAdgroupFeedMatchObj->addAdgroupFeedMatch($adGroupId, $feedId, $lhsOperand, $lhsOperandName, $operator, 
								$feedItemId, $platform, $feedAttrId, 1, 1);
			}
		}
		
		/**
		 * Update keyword criterions
		 * Function to update keywords
		 * @params : $params - user input array
		 * @result: ADGroup Criterions with Biddable and negative keywords
		 */
		function updateKeyword($params)
		{
			$operations = array();
			$adGroupCriterionService = $this->user->GetService('AdGroupCriterionService', ADWORDS_VERSION);
			$deleteArr = $params['delete'];
			foreach($deleteArr as $criterionId => $toDelete){
				if(!$toDelete) continue;
				$keywordObj = new Keyword();
				$keywordObj->id = $criterionId;
				$adGroupCriterion = new BiddableAdGroupCriterion();
				$adGroupCriterion->adGroupId = $params['id'];
				$adGroupCriterion->criterion = $keywordObj;
				$adGroupCriteria[] = $adGroupCriterion;
				// Create operation.
				$operation = new AdGroupCriterionOperation();
				$operation->operand = $adGroupCriterion;
				$operation->operator = 'REMOVE';
				$operations[] = $operation;
			}
			$delNegArr = $params['deleteNeg'];
			if($delNegArr){
				foreach($delNegArr as $criterionId => $toDelete){
					if(!$toDelete) continue;
					$keywordObj = new Keyword();
					$keywordObj->id = $criterionId;
					$adGroupCriterion = new NegativeAdGroupCriterion();
					$adGroupCriterion->adGroupId = $params['id'];
					$adGroupCriterion->criterion = $keywordObj;
					$adGroupCriteria[] = $adGroupCriterion;
					// Create operation.
					$operation = new AdGroupCriterionOperation();
					$operation->operand = $adGroupCriterion;
					$operation->operator = 'REMOVE';
					$operations[] = $operation;
				}
			}
			$editArr = $params['edit'];
			$statusArr = $params['status'];
			$destinationUrlArr = $params['destinationUrl'];
			$cpcBidArr = $params['cpcBid'];

			//$matchTypeArr = $params['keywordMatch'];
			foreach($editArr as $criterionId => $toEdit){
				if($toEdit){
					if($deleteArr[$criterionId] == 1) continue;
					$keywordObj = new Keyword();
					$keywordObj->id = $criterionId;
					//$keywordObj->matchType = $matchTypeArr[$criterionId];
					$adGroupCriterion = new BiddableAdGroupCriterion();
					$adGroupCriterion->adGroupId = $params['id'];
					$adGroupCriterion->criterion = $keywordObj;
					$adGroupCriterion->userStatus = $statusArr[$criterionId];
					$adGroupCriterion->destinationUrl = $destinationUrlArr[$criterionId];
					$cpcBid = sprintf("%.2f", $cpcBidArr[$criterionId]);
					if($cpcBid > 0){
						$bid = new CpcBid();
						$bid->bid =  new Money($cpcBid * AdWordsConstants::MICROS_PER_DOLLAR);
						$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
						$biddingStrategyConfiguration->bids[] = $bid;
						$adGroupCriterion->biddingStrategyConfiguration = $biddingStrategyConfiguration;
					}
					$adGroupCriteria[] = $adGroupCriterion;
					// Create operation.
					$operation = new AdGroupCriterionOperation();
					$operation->operand = $adGroupCriterion;
					$operation->operator = 'SET';
					$operations[] = $operation;
				}
			}
			$newKeywordArr = $params['newKeyword'];
			$newStatusArr = $params['newStatus'];
			$newDestUrlArr = $params['newDestinationUrl'];
			$newCpcBidArr = $params['newCpcBid'];
			$newMatchTypeArr = $params['newKeywordMatch'];
			foreach($newKeywordArr as $keyIndex => $newKeyword){
				if(trim($newKeyword) == '') continue;
				$keywordObj = new Keyword();
				$keywordObj->text = trim($newKeyword);
				$keywordObj->matchType = $newMatchTypeArr[$keyIndex];
				$adGroupCriterion = new BiddableAdGroupCriterion();
				$adGroupCriterion->adGroupId = $params['id'];
				$adGroupCriterion->criterion = $keywordObj;
				$adGroupCriterion->userStatus = $newStatusArr[$keyIndex];
				$adGroupCriterion->destinationUrl = $newDestUrlArr[$keyIndex];
				$cpcBid = sprintf("%.2f", $newCpcBidArr[$keyIndex]);
				if($cpcBid > 0){
					$bid = new CpcBid();
					$bid->bid =  new Money($cpcBid * AdWordsConstants::MICROS_PER_DOLLAR);
					$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
					$biddingStrategyConfiguration->bids[] = $bid;
					$adGroupCriterion->biddingStrategyConfiguration = $biddingStrategyConfiguration;
				}
				
				$adGroupCriteria[] = $adGroupCriterion;
				// Create operation.
				$operation = new AdGroupCriterionOperation();
				$operation->operand = $adGroupCriterion;
				$operation->operator = 'ADD';
				$operations[] = $operation;
			}
			$negativeKeywordArr = $params['newNegativeKeyword'];
			$negativeKeywordMatchArr = $params['negKeywordMatch'];
			foreach($negativeKeywordArr as $keyIndex => $negativeKeyword){
				if(trim($negativeKeyword) == '') continue;
				$keywordObj = new Keyword();
				$keywordObj->text = trim($negativeKeyword);
				$keywordObj->matchType = $negativeKeywordMatchArr[$keyIndex];
				$adGroupCriterion = new NegativeAdGroupCriterion();
				$adGroupCriterion->adGroupId = $params['id'];
				$adGroupCriterion->criterion = $keywordObj;
				$adGroupCriteria[] = $adGroupCriterion;
				// Create operation.
				$operation = new AdGroupCriterionOperation();
				$operation->operand = $adGroupCriterion;
				$operation->operator = 'ADD';
				$operations[] = $operation;
			}
			try{
				if($operations){
					$result = $adGroupCriterionService->mutate($operations);
					return $result->value;
				}
			} catch(Exception $ex){
				throw $ex;
			}
		}
		
		/**
		 * Function to update dynamic search ads
		 * @params: $adgroupId - long
		 * @params: $params - array of user inputs
		 */
		function updateDynamicSearchAd($adGroupId, $params=array())
		{
			$adGroupAdService = $this->user->GetService('AdGroupAdService', ADWORDS_VERSION);
			$operations = array();
			array_walk_recursive($params, 'trim');
			$editAdArr = $params['editAd'];
			$deleteAdArr = $params['deleteAd'];
			$headLineArr = $params['headline'];
			$description1Arr = $params['description1'];
			$description2Arr = $params['description2'];
			$displayUrlArr = $params['displayUrl'];
			$destUrlArr  =$params['destURL'];
			$deviceArr = $params['device'];
			$statusArr = $params['status'];
			$newHeadLineArr = $params['newHeadline'];
			$newDesc1Arr = $params['newDescription1'];
			$newDesc2Arr = $params['newDescription2'];
			$newDisplayUrlArr = $params['newDisplayUrl'];
			$newDestURLArr = $params['newDestURL'];
			$newStatusArr = $params['newStatus'];
			$newDeviceArr = array_values($params['newDevice']);
			if($newDesc1Arr){
				foreach($newDesc1Arr as $newKey => $newDescription1){
					$dynamicSearchAd = new DynamicSearchAd();
					$dynamicSearchAd->description1 = $newDesc1Arr[$newKey];
					$dynamicSearchAd->description2 = $newDesc2Arr[$newKey];
					$dynamicSearchAd->displayUrl = $newDisplayUrlArr[$newKey];
					if($newDestURLArr[$newKey]){
						$dynamicSearchAd->url = $newDestURLArr[$newKey];
					}
					$dynamicSearchAd->devicePreference = $newDeviceArr[$newKey] ? $newDeviceArr[$newKey]: NULL;
					// Create ad group ad.
					$adGroupAd = new AdGroupAd();
					$adGroupAd->adGroupId = $adGroupId;
					$adGroupAd->ad = $dynamicSearchAd;
					$adGroupAd->status = $newStatusArr[$newKey];
					// Create operation.
					$operation = new AdGroupAdOperation();
					$operation->operand = $adGroupAd;
					$operation->operator = 'ADD';
					$operations[] = $operation;
				}
			}
			foreach($editAdArr as $editAdId=>$editable){
				if(!$editable){
					continue;
				}
				$dynamicSearchAd = new DynamicSearchAd();
				$dynamicSearchAd->description1 = $description1Arr[$editAdId];
				$dynamicSearchAd->description2 = $description2Arr[$editAdId];
				$dynamicSearchAd->displayUrl = $displayUrlArr[$editAdId];
				$dynamicSearchAd->url = $destUrlArr[$editAdId];
				$dynamicSearchAd->devicePreference = $deviceArr[$editAdId] ? $deviceArr[$editAdId]: NULL;
				// Create ad group ad.
				$adGroupAd = new AdGroupAd();
				$adGroupAd->adGroupId = $adGroupId;
				$adGroupAd->ad = $dynamicSearchAd;
				$adGroupAd->status = $statusArr[$editAdId];
				// Create operation.
				$operation = new AdGroupAdOperation();
				$operation->operand = $adGroupAd;
				$operation->operator = 'ADD';
				$operations[] = $operation;
			}
			foreach($deleteAdArr as $deleteAdId => $deletable){
				$editable = $editAdArr[$deleteAdId];
				if($deletable == 0 && $editable == 0){
					continue;
				}
				$dynamicSearchAd = new DynamicSearchAd();
				$dynamicSearchAd->id = $deleteAdId;
				$adGroupAd = new AdGroupAd();
				$adGroupAd->adGroupId = $adGroupId;
				$adGroupAd->ad = $dynamicSearchAd;
				$operation = new AdGroupAdOperation();
				$operation->operand = $adGroupAd;
				$operation->operator = 'REMOVE';
				$operations[] = $operation;
			}
			try{
				if($operations){
					$result = $adGroupAdService->mutate($operations);
					return $result->value;
				}
			} catch(Exception $ex){
				throw $ex;
			}
		}
		
		/**
		 * Function to update dynamic ad parameters
		 * @params: $params - user input
		 * @result : Return array of Biddable / Negative adgroup criterion object
		 */
		function updateDynamicAdTarget($params)
		{
		 	$operations = array();
			$adgroupId = $params['id'];
			$campaignId = $params['campaignId'];
			$adGroupCriterionService = $this->user->GetService('AdGroupCriterionService', ADWORDS_VERSION);
			$deleteArr = $params['pageDelete'];
			$adGroupCriteria = array();
			foreach($deleteArr as $criterionId => $toDelete){
				if(!$toDelete) continue;
				$webPageObj = new Webpage();
				$webPageObj->id = $criterionId;
				$adGroupCriterion = new BiddableAdGroupCriterion();
				$adGroupCriterion->adGroupId = $params['id'];
				$adGroupCriterion->criterion = $webPageObj;
				// Create operation.
				$operation = new AdGroupCriterionOperation();
				$operation->operand = $adGroupCriterion;
				$operation->operator = 'REMOVE';
				$operations[] = $operation;
			}
			
			$editPageArr = $params['pageEdit'];
			$statusArr = $params['pageStatus'];
			$destinationUrlArr = $params['pageDestinationUrl'];
			$cpcBidArr = $params['pageCpcBid'];
			$criterionNameArr = $params['pageName'];
			$selectCondArr = $params['select'];
			$selectCondValArr = $params['text'];
			foreach($editPageArr as $editCriterionId => $editable){
				if(!$editable) continue;
				$webPageObj = new Webpage();
				$webPageObj->id = $editCriterionId;
				$adGroupCriterion = new BiddableAdGroupCriterion();
				$adGroupCriterion->adGroupId = $params['id'];
				$adGroupCriterion->criterion = $webPageObj;
				$adGroupCriterion->userStatus = $statusArr[$editCriterionId];
				$adGroupCriterion->destinationUrl = $destinationUrlArr[$editCriterionId];
				$cpcBid = sprintf("%.2f", $cpcBidArr[$editCriterionId]);
				if($cpcBid > 0){
					$bid = new CpcBid();
					$bid->bid =  new Money($cpcBid * AdWordsConstants::MICROS_PER_DOLLAR);
					$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
					$biddingStrategyConfiguration->bids[] = $bid;
					$adGroupCriterion->biddingStrategyConfiguration = $biddingStrategyConfiguration;
				}
				// Create operation.
				$operation = new AdGroupCriterionOperation();
				$operation->operand = $adGroupCriterion;
				$operation->operator = 'SET';
				$operations[] = $operation;
			}
			$newStatusArr = $params['newStatus'];
			$newDestUrlArr = $params['newDestinationUrl'];
			$newCpcBidArr = $params['newCpcBid'];
			$newCriterionNameArr = $params['newPageName'];
			$newSelectCondArr = array_values($params['newSelect']);
			$newSelectCondValArr = array_values($params['newText']);
			
			foreach($newStatusArr as $keyIndex => $editable){
				if(trim( $newCriterionNameArr[$keyIndex]) == '') continue;
				$webPageObj = new Webpage();
				$webPageParameter = new WebpageParameter();
				$webPageParameter->criterionName = $newCriterionNameArr[$keyIndex];
				$webPageCond = array();
				foreach($newSelectCondArr[$keyIndex] as $selKey => $selValue){
					if($selValue == 'None'){continue;}
					$webPageCondition = new WebpageCondition();
					$webPageCondition->operand = $selValue;
					$webPageCondition->argument = $newSelectCondValArr[$keyIndex][$selKey];
					//Check the argument match for the '\*|\>\>|\=\=|\&\+' reg expression
					if(preg_match('/\*|\>\>|\=\=|\&\+/', $webPageCondition->argument)) {
						continue;
					}
					$webPageCond[] = $webPageCondition;
				}
				$webPageParameter->conditions = $webPageCond; 
				$webPageObj->parameter = $webPageParameter;
				$adGroupCriterion = new BiddableAdGroupCriterion();
				$adGroupCriterion->adGroupId = $params['id'];
				$adGroupCriterion->criterion = $webPageObj;
				$adGroupCriterion->userStatus = $newStatusArr[$keyIndex];
				$adGroupCriterion->destinationUrl = $newDestUrlArr[$keyIndex];
				$cpcBid = sprintf("%.2f", $newCpcBidArr[$keyIndex]);
				if($cpcBid > 0){
					$bid = new CpcBid();
					$bid->bid =  new Money($cpcBid * AdWordsConstants::MICROS_PER_DOLLAR);
					$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
					$biddingStrategyConfiguration->bids[] = $bid;
					$adGroupCriterion->biddingStrategyConfiguration = $biddingStrategyConfiguration;
				}
				// Create operation.
				$operation = new AdGroupCriterionOperation();
				$operation->operand = $adGroupCriterion;
				$operation->operator = 'ADD';
				$operations[] = $operation;
			}
			try{
				if($operations){
					$result = $adGroupCriterionService->mutate($operations);
					return $result->value;
				}
			} catch(Exception $ex){
				throw $ex;
			}
		 }
		/*
		 * Function to update location extensions
		 * @params - User Input array
		 * @result - Location Extension
		 */
		function updateLocationExtension($params)
		{}
		/**
		 * Function to update conversion tracker status and name
		 * @params - $params - array of user inputs
		 * @result - array of conversion trackers
		 */
		function updateConversionTracker($params)
		{
			$conversionTrackerService = $this->user->GetService('ConversionTrackerService', ADWORDS_VERSION);
			$editArr = $params['edit'];
			$conversionTypeArr = $params['conversionType'];
			$conversionNameArr = $params['conversionName'];
			$conversionStatusArr = $params['conversionStatus'];
			$ctcLookbackArr = $params['ctcLookback'];
			$operations = array();
			if($editArr){
				foreach($editArr as $editConversionId => $editable){
					if(!$editable) continue;
					$conversionType = $conversionTypeArr[$editConversionId];
					$conversionTrackObj = new $conversionType();
					$conversionTrackObj->id = $editConversionId;
					$conversionTrackObj->name = $conversionNameArr[$editConversionId];
					$conversionTrackObj->status = $conversionStatusArr[$editConversionId];
					$conversionTrackObj->ctcLookbackWindow = $ctcLookbackArr[$editConversionId];
					$operation = new ConversionTrackerOperation();
					$operation->operand = $conversionTrackObj;
					$operation->operator = 'SET';
					$operations[] = $operation;
				}
			}
			if($operations){
				try{
					$result = $conversionTrackerService->mutate($operations);
					return $result->value;
				}catch(Exception $ex){}
			}
		}
		/**
		 * Function to add conversion tracker status and name
		 * @params - $params - array of user inputs
		 * @result - array of conversion trackers
		 */
		 
		function addWebConversionTracker($params)
		{
			$conversionTrackerService = $this->user->GetService('ConversionTrackerService', ADWORDS_VERSION);
			$conversionTracker = new AdWordsConversionTracker();
			$conversionTracker->name = $params['conversionName'];
			$conversionTracker->trackingCodeType = $params['trackingCodeType'];
			$conversionTracker->status = 'ENABLED';
			$conversionTracker->category = $params['conversionCategory'];
			$conversionTracker->viewthroughLookbackWindow = $params['viewLookBackWindow'];
			$conversionTracker->isProductAdsChargeable = TRUE;
			$conversionTracker->productAdsChargeableConversionWindow = 15;
			$conversionTracker->markupLanguage = $params['markupLanguage'];
			if($params['addGoogleSiteStats'] == 1){
				$conversionTracker->textFormat = $params['rdNoLine'];
			} else {
				$conversionTracker->textFormat = 'HIDDEN';
			}
			$conversionTracker->backgroundColor = $params['pageBgColor'] ? $params['pageBgColor'] : 'ffffff';
			$conversionTracker->conversionPageLanguage = $params['convLanguage'];
			if($params['rdAlwaysDefaultValue'] == 1){
				$conversionTracker->defaultRevenueValue = $params['txtAlwaysDefaultValue'];	
				$conversionTracker->alwaysUseDefaultRevenueValue = true;
			} else if($params['rdAlwaysDefaultValue'] == 0){
				$conversionTracker->defaultRevenueValue = $params['txtDefaultValue'];	
				$conversionTracker->alwaysUseDefaultRevenueValue = false;
			} else {
				$conversionTracker->defaultRevenueValue = $params['hidDefaultValue'];
				$conversionTracker->alwaysUseDefaultRevenueValue = true;
			}
			$conversionTracker->countingType = $params['slctCountType'];
			
			// Create operation.
			$operation = new ConversionTrackerOperation();
			$operation->operand = $conversionTracker;
			$operation->operator = 'ADD';
			$operations = array($operation);
			try{
				$result = $conversionTrackerService->mutate($operations);
				return $result->value;
			}catch(Exception $ex){
				throw $ex;
			}
		}
		/**
		 * Function to update flexible bids based on user inputs
		 * @params - $params - user input array
		 * @result - Returns the bidding scheme object
		 */
		function updateFlexibleBid($params)
		{
			$biddingStrategyService = $this->user->GetService('BiddingStrategyService', ADWORDS_VERSION);
			$sharedBiddingStrategy = new SharedBiddingStrategy();
			$sharedBiddingStrategy->name = $params['bidName'];
			$bidSchemeType = $params['bidSchemeType'];
			$biddingScheme = new $bidSchemeType();
			if($bidSchemeType == 'TargetRoasBiddingScheme'){
				$biddingScheme->targetRoas = ($params['roasPercent'] / 100);
				if($params['rdRoasMaxBidLimit']){
					$biddingScheme->bidCeiling = new Money($params['roasMaxLimit'] * AdWordsConstants::MICROS_PER_DOLLAR);
				} else {
					$biddingScheme->bidCeiling = new Money(0);
				}
				if($params['rdRoasMinBidLimit']){
					$biddingScheme->bidFloor = new Money($params['roasMinLimit'] * AdWordsConstants::MICROS_PER_DOLLAR);
				} else {
					$biddingScheme->bidFloor = new Money(0);
				}
			}			
			if($bidSchemeType == 'TargetCpaBiddingScheme'){
				$biddingScheme->targetCpa =  new Money($params['targetCPA'] * AdWordsConstants::MICROS_PER_DOLLAR);
				if($params['rdCPAMaxBidLimit']){
					$biddingScheme->maxCpcBidCeiling = new Money($params['cpaMaxLimit'] * AdWordsConstants::MICROS_PER_DOLLAR);
				} else {
					$biddingScheme->maxCpcBidCeiling = new Money(0);
				}
				if($params['rdCPAMinBidLimit']){
					$biddingScheme->maxCpcBidFloor = new Money($params['cpaMinLimit'] * AdWordsConstants::MICROS_PER_DOLLAR);
				} else {
					$biddingScheme->maxCpcBidFloor = new Money(0);
				}
			}
			if($bidSchemeType == 'TargetSpendBiddingScheme'){
				if($params['spendMax']){
					$biddingScheme->bidCeiling = new Money($params['spendMax'] * AdWordsConstants::MICROS_PER_DOLLAR);
				} else {
					$biddingScheme->bidCeiling = new Money(0);
				}
				if($params['spendTarget']){
					$biddingScheme->spendTarget = new Money($params['spendTarget'] * AdWordsConstants::MICROS_PER_DOLLAR);
				} else {
					$biddingScheme->spendTarget = new Money(0);
				}
			}
			if($bidSchemeType == 'PageOnePromotedBiddingScheme'){
				$biddingScheme->strategyGoal = $params['rdPageLocation'];
				$biddingScheme->bidChangesForRaisesOnly = $params['rdBidChange'];
				if($params['pageBidAdjustment'] != 0){
					$bidModifier = ($params['pageBidAdjustment']*1+100)/100;
					$biddingScheme->bidModifier = $bidModifier;
				} else {
					$biddingScheme->bidModifier = 1;
				}
				$maxLimit = sprintf("%.2f", $params['pageMaxLimit']);
				$biddingScheme->bidCeiling = new Money($maxLimit * AdWordsConstants::MICROS_PER_DOLLAR);
				$biddingScheme->raiseBidWhenBudgetConstrained = $params['rdPageBidBudget'];
				$biddingScheme->raiseBidWhenLowQualityScore = $params['rdPageBidLowQuality'];
			}
			$sharedBiddingStrategy->biddingScheme = $biddingScheme;
			$operation = new BiddingStrategyOperation();
			if($params['id']){
				$sharedBiddingStrategy->id = $params['id'];
				$operation->operator = 'SET';
			} else {
				$operation->operator = 'ADD';
			}
		  	$operation->operand = $sharedBiddingStrategy;
			try{
				$result = $biddingStrategyService->mutate(array($operation));
				return $result->value;
			} catch(Exception $ex) {
				throw $ex;
			}
		}
		/**
		 * Function to update Bidding strategy for adgroups
		 * @params - $params - array of user inputs
		 * @result - array of modified adgroups
		 */
		function updateAdgroupBid($params)
		{
			$adGroupService = $this->user->GetService('AdGroupService', ADWORDS_VERSION);
			$operations = array();
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			if($params['saveManualCPC']) {
				$biddingScheme = new ManualCpcBiddingScheme();
				$biddingStrategyConfiguration->biddingScheme = $biddingScheme;
				$biddingStrategyConfiguration->biddingStrategyType = 'MANUAL_CPC';
				if($params['maxCPCBid']){
					$bid = new CpcBid();
					$defaultBid = $params['maxCPCBid'];
					$bid->bid = new Money($defaultBid * AdWordsConstants::MICROS_PER_DOLLAR);
					$biddingStrategyConfiguration->bids[] = $bid;
				}
			} else if($params['saveBidStrategy'] && $params['rdBidId']){
				$biddingStrategyConfiguration->biddingStrategyId = $params['rdBidId'];
			} else if($params['saveCampBid']){
				$biddingStrategyConfiguration->biddingStrategyId = $params['campBidId'];
			} else if($params['conversionBid']){
				$biddingScheme = new ConversionOptimizerBiddingScheme();
				$biddingStrategyConfiguration->biddingScheme = $biddingScheme;
				$biddingStrategyConfiguration->biddingStrategyType = 'CONVERSION_OPTIMIZER';
			} else {
				return;
			}
			$adGroupListArr = $params['chkAdgroup'];
			foreach($adGroupListArr as $adgroupId){
				$adGroup = new AdGroup();
				$adGroup->campaignId = $params['id'];
				$adGroup->id = $adgroupId;
				$adGroup->biddingStrategyConfiguration = $biddingStrategyConfiguration;
				$operation = new AdGroupOperation();
				$operation->operand = $adGroup;
				$operation->operator = 'SET';
				$operations[] = $operation;
			}
			try{
				$result = $adGroupService->mutate($operations);
				return $result->value;
			}catch(Exception $ex){
				throw $ex;
			}
		}
		/**
		 * Function to update Bidding strategy for keywords
		 * @params - $params - array of user inputs
		 * @result - array of modified adgroups
		 */
		function updateKeywordBid($params)
		{
			$adGroupCrtService = $this->user->GetService('AdGroupCriterionService', ADWORDS_VERSION);
			$operations = array();
			$biddingStrategyConfiguration = new BiddingStrategyConfiguration();
			if($params['saveManualCPC']) {
				$biddingScheme = new ManualCpcBiddingScheme();
				$biddingStrategyConfiguration->biddingScheme = $biddingScheme;
				$biddingStrategyConfiguration->biddingStrategyType = 'MANUAL_CPC';
				if($params['maxCPCBid']){
					$bid = new CpcBid();
					$defaultBid = $params['maxCPCBid'];
					$bid->bid = new Money($defaultBid * AdWordsConstants::MICROS_PER_DOLLAR);
					$biddingStrategyConfiguration->bids[] = $bid;
				}
			} else if($params['saveBidStrategy'] && $params['rdBidId']){
				$biddingStrategyConfiguration->biddingStrategyId = $params['rdBidId'];
			} else if($params['saveCampBid']){
				$biddingStrategyConfiguration->biddingStrategyId = $params['campBidId'];
			} else if($params['conversionBid']){
				$biddingScheme = new ConversionOptimizerBiddingScheme();
				$biddingStrategyConfiguration->biddingScheme = $biddingScheme;
				$biddingStrategyConfiguration->biddingStrategyType = 'CONVERSION_OPTIMIZER';
			} else {
				return;
			}
			$keywordListArr = $params['chkKeyword'];
			foreach($keywordListArr as $keywordId){
				$keywordObj = new Keyword();
				$keywordObj->id = $keywordId;
				$adGroupCriterion = new BiddableAdGroupCriterion();
				$adGroupCriterion->biddingStrategyConfiguration = $biddingStrategyConfiguration;
				$adGroupCriterion->adGroupId = $params['id'];
				$adGroupCriterion->criterion = $keywordObj;
				$adGroupCriteria[] = $adGroupCriterion;
				$operation = new AdGroupCriterionOperation();
				$operation->operand = $adGroupCriterion;
				$operation->operator = 'SET';
				$operations[] = $operation;
			}
			try{
				$result = $adGroupCrtService->mutate($operations);
				return $result->value;
			}catch(Exception $ex){
				throw $ex;
			}
		}
		/*
		 * Get the campaign list for given adword user.
		 * @params: $campaignIdArray - array of campaign Id List to get
		 * @result: retun boolean
		 */
		function getCampaignList($campaignIdArray=array())
		{
			$campaignService = $this->user->GetService('CampaignService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('Id', 'Name', 'Status', 'ServingStatus', 'Settings', 'AdvertisingChannelType', 
			'StartDate', 'EndDate', 'BudgetId', 'Eligible', 'AdServingOptimizationStatus', 
			'TargetGoogleSearch', 'TargetSearchNetwork', 'TargetContentNetwork', 'EnhancedCpcEnabled', 
			'TargetPartnerSearchNetwork', 'BiddingStrategyId', 'BiddingStrategyType', 'BidCeiling');
			$selector->ordering[] = new OrderBy('Name', 'ASCENDING');
			// Filter out deleted criteria.
			//$selector->predicates[] = new Predicate('Status', 'NOT_IN', array('REMOVED'));
			if($campaignIdArray){
				$selector->predicates[] = new Predicate('Id', 'IN', $campaignIdArray);
			}
			// Create paging controls.
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			try{
				do {
					$page = $campaignService->get($selector);
					// Display results.
					if (isset($page->entries)) {
						foreach ($page->entries as $campaign) {
							$adwCampaignObj = getObject('adwCampaign');
							$customerId= $this->customerId;
							$newCampId = $adwCampaignObj->addCampaign($campaign, $customerId);
						}
					}
					// Advance the paging index.
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
			}catch(Exception $ex){
				return false;
			}
			return true;
		}
		/**
		 * Function to get ad groups based on given campaign id and adgroupId
		 * @params: $campaignIdArr - array()
		 * @params: $adGroupIdArr - array()
		 * @result: array of adgroupIds
		 */
		function GetAdGroups($campaignIdArr=array(), $adGroupIdArr=array()) {
			$newAdgroupIdArr = array();
			$adGroupService = $this->user->GetService('AdGroupService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('Id', 'Name', 'CampaignId', 'Status','Settings', 'BiddingStrategyId', 'BiddingStrategyType', 
				'BiddingStrategySource', 'BiddingStrategyName', 'ContentBidCriterionTypeGroup','CpmBid', 'CpcBid', 'TargetCpaBid');
			$selector->ordering[] = new OrderBy('CampaignId', 'ASCENDING');
			
			if($campaignIdArr){
				$selector->predicates[] = new Predicate('CampaignId', 'IN', $campaignIdArr);
			}
			if($adGroupIdArr){
				$selector->predicates[] = new Predicate('Id', 'IN', $adGroupIdArr);
			}
			// Create paging controls.
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			try{
				do {
					// Make the get request.
					$page = $adGroupService->get($selector);
					$adwAdGroupObj = getObject('adwAdGroup');
					$customerId= $this->customerId;
					// Display results.
					if (isset($page->entries)) {
						foreach ($page->entries as $adGroup) {
							$newAdgroupIdArr[] = $adGroup->id;
							$adGroupId = $adwAdGroupObj->addAdGroup($adGroup, $customerId, $clientId, $userId);
						}
					} 
					// Advance the paging index.
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
			}catch(Exception $ex){
				return false;
			}
			return $newAdgroupIdArr;
		}
		/*
		 * Function to get Campaign Criterion
		 * @params: $campaignIdArr - array
		 * @result: boolean
		 */
		function getCampaignCriterionList($campaignIdArr=array(), $campCrtIdArr = array())
		{
			$campaignCriterionService = $this->user->GetService('CampaignCriterionService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('CampaignId', 'BidModifier','Id', 'IsNegative', 'CriteriaType', 'DayOfWeek', 'StartHour', 'StartMinute', 
				'EndHour', 'EndMinute','AgeRangeType', 'CarrierName', 'CarrierCountryCode', 'ContentLabelType', 'UserInterestId', 
				'UserInterestName', 'UserListId', 'UserListName', 'UserListMembershipStatus', 'GenderType', 'KeywordText', 'KeywordMatchType',
				'LanguageCode', 'LanguageName', 'LocationName', 'DisplayType', 'TargetingStatus', 'MatchingFunction', 'MobileAppCategoryId',
				'DeviceName','ManufacturerName','DeviceType','OperatingSystemName', 'OsMajorVersion','OsMinorVersion', 
				'OperatorType', 'PlacementUrl', 'PlatformName', 'GeoPoint','RadiusDistanceUnits','RadiusInUnits', 'Address','VerticalId', 
				'VerticalParentId', 'Path');
			$selector->ordering[] = new OrderBy('CampaignId', 'ASCENDING');
			if($campaignIdArr){
				$selector->predicates[] = new Predicate('CampaignId', 'IN', $campaignIdArr);
			}
			if($campCrtIdArr){
				$selector->predicates[] = new Predicate('Id', 'IN', $campCrtIdArr);
			}
			// Create paging controls.
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			try{
				do {
					// Make the get request.
					$page = $campaignCriterionService->get($selector);
					$addCampaignCriterionObj = getObject('adwCampCriterion');
					$customerId= $this->customerId;
					// Display results.
					if (isset($page->entries)) {
						foreach ($page->entries as $critera) {
							$campId = $addCampaignCriterionObj->addCampaignCriterion($critera, $customerId, 1, 1);
						}
					}
					// Advance the paging index.
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
			} catch(Exception $ex) {
				return false;
			}
			return true;
		}
		/**
		 * Get Campaign Extension for campaigns
		 * @params: $campaignIdArr - array
		 * @result: boolean
		 */
		function getCampaignExtensions($campaignIdArr=array())
		{}
		/**
		 * Get Campaign Extension for campaigns
		 * @params: $campaignIdArr - array
		 * @result: boolean
		 */
		function getCampaignFeeds($campaignIdArr=array())
		{
			$campaignFeedService = $this->user->GetService('CampaignFeedService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('CampaignId','FeedId','PlaceholderTypes','Status', 'MatchingFunction');
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			if($campaignIdArr){
				$selector->predicates[] = new Predicate('CampaignId', 'IN', $campaignIdArr);
			}
			$selector->predicates[] = new Predicate('Status', 'NOT_IN', array('REMOVED'));
			$entriesArr = array();
			try{
				do {
					// Make the get request.
					$page = $campaignFeedService->get($selector);
					if (isset($page->entries)) {
						foreach ($page->entries as $campaignFeed) {
							$entriesArr[] = $campaignFeed;
							$adwCampFeedObj = getObject('adwCampFeed');
							$userId = $clientId = 1;
							$campId = $adwCampFeedObj->addCampaignFeed($campaignFeed, $clientId, $userId);
						}
					}
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
				$this->addCampaignFeedMatch($entriesArr);
			}catch(Exception $ex){
				return false;
			}
			return true;
		}
		/**
		 * Add Campaign Feed Match in Database
		 * @params: array of Campaign feeds
		 * @result: boolean
		 */
		function addCampaignFeedMatch($campaignFeedArr)
		{
			foreach($campaignFeedArr as $campaignFeed){
				$matchFunction = $campaignFeed->matchingFunction;
				$campaignId = $campaignFeed->campaignId;
				$feedId = $campaignFeed->feedId;
				$adwCampFeedMatchObj = getObject('adwCampFeedMatch');
				$adwCampFeedMatchObj->deleteCampaignFeedMatch($campaignId, $feedId);
				if($matchFunction->rhsOperand){
					$this->getCampaignFeedMatches($matchFunction, $campaignId, $feedId);
				} else {
					foreach($matchFunction->lhsOperand as $operand){
						if($operand instanceof FunctionOperand) {
							$feedFuntion = $operand->value;
							$this->getCampaignFeedMatches($feedFuntion, $campaignId, $feedId);
						}
					}
				}
			}
			return true;
		}
		/**
		 * Get Text Ads 
		 * @params: $adGroupIdArr - array
		 * @return: boolean
		 */
		function GetTextAds($adGroupIdArr=array()) 
		{
			$adGroupAdService = $this->user->GetService('AdGroupAdService', ADWORDS_VERSION);
			// Create selector.
			$selector = new Selector();
			$selector->fields = array('AdGroupId',  'Status','AdGroupCreativeApprovalStatus','AdGroupAdDisapprovalReasons',
				'AdGroupAdTrademarkDisapproved', 'Id', 'Url', 'DisplayUrl', 'DevicePreference', 'Headline', 'Description1', 'Description2', 'AdType');
			$selector->ordering[] = new OrderBy('AdGroupId', 'ASCENDING');
			// Create predicates.
			$selector->predicates[] = new Predicate('AdType', 'IN', array('TEXT_AD','DYNAMIC_SEARCH_AD'));
			$selector->predicates[] = new Predicate('Status', 'IN', array('ENABLED', 'PAUSED', 'DISABLED'));
			if($adGroupIdArr){
				$selector->predicates[] = new Predicate('AdGroupId', 'IN', $adGroupIdArr);
			}
			// Create paging controls.
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			$customerId= $this->customerId;
			try{
				do {
					$page = $adGroupAdService->get($selector);
					$adwTextAdObj = getObject('adwTextAd');
					// Display results.
					if (isset($page->entries)) {
						foreach ($page->entries as $adGroupAd) {
							$clientId = 1;
							$userId = 1;
							$textAdId = $adwTextAdObj->addTextAd($adGroupAd, $customerId, $clientId, $userId);
						}
					}
					// Advance the paging index.
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
			} catch(Exception $ex){
				return false;
			}
			return true;
		}
		/**
		 * Function to get adgroup criterion
		 * @params: $adGroupIdArr - array
		 * @return: boolean
		 */
		function getAdGroupCriterion($adGroupIdArr=array())
		{
			$adGroupCriterionService = $this->user->GetService('AdGroupCriterionService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('Id', 'AdGroupId', 'AgeRangeType', 'ApprovalStatus', 'Argument', 'BidModifier', 'BidType', 
				'BiddingStrategyId', 'BiddingStrategyName', 'BiddingStrategySource', 'BiddingStrategyType', 'CaseValue', 'CpcBid', 
				'CpcBidSource', 'CpmBid', 'CpmBidSource', 'CriteriaCoverage', 'CriteriaSamples', 'CriteriaType', 'CriterionUse', 
				'DestinationUrl', 'DisapprovalReasons', 'DisplayName', 'EnhancedCpcEnabled', 'ExperimentBidMultiplier', 'ExperimentDataStatus', 
				'ExperimentDeltaStatus', 'ExperimentId', 'FirstPageCpc', 'GenderType', 'IsKeywordAdRelevanceAcceptable', 
				'IsLandingPageQualityAcceptable', 'KeywordMatchType', 'KeywordText', 'MobileAppCategoryId',
				'Operand', 'Parameter', 'ParentCriterionId', 'PartitionType', 'Path', 'PercentCpaBid', 'PercentCpaBidSource', 'PlacementUrl', 
				'QualityScore', 'Status', 'SystemServingStatus', 'Text', 'TopOfPageCpc', 'UserInterestId', 'UserInterestName', 'UserListId', 
				'UserListMembershipStatus', 'UserListName','VerticalId', 'VerticalParentId');
			$selector->ordering[] = new OrderBy('AdGroupId', 'ASCENDING');
			if($adGroupIdArr) { 
				$selector->predicates[] = new Predicate('AdGroupId', 'IN', $adGroupIdArr);
			}
			$selector->predicates[] = new Predicate('Status', 'IN', array('ENABLED', 'PAUSED', 'REMOVED'));
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			$count = 0;
			try{
				do {
					// Make the get request.
					$page = $adGroupCriterionService->get($selector);
					$customerId= $this->customerId;
					$count = 0;
					// Display results.
					if (isset($page->entries)) {
					  foreach ($page->entries as $adGroupCriteria) {
						$count++;
						$clientId = $userId = 1;
						$adwAdGroupCriterionObj = getObject('adwAdGroupCriterion');
						$groupCritId = $adwAdGroupCriterionObj->addAdGroupCriterion($adGroupCriteria, $customerId, $clientId, $userId);
					  }
					}
					// Advance the paging index.
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
			}catch(Exception $ex){
				return false;
			}
			return true;
		}
		/**
		 * Function to get adgroup feeds
		 * @params: $adGroupIdArr - array
		 * @return: boolean
		 */
		function getAdgroupFeeds($adGroupIdArr=array())
		{
			$adGroupFeedService  = $this->user->GetService('AdGroupFeedService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('AdGroupId','FeedId','PlaceholderTypes','Status', 'MatchingFunction');
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			if($adGroupIdArr) { 
				$selector->predicates[] = new Predicate('AdGroupId', 'IN', $adGroupIdArr);
			}
			$entriesArr = array();
			try{
				do {
					// Make the get request.
					$page = $adGroupFeedService->get($selector);
					if (isset($page->entries)) {
						foreach ($page->entries as $adGroupFeed) {
							$entriesArr[] = $adGroupFeed;
							$adwAdGroupFeedObj = getObject('adwAdGroupFeed');
							$userId = $clientId = 1;
							$campId = $adwAdGroupFeedObj->addAdGroupFeed($adGroupFeed, $clientId, $userId);
						}
					}
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
				$this->addAdgroupFeedMatch($entriesArr);
			} catch(Exception $ex){
				return false;
			}
			return true;
		}
		/**
		 * Function to add adgroup feed match in array
		 * @params: $adGroupIdArr - array
		 * @return: boolean
		 */
		function addAdgroupFeedMatch($adgroupFeedArr)
		{
			foreach($adgroupFeedArr as $adgroupFeed){
				$matchFunction = $adgroupFeed->matchingFunction;
				$adGroupId = $adgroupFeed->adGroupId;
				$feedId = $adgroupFeed->feedId;
				$adwAdgroupFeedMatchObj = getObject('adwAdgroupFeedMatch');
				$adwAdgroupFeedMatchObj->deleteAdgroupFeedMatch($adGroupId, $feedId);
				if($matchFunction->rhsOperand){
					$this->getAdgroupMatches($matchFunction, $adGroupId, $feedId);
				} else {
					foreach($matchFunction->lhsOperand as $operand){
						if($operand instanceof FunctionOperand) {
							$feedFuntion = $operand->value;
							$this->getAdgroupMatches($feedFuntion, $adGroupId, $feedId);
						}
					}
				}
			}
			return true;
		}
		/**
		 * Function to get Feeds
		 * @params: $feedIdList = array
		 * @result: boolean
		 */
		function getFeeds($feedIdList=array())
		{
			$feedService = $this->user->GetService('FeedService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('Attributes','FeedStatus','Id','Name','Origin','SystemFeedGenerationData');
			$selector->predicates[] = new Predicate('FeedStatus', 'NOT_IN', array('REMOVED'));
			if($feedIdList){
				$selector->predicates[] = new Predicate('Id', 'IN', $feedIdList);
			}
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			try{
				do {
					// Make the get request.
					$page = $feedService->get($selector);
					$adwFeedObj = getObject('adwFeed');
					$customerId= $this->customerId;
					if (isset($page->entries)) {
						foreach ($page->entries as $feed) {
							$clientId = $userId = 1;
							$feedId = $adwFeedObj->addFeed($feed, $customerId, $clientId, $userId);
						}
					} 
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
				return true;
			}catch(Exception $ex) {
				return false;
			}
		}
		/**
		 * Function to get feed items
		 * @params: $feedIdList - array
		 * @result: boolean
		 */
		function getFeedItems($feedIdList=array())
		{
			$feedItemService = $this->user->GetService('FeedItemService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('AttributeValues','DevicePreference','EndTime','FeedId','FeedItemId',
									  'Scheduling','StartTime','Status','PolicyData');
			if($feedIdList){
				$selector->predicates[] = new Predicate('FeedId', 'IN', $feedIdList);
			}
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			try{
				do {
					$page = $feedItemService->get($selector);
					if (isset($page->entries)) {
						foreach ($page->entries as $feedItem) {
							$adwFeedItemObj = getObject('adwFeedItem');
							$clientId = $userId = 1;
							$feedItemId = $adwFeedItemObj->addFeedItem($feedItem, $clientId, $userId);
						}
					}
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
			}catch(Exception $ex){
				return false;
			}
		}
		/**
		 * Function to get feed mapping
		 * @params: $feedIdList - array
		 * @result: boolean
		 */
		function getFeedMapping($feedIdList=array())
		{
			$feedMapService = $this->user->GetService('FeedMappingService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('AttributeFieldMappings','CriterionType','FeedId','FeedMappingId','PlaceholderType','Status');
			$selector->predicates[] = new Predicate('Status', 'NOT_IN', array('REMOVED'));
			if($feedIdList){
				$selector->predicates[] = new Predicate('FeedId', 'IN', $feedIdList);
			}
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			try{
				do {
					// Make the get request.
					$page = $feedMapService->get($selector);
					if (isset($page->entries)) {
						foreach ($page->entries as $feedMap) {
							$adwFeedMapObj = getObject('adwFeedMap');
							$clientId = $userId = 1;
							$adwFeedMapObj->addFeedMap($feedMap, $clientId, $userId);
						}
					}
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
			} catch(Exception $ex){
				return false;
			}
			return true;
		}
		/**
		 * Function to get bidding stratergy
		 * @result: boolean
		 */
		function getBiddingStatergy()
		{
			$campaignService = $this->user->GetService('BiddingStrategyService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('Id', 'Name', 'BiddingScheme', 'Status', 'Type', 'PageOnePromotedStrategyGoal', 'PageOnePromotedBidCeiling', 
				'PageOnePromotedBidModifier', 'PageOnePromotedBidChangesForRaisesOnly', 'PageOnePromotedRaiseBidWhenBudgetConstrained', 
				'PageOnePromotedRaiseBidWhenLowQualityScore','TargetCpa', 'TargetCpaMaxCpcBidCeiling', 'TargetCpaMaxCpcBidFloor', 'TargetRoas', 
				'TargetRoasBidCeiling', 'TargetRoasBidFloor', 'TargetSpendBidCeiling', 'TargetSpendSpendTarget');
			$selector->ordering[] = new OrderBy('Id', 'ASCENDING');
		 
			// Filter out deleted criteria.
			$selector->predicates[] = new Predicate('Status', 'NOT_IN', array('REMOVED'));
		 
			// Create paging controls.
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
		 	try{
				do {
					// Make the get request.
					$page = $campaignService->get($selector);
					
					$adwBidStatObj = getObject('adwBidStrategy');
					$customerId = $this->user->GetClientCustomerId();
			 
					// Display results.
					if (isset($page->entries)) {
						foreach ($page->entries as $entry) {
							$userId = 1;
							$clientId = 1;
							$bidId = $adwBidStatObj->addBidStrategy($entry, $customerId, $clientId, $userId);
						}
					}
					// Advance the paging index.
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
			}catch(Exception $ex){
				return false;
			}
			return true;
		}
		/**
		 * Function to get Budget List for customer
		 * @result: boolean
		 */
		function getBudgetList()
		{
			$campaignService = $this->user->GetService('BudgetService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('BudgetId', 'BudgetName', 'Period', 'Amount', 'DeliveryMethod', 'BudgetReferenceCount', 
				'IsBudgetExplicitlyShared','BudgetStatus');
			$selector->ordering[] = new OrderBy('BudgetId', 'ASCENDING');
			// Filter out deleted criteria.
			$selector->predicates[] = new Predicate('BudgetStatus', 'NOT_IN', array('REMOVED'));
			// Create paging controls.
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			try{
				do {
					// Make the get request.
					$page = $campaignService->get($selector);
					$adwBudgetObj = getObject('adwBudget');
					$customerId= $this->user->GetClientCustomerId();		 
					if (isset($page->entries)) {
						foreach ($page->entries as $budget) {
							$budgetId = $adwBudgetObj->addAdwordBudget($budget, $customerId, $clientId, $userId);
						}
					}
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
			} catch(Exception $ex){
				return false;
			}
			return true;
		}
		/**
		 * Function to get Conversion Trackers list
		 * @result: boolean
		 */
		function getConversionTrackers()
		{
			$conversionTrackerService = $this->user->GetService('ConversionTrackerService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('AlwaysUseDefaultRevenueValue','AppId','AppPlatform','AppPostbackUrl','BackgroundColor','Category',
				'ConversionPageLanguage','ConversionValue','CountingType','CtcLookbackWindow','DefaultRevenueValue','Id','IsProductAdsChargeable',
				'MarkupLanguage','MostRecentConversionDate','Name','NumConversionEvents','NumConvertedClicks','PhoneCallDuration',
				'ProductAdsChargeableConversionWindow','Status','TextFormat','TrackingCodeType','ViewthroughLookbackWindow'); //'OriginalConversionTypeId'
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			$entryArr = array();
			try{
				do {
					// Make the get request.
					$page = $conversionTrackerService->get($selector);
					if (isset($page->entries)) {
						foreach ($page->entries as $conversionTracker) {
						   $entryArr[] = $conversionTracker;
						}
					}
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
				$adwConvObj = getObject('adwConversionTracker');
				$customerId= $this->user->GetClientCustomerId();
				if($entryArr){
					foreach($entryArr as $conversionTracker){
						$conversionId = $adwConvObj->addConversionTracker($conversionTracker, $customerId, 1, 1);
					}
				}
				return true;				
			}catch(Exception $ex){
				return false;
			}
		}
		/**
		 * Function to get customer feeds
		 * @result boolean
		 */
		 function getCustomerFeeds()
		 {
		 	$customerFeedService = $this->user->GetService('CustomerFeedService', ADWORDS_VERSION);
			$selector = new Selector();
			$selector->fields = array('FeedId','PlaceholderTypes','Status', 'MatchingFunction');
			$selector->paging = new Paging(0, AdWordsConstants::RECOMMENDED_PAGE_SIZE);
			$entriesArr = array();
			try{
				do {
					// Make the get request.
					$page = $customerFeedService->get($selector);
					if (isset($page->entries)) {
						foreach ($page->entries as $customerFeed) {
							$entriesArr[] = $customerFeed;
						}
					}
					$selector->paging->startIndex += AdWordsConstants::RECOMMENDED_PAGE_SIZE;
				} while ($page->totalNumEntries > $selector->paging->startIndex);
				foreach($entriesArr as $customerFeed){
					$adwCampFeedObj = getObject('adwCustomerFeed');
					$userId = $clientId = 1;
					$customerId= $this->user->GetClientCustomerId();
					$campId = $adwCampFeedObj->addCustomerFeed($customerFeed, $customerId, $clientId, $userId);
				}
			} catch(Exception $ex){
				return false;
			}
			return $entriesArr;
		 }
		 /**
		  * Function to create adgroups with keywords
		  * @params: array of user inputs
		  * @return: array of success and failure upload keywords
		  */
		 function addNewKeywordForAdgroup($params)
		 {
		 		require_once UTIL_PATH . '/ChoiceUtils.php';
				require_once UTIL_PATH . '/OgnlUtils.php';
				$campaignId = $params['campaignList'];
				$adGroupId = $params['adGroup'];
				$customerId= $this->user->GetClientCustomerId();
				if($adGroupId == -1){
					$adGroupName = $params['newAdgroup'];
					$adGroupList = $this->addNewAdGroup($campaignId, $adGroupName, 1);
					$adwAdGroupObj = getObject('adwAdGroup');
					foreach ($adGroupList as $adGroup) {
						$adGroupId = $adwAdGroupObj->addAdGroup($adGroup, $customerId, $clientId, $userId);
					}
					$adGroupId = $adGroup->id;
				}
				$keywordList = $params['checkKeyword'];
				if(!$keywordList) return;
				$adwKeyIdeaResultObj = getObject('adwKeyIdeaResult');
				$keywordResultList = $adwKeyIdeaResultObj->getKeywordForAdd($params['ideaId'], $keywordList, $params['userClientId']);
				$mutateJobService = $this->user->GetService('MutateJobService', ADWORDS_VERSION);
				$keywordListId = array();
				foreach($keywordResultList as $keywordList){
					$keywordObj = new Keyword();
					$keywordObj->matchType = 'BROAD';
					$keywordObj->text = $keywordList['ar_text'];
					$keywordListId[] = $keywordList['ar_id'];
					$adGroupCriterion = new BiddableAdGroupCriterion();
					$adGroupCriterion->adGroupId = $adGroupId;
					$adGroupCriterion->criterion = $keywordObj;
					$operation = new AdGroupCriterionOperation();
					$operation->operator = 'ADD';
					$operation->operand = $adGroupCriterion;
					$operations[] = $operation;
				}
				$policy = new BulkMutateJobPolicy();
				$policy->prerequisiteJobIds = array();
				$job = $mutateJobService->mutate($operations, $policy);
				$selector = new BulkMutateJobSelector();
				$selector->jobIds[] = $job->id;
				$selector->includeStats = TRUE;
				$selector->includeHistory = TRUE;
				$numRetries = 0;
				$maxRetries = 100;
				$retryInterval = 10;
				do {
					sleep($retryInterval);
					$jobs = $mutateJobService->get($selector);
					$job = $jobs[0];
					switch ($job->status) {
						case 'PENDING': break;
						case 'PROCESSING': break;
						case 'COMPLETED': break;
						case 'FAILED': break;
					}
					$numRetries++;
				} while (($job->status == 'PENDING' || $job->status == 'PROCESSING') && $numRetries < $maxRetries);
				if ($job->status == 'COMPLETED') {
					$jobResult = ChoiceUtils::GetValue($mutateJobService->getResult($selector));
					$lost = array();
					$skipped = array();
					$skippedIdArr = array();
					$failed = array();
					$errors = array();
					$genericErrors = array();
					$succeeded = array();
					for ($i = 0; $i < sizeof($jobResult->results); $i++) {
					  $operation = $operations[$i];
					  $adwAdGroupCriterionObj = getObject('adwAdGroupCriterion');
					  $result = ChoiceUtils::GetValue($jobResult->results[$i]);
					  if ($result instanceof AdGroupCriterion) {
							$succeeded[] = $result->criterion->text;
							$adwAdGroupCriterionObj->addAdGroupCriterion($result, $customerId,$params['userClientId'], $params['userId']);
					  }
					}
					foreach ($jobResult->errors as $error) {
						$index = OgnlUtils::GetOperationIndex($error->fieldPath);
						if (isset($index)) {
							$keywordText = $operations[$index]->operand->criterion->text;
							$keywordId = $keywordListId[$index];
							switch ($error->reason) {
								case 'LOST_RESULT':
									$lost[] = $keywordText;
								break;
								case 'UNPROCESSED_RESULT':
								case 'BATCH_FAILURE':
									$skipped[] = $keywordText;
									$skippedIdArr[] = $keywordId;
								break;
								default:
								if (!in_array($keywordText, $failed)) {
									$failed[] = $keywordText;
								}
								$errors[$keywordText][] = $error;
							}
						} else {
							$genericErrors[] = $error;
						}
					}
				}
				if($skipped){
					$adwKeyIdeaResultObj = getObject('adwKeyIdeaResult');
					$keywordResultList = $adwKeyIdeaResultObj->updateKeywordFailedToUpload($params['ideaId'], $params['userClientId'], $skippedIdArr);
				}
				$resultArr = array('adGroupId'=> $adGroupId,
					'success'=>$succeeded, 
					'skipped' => $skipped, 
					'failed' => $failed, 
					'genereicError' => $genericErrors, 
					'errors' =>$errors);
				return $resultArr;
		 }
		 
		 /**
		  * Update the Call Only Ad status
		  * @params: $params - array of user inputs
		  * @result: List of Ads
		  */
		function updateCallOnlyAdStatus($params)
		{
			$adGroupAdService = $this->user->GetService('AdGroupAdService', ADWORDS_VERSION);
			$adStatus = $params['callAdStatus'];
			$adList = $params['chkCallAd'];
			$operations = array();
			foreach($adList as $adId){
				$callOnlyAd = new CallOnlyAd();
				$callOnlyAd->id = $adId;
				// Create ad group ad.
				$adGroupAd = new AdGroupAd();
				$adGroupAd->adGroupId = $params['id'];
				$adGroupAd->ad = $callOnlyAd;
				$adGroupAd->status = $adStatus;
				// Create operation.
				$operation = new AdGroupAdOperation();
				$operation->operand = $adGroupAd;
				$operation->operator = 'SET';
				$operations[] = $operation;
			}
			try {
				if($operations){
					$result = $adGroupAdService->mutate($operations);
					$adGroupList = $result->value;
					return $adGroupList;
				}
			} catch(Exception $e) {
				throw $e;
			}
		}
		
		/**
		 * Function to edit Call only ads
		 * @params: $adgroupId - long
		 * @params: $params - array of user inputs
		 */
		function editCallOnlyAds($adGroupId, $params=array())
		{
			$adGroupAdService = $this->user->GetService('AdGroupAdService', ADWORDS_VERSION);
			$operations = array();
			$editAdArr = $params['editAd'];
			$deleteAdArr = $params['deleteAd'];
			$businessNameArr = $params['businessName'];
			$description1Arr = $params['ca_description1'];
			$description2Arr = $params['ca_description2'];
			$displayUrlArr = $params['displayUrl'];
			$phoneNoArr = $params['phoneNo'];
			//$destUrlArr  =$params['destURL'];
			$deviceArr = $params['device'];
			$statusArr = $params['status'];
			$phoneNoVerificationUrl = $params['phoneVerificationUrl'];
			$newBusinessNameArr = $params['newBusinessName'];
			$newDesc1Arr = $params['newDescription1'];
			$newDesc2Arr = $params['newDescription2'];
			$newDisplayUrlArr = $params['newDisplayUrl'];
			$newDestURLArr = $params['newDestURL'];
			$newStatusArr = $params['newStatus'];
			$newDeviceArr = array_values($params['newDevice']);
			$newPhoneNoArr = $params['newPhoneNo'];
			$newPhoneNoVerificationUrl = $params['newPhoneVerificationUrl'];
			if($newBusinessNameArr){
				foreach($newBusinessNameArr as $newKey => $newBusinessName){
					if(! $newBusinessName) continue;
					$callOnlyAd = new CallOnlyAd();
					$callOnlyAd->businessName = $newBusinessName;//. uniqid();
					$callOnlyAd->description1 = $newDesc1Arr[$newKey];
					$callOnlyAd->description2 = $newDesc2Arr[$newKey];
					$callOnlyAd->displayUrl = $newDisplayUrlArr[$newKey];
					$callOnlyAd->countryCode = 'US';
					if($newPhoneNoVerificationUrl[$newKey]){
						$callOnlyAd->phoneNumberVerificationUrl = $newPhoneNoVerificationUrl[$newKey];
					}
					//$callOnlyAd->finalUrls = array($newDestURLArr[$newKey]);
					$callOnlyAd->devicePreference = $newDeviceArr[$newKey] ? $newDeviceArr[$newKey]: NULL;
					$callOnlyAd->phoneNumber = $newPhoneNoArr[$newKey];
					// Create ad group ad.
					$adGroupAd = new AdGroupAd();
					$adGroupAd->adGroupId = $adGroupId;
					$adGroupAd->ad = $callOnlyAd;
					$adGroupAd->status = $newStatusArr[$newKey];
					// Create operation.
					$operation = new AdGroupAdOperation();
					$operation->operand = $adGroupAd;
					$operation->operator = 'ADD';
					$operations[] = $operation;
				}
			}
			foreach($editAdArr as $editAdId=>$editable){
				if(!$editable){
					continue;
				}
				$callOnlyAd = new CallOnlyAd();
				$callOnlyAd->businessName = $businessNameArr[$editAdId];//. uniqid();
				$callOnlyAd->description1 = $description1Arr[$editAdId];
				$callOnlyAd->description2 = $description2Arr[$editAdId];
				$callOnlyAd->displayUrl = $displayUrlArr[$editAdId];
				$callOnlyAd->countryCode = 'US';
				//$callOnlyAd->finalUrls = array($destUrlArr[$editAdId]);
				if($phoneNoVerificationUrl[$editAdId]){
					$callOnlyAd->phoneNumberVerificationUrl = $phoneNoVerificationUrl[$editAdId];
				}
				$callOnlyAd->devicePreference = $deviceArr[$editAdId] ? $deviceArr[$editAdId]: NULL;
				$callOnlyAd->phoneNumber = $phoneNoArr[$editAdId];
				// Create ad group ad.
				$adGroupAd = new AdGroupAd();
				$adGroupAd->adGroupId = $adGroupId;
				$adGroupAd->ad = $callOnlyAd;
				$adGroupAd->status = $statusArr[$editAdId];
				// Create operation.
				$operation = new AdGroupAdOperation();
				$operation->operand = $adGroupAd;
				$operation->operator = 'ADD';
				$operations[] = $operation;
			}
			foreach($deleteAdArr as $deleteAdId => $deletable){
				$editable = $editAdArr[$deleteAdId];
				if($deletable == 0 && $editable == 0){
					continue;
				}
				$callOnlyAd = new CallOnlyAd();
				$callOnlyAd->id = $deleteAdId;
				$adGroupAd = new AdGroupAd();
				$adGroupAd->adGroupId = $adGroupId;
				$adGroupAd->ad = $callOnlyAd;
				$operation = new AdGroupAdOperation();
				$operation->operand = $adGroupAd;
				$operation->operator = 'REMOVE';
				$operations[] = $operation;
			}
			try{
				if($operations){
					$result = $adGroupAdService->mutate($operations);
					return $result->value;
				}
			} catch(Exception $ex){
				throw $ex;
			}
		}
}
?>