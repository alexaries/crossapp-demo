package component
{
	import spark.components.Button;
	
	import style.Skin_CrotaSmallButton;

	public class CrotaSmallButton extends Button
	{
		public function CrotaSmallButton()
		{
			super();
			initStyle();
		}
		private function initStyle():void{
		    setStyle("skinClass",Skin_CrotaSmallButton);
//			this.setStyle("color",0xffffff);
//			this.setStyle("fontFamily","幼圆");
//			this.setStyle("fontSize",12);
////			this.setStyle("fontWeight","bold");
//			this.width=83;
//			this.height=22;
		}
	}
}