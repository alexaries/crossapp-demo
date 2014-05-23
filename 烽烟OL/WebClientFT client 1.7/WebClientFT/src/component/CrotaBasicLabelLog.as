package component
{import flash.text.TextFormat;
	
	import spark.components.Label;
	import spark.filters.DropShadowFilter;
	import spark.filters.GlowFilter;
	
	public class CrotaBasicLabelLog extends Label
	{
		public function CrotaBasicLabelLog()
		{
			super();
			//			setStyle("color", 0xff0000);
			/*this.setStyle("color",0xffffff);
			this.setStyle("fontFamily","幼圆");
			this.setStyle("fontSize",16);
			this.setStyle("fontWeight","bold");*/
			var newFilter:DropShadowFilter = new DropShadowFilter();
			newFilter.blurX = 2;
			newFilter.blurY = 2;
			newFilter.distance = 1;
			newFilter.angle = 30;
			newFilter.alpha = 2;
			newFilter.color = 0x000000;
			newFilter.strength=1;
			//			this.filters = [ newFilter ];
			
			//			
			var growFilte:GlowFilter = new GlowFilter(0x99CC00,1,1,1,1);
			var arr:Array = new Array();
			arr.push(growFilte);
			this.filters = arr;
		}
	}
}