package component
{
	import mx.controls.Text;
	
	import spark.filters.GlowFilter;

	public class CrotaBasicText extends Text
	{
		public function CrotaBasicText()
		{
			super();
			var growFilte:GlowFilter = new GlowFilter(0x000000,0.7,2,2,5,1);			
			var arr:Array = new Array();
			arr.push(growFilte);
			this.filters =arr;
			this.enabled = false;
		}
	}
}