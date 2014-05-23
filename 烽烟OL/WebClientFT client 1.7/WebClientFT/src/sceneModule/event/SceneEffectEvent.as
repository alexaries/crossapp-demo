package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 场景效果事件 
	 * @author Dream-Y
	 * 
	 */	
	public class SceneEffectEvent extends Event
	{
		public static var SwitchSceneOrBattleEffect:String = "switchSceneOrBattleEffect";
		public var effID:String;
		public var fun:Function;
		public var x:int;
		public var y:int;
		public function SceneEffectEvent(type:String,_effID:String,_fun:Function = null,_x:int=0,_y:int=0)
		{
			effID = _effID;
			fun = _fun;
			x = _x;
			y = _y;
			super(type);
		}
	}
}