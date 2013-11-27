/**
 * ScrollingEvent.as
 *
 * Project: CLX.Satellite.RL
 * Date: Jul 1, 2013
 * 
 * @package		com.clx.uicomponents.list.event
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
	 * Scrolling Event 
	 * @author dtie
	 */
	public class ScrollingEvent extends Event
	{
		public static const SCROLLING_STARTED:String ="SCROLLING_STARTED"; 
		public static const SCROLLING_STOPPED:String ="SCROLLING_STOPPED";
		public static const TAP_ACTION:String ="TAP_ACTION";
		public static const DELETE_ACTION:String ="DELETE_ACTION";
		
		private var userObj:Object;
		private var userId:int;
		
		/**
		 * Constructor 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function ScrollingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}

	}
}