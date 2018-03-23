<?php
//Replace the line with require "vendor/autoload.php" if you are using the Samples from outside of _Samples folder
include('../config.php');

use QuickBooksOnline\API\Core\ServiceContext;
use QuickBooksOnline\API\DataService\DataService;
use QuickBooksOnline\API\PlatformService\PlatformService;
use QuickBooksOnline\API\Core\Http\Serialization\XmlObjectSerializer;
use QuickBooksOnline\API\Facades\Vendor;

// Prep Data Services
/*
$dataService = DataService::Configure(array(
       'auth_mode' => 'oauth2',
         'ClientID' => "Q0fXL014zAv3wzmlhwXMEHTrKepfAshCRjztEu58ZokzCD5T7D",
         'ClientSecret' => "stfnZfuSZUDay6cJSWtvQ9HkWiKFbcI9YuBTET5P",
         'accessTokenKey' =>  "eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..lmGChkCAJYTxucq_gspS8A.of6yijgWgpPQ744zAoQZHL3ePKpF8b9UrAX9BB7Pp94-52acJgvTLaiJwSpbxTHs1S-1ap3WokLxL44_dciUANbSeqLvn6gf_oSv3TSNT_Za4j72Pl6kR8-VAcmYqIB75VLTvXA65qrPYirKRxsdJLs-WzzIEab6n5rNJo2DzAgqUIkir__ltf3JBOLvaaz3Hp40KvZaVQG0cl2w60DfIs-fjZwhzJG5FKSorw-_TCg1xmxbJXC6bZBntbo-OwiL5yJ8_FAsPcNo2d-sONhltN7zBug6M_dJ8Ptj3GhOJh8V16LUC0BFvvTncWTyiRPG8yDcq1Ngm172aDIw5jlL5UzW0hS8GarOGGUjWIc4nO_Zvvn1NwP06-1cL7Mb7HNJ4CgG9EjotqLHK07DEegQO5NZTRRE3lQfjtndcb4g2EsQJrThy6d412DD9UIwK-mm8gIch3skATvnDskWkP_fegmaAvd40jSMptPVt4_ujy-55CmZHk46QwjCJTiiSrh6kid--QewudVC9Mz6y3nnjEfEWZpsFcuuU7omghu-Ds-aoW94pYrKLTWcDd56S4moT9VFcvJGK5Ew_5HT6eavNvFhcO376mdkeYGxFJ7o4-i-4vCv27H-3KH4147yAheSJ0dqvjNxyFTCfULKPm2kgjz8LpcIi2wxLpShG7wgoe9ldcYUQTyDZ8wME6qgUR95.xczznGp9u2s1likp8jOhaQ",
         'refreshTokenKey' => 'Q0115201062198zx1lpp6MpzcYOqWbwqbHVJGfy0ledlb6A9Z8',
         'QBORealmID' => "193514611894164",
         'baseUrl' => "development"
));
*/

$dataService = DataService::Configure(array(
     'auth_mode' => 'oauth2',
     'ClientID' => "Q0YaXtyl1AGdmPRxrPLIYd2WLOgHrEVSZynMwaLEisOuB8Jhwd",
     'ClientSecret' => "rfXGiCkmTul7CRQ3D37yIrM12MTA8M7hBWoxs1sz",
     'accessTokenKey' => 'eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..NaDU4NyJAmrjp8_Tg5_x8Q.OVZLb-IBhZHy81pyymLgM0lkHN8rhc480WEpUBvKnBNw7EWtOijcliiXjwkgiin1C9zxz9HAUvolXkiws4toM5st-uSyi4CYsybjxvgOGC017L8T1Dsarbkcjf0HiBWhWwn6EpeiM6hOHbxAIAssS8yR2286o3eJ2uWlMGhcNYSISuMQlc2MnEqE4sSy_6a222xL-VQkYZd-ngdS3ACOsXv7sv1qghg_MH4Lfkv3x3VW-AbhTcZL4QbpvmdF7OckbQimYuLBWYhI6D3chAq72cs3dAaJ_6J_pMP6RN3Oa_G2x4bq8zGoYygMKLjjNbQJtxoFLdXDKteH1alNho7q_wHIBFuF-jpaZfVPb7gKourTqLDg5Iej6soHVPJn8eIhQ2R8vQUTthXz1gAfAbWj3qQzeIGGJev7NbfXe3yN5xCf6-dp0ChtjxNReitH2O5-zROol1GaF6pcYZr2Rjy_2CejLOHAmH2S4JqvCwjqVL9iaKUtyCeMRHrwtgtPuWFawW3XIe7XtRZNKfc-dfyMNuHmYiz_64g07rCQ4Oibt-wchQH0rq44UBOEAQBc7Hsv_ynHMT4pfek59Bmo24ElbeWzAUBQwQ6MtA7OrcUai2h3VM77mtjFtCAKOLxqrcYFNqx1BqJrxb3xm3FGJZEm2oby_KZxKsUW4OVflwCiypvlBN2RURKNcfh-zd53kIrw17Ot7ygQYrpWCsWADVy6iA.KtHwNiyh-eCpAMRADjsIow',
     'refreshTokenKey' => "Q011526363547ONbcpRcHnygEWXR1Ohmlz4bO3RF3o5M8GjLpT",
     'QBORealmID' => "193514687654644",
     'baseUrl' => "Development"
));

$dataService->setLogLocation("/Users/hlu2/Desktop/newFolderForLog");

// Run a query
$entities = $dataService->Query("Select * FROM vendor");

print_r($entities);

$error = $dataService->getLastError();
echo "<pre>";
print_r($error);exit;
if ($error) {
    echo "The Status code is: " . $error->getHttpStatusCode() . "\n";
    echo "The Helper message is: " . $error->getOAuthHelperError() . "\n";
    echo "The Response message is: " . $error->getResponseBody() . "\n";
    exit();
}
// Echo some formatted output
var_dump($entities);

/*
Example output:

Customer[0] GivenName: Jimco LLC	(Created at 2013-06-29T22:06:45-07:00)
Customer[1] GivenName: ACME Corp	(Created at 2013-06-29T22:10:18-07:00)
Customer[2] GivenName: Smithco Inc.	(Created at 2013-06-29T22:11:57-07:00)
Customer[3] GivenName: Special Inc.	(Created at 2013-06-29T22:13:34-07:00)
*/
