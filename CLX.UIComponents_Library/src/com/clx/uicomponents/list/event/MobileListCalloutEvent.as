/**
 * MobileListCalloutEvent.as
 *
 * Project: CLX.Satellite.RL
 * Date: Jul 1, 2013
 * 
 * @package		com.clx.satellite.core.app.view.component.list.event
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		dtie
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.list.event
{
	import flash.events.Event;
	
	/**
	 * Event class for MobileList Callouts 
	 * @author dtie
	 * 
	 */
	public class MobileListCalloutEvent extends Event
	{
		public static const NAME:String = 'MobileListCalloutEvent';
		// event types
		public static const SHOW_CALLOUT:String = NAME + 'ShowCallout';
		
		public var calloutTitle:String;
		public var calloutMessage:String;
		
		/**
		 * Constructor 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function MobileListCalloutEvent(type:String){
			super(type, true, false);
		}
	}
}