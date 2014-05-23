package component
{
	/**
	 * CheckBox
	 * @author Yaolx
	 * 
	 */
	import spark.components.CheckBox;
	
	import style.Skin_CrotaBasicCheckBox;
	import style.Skin_CrotaBasicCheckBoxCreate;

	public class CrotaBasicCheckBoxCreate extends CheckBox
	{
		public function CrotaBasicCheckBoxCreate()
		{
			super();
			initCheckBoxStyle();
		}
		private function initCheckBoxStyle():void{
			setStyle("skinClass",Skin_CrotaBasicCheckBoxCreate);
		}
	}
}