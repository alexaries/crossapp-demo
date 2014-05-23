package component
{
	import flash.events.FocusEvent;
	
	import spark.components.TextInput;
	
	import style.Skin_CrotaChatTextLoginbar;
	
	/**
	 * 聊天文本输入框
	 * @author Yaolx
	 * 
	 */
	
	public class CrotaChatTextInputLoginbar extends TextInput
	{
		public function CrotaChatTextInputLoginbar()
		{
			super();
			initStyle();
			focusCancel();
		}
		private function initStyle():void{
			
			this.setStyle("color",0xffffff);
			this.setStyle("fontSize",14);
			setStyle("skinClass",Skin_CrotaChatTextLoginbar);
		}
		//添加选中事件监听，取消鼠标选中状态
		private function focusCancel():void{
			this.addEventListener(FocusEvent.FOCUS_IN,onFocusIn);
		}
		
		//取消鼠标选中状态
		private function onFocusIn(evt:FocusEvent):void{
//			this.focusManager.hideFocus();
			this.setStyle("color",0x556B2F);
		}
	}
}