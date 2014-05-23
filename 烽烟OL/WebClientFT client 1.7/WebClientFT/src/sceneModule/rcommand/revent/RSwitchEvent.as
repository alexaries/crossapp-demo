package sceneModule.rcommand.revent
{
	import flash.events.Event;
	
	public class RSwitchEvent extends Event
	{
		public function RSwitchEvent(type:String,id:int=-1,functionType:int=0)
		{
			super(type);
			switchId = id;
			this.functionType = functionType;
		}
		/**
		 * 要切换到的关卡，>0 直接切换，<0切换到角色自己的公会场景
		 * 如：nextLevel=1,切换到场景1
		 * nextLevel=-1,切换到自己的公会场景，可能是123，也可能是456
		 */		
		//public var nextLevel:int=-1;
		public var functionType:int;//1.切换场景，2：弹对话框
		public var switchId:int;//传送门ID
		
		public static const SWITCH_EVENT:String = "switchEvent";
		
		public static const SWITCH_1:String = "switchNextLevel";//切换场景
		public static const SWITCH_2:String = "showDialog";//显示窗口
		
		public static const SWITCH_FUNCTION_TYPE_STR:String = "functionType"; //变量名
		public static const SWITCH_ID_STR:String = "switchId"; //变量名
		
		public static const NEXT_LEVEL_STR:String = "nextLevel";
		public static const NUM_STR:String = "|Number|";
	}
}