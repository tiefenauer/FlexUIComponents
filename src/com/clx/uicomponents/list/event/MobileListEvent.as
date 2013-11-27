/**
 * ShowCalloutEvent.as
 *
 * Project: CLX.Satellite
 * Date: Feb 15, 2013
 * 
 * @package		ch.clx.satellite.core.app.view.component.list
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		Daniel Tiefenauer (daniel.tiefenauer[at]crealogix.com)
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.list.event
{
	import flash.events.Event;
	
	/**
	 * Event to show a callout. The event holds the title and message for the callout to be shown 
	 * @author Daniel Tiefenauer (daniel.tiefenauer[at]crealogix.com)
	 */
	public class MobileListEvent extends Event
	{
		public static const NAME:String = 'MobileIconItemRendererEvent';
		
		//-------------------------------------
		// Event Names
		//-------------------------------------
		public static const ICON_CLICKED:String = NAME + "iconClicked";
		public static const LABEL_CLICKED:String = NAME + "labelClicked";
		public static const MESSAGE_CLICKED:String = NAME + "messageClicked";
		public static const DECORATOR_CLICKED:String = NAME + "decoratorClicked";

		//-------------------------------------
		// Private/Protected variables
		//-------------------------------------
		public var data:Object;
		
		/**
		 * Constructor 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function MobileListEvent(type:String, data:Object=null, bubbles:Boolean=true, cancelable:Boolean=true){
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		override public function clone():Event{
			return new MobileListEvent(type, data, bubbles, cancelable);
		}
		
		
	}
}