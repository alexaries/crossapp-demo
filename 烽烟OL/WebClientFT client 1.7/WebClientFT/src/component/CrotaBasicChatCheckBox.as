package component
{
	/**
	 * CheckBox
	 * @author Yaolx
	 * 
	 */
	import spark.components.CheckBox;
	import style.Skin_CrotaChatCheckBox;
	public class CrotaBasicChatCheckBox extends CheckBox
	{
		public function CrotaBasicChatCheckBox()
		{
			super();
			initCheckBoxStyle();
		}
		private function initCheckBoxStyle():void{
		    setStyle("skinClass",Skin_CrotaChatCheckBox);
		}
	}
}