/**
 * IconPopup.as
 *
 * Project: clx-satellite
 * Date: Oct 31, 2013
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
	import com.clx.uicomponents.skins.DefaultAlertPopupSkin;
	
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import spark.components.Button;

	/**
	 * Basic alert with title, message, OK- and Cancel-Button 
	 * @author dtie
	 * 
	 */
	public class AlertPopup extends SimplePopup implements ISimplePopup
	{
		[SkinPart(required="true")] public var okButton:Button;
		[SkinPart(required="false")] public var cancelButton:Button;
		
		// PopupTypes
		public static const DEFAULT:String = 'default';
		public static const INFO:String = 'info';
		public static const WARNING:String = 'warning';
		public static const ERROR:String = 'error';
		
		// constants
		public static const OK:String = 'ok';
		public static const CANCEL:String = 'cancel';
		
		public var type:String;
		[Bindable] public var isCancelable:Boolean = true;
		[Bindable] public var okButtonLabel:String = 'OK';
		[Bindable] public var cancelButtonLabel:String = 'Cancel';
		
		/**
		 * Constructor 
		 * @param type
		 * @param title
		 * @param message
		 * 
		 */
		public function AlertPopup(type:String=DEFAULT, title:String=null, message:String=null){
			super(title, message)
			this.type = type;
			setStyle('skinClass', DefaultAlertPopupSkin);
		}
		
		//--------------------------------
		// Private/Protected functions
		//--------------------------------
		override protected function createChildren():void{
			super.createChildren();
			
			okButton.addEventListener(MouseEvent.CLICK, onOkButtonClick);
			okButton.label = okButtonLabel;
			
			if (cancelButton){
				cancelButton.label = cancelButtonLabel;
				cancelButton.addEventListener(MouseEvent.CLICK, onCancelButtonClick);
			}
		}
		
		//--------------------------------
		// Event handlers
		//--------------------------------
		private function onOkButtonClick(event:MouseEvent):void{
			close(true, OK);
		}
		private function onCancelButtonClick(event:MouseEvent):void{
			close(true, CANCEL);
		}
		
	}
}