<?php
/**
 * Smarty plugin
 * 
 * @package Smarty
 * @subpackage PluginsModifier
 */

/**
 * Smarty capitalize modifier plugin
 * 
 * Type:     modifier<br>
 * Name:     capitalize<br>
 * Purpose:  capitalize words in the string
 *
 * {@internal {$string|capitalize:true:true} is the fastest option for MBString enabled systems }}
 *
 * @param string  $string    string to capitalize
 * @param boolean $uc_digits also capitalize "x123" to "X123"
 * @param boolean $lc_rest   capitalize first letters, lowercase all following letters "aAa" to "Aaa"
 * @return string capitalized string
 * @author Monte Ohrt <monte at ohrt dot com> 
 * @author Rodney Rehm
 */
function smarty_modifier_time_format($seconds)
{
    if($seconds){
		$minutes = $seconds % 3600;
		$hours = ($seconds - $minutes) / 3600;
		$seconds = $minutes % 60;
		$minutes = ($minutes - $seconds) / 60;
	} 

	/*
	if($hours==0 && $minutes == 0){
		$time = sprintf('%02d:%02d:%02d', $hours, $minutes, $seconds);
	} else {
		$time = sprintf('%02d:%02d', $hours, $minutes);
	}
	*/
	$time = sprintf('%02d:%02d:%02d', $hours, $minutes, $seconds);
	return $time;
} 

?>