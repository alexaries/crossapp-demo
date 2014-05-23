package sceneModule.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.group.group906.TeamMemberInfo;
	import proto.group.group906.memberInfo;
	
	import sceneModule.event.TeamMemberInfoResponseEvent;
	import sceneModule.model.vo.groupVo.TeamMemberInfoVo;

	/**
	 * 组队成员信息返回事件 
	 * @author Yaolx
	 * 
	 */
	public class TeamMemberInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:TeamMemberInfoResponseEvent;
		public function TeamMemberInfoResponseCommand()
		{
			super();
		}
		
		override public function execute():void{
			var teamByteArray:ByteArray = evt.obj as ByteArray;
			var teamResponseData:TeamMemberInfo = new TeamMemberInfo();
			teamResponseData.readExternal(teamByteArray);
			if(teamResponseData.member){
				SystemDataModel.teamLeaderId = teamResponseData.leaderId;
				var l:int = teamResponseData.member.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var memberInfoVo:memberInfo = teamResponseData.member[i];
					if(memberInfoVo.id != SystemDataModel.roleId){
						var teamMemberInfoVo:TeamMemberInfoVo = new TeamMemberInfoVo();
						teamMemberInfoVo.hp = memberInfoVo.hp;
						teamMemberInfoVo.id = memberInfoVo.id;
						teamMemberInfoVo.maxHp =memberInfoVo.maxHp;
						teamMemberInfoVo.maxMp =memberInfoVo.maxMp;
						teamMemberInfoVo.mp = memberInfoVo.mp;
						teamMemberInfoVo.nickName =memberInfoVo.nickname;
						teamMemberInfoVo.profession =memberInfoVo.profession;
						teamMemberInfoVo.level = memberInfoVo.level;
						arr.addItem(teamMemberInfoVo);
					}
					
				}
				SystemDataModel.teamCollection.source = arr.toArray();
			}
		}
	}
}