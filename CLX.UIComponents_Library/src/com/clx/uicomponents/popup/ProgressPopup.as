/**
 * ProgressPopup.as
 *
 * Project: clx-satellite
 * Date: Oct 30, 2013
 * 
 * @package		com.clx.satellite.core.app.view.component.popup
 * @copyright	Copyright (c) 2013 Crealogix E-Business AG
 * @link		http://www.crealogix.com
 * @author		dtie
 * @version		1.0.0
 *
 */

package com.clx.uicomponents.popup
{
	import com.clx.uicomponents.skins.DefaultProgressPopupSkin;
	
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.ProgressBar;
	import spark.core.IDisplayText;
	
	/**
	 * Popup to display a progress 
	 * @author dtie
	 * 
	 */
	public class ProgressPopup extends SimplePopup implements ISimplePopup
	{
		// Skin parts
		[SkinPart(required="true")] public var progressBar:ProgressBar;
		[SkinPart(required="true")] public var cancelButton:Button;
		[SkinPart(required="false")] public var currentProgressLabel:IDisplayText;
		[SkinPart(required="false")] public var totalProgressLabel:IDisplayText;
		
		// constants
		public static const CANCEL:String = 'cancel';
		
		// public vars
		[Bindable] public var cancelButtonLabel:String = 'Cancel';
		
		[Bindable] protected var _currentProgressLabel:String;
		[Bindable] protected var _totalProgressLabel:String;
		
		/**
		 * Constructor 
		 * @param title
		 * @param message
		 */
		public function ProgressPopup(title:String=null, message:String=null){
			super(title, message);
			setStyle('skinClass', DefaultProgressPopupSkin);
		}
		
		override protected function onCreationComplete(event:FlexEvent):void{
			super.onCreationComplete(event);
			if (currentProgressLabel)
				currentProgressLabel.text = _currentProgressLabel;
			if (totalProgressLabel)
				totalProgressLabel.text = _totalProgressLabel;
		}
		
		override protected function createChildren():void{
			super.createChildren();
			title = _title;
			message = _message;
			progressBar.currentProgress = 0;
			progressBar.totalProgress = 100;
			cancelButton.addEventListener(MouseEvent.CLICK, onCancelButtonClick);
		}
		
		//--------------------------------
		// Event handlers
		//--------------------------------
		protected function onCancelButtonClick(event:MouseEvent):void{
			close(true, CANCEL);
		}

		//--------------------------------
		// Getter/Setter
		//--------------------------------
		[Bindable]
		public function get currentProgress():String{
			return _currentProgressLabel;
		}
		public function set currentProgress(value:String):void{
			_currentProgressLabel = value;
			if (currentProgressLabel)
				currentProgressLabel.text = _currentProgressLabel;
		}
		[Bindable]
		public function get totalProgress():String{
			return _totalProgressLabel;
		}
		public function set totalProgress(value:String):void{
			_totalProgressLabel = value;
			if (totalProgressLabel)
				totalProgressLabel.text = _totalProgressLabel;
		}
			
	}
}


