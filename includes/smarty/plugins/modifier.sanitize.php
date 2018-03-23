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
 * @link 
 * @author Monte Ohrt <monte at ohrt dot com> 
 * @param string $ 
 * @return string 
 */
function smarty_modifier_sanitize($text)
{ 
    $text = trim($text);
	$text = filter_var($text, FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_HIGH);
	$text = str_replace(array("\r\n","\r","\n"),' ', $text);
	$text = addslashes(html_entity_decode($text, ENT_QUOTES));
	return $text;
} 

?>