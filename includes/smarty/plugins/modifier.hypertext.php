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
function smarty_modifier_hypertext($text)
{ 
    $text = trim($text);
	$text = html_entity_decode($text);
	$text = " ".$text;
	$text = preg_replace('/((f|ht){1}tps?:\/\/)[-a-zA-Z0-9@:%_\+.~#?&\/\/=]+/i',
			'<a href="$0" target=_blank>$0</a>', $text);
	$text = preg_replace('/[_\.0-9a-z-]+@([0-9a-z][0-9a-z-]+\.)+[a-z]{2,3}/i',
	'<a href="mailto:$0" target=_blank>$0</a>', $text);
	$text = preg_replace('#([[:space:]()[{}])(www.[-a-zA-Z0-9@:%_\+.~\#\?&//=]+)#i',
	'\\1<a href="http://\\2" target=_blank>\\2</a>', $text);
	return $text;
} 

?>