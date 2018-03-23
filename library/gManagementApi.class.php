<?php
/**
 * gManagementApi - Google Analytics Management PHP Interface
 *
 * https://code.google.com/p/google-analytics-management-api-for-php/
 *
 * @copyright Seer Interactive 2010 http://www.seerinteractive.com
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @author Chris Le <chrisl@seerinteractive.com>
 * @version 1.0
 *
 * @example
 * require('gapi.class.php');
 * require('gManagementApi.class.php');
 *
 * define('GA_EMAIL', 'myUsername');
 * define('GA_PASSWORD', 'mySecretPassword');
 *
 * $ga = new gManagementApi(GA_EMAIL, GA_PASSWORD);
 *
 * // Get all the accounts
 * $ga->requestAccountFeed();
 *
 * // Get all web properties for all your accounts
 * $ga->requestAccountFeed('~all');
 *
 * // Get all web properties for specfically UA-12345-2
 * $ga->requestAccountFeed('12345');
 *
 * // To get all the profiles you have access to for web property under account 12345
 * $ga->requestAccountFeed('12345', '~all');
 *
 * // To get the profiles for a specific web property UA-12345-2 under account 12345
 * $ga->requestAccountFeed('12345', 'UA-12345-2');
 *
 * // To get all the goals for profile 6789 for web property UA-12345-2 under acount 12345
 * $ga->requestAccountFeed('12345', 'UA-12345-2', '~all');
 *
 * // To get everything and the kitchen sink
 * $ga->requestAccountFeed('~all', '~all', '~all');
 *
 * // To get all advanced segments
 * $ga->requestAdvancedSegmentFeed();
 *
 */

class gManagementApi extends gapi {

	const GOOGLE_MANAGEMENT_URL =
		'https://www.google.com/analytics/feeds/datasources/ga/accounts';
	const GOOGLE_ADV_SEGMENT_URL =
		'https://www.google.com/analytics/feeds/datasources/ga/segments';
	private $auth_token = null;

	public function __construct($email, $password, $token=null) {
    	if($token !== null) {
      		$this->auth_token = $token;
    	} else {
    		$this->authenticateUser($email,$password);
      		$this->auth_token = $this->getAuthToken();
     	}
    }

	/**
	 * Requests an account, web property, profile, or goal feed from Google
	 * Management API.
	 *
	 * To get all of the account IDs, leave all parameters blank.  If you want
	 * the web properties of a particular Analytics account, only specify the
	 * accountID.  If you want all the profiles in a web property, specify
	 * the account ID, and web property.
	 *
	 * @param string $accountId Optional: Analytics account ID.  Use '~all' for everything.
	 * @param string $webPropertyId Optional: Web property ID
	 * @param string $profileId Optional: Profile ID
	 */
    public function requestAccountFeed($accountId = null, $webPropertyId = null,
		$profileId = null) {

		// Create our URL
		$uri = gManagementApi::GOOGLE_MANAGEMENT_URL;
		if($accountId) $uri .= '/' . $accountId . '/webproperties';
		if($webPropertyId) $uri .= '/' . $webPropertyId . '/profiles';
		if($profileId) $uri .= '/'. $profileId . '/goals';

		$response = $this->httpRequest($uri, null, null, $this->generateAuthHeader());
		if (substr($response['code'], 0, 1) == '2') {
			return $this->accountObjectMapper ($response['body']);
		} else {
			throw new Exception('GAPI: Failed to request account data. '.
				'Error: "' . strip_tags($response['body']) . '"');
		}
	}

    /**
     * Requests advanced segment info from the management API
     */
	public function requestAdvancedSegmentFeed() {
		$uri = gManagementApi::GOOGLE_ADV_SEGMENT_URL;
		$response = $this->httpRequest($uri, null, null, $this->generateAuthHeader());
		if (substr($response['code'], 0, 1) == '2') {
			return $this->accountObjectMapper ($response['body']);
		} else {
			throw new Exception('GAPI: Failed to request account data. '.
				'Error: "' . strip_tags($response['body']) . '"');
		}
	}

}