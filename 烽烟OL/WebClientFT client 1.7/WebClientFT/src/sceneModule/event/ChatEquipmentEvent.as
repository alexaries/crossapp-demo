package sceneModule.event
{
	import flash.events.Event;
	
	import proto.chat.chat1003.itemLinkData;
	
	import sceneModule.view.chat.vo.ChatEquipmentVo;

	public class ChatEquipmentEvent extends Event
	{
		public static const CHATEQUIPMENTEVENT:String = "chatEquipment";
		public var chatEquipVo:itemLinkData;
		public function ChatEquipmentEvent(type:String,value:itemLinkData)
		{
			super(type);
			chatEquipVo = value;
		}
	}
}