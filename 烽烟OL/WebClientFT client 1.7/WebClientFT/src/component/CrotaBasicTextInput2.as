package component
{
	import flash.events.FocusEvent;
	
	import spark.components.TextInput;
	
	
	import style.Skin_CrotaBasicTextInput;
	
	/**
	 * 文本输入框
	 * @author Yaolx
	 * 
	 */
	
	public class CrotaBasicTextInput2 extends TextInput
	{
		public function CrotaBasicTextInput2()
		{
			super();
			initStyle();
			focusCancel();
		}
		private function initStyle():void{
			//		    setStyle("contentBackgroundAlpha", 0.0);
			//			setStyle("borderAlpha",0.0);
			this.setStyle("color",0xdfebff);
			this.setStyle("fontFamily","幼圆");
			this.setStyle("fontSize",14);
			
			setStyle("skinClass",Skin_CrotaBasicTextInput);
		}
		//		public function get textHeight():Number{
		//		
		//		}
		
		//添加选中事件监听，取消鼠标选中状态
		private function focusCancel():void{
			this.addEventListener(FocusEvent.FOCUS_IN,onFocusIn);
		}
		
		//取消鼠标选中状态
		private function onFocusIn(evt:FocusEvent):void{
			this.focusManager.hideFocus();
		}
	}
}