package sceneModule.rresource
{
	import flash.geom.Point;

	/**
	 * NPC 常量类 
	 * @author mutou
	 * 
	 */	
	public class RNpcConst
	{
		public function RNpcConst()
		{
		}
		//帧频
		public static const NPC_FRAME_RATE:Number = 0.125;
		
		//=============================NPC layer
		public static const NPC_LAYER_INDEX:int = 17;
		
		//=============================实体等名称
		public static const NPC_ENTITY_NAME:String = "NpcEnt";
		//NPC状态组件名
		public static const NPC_STATE_RENDER_NAME:String = "npcStateRender";
		//角色与NPC的距离
		public static const NPC_OFFSET_X:int = 30;
		public static const NPC_OFFSET_Y:int = 20;
		//NPC状态
		public static const NPC_STATE_1:int = 0;//空白
		public static const NPC_STATE_2:int = 1;//金叹号
		public static const NPC_STATE_3:int = 2;//银问号
		public static const NPC_STATE_4:int = 3;//金问号
		//NPC图标前缀
		public static const ICON_PRE_STR:String = "npcIcon";
		//icon动作名称
		public static const ICON_STR:String = "iconAction";
		//icon组件名称
		public static const ICON_ANIMATOR_NAME:String = "iconCmp";
		//icon render name
		public static const ICON_RENDER_NAME:String = "iconRender";
		//icon sheet name
		public static const ICON_SHEET_NAME:String = "iconSheet";
	}
}
