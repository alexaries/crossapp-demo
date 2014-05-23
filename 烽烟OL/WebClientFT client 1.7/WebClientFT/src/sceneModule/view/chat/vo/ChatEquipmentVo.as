package sceneModule.view.chat.vo
{
	import sceneModule.model.vo.packageVo.PackageItem;

	/**
	 * 聊天连接VO 
	 * @author Yaolx
	 * 
	 */	
	public class ChatEquipmentVo
	{
		public var chatEquipType:int;//聊天连接类型 0:装备1:角色
		public var id:int;//唯一标示
		public var name:String;//连接名称
		public var itemInfo:PackageItem;//物品信息
		public function ChatEquipmentVo()
		{
		}
	}
}