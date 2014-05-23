package component
{
	/**
	 * Label
	 * @author Yaolx
	 * 
	 */
	import flash.text.TextFormat;
	
	import spark.components.Label;
	import spark.filters.DropShadowFilter;
	import spark.filters.GlowFilter;

	public class CrotaBasicLabel extends Label
	{
		public function CrotaBasicLabel()
		{
			super();
			var growFilte:GlowFilter = new GlowFilter(0x34332d ,0.7,2,2,5);
			this.filters =[growFilte];
		}
	}
}