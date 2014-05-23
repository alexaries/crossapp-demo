package sceneModule.view.blacksmith.event
{
	import flash.events.Event;

	/**
	 * 在强化界面双击背包装备，发送强化改装备事件 
	 * @author Dream-Y
	 * 
	 */	
	public class BlacksmithDoubleClickInPackEvent extends Event
	{
		public static var BLACKSMITHDOUBLECLICKINPACK:String = "blacksmithDoubleClickInPack";
		public var id_temp:int;//模板id
		public var tempItemId:int;
		public var tempPos:int;
		public var inBodyFlag:Boolean;
		public function BlacksmithDoubleClickInPackEvent(type:String,value:int,pos:int,flag:Boolean,tId:int)
		{
			tempItemId = value;
			tempPos = pos;
			inBodyFlag = flag;
			id_temp = tId;
			super(type);
		}
	}
}