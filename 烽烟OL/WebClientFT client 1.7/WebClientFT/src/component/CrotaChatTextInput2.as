package component
{
	import flash.events.FocusEvent;
	
	import spark.components.TextInput;
	

	import style.Skin_CrotaTextInput1;
	
	/**
	 * 聊天文本输入框
	 * @author Yaolx
	 * 
	 */
	
	public class CrotaChatTextInput2 extends TextInput
	{
		public function CrotaChatTextInput2()
		{
			super();
			initStyle();
			focusCancel();
		}
		private function initStyle():void{
			
			//			this.setStyle("color",0xffffff);
			//			this.setStyle("fontSize",14);
			setStyle("skinClass",Skin_CrotaTextInput1);
		}
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