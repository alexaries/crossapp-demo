package sceneModule.rcommand.revent
{
	import flash.events.Event;
	/**
	 * NPC事件，如创建完成等
	 * @author mutou
	 * 
	 */	
	public class RNpcEvent extends Event
	{
		public function RNpcEvent(type:String,npcId:int=-1)
		{
			super(type);
			this.npcId = npcId;
		}
		public static var NPC_CTREATED_EVENT:String = "npcCreated";
		public static var ALL_NPC_CREATED_EVENT:String = "allNpcCreatedEvent";
		public var npcId:int;
	}
}