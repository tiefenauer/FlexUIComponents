/**
 * IPullDownToRefreshGroup.as
 *
 * Project: CLX.UIComponents
 * Date: Dec 6, 2013
 * 
 * @package		com.clx.uicomponents.list.interfaces
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		dtie
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.list.interfaces
{
	[Bindable]
	public interface IPullDownToRefreshGroup 
	{
		function set ready(value:Boolean):void;
		function get ready():Boolean;
		
		function get height():Number;
		function set height(value:Number):void;
		
		function get minHeight():Number;
		function set minHeight(value:Number):void;

		function set refreshing(value:Boolean):void;
		
		function set labelText(value:String):void;
	}
}