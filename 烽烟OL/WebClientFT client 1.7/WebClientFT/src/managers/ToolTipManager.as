package managers
{
	import flash.utils.Dictionary;
	
	import mx.core.IVisualElement;
	
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.pack.view.MainSmallDesTooltip;
	import sceneModule.view.pet.view.PetToolTipComponent;
	import sceneModule.view.roleInfo.view.RoleInfoShowTooltip;

	/**
	 * 游戏中ToolTip管理器 
	 * @author Dream-Y
	 * 
	 */	
	public class ToolTipManager
	{
		/**
		 * ToolTip对象缓存 
		 */		
		public static var dictionary:Dictionary;
		public function ToolTipManager()
		{
		}
		
		public static function showToolTip(tipName:String):IVisualElement{
			if(!dictionary){
				dictionary = new Dictionary();
			}
			
			var toolTip:IVisualElement = dictionary[tipName];
			
			if(toolTip == null){
				switch(tipName){
					case MainMenuEquipmentTooltip.NAME:
						toolTip = new MainMenuEquipmentTooltip() as IVisualElement;
						break;
					case MainSmallDesTooltip.NAME:
						toolTip = new MainSmallDesTooltip() as IVisualElement;
						break;
					case PetToolTipComponent.NAME:
						toolTip = new PetToolTipComponent() as IVisualElement;
						break;
					case RoleInfoShowTooltip.NAME:
						toolTip = new RoleInfoShowTooltip() as IVisualElement;
						break;
				}
			}
			
			return toolTip;
		}
	}
}