package com.clx.uicomponents.list
{
	
	import com.clx.uicomponents.list.event.MobileListCalloutEvent;
	import com.clx.uicomponents.list.interfaces.IMobileItemRenderer;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.events.FlexEvent;
	
	import spark.components.IconItemRenderer;
	
	//*********************************************************************
	// Styles
	//*********************************************************************
	/**
	 * Style for title in callout 
	 */
	[Style(name="calloutTitleStyleName", type="String", inherit="no")]
	/**
	 *Style for message in callout 
	 */
	[Style(name="calloutMessageStyleName", type="String", inherit="no")]
	
	//*********************************************************************
	// Events
	//*********************************************************************
	[Event(name="iconClicked", type="flash.events.Event")]
	[Event(name="decoratorClicked", type="flash.events.Event")]
	/*
	[Event(name="labelClicked", type="ch.igh.dataselect.mobile.core.view.component.list.event.MobileIconItemRendererEvent")]
	[Event(name="messageClicked", type="ch.igh.dataselect.mobile.core.view.component.list.event.MobileIconItemRendererEvent")]
	[Event(name="longTap", type="ch.igh.dataselect.mobile.core.view.component.list.event.MobileIconItemRendererEvent")]	
	*/
	
	/**
	 * IconItemRenderer for MobileList 
	 * @author dtie
	 */
	public class MobileIconItemRenderer extends IconItemRenderer implements IMobileItemRenderer
	{
		public static const NAME:String = 'MobileIconItemRenderer';
		
		// event types
		public static const ICON_CLICKED:String = 'iconClicked';
		public static const DECORATOR_CLICKED:String = 'decoratorClicked';
		
		//------------------------------------
		// Private/Protected variables
		//------------------------------------
		protected var _showCallout:Boolean;
		protected var _calloutTitleFunction:Function = null;
		protected var _calloutTitleField:String = null;
		protected var _calloutMessageFunction:Function = null;
		protected var _calloutMessageField:String = null;

		/* Wird nicht benötigt. Falls ein Event Listener registriert wird, wird das Icon/Decorator automatisch klickbar
		protected var _iconClickable:Boolean = false;
		protected var _decoratorClickable:Boolean = false;
		*/
		
		protected var _decoratorFunction:Function;
		private var _touchTimer:Timer = new Timer(700);
		
		public var iconClicked:Boolean = false;
		public var decoratorClicked:Boolean = false;
		public var labelClicked:Boolean = false;
		public var messageClicked:Boolean = false;
		
		/**
		 * Constructor
		 */
		public function MobileIconItemRenderer(){
			super();
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		private function onCreationComplete(event:FlexEvent):void{

/*			invalidateProperties();
			validateNow();*/
		}
		
/*		override public function set enabled(value:Boolean):void{
			if (this.owner && this.owner is MobileList){
				var ownerIsEnabled:Boolean = MobileList(this.owner).enabled;
				if (!ownerIsEnabled)
					super.enabled = false;
				else
					super.enabled = value;
			}
		}*/
		
		override public function invalidateDisplayList():void{
			super.invalidateDisplayList();
			if (this.owner && this.owner is MobileList){
				var ownerIsEnabled:Boolean = MobileList(this.owner).enabled;
				this.alpha = ownerIsEnabled?1:0.5;
			}
		}
		
		/**
		 * Helper function to determine whether which component has been clicked.
		 * This has to be done because event listeners on these components do not work because they're BitmapImages 
		 * @param event
		 */
		private function onClick(event:MouseEvent):void{
			var cp:Point = new Point( event.localX, event.localY );
			
			switch (true){
				case isLabelClicked(cp):
					labelClicked = true;
					break;
				case isMessageClicked(cp):
					messageClicked = true;
					break;
				case isIconClicked(cp):
					iconClicked = true;
					dispatchEvent(new Event(ICON_CLICKED));
					break;
				case isDecoratorClicked(cp):
					decoratorClicked = true;
					dispatchEvent(new Event(DECORATOR_CLICKED));
					break;
			} 
		}
		
		/**
		 * Helper function to check whether the icon has been clicked 
		 * @param point
		 * @return 
		 */
		private function isIconClicked( point:Point ):Boolean{
			if (!iconDisplay)
				return false;
			
			var ix:Number = iconDisplay.x;
			var iy:Number = iconDisplay.y;
			var iw:Number = iconDisplay.width;
			var ih:Number = iconDisplay.height;

			return ( point.x > ix && point.x < ix + iw && point.y > iy && point.y < iy + ih )
		}
		
		/**
		 * Helper function to check whether the decorator has been clicked 
		 * @param point
		 * @return 
		 */
		private function isDecoratorClicked( point:Point ):Boolean{
			if (!decoratorDisplay)
				return false;
			
			var ix:Number = decoratorDisplay.x;
			var iy:Number = decoratorDisplay.y;
			var iw:Number = decoratorDisplay.width;
			var ih:Number = decoratorDisplay.height;
			
			return ( point.x > ix && point.x < ix + iw && point.y > iy && point.y < iy + ih )
		}
		
		/**
		 * Helper function to check whether the label was clicked 
		 * @param point
		 * @return 
		 */
		private function isLabelClicked( point:Point ):Boolean{
			if (!labelDisplay)
				return false;
			
			var ix:Number = labelDisplay.x;
			var iy:Number = labelDisplay.y;
			var iw:Number = labelDisplay.width;
			var ih:Number = labelDisplay.height;
			
			return ( point.x > ix && point.x < ix + iw && point.y > iy && point.y < iy + ih )
		}
		
		/**
		 * Helper function to determine if message was clicked 
		 * @param point
		 * @return 
		 */
		private function isMessageClicked( point:Point ):Boolean{
			if (!messageDisplay)
				return false;
			
			var ix:Number = messageDisplay.x;
			var iy:Number = messageDisplay.y;
			var iw:Number = messageDisplay.width;
			var ih:Number = messageDisplay.height;
			
			return ( point.x > ix && point.x < ix + iw && point.y > iy && point.y < iy + ih )
		}
		
		/**
		 * Add event listeners on private components 
		 */
		override protected function createChildren():void{
			super.createChildren();
			addEventListener(MouseEvent.MOUSE_DOWN, onTouchBegin);
			addEventListener(MouseEvent.MOUSE_UP, onTouchEnd);

			_touchTimer.addEventListener(TimerEvent.TIMER, onTouchTimer);
		}
		override protected function createLabelDisplay():void{
			super.createLabelDisplay();
			if (labelDisplay){
				labelDisplay.mouseEnabled = this.mouseEnabled;
			}
		}
		override protected function createMessageDisplay():void{
			super.createMessageDisplay();
			if (messageDisplay){
				messageDisplay.mouseEnabled = this.mouseEnabled;				
			}
		}
		override protected function createIconDisplay():void{
			super.createIconDisplay();
			if (iconDisplay){
				iconDisplay.alpha = this.enabled?1:0.5;
			}
		}
		/**
		 * Add event listeners on available display components
		 */
		override protected function commitProperties():void{
			// create decorator from function
			if (_decoratorFunction != null)
				decorator = _decoratorFunction.call(this, data);
			super.commitProperties();
		}
		
		//------------------------------------
		// Event handlers
		//------------------------------------
		private function onTouchBegin(event:Event):void {
			_touchTimer.start();
		}
		private function onTouchEnd(event:Event):void {
			_touchTimer.stop();
			_touchTimer.reset();
		}
		private function onTouchTimer(event:TimerEvent):void {
			_touchTimer.stop();
			_touchTimer.reset();
			if(_showCallout){
				var calloutEvent:MobileListCalloutEvent = new MobileListCalloutEvent(MobileListCalloutEvent.SHOW_CALLOUT);
				// Callout title
				if(_calloutTitleFunction != null) {
					calloutEvent.calloutTitle = _calloutTitleFunction.call(null, data);
				}
				else if (_calloutTitleField && data.hasOwnProperty(_calloutTitleField)){
					calloutEvent.calloutTitle = data[_calloutTitleField];
				}
				
				// Callout message
				if(_calloutMessageFunction != null){
					calloutEvent.calloutMessage = _calloutMessageFunction.call(null, data);
				}
				else if (_calloutMessageField && data.hasOwnProperty(_calloutMessageField)){
					calloutEvent.calloutMessage = data[_calloutMessageField];
				}
				dispatchEvent(calloutEvent);
			}
		}
		
		//------------------------------------
		// Getter/Setter
		//------------------------------------
		public function get showCallout():Boolean{
			return _showCallout;
		}
		public function set showCallout(value:Boolean):void{
			_showCallout = value;
		}
		public function set decoratorFunction(value:Function):void{
			_decoratorFunction = value;
		}
		public function get labelText():String{
			return labelDisplay.text;
		}
		public function get messageText():String{
			return messageDisplay.text;
		}
		public function set calloutTitleField(value:String):void{
			_calloutTitleField = value;
		}
		public function set calloutTitleFunction(value:Function):void {
			_calloutTitleFunction = value;
		}
		public function set calloutMessageField(value:String):void {
			_calloutMessageField = value;
		}
		public function set calloutMessageFunction(value:Function):void {
			_calloutMessageFunction = value;
		}
		public function get iconClickable():Boolean{
			return hasEventListener(ICON_CLICKED);
			//return _iconClickable;
		}
		/* Wird nicht benötigt. Falls ein Event Listener registriert wird, wird das Icon automatisch klickbar
		public function set iconClickable(value:Boolean):void{
			//_iconClickable = value;
		}
		*/
		public function get decoratorClickable():Boolean{
			return hasEventListener(DECORATOR_CLICKED);
			//return _decoratorClickable;
		}
		/* Wird nicht benötigt. Falls ein Event Listener registriert wird, wird der decorator automatisch klickbar
		public function set decoratorClickable(value:Boolean):void{
			_decoratorClickable = value;
		}
		*/

	}
}