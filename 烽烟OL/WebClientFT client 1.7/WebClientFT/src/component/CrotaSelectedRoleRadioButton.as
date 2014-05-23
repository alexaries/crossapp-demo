package component
{
	import mx.controls.Image;
	import mx.controls.Label;
	
	import spark.components.Label;
	import spark.components.RadioButton;
	
	import style.Skin_CrotaWorldRadioButton;

	public class CrotaSelectedRoleRadioButton extends RadioButton
	{
		public function CrotaSelectedRoleRadioButton()
		{
			super();
			initStyle();
			addImageAndLabelComponent();
			this.width = 294;
			this.height = 64;
		}
		private function initStyle():void{
		    this.setStyle("skinClass",Skin_CrotaWorldRadioButton);
		}
		/**
		 * 添加图片和Label控件
		 */
		private var roleImg:Image;
		private var roleLevelLab:spark.components.Label;
		private var roleNameLab:spark.components.Label;
		private function addImageAndLabelComponent():void{
			roleImg = new Image();
			roleImg.width = 66;
			roleImg.height = 35;
			this.addChild(roleImg);
			
			roleLevelLab = new spark.components.Label();
			roleLevelLab.x = 107;
			roleLevelLab.y = 10;
			this.addChild(roleLevelLab);
			
			roleNameLab = new spark.components.Label();
			roleNameLab.x = 170;
			roleNameLab.y = 10;
			this.addChild(roleNameLab);
		}
		public function set setRoleInfo(obj:Object):void{
			
		}
	}
}