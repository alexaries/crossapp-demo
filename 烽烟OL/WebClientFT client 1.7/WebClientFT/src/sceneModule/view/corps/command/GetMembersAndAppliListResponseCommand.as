package sceneModule.view.corps.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.corps.corps1303.GetCorpsMemberOrAppliListInfoResponse;
	import proto.corps.corps1303.MemberOrAppliListBaseInfo;
	
	import sceneModule.model.vo.corpsVO.CorpsMembersAndAppliInfoVO;
	import sceneModule.view.corps.event.GetMembersAndAppliListResponseEvent;

	/**
	 * 获取军团成员列表和申请列表 
	 * @author Dream-Y
	 * 
	 */	
	public class GetMembersAndAppliListResponseCommand extends Command
	{
		[Inject]
		public var evt:GetMembersAndAppliListResponseEvent;
		public function GetMembersAndAppliListResponseCommand()
		{
			super();
		}
		override public function execute():void{
			var byteArray:ByteArray = evt.obj as ByteArray;
			var responseData:GetCorpsMemberOrAppliListInfoResponse = new GetCorpsMemberOrAppliListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.data.memberOrAppliListBaseInfo.length;
				SystemDataModel.mainCorpsInfo.curPage = responseData.data.curPage;
				SystemDataModel.mainCorpsInfo.maxPage = responseData.data.maxPage;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var baseInfo:MemberOrAppliListBaseInfo = responseData.data.memberOrAppliListBaseInfo[i];
					var corpsMembersInfo:CorpsMembersAndAppliInfoVO = new CorpsMembersAndAppliInfoVO();
					corpsMembersInfo.memberContributio = baseInfo.memberContribution;
					corpsMembersInfo.memberLevel = baseInfo.memberLevel;
					corpsMembersInfo.memberliId = baseInfo.memberliId;
					corpsMembersInfo.memberName = baseInfo.memberName;
					corpsMembersInfo.memberProfession = baseInfo.memberProfession;
					corpsMembersInfo.memberRank = baseInfo.memberRank;
					corpsMembersInfo.memberTime = baseInfo.memberTime;
					corpsMembersInfo.memberType = responseData.data.setType;
					arr.addItem(corpsMembersInfo);
				}
				SystemDataModel.mainCorpsInfo.corpsMembersAndAppliList.source = arr.toArray();
			}
		}
	}
}