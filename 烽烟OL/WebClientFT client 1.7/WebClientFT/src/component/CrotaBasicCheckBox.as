package component
{
	/**
	 * CheckBox
	 * @author Yaolx
	 * 
	 */
	import spark.components.CheckBox;
	import style.Skin_CrotaBasicCheckBox;
	public class CrotaBasicCheckBox extends CheckBox
	{
		public function CrotaBasicCheckBox()
		{
			super();
			initCheckBoxStyle();
		}
		private function initCheckBoxStyle():void{
		    setStyle("skinClass",Skin_CrotaBasicCheckBox);
		}
	}
}