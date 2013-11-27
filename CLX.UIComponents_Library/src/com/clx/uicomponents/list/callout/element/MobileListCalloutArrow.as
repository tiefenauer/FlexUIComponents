/**
 * MobileListCalloutArrow.as
 *
 * Project: CLX.Satellite Core
 * Date: Feb 14, 2013
 * 
 * @package		ch.crealogix.satellite.app.view.elements
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		Daniel Tiefenauer (daniel.tiefenauer[at]crealogix.com)
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.list.callout.element
{
	import spark.skins.mobile.supportClasses.CalloutArrow;
	
	/**
	 * Default skin for Mobile List Callouts 
	 * @author Daniel Tiefenauer (daniel.tiefenauer[at]crealogix.com)
	 * 
	 */
	public class MobileListCalloutArrow extends CalloutArrow
	{
		/**
		 * Constructor 
		 */
		public function MobileListCalloutArrow() {
			super();
		}
		
		public function get arrowBorderColor():Number {
			return super.borderColor;
		}
		
		public function set arrowBorderColor(value:Number):void {
			super.borderColor = value;
		}
		
		public function get arrowBorderThickness():Number {
			return super.borderThickness;
		}
		
		public function set arrowBorderThickness(value:Number):void {
			super.borderThickness = value;
		}
	}
}