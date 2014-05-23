package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 场景加载完成显示场景名称事件 
	 * @author Dream-Y
	 * 
	 */	
	public class SceneLoadedAndShowSceneNameEvent extends Event
	{
		public static const SCENELOADEDANDSHOWSCENENAME:String = "sceneLoadedAndShowSceneName";
		public static const LEVELUPEFFECT:String = "levelUpEffect";
		public var sceneResId:int;
		public function SceneLoadedAndShowSceneNameEvent(type:String,srId:int)
		{
			sceneResId = srId;
		    super(type);	
		}
	}
}