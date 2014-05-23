package sceneModule.rcommand.revent
{
	import flash.events.Event;
	/**
	 * 角色触发事件，如角色跑到NPC面前停止，应触发事件弹出对话界面 
	 * @author mutou
	 * 
	 */	
	public class RCharacterEvent extends Event
	{
		/**
		 * 角色移动到NPC面前的事件及所需参数
		 * @param type 事件类型
		 * @param id NPC ID
		 * @param name NPC NAME
		 * @param functionType NPC 功能类型，如商战，军团...
		 * 
		 */		
		public function RCharacterEvent(type:String,id:int=-1,name:String="",functionType:int=-1)
		{
			super(type);
			this.npcId = id;
			this.npcName = name;
			this.npcFunctionType = functionType;
		}
		public static const CHAT_WITH_NPC_EVENT:String = "chatWithNpcEvent";//与NPC聊天
		public var npcId:int;
		public var npcName:String;
		public var npcFunctionType:int;
	}
}