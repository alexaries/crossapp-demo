package sceneModule.view.corps.command
{
	/**
	 * 获取或搜索军团返回事件 
	 * @author Dream-Y
	 * 
	 */
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.corps.corps1301.CorpsInfo;
	import proto.corps.corps1301.CorpsListInfo;
	import proto.corps.corps1301.GetCorpsListInfoResponse;
	
	import sceneModule.model.vo.corpsVO.CorpsListInfoVo;
	import sceneModule.view.corps.event.GetOrSearchCorpsListResponseEvent;

	public class GetOrSearchCorpsListResponseCommand extends Command
	{
		[Inject]
		public var evt:GetOrSearchCorpsListResponseEvent;
		public function GetOrSearchCorpsListResponseCommand()
		{
			super();
		}
		
		override public function execute():void{
			var byteArray:ByteArray = evt.obj as ByteArray;
			var getCorpsListRes:GetCorpsListInfoResponse = new GetCorpsListInfoResponse();
			getCorpsListRes.readExternal(byteArray);
			if(getCorpsListRes.result){
				var corpsListInfo:CorpsListInfo = getCorpsListRes.data;
				SystemDataModel.mainCorpsInfo.curPage = corpsListInfo.curPage;
				SystemDataModel.mainCorpsInfo.maxPage = corpsListInfo.maxPage;
				var l:int = corpsListInfo.corpsInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var corpsInfo:CorpsInfo = corpsListInfo.corpsInfo[i];
					var corpsListInfoVo:CorpsListInfoVo = new CorpsListInfoVo();
					corpsListInfoVo.corpsAnnouncement = corpsInfo.corpsAnnouncement;
					corpsListInfoVo.corpsChief = corpsInfo.corpsChief;
					corpsListInfoVo.corpsId = corpsInfo.corpsId;
					corpsListInfoVo.corpsImg = corpsInfo.corpsImg;
					corpsListInfoVo.corpsLevel = corpsInfo.corpsLevel;
					corpsListInfoVo.corpsName = corpsInfo.corpsName;
					corpsListInfoVo.corpsTitle = corpsInfo.corpsTitle;
					corpsListInfoVo.curNum = corpsInfo.curNum;
					corpsListInfoVo.maxNum = corpsInfo.maxNum;
					corpsListInfoVo.onApplication = corpsInfo.onApplication;
					corpsListInfoVo.corpRunningFlag = corpsInfo.runningFlag;
					corpsListInfoVo.levReq = corpsInfo.levelrequired;
					arr.addItem(corpsListInfoVo);
				}
				SystemDataModel.mainCorpsInfo.corpsListInfo.source = arr.toArray();
			}
		}
	}
}