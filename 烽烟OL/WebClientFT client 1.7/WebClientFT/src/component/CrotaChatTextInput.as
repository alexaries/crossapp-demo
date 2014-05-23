package component
{
	import flash.events.FocusEvent;
	
	import spark.components.TextInput;
	
	import style.Skin_CrotaChatTextInput;

	/**
	 * 聊天文本输入框
	 * @author Yaolx
	 * 
	 */

	public class CrotaChatTextInput extends TextInput
	{
		public function CrotaChatTextInput()
		{
			super();
			initStyle();
			focusCancel();
			this.restrict = "^[] ";
		}
		private function initStyle():void{

//			this.setStyle("color",0xffffff);
//			this.setStyle("fontSize",12);
			setStyle("focusedTextSelectionColor", 0x000000);
			setStyle("skinClass",Skin_CrotaChatTextInput);
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