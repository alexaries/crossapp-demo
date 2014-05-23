package component
{
	import flash.events.FocusEvent;
	
	import flash.filters.DropShadowFilter;
	
	import spark.components.TextArea;
	
	import style.Skin_CrotaBasicTextArea;

	/**
	 * TextArea 
	 * @author Yaolx
	 * 
	 */	
	public class CrotaBasicTextArea extends TextArea
	{
		public function CrotaBasicTextArea()
		{
			super();
			this.setStyle("skinClass",Skin_CrotaBasicTextArea);
			this.addEventListener(FocusEvent.FOCUS_IN,onFocusIn);
			
			var newFilter:DropShadowFilter = new DropShadowFilter();
			newFilter.blurX = 4;
			newFilter.blurY = 4;
			newFilter.distance = 4;
			newFilter.angle = 45;
			newFilter.alpha = 1;
			newFilter.color = 0x000000;
			this.filters = [ newFilter ];
		}
		//取消鼠标选中状态
		private function onFocusIn(evt:FocusEvent):void {
			if (null != focusManager) {
				this.focusManager.hideFocus();
			}
		}
	}
}