package sceneModule.model.vo.groupVo
{
	import sceneModule.model.vo.RoleInfoVo;

	/**
	 * 阵法每一个格子的信息vo 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class MatrixEveryOneInfoVo
	{
		public var pos:int;//位置 格子在阵法的位置
		public var isOpen:Boolean;//格子是否开放 默认不开放
//		public var effectIsIncrease:Boolean;//改格子对玩家的效果是增加还是伤害  默认是伤害
		public var effectPer:int;//效果值
		public var isHaveRole:Boolean;//改格子中是否存在玩家 默认不存在
		public var matrixIndex:int;//阵法索引
		public var roleInfo:RoomRoleListRoleInfoVo = new RoomRoleListRoleInfoVo();//如果存在玩家 则玩家信息
		public function MatrixEveryOneInfoVo()
		{
		}
	}
}