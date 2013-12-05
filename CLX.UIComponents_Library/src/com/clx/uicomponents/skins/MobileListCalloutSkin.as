/**
 * MobileListCalloutSkin.as
 *
 * Project: CLX.Satellite.RL
 * Date: Jul 1, 2013
 * 
 * @package		assets.skins
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		dtie
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.skins
{
	import com.clx.uicomponents.list.callout.element.MobileListCalloutArrow;
	
	import mx.core.DPIClassification;
	import mx.states.SetStyle;
	
	import spark.skins.mobile.CalloutSkin;
	
	/**
	 * Default skin for Mobile List Callouts 
	 * @author Daniel Tiefenauer (daniel.tiefenauer[at]crealogix.com)
	 */
	public class MobileListCalloutSkin extends CalloutSkin
	{
		/**
		 * Constructor 
		 */
		public function MobileListCalloutSkin(){
			super();
			initSkin();
		}
		
		protected function initSkin():void {
			//contentBackgroundInsetClass = null;
			//frameThickness = 0;
			//useBackgroundGradient = false;
			switch (applicationDPI) {
				case DPIClassification.DPI_320:  {
					arrowWidth = 60;
					arrowHeight = 30;
					break;
				}
				case DPIClassification.DPI_240:  {
					arrowWidth = 30;
					arrowHeight = 15;
					break;
				}
				default:  {
					arrowWidth = 18;
					arrowHeight = 9;
					break;
				}
			}
			setStyle('color', 0xFFFFFF);
		}
		
		override protected function createChildren():void {
			
			// create arrow first, super will skip default arrow creation 
			arrow = new MobileListCalloutArrow();
			arrow.id = "arrow";
			arrow.styleName = this;
			
			// call super
			super.createChildren();
			
			// add arrow above all other children
			addChild(arrow);
			
			// bring contentGroup to front
			swapChildren(arrow, contentGroup);
		}
		
		protected function get calloutArrow():MobileListCalloutArrow {
			return arrow as MobileListCalloutArrow;
		}
		
		public function get calloutBorderColor():Number {
			return super.borderColor;
		}
		
		public function set calloutBorderColor(value:Number):void {
			if (calloutArrow) {
				calloutArrow.arrowBorderColor = value;
			}
			super.borderColor = value;
		}
		
		public function get calloutBorderThickness():Number {
			return super.borderThickness;
		}
		
		public function set calloutBorderThickness(value:Number):void {
			if (calloutArrow) {
				calloutArrow.arrowBorderThickness = value;
			}
			super.borderThickness = value;
		}	
	}
}