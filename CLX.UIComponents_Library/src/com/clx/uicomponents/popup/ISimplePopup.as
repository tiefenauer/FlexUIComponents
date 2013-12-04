/**
 * ISimplePopup.as
 *
 * Project: clx-satellite
 * Date: Nov 7, 2013
 * 
 * @package		com.clx.satellite.core.app.view.component.popup
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		dtie
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.popup
{
	public interface ISimplePopup
	{
		function get title():String;
		function set title(value:String):void;
		
		function get message():String;
		function set message(value:String):void;
		
		function show():void;
		function close(commit:Boolean=false, data:*=null):void;
	}
}