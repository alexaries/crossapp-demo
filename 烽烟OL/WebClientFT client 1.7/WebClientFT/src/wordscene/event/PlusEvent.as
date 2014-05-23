package wordscene.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class PlusEvent extends Event 
	{
		public static const PlusEvent_HIDE_PLAYER_INFO:String = "PlusEvent_HIDE_PLAYER_INFO";
		public static const PlusEvent_EXIT_FIGHT:String = "PlusEvent_EXIT_FIGHT";
		
		public static const PlusEvent_OPEN_PATA:String = "PlusEvent_OPEN_PATA";
		public static const PlusEvent_OPEN_JINGJI:String = "PlusEvent_OPEN_JINGJI";
		public static const PlusEvent_CLOSE_JINGJI:String = "PlusEvent_CLOSE_JINGJI";
		
		public static const PlusEvent_SCENE_PK:String = "PlusEvent_SCENE_PK";
		
		public static const PlusEvent_ResetPKAble:String = "PlusEvent_ResetPKAble";
		
		//打开战役
		public static const PlusEvent_OPEN_ZHANYI:String = "PlusEvent_OPEN_ZHANYI";
		//战役中点击item
		public static const PlusEvent_ZhanyiItemClick:String = "PlusEvent_ZhanyiItemClick";
		
		private var _obj:Object;
		public function PlusEvent(type:String, obj:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_obj = obj;
			super(type, bubbles, cancelable);
		}
		
		public function get obj():Object 
		{
			return _obj;
		}
		
	}

}