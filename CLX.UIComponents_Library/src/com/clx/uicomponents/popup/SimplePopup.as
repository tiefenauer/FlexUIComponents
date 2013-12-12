/**
 * SimplePopup.as
 *
 * Project: CLX.UIComponents
 * Date: Dec 4, 2013
 * 
 * @package		com.clx.uicomponents.popup
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		dtie
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.popup
{
	import flash.system.System;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Application;
	import spark.components.SkinnablePopUpContainer;
	import spark.core.IDisplayText;
	
	/**
	 * Basisklasse für Popups mit titel und message 
	 * @author dtie
	 * 
	 */
	public class SimplePopup extends SkinnablePopUpContainer implements ISimplePopup
	{
		[SkinPart] public var titleDisplay:IDisplayText;
		[SkinPart] public var messageDisplay:IDisplayText;

		[Bindable] protected var _title:String;
		[Bindable] protected var _message:String;
		
		public function SimplePopup(title:String=null, message:String=null):void{
			_title = title;
			_message = message;
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		protected function onCreationComplete(event:FlexEvent):void{
			if (titleDisplay)
				titleDisplay.text = _title;
			if (messageDisplay)
				messageDisplay.text = _message;
		}
		
		/**
		 * Show & Center Popup 
		 */
		public function show():void{
			try{
				var parent:Application = FlexGlobals.topLevelApplication as Application;
				if (parent.className != 'FlexUnitApplication'){
					super.open(parent, true);
					width = FlexGlobals.topLevelApplication.width * 0.8;
					PopUpManager.centerPopUp(this);
					PopUpManager.bringToFront(this);	
				}
			}
			catch(error:Error){
				// we are probably in FlexUnitApplication
			}
		}
		
		//--------------------------------
		// Getter/Setter
		//--------------------------------
		[Bindable]
		public function get title():String{
			return _title;
		}
		public function set title(value:String):void{
			_title = value;
			if (titleDisplay)
				titleDisplay.text = _title;
		}
		[Bindable]
		public function get message():String{
			return _message;
		}
		public function set message(value:String):void{
			_message = value;
			if (messageDisplay)
				messageDisplay.text = _message;
		}
	}
}