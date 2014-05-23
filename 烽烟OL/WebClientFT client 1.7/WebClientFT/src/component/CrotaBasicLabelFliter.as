package component
{
	/**
	 * Label
	 * @author Yaolx
	 * 
	 */
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import spark.components.Label;
	import spark.filters.DropShadowFilter;
	import spark.filters.GlowFilter;

	public class CrotaBasicLabelFliter extends Label
	{
		public function CrotaBasicLabelFliter()
		{
			super();
//			setStyle("color", 0xff0000);
			this.buttonMode = true;
			this.mouseChildren = false;
			this.useHandCursor = true;
			this.setStyle("color",0xffffff);
			this.setStyle("fontSize",12);
			this.addEventListener(MouseEvent.MOUSE_OVER,onChangeFliter);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onChangeFliter);	
			this.addEventListener(MouseEvent.MOUSE_UP,onChangeCommon);
			this.addEventListener(MouseEvent.MOUSE_OUT,onChangeCommon);
		}
		private function onChangeFliter(evt:MouseEvent):void{
			this.setStyle("color",0xcfa972);
//			var growFilte:GlowFilter = new GlowFilter(0xcfa972,1,1,1,4,1);
//			var arr:Array = new Array();
//			arr.push(growFilte);
//			this.filters = arr;
		}
		private function onChangeCommon(evt:MouseEvent):void{
			this.setStyle("color",0xffffff);
//			this.filters = [];
		}
	}
}