package sceneModule.model.vo.groupVo
{
	/**
	 * 房间信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class RoomInfoVo
	{
		public var roomId:int;//房间id
		public var groupName:String;//队伍名称
		public var groupPassword:String;//密码
		public var copySceneId:int;//副本id
		public var copyLevel:int;//难道级别0普通1精英2英雄
		public function RoomInfoVo()
		{
		}
	}
}