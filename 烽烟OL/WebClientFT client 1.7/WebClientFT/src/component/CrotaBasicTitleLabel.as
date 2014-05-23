package component
{
	import spark.components.Label;
	import spark.filters.DropShadowFilter;

	public class CrotaBasicTitleLabel extends Label
	{
		public function CrotaBasicTitleLabel()
		{
			super();
			//			setStyle("color", 0xff0000);
			this.setStyle("color",0xffffff);
			this.setStyle("fontFamily","幼圆");
			this.setStyle("fontSize",16);
			this.setStyle("fontWeight","bold");
			var newFilter:DropShadowFilter = new DropShadowFilter();
			newFilter.blurX = 2;
			newFilter.blurY = 2;
			newFilter.distance = 1;
			newFilter.strength = 8;
			newFilter.angle = 45;
			newFilter.alpha = 1;
			newFilter.color = 0x000000;
			this.filters = [ newFilter ];
		}
	}
}