package sceneModule.rcommand.revent
{
	import flash.events.Event;
	
	public class RLoadEvent extends Event
	{
		public function RLoadEvent(type:String, per:Number=0,countRate:String="")
		{
			super(type);
			this.percentLoaded = per;
			if(countRate != ""){
				this.countRate = countRate;
			}
		}
		public static const PERCENT_LOADED_EVENT:String = "loadPercentEvent";//场景初始化资源加载
		
		public static const PERCENT_BATTLE_LOADED_EVENT:String = "loadBattlePercentEvent";//战斗资源加载
		public static const BATTLE_LOADED_EVENT:String = "battleLoadedEvent";//战斗资源加载完成
		
		public var percentLoaded:Number;
		public var countRate:String="";
	}
}