package sceneModule.rresource
{
	/**
	 * 场景角色资源 
	 * @author mutou
	 * 
	 */	
	public class RCharacterRes
	{
		public function RCharacterRes()
		{
		}
		/**
		 * =======================各种职业的图片信息，以及动作起始帧和结束帧=================
		 * 
		 * 顺序 依次为 ---- 
		 * sizeX[0],sizeY[1],centerX[2],centerY[3],xCount[4],yCount[5],action[6,7]
		 * sizeX[0],sizeY[1] -- 帧大小
		 * centerX[2],centerY[3] -- 帧中点坐标
		 * xCount[4],yCount[5] -- 帧列和行的数量
		 * action[6,7] -- 动作的起始帧和结束帧
		 * 动作：站立，跑动
		 * 
		 * ================================================================================
		 */	
		
		//默认初始化的空白角色模型
		public static const BLANK_CHA_SWF:String = "assets/swf/sceneRes/blankCha.swf";
		public static const BLANK_CHA_JSON:String = "assets/swf/sceneRes/blankCha.gs-cha";
		
		//默认初始化的全部空白模型
		public static const BLANK_RES_SWF:String = "assets/swf/sceneRes/blankRes.swf";
		public static const BLANK_RES_JSON:String = "assets/swf/sceneRes/blankRes.gs-cha";
		
		public static const BLANK_SWITCH_SWF:String = "assets/swf/sceneRes/blankSwitch.swf";
		public static const BLANK_SWITCH_JSON:String = "assets/swf/sceneRes/blankSwitch.gs-cha";
		
		public static const CHA_URL_PRE:String = "assets/swf/sceneRes/";//角色资源路径前缀
		public static const CHA_JSON_EXTENSION_NAME:String = ".gs-cha";//JSON文件扩展名
		
		//角色怪物坐标配置文件
		public static const CHA_POS_URL:String = "assets/swf/sceneRes/pos.gs-cha";
		public static const CHA_POS_JSON_ID:String = "chaPosJs";
	}
}