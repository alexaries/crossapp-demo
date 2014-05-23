package sceneModule.view.friend.command
{
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.friends.friends302.Friend;
	
	import sceneModule.view.friend.event.GetPlayerFrindsResponseEvent;
	import sceneModule.view.friend.model.vo.FriendInfoVo;

	/**
	 * 获取好友信息Response Command 
	 * @author Yaolx
	 * 
	 */	
	public class GetPlayerFrindsResponseCommand extends Command
	{
		[Inject]
		public var evt:GetPlayerFrindsResponseEvent;
		public function GetPlayerFrindsResponseCommand()
		{
			super();
		}
		override public function execute():void{
//		    SystemDataModel.playerFriendsVo.friendCount = evt.result.data.friendCount;
			/*var l:int = evt.result.data.friends.length;
			var friendsArr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var friendsVo:Friend = evt.result.data.friends[i];
				var friendInfoVo:FriendInfoVo = new FriendInfoVo();
				    friendInfoVo.comp = friendsVo.comp;
					friendInfoVo.roleId = friendsVo.roleId;
					friendInfoVo.roleName = friendsVo.roleName;
					friendInfoVo.lastLoadTime = friendsVo.lastLoadTime;
					friendInfoVo.level = friendsVo.level;
					friendInfoVo.roleProfession = friendsVo.roleProfession;
					friendInfoVo.isLine = friendsVo.zx;
					friendInfoVo.showMesFlag = friendsVo.tishi;
					friendsArr.addItem(friendInfoVo);
			}
			SystemDataModel.playerFriendsVo.friendsCollection.source = friendsArr.toArray();*/
		}
	}
}