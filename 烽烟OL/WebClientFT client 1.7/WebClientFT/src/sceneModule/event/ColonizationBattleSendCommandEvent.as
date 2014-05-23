package sceneModule.event
{
	import flash.events.Event;
	
	import sceneModule.view.copyScene.model.FubenChoseItemVo;

	/**
	 * 发送殖民战指令事件 
	 * @author Dream-Y
	 * 
	 */	
	public class ColonizationBattleSendCommandEvent extends Event
	{
		public static var COLONIZATIONBATTLESENDCOMMAND:String = "colonizationBattleSendCommand";
		public var copySceneId:int;
		public var camp:int;
		public var _info:FubenChoseItemVo;
		public function ColonizationBattleSendCommandEvent(type:String,value:FubenChoseItemVo)
		{
//			copySceneId = value;
//			camp = _camp;
			_info = value;
			super(type);
		}
	}
}