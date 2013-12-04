/**
 * IndefiniteProgressPopup.as
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
	import com.clx.uicomponents.skins.DefaultIndefiniteProgressPopupSkin;
	
	import flash.events.MouseEvent;
	
	import spark.components.Button;
	
	/**
	 * Indefinite Progress Popup with spinner 
	 * @author dtie
	 */
	public class IndefiniteProgressPopup extends SimplePopup implements ISimplePopup
	{
		[SkinPart(required="true")] public var cancelButton:Button; 
		
		[Bindable] public var cancelButtonLabel:String = 'Cancel';
		
		/**
		 * Constructor 
		 * @param title
		 * @param message
		 */
		public function IndefiniteProgressPopup(title:String=null, message:String=null){
			super(title, message);
			setStyle('skinClass', DefaultIndefiniteProgressPopupSkin);
		}
		
		override protected function createChildren():void{
			super.createChildren();
			cancelButton.addEventListener(MouseEvent.CLICK, onCancelButtonClick)
		}
		
		//--------------------------------
		// Event handlers
		//--------------------------------
		protected function onCancelButtonClick(event:MouseEvent):void{
			close();
		}

	}
}