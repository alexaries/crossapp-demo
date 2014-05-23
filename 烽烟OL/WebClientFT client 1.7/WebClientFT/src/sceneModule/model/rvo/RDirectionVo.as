package sceneModule.model.rvo
{
	import flash.geom.Point;
	
	/**
	 * 记录角色的坐标和方向 
	 * @author mutou
	 * 
	 */	
	public class RDirectionVo
	{
		public function RDirectionVo()
		{
		}
		
		public static const RIGHT_DIRECTION:int = 1; //玩家朝向右
		public static const LEFT_DIRECTION:int = 2; //玩家朝向左
		
		public var chaPos:Point;//角色当前坐标
		public var chaDirection:int;//获取角色当前方向 1：朝右，2：朝左
	}
}