package sceneModule.model.vo.groupVo
{
	/**
	 * 队伍信息VO
	 * @author Yaolx
	 * 
	 */	
	public class GroupInfoVo
	{
		public var groupHallId:int;//房间id
		public var groupHallNumber:int;//房间号
		public var groupHallClock:Boolean;//房间是否加锁 默认为开放
		public var copySceneLevel:int;//副本级别 0普通1困难2英雄
		public var groupName:String;//队伍名称
		public var curRoleNum:int;//当前玩家数量
		public var copySceneId:int;//副本id
		public function GroupInfoVo()
		{
		}
	}
}