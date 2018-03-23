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
function smarty_modifier_camel_case($string)
{
    //$string = preg_replace('/(?<=\\w)(?=[A-Z])/'," $1", $string);
	$string = preg_replace('/((?:^|[A-Z])[a-z]+)/'," $1", $string);
	$string = trim($string); // See more at: http://www.tech-recipes.com/rx/5626/php-camel-case-to-spaces-or-underscore/#sthash.c8a2iXGr.dpuf
	return $string;
} 

?>