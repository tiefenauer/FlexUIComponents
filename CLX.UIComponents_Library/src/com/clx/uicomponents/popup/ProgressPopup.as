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
	
	import spark.components.Button;
	import spark.components.ProgressBar;
	
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
		
		// constants
		public static const CANCEL:String = 'cancel';
		
		// public vars
		[Bindable] public var cancelButtonLabel:String = 'Cancel';
		
		/**
		 * Constructor 
		 * @param title
		 * @param message
		 */
		public function ProgressPopup(title:String=null, message:String=null){
			super(title, message);
			setStyle('skinClass', DefaultProgressPopupSkin);
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
		
	}
}


