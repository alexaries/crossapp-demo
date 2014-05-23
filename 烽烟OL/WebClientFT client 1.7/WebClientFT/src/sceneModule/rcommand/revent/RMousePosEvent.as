package sceneModule.rcommand.revent
{
	/**
	 * 鼠标点击事件类ds 
	 */	
	import flash.events.Event;
	
	public class RMousePosEvent extends Event
	{
		public function RMousePosEvent(type:String,id:int,name:String,chaType:int=1,chaProfessionType:int=-1,masterId:int=-1,chaLevel:int=-1,vipLevel:int=-1, campid:int = 0)
		{
			super(type);
			this.chaId = id;
			this.chaName = name;
			this.chaType = chaType;
			this.chaProfessionType = chaProfessionType;
			this.masterId = masterId;
			this.chaLevel = chaLevel;
			this.vipLevel = vipLevel;
			this.campid = campid;
		}
		/**
		 * 要操作的对象ID
		 * 可以是角色
		 * 可以是NPC 
		 */		
		public var chaId:int=-1;
		public var chaName:String;
		public var chaType:int;//角色类型，区别于职业类型，1：角色，2：怪物，3：宠物
		public var chaProfessionType:int;//角色职业类型，战士，法师，游侠
		
		public var masterId:int = -1;
		
		public var chaLevel:int=-1;
		public var vipLevel:int = -1;
		public var campid:int = 0;
		
		public static const MOUSE_SELECTED_EVENT:String = "MouseSelectedEvent";
	}
}