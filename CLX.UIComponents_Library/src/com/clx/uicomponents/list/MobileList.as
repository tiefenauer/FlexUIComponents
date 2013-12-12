/**
 * MobileList.as
 *
 * Project: CLX.Satellite.RL
 * Date: Jul 1, 2013
 * 
 * @package		com.clx.satellite.core.app.view.component
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		dtie
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.list
{
	
	import com.clx.uicomponents.list.callout.MobileListCallout;
	import com.clx.uicomponents.list.event.MobileListCalloutEvent;
	import com.clx.uicomponents.list.interfaces.IPullDownToRefreshGroup;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.core.mx_internal;
	import mx.effects.Move;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	import spark.events.PopUpEvent;
	
	use namespace mx_internal;
	
	[Event(name="iconClicked", type="flash.events.Event")]
	[Event(name="decoratorClicked", type="flash.events.Event")]
	[Event(name="labelClicked", type="flash.events.Event")]
	[Event(name="messageClicked", type="flash.events.Event")]
	[Event(name="readyToRefreshStart", type="flash.events.Event")]
	[Event(name="readyToRefreshStop", type="flash.events.Event")]
	[Event(name="refreshing", type="flash.events.Event")]
	
	/**
	 * Enhanced list for use in mobile apps. Features a callout that can be opened for each list item
	 * http://flexponential.com/2009/12/20/disable-selection-on-some-items-in-a-spark-list/ 
	 */
	public class MobileList extends List
	{
		public static const NAME:String = 'MobileList';
		//-------------------------------------
		// Event Names
		//-------------------------------------
		public static const ICON_CLICKED:String = "iconClicked";
		public static const LABEL_CLICKED:String = "labelClicked";
		public static const MESSAGE_CLICKED:String = "messageClicked";
		public static const DECORATOR_CLICKED:String = "decoratorClicked";
		public static const READY_TO_REFRESH_START:String = "readyToRefreshStart";
		public static const READY_TO_REFRESH_STOP:String = "readyToRefreshStop";
		public static const REFRESHING:String = "refreshing";

		//------------------------------------
		// Private/Protected variables
		//------------------------------------
		protected var _preventSelection:Boolean;
		protected var _callout:MobileListCallout;
		protected var _preventCalloutOpening:Boolean = false;
		protected var _readyToRefresh:Boolean = false;
		protected var _refreshing:Boolean = false;
		protected var _pullDownToRefreshGroup:IPullDownToRefreshGroup;
		
		/**
		 * Constructor 
		 */
		public function MobileList(){
			addEventListener(IndexChangeEvent.CHANGE, onChange);
			addEventListener(IndexChangeEvent.CHANGING, onChanging);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		override protected function createChildren():void{
			super.createChildren();
			addEventListener(MobileListCalloutEvent.SHOW_CALLOUT, openCallout);
/*			addEventListener(ICON_CLICKED, onIconClicked);
			addEventListener(DECORATOR_CLICKED, onDecoratorClicked);	*/		
			scroller.viewport.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, refreshCalloutProperties);
			dataGroup.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onDataGroupPropertyChange);
		}
		
		override public function setSelectedIndex(value:int, dispatchChangeEvent:Boolean=false, changeCaret:Boolean=true):void{
			if (value == selectedIndex)
				return;
			
			if (value >= 0 && value < dataProvider.length){
				var renderer:MobileIconItemRenderer = dataGroup.getElementAt(value) as MobileIconItemRenderer;
				if (renderer.selectionEnabled != false){
					
					if (dispatchChangeEvent)
						dispatchChangeAfterSelection = dispatchChangeEvent;
					
					_proposedSelectedIndex = value;
					invalidateProperties();
				}
			} else {
				if (dispatchChangeEvent)
					dispatchChangeAfterSelection = dispatchChangeEvent;
				
				_proposedSelectedIndex = value;
				invalidateProperties();
			}
		}
		
		override mx_internal function setSelectedIndices(value:Vector.<int>, dispatchChangeEvent:Boolean=false, changeCaret:Boolean=true):void
		{
			var newValue:Vector.<int> = new Vector.<int>;
			// take out indices that are on items that have selectionEnabled=false
			
			for(var i:int = 0; i < value.length; i++)
			{
				
				var item:* = dataProvider.getItemAt(value[i]);
				
				if (item.selectionEnabled == false)
				{
					continue;
				}
				
				newValue.push(value[i]);
			}
			
			super.setSelectedIndices(newValue, dispatchChangeEvent);
		}
		
		
		//------------------------------------
		// Event handlers
		//------------------------------------
		protected function onChanging(event:IndexChangeEvent):void{
			var source:* = dataGroup.getElementAt(selectedIndex);
			if (source is MobileIconItemRenderer){
				var renderer:MobileIconItemRenderer = MobileIconItemRenderer(source);
				//_preventSelection = source.iconClicked || source.decoratorClicked;
				
				if (renderer.STATE == MobileIconItemRenderer.OVERLAY_ACTIVE){
					_preventSelection = true;
				}
				if (renderer.iconClickable && renderer.iconClicked){
					renderer.iconClicked = false;
					_preventSelection = true;
					dispatchEvent(new Event(ICON_CLICKED));
				}
				if (renderer.decoratorClickable && renderer.decoratorClicked){
					renderer.decoratorClicked = false;
					_preventSelection = true;
					dispatchEvent(new Event(DECORATOR_CLICKED));
				}
			}
		}
		
		/**
		 * Selection change handler: Prevent selection if callout is open
		 */
		protected function onChange(event:IndexChangeEvent):void{
			if (_preventSelection || _callout && _callout.isOpen){
				_preventSelection = false;
				event.stopImmediatePropagation();
				callLater(function():void { selectedIndex = -1;}, null);
			}
		}
		/*
		private function onIconClicked(event:Event):void{
			_preventSelection = true;
			dispatchEvent(new MobileListEvent(MobileListEvent.ICON_CLICKED, selectedItem));
		}
		private function onDecoratorClicked(event:Event):void{
			_preventSelection = true;
			dispatchEvent(new MobileListEvent(MobileListEvent.DECORATOR_CLICKED, selectedItem));
		}
		*/
		
		/**
		 * Zeige "Pull down to refresh" 
		 * @param event
		 */
		protected function onDataGroupPropertyChange(event:PropertyChangeEvent):void{
			if (!_refreshing && _pullDownToRefreshGroup && event.source == event.target && event.property == "verticalScrollPosition"){
				var vScroll:Number = dataGroup.verticalScrollPosition;
				_pullDownToRefreshGroup.height = vScroll* -1;
				if(vScroll < _pullDownToRefreshGroup.minHeight * -1){
					dispatchEvent(new Event(READY_TO_REFRESH_START));
					readyToRefresh = true;
				}
				else if(!_refreshing){
					_readyToRefresh = false;
					dispatchEvent(new Event(READY_TO_REFRESH_STOP));
				}
			}
		}
		
		protected function onMouseUp(event:MouseEvent):void{
			if (_readyToRefresh){
				refreshing = true;
				dispatchEvent(new Event(REFRESHING));
			}
			else{
				refreshing = false;
			}
		}
		
		//------------------------------------
		// Private functions
		//------------------------------------
		private function openCallout(event:MobileListCalloutEvent):void{
			if (!_preventCalloutOpening){
				closeCallout();
				_callout = new MobileListCallout();
				_callout.title = event.calloutTitle;
				_callout.message = event.calloutMessage;
				
				_callout.maxWidth = this.width - 15;
				_callout.minWidth = this.width - 15;
				_callout.invalidateProperties();
				_callout.id = 'MobileListCallout';
				_callout.verticalPosition = 'after';
				
				_callout.addEventListener(PopUpEvent.OPEN, onCalloutOpen);
				_callout.addEventListener(PopUpEvent.CLOSE, onCalloutClose);
				_callout.open(event.target as DisplayObjectContainer);				
			}
			
		}
		
		/**
		 * Refresh callout properties such as position (e.g. if user tap&holds list item, callout opens and scrolls list, callout needs
		 * to scroll with item) 
		 * @param event
		 * 
		 */
		private function refreshCalloutProperties(event:Event):void {
			_preventCalloutOpening = true;
			if (_callout && _callout.isOpen){
				_callout.y = _callout.owner.getBounds(this).bottom + getBounds(FlexGlobals.topLevelApplication as DisplayObject).y;
				if (_callout.y  > getBounds(FlexGlobals.topLevelApplication as DisplayObject).bottom ||
					_callout.y  < getBounds(FlexGlobals.topLevelApplication as DisplayObject).top)
					closeCallout();
			}
			callLater(function():void {
				_preventCalloutOpening = false;
			});
		}
		
		/**
		 * Callout has opened
		 * @param event
		 */
		private function onCalloutOpen(event:PopUpEvent):void{
			preventSelection = true;
		}
		
		/**
		 * Callout has closed
		 * @param event
		 */
		private function onCalloutClose(event:PopUpEvent):void{
			preventSelection = false;
		}
		
		//--------------------------------
		// Private/Protected methods
		//--------------------------------
		private function closeCallout():void{
			if (_callout && _callout.isOpen){
				_callout.close();
				preventSelection = false;
			}
		}
		
		//--------------------------------
		// Getter/Setter
		//--------------------------------
		override public function set enabled(value:Boolean):void{
			this.alpha = (value)?1:0.5;
			if (dataProvider){
				ArrayCollection(dataProvider).refresh();
			}
			super.enabled = value;
		}
		public function get refreshing():Boolean{
			return _refreshing;
		}
		public function set refreshing(value:Boolean):void{
			if (value == _refreshing)
				return;

			_refreshing = value;
			_pullDownToRefreshGroup.refreshing = value;
			if (_refreshing && _pullDownToRefreshGroup){
				_pullDownToRefreshGroup.refreshing = true;
				this.y += _pullDownToRefreshGroup.height;
			}
			else if (!_refreshing && _pullDownToRefreshGroup){
				var move:Move = new Move(this);
				move.yFrom = this.y;
				move.yTo = this.y -= _pullDownToRefreshGroup.height;
				move.duration = 200;
				move.play();
				_readyToRefresh = false;
			}
		}
		public function set readyToRefresh(value:Boolean):void{
			_readyToRefresh = value;
			if (_pullDownToRefreshGroup){
				if (value) 
					_pullDownToRefreshGroup.ready = true;
				else 
					_pullDownToRefreshGroup.ready = false;
			}
		}
		public function set pullDownToRefreshGroup(value:IPullDownToRefreshGroup):void{
			_pullDownToRefreshGroup = value;
		}
		
	}
}