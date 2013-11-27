/**
 * ICallout.as
 *
 * Project: CLX.Satellite Core
 * Date: Feb 12, 2013
 * 
 * @package		ch.crealogix.satellite.app.view.elements.interfaces
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		Daniel Tiefenauer (daniel.tiefenauer[at]crealogix.com)
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.list.callout.interfaces
{
	public interface ICallout{
		function get message():String;
		function set message(value:String):void;
	}
}