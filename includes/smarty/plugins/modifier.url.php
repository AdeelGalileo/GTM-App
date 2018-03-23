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
function smarty_modifier_url($text, $uc_digits = false)
{ 
     if(trim($text) == '') return;
	 if(!stristr( $text, 'https://') && !stristr( $text, 'http://')){
	  $text = 'http://'.$text;
	 }
	 return $text;
} 

?>