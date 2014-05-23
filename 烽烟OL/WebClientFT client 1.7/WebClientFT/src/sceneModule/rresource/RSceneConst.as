package sceneModule.rresource
{
	/**
	 * 脚本中涉及到的公用常量 
	 * @author mutou
	 * 
	 */	
	public class RSceneConst
	{
		public function RSceneConst()
		{
		}
		//场景边界实体前缀
		public static const BOUNDS_ENTITY_NAME:String = "BoundsEntity";
		//鼠标点击样式实体名
		public static const MOUSE_EFFECT_ENTITY_NAME:String = "MouseEffectEnt";
		//可攻击的双剑样式
		public static const SWORD_ENTITY_NAME:String = "swordEnt";
		//传送门实体
		public static const SWITCH_ENTITY_NAME:String = "SwitchEnt";
		public static const SWITCH_RENDER_NAME:String = "SwitchRender";
		public static const SWITCH_LAYER_INDEX:int = 18;//传送门所在层
		public static const SWITCH_FRAME_RATE:Number = 0.125;//传送门帧频
		
		//默认加载器，用来加载blankCha.swf以及传送门空白资源等一切空白信息
		public static const DEFAULT_LOADER_NAME:String = "default-loader";
		public static const BLANK_CHA_ID:String = "blankCha";//默认资源ID
		public static const BLANK_RES_ID:String = "blankRes";//默认全空白资源ID
		public static const BLANK_SWITCH_ID:String = "blankSwitch";//默认传送门ID
	}
}