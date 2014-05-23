package sceneModule.view.pet.event
{
	import flash.events.Event;

	/**
	 * 获取宠物列表信息返回处理事件 
	 * @author Dream-Y
	 * 
	 */	
	public class GetPetListInfoResponseEvent extends Event
	{
		public static var GETPETLISTINFO:String = "getPetListInfo";
		public var obj:Object;
		public function GetPetListInfoResponseEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}