<?php
//Replace the line with require "vendor/autoload.php" if you are using the Samples from outside of _Samples folder
include('../config.php');

use QuickBooksOnline\API\Core\ServiceContext;
use QuickBooksOnline\API\DataService\DataService;
use QuickBooksOnline\API\PlatformService\PlatformService;
use QuickBooksOnline\API\Core\Http\Serialization\XmlObjectSerializer;
use QuickBooksOnline\API\Facades\Invoice;

// Prep Data Services
/*$dataService = DataService::Configure(array(
       'auth_mode' => 'oauth1',
         'consumerKey' => "qyprdUSoVpIHrtBp0eDMTHGz8UXuSz",
         'consumerSecret' => "TKKBfdlU1I1GEqB9P3AZlybdC8YxW5qFSbuShkG7",
         'accessTokenKey' => "qyprdxccscoNl7KRbUJoaJQIhUvyXRzD9tNOlXn4DhRDoj4g",
         'accessTokenSecret' => "JqkHSBKzNHbqjMq0Njbcq8fjgJSpfjMvqHVWnDOW",
         'QBORealmID' => "193514464689044",
         'baseUrl' => "Development"
));*/

$dataService = DataService::Configure(array(
     'auth_mode' => 'oauth2',
     'ClientID' => "Q0YaXtyl1AGdmPRxrPLIYd2WLOgHrEVSZynMwaLEisOuB8Jhwd",
     'ClientSecret' => "rfXGiCkmTul7CRQ3D37yIrM12MTA8M7hBWoxs1sz",
     'accessTokenKey' => 'eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..01_6r_Z5oEmcdz8Gz9yV2Q.pRr-Bl7y0lIT3xK6kjBQVScD5cpUFahjOb_ME4-HTZNBozjkls8w2mfuZ5qCz0yaRQd-IR8uTo8vp474tXYue5lsiw51hYOgshXpHwy_q7--XlXQnRoHANjBijhRB18tMrApbWZsx5HuvL4wKqaT0MytMyXPa9oBjAs6kWfHqF5dLuhPrfO2D_8OnLiwBhP5ykg-2-Yg2IItoGT9wKG86CFln8GCw3Kv6EDKpFQzbx8fqiwPbBf0Iuudhy2Ayq2XXPgIq86DaTKRuUkFSOrkKmnXM6Fy6zi_9n1N5EvtORgL-6Ru81-5xI0F6go-YhSQpOdlBTXeFcohXOmmT2DSuhKMmPrAF-vkpnlZjRB46krQnRYnSjknOuhOE6Bj1Zu8bqWFFgOxzslD33wS2NKULSWcxhPKI_FB0U_FKHkdbpZyehGSgZ_dmsGV70vpkH2wmLmyFEUDXRzSQfNVDijYM7CQk9suu6SxnqdBSJwSLgkRbHDXxxO41JKsLO1oyqFxOHTutFBr30xVaHQyKsEcX1JxX0zsZAErIAk4bA8t-MqAU-fKguy0nJGQROnnpC_3y8Gy_6rn35wpb-EBZnhSymwcTWNPH3TGTH7MUsMUfKjSS1U7_w_qVHsTIbiIV5ZAFL3agYWJ7Zx4XGrVkavc8ACg6hWUJ4aPEHJQDDE9Wy_d2Fprf0FDbGp6JXtuWgz9CpRMHMvWgj7Gm0JAPE1n8XIeiuJ1GplWMREl0J6dC8PLztqH5mmQ-oZO_HlScoSb.W_-izBelqyvrMmmDY1mfZg',
     'refreshTokenKey' => "Q011524923896Mk0uo8Vp6CkI5yq7NYZtRLArbBdCVnVFMZaJ5",
     'QBORealmID' => "193514687654644",
     'baseUrl' => "Development"
));

$dataService->setLogLocation("/Users/hlu2/Desktop/newFolderForLog");

$dataService->throwExceptionOnError(true);

$OAuth2LoginHelper = $dataService->getOAuth2LoginHelper();

$accessToken = $OAuth2LoginHelper->refreshToken();

$dataService->updateOAuth2Token($accessToken);

//Add a new Invoice
$theResourceObj = Invoice::create([
     "Line" => [
   [
     "Amount" => 999.00,
     "DetailType" => "SalesItemLineDetail",
     "SalesItemLineDetail" => [
       "ItemRef" => [
         "value" => 73,
         "name" => "Photo Gallery Optimization"
        ],
		"ClassRef"=> [
		"value"=> "5000000000000041598"
		]
      ]
      ]
    ],
	"CustomerRef"=> [
	  "value"=> 58
	]
	
]);
$resultingObj = $dataService->Add($theResourceObj);

echo "<pre>";

$error = $dataService->getLastError();
if ($error != null) {
    echo "The Status code is: " . $error->getHttpStatusCode() . "\n";
    echo "The Helper message is: " . $error->getOAuthHelperError() . "\n";
    echo "The Response message is: " . $error->getResponseBody() . "\n";
}
else {
    echo "Created Id={$resultingObj->Id}. Reconstructed response body:\n\n";
    $xmlBody = XmlObjectSerializer::getPostXmlFromArbitraryEntity($resultingObj, $urlResource);
    echo $xmlBody . "\n";
}

/*
Created Customer Id=801. Reconstructed response body:

<?xml version="1.0" encoding="UTF-8"?>
<ns0:Customer xmlns:ns0="http://schema.intuit.com/finance/v3">
  <ns0:Id>801</ns0:Id>
  <ns0:SyncToken>0</ns0:SyncToken>
  <ns0:MetaData>
    <ns0:CreateTime>2013-08-05T07:41:45-07:00</ns0:CreateTime>
    <ns0:LastUpdatedTime>2013-08-05T07:41:45-07:00</ns0:LastUpdatedTime>
  </ns0:MetaData>
  <ns0:GivenName>GivenName21574516</ns0:GivenName>
  <ns0:FullyQualifiedName>GivenName21574516</ns0:FullyQualifiedName>
  <ns0:CompanyName>CompanyName426009111</ns0:CompanyName>
  <ns0:DisplayName>GivenName21574516</ns0:DisplayName>
  <ns0:PrintOnCheckName>CompanyName426009111</ns0:PrintOnCheckName>
  <ns0:Active>true</ns0:Active>
  <ns0:Taxable>true</ns0:Taxable>
  <ns0:Job>false</ns0:Job>
  <ns0:BillWithParent>false</ns0:BillWithParent>
  <ns0:Balance>0</ns0:Balance>
  <ns0:BalanceWithJobs>0</ns0:BalanceWithJobs>
  <ns0:PreferredDeliveryMethod>Print</ns0:PreferredDeliveryMethod>
</ns0:Customer>
*/
