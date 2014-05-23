package sceneModule.rcommand.revent
{
	import flash.events.Event;
	
	public class RBattleSealPetEvent extends Event
	{
		public function RBattleSealPetEvent(type:String)
		{
			super(type);
		}
		public static const SEAL_PET_SUCCESS_EVENT:String = "sealPetSuccessEvent";//宠物封印成功事件
	}
}