/**
 * IMobileItemRenderer.as
 *
 * Project: CLX.Satellite Core
 * Date: Feb 14, 2013
 * 
 * @package		ch.crealogix.satellite.app.view.elements.interfaces
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		Daniel Tiefenauer (daniel.tiefenauer[at]crealogix.com)
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.list.interfaces
{
	

	/**
	 * Interface for all custom mobile item renderers 
	 * @author dtie
	 */
	public interface IMobileItemRenderer
	{
		function get labelText():String;
		function get messageText():String;
		//function get preventSelection():Boolean;
	}
}