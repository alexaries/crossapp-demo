package sceneModule.view.corps.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.corps.corps1314.GetCorpsTechnologyListInfoResponse;
	import proto.corps.corps1314.TechnologyInfo;
	
	import sceneModule.model.vo.corpsVO.CorpsTechnologyInfoVo;
	import sceneModule.view.corps.event.GetCorpsTechnologyListInfoResponseEvent;

	/**
	 * 获取军团科技列表返回事件
	 * @author Dream-Y
	 * 
	 */
	public class GetCorpsTechnologyListInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:GetCorpsTechnologyListInfoResponseEvent;
		public function GetCorpsTechnologyListInfoResponseCommand()
		{
			super();
		}
		
		override public function execute():void{
			var byteArray:ByteArray = evt.obj as ByteArray;
			var responseData:GetCorpsTechnologyListInfoResponse = new GetCorpsTechnologyListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainCorpsInfo.curPage = responseData.data.curPage;
				SystemDataModel.mainCorpsInfo.maxPage = responseData.data.maxPage;
				var l:int = responseData.data.technologyInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var technologyInfoVo:CorpsTechnologyInfoVo = new CorpsTechnologyInfoVo();
					var technologyInfo:TechnologyInfo = responseData.data.technologyInfo[i];
					technologyInfoVo.curSchedule = technologyInfo.curSchedule;
					technologyInfoVo.maxSchedule = technologyInfo.maxSchedule;
					technologyInfoVo.remainCondition = technologyInfo.remainCondition;
					technologyInfoVo.technologyDes = technologyInfo.technologyDes;
					technologyInfoVo.technologyId = technologyInfo.technologyId;
					technologyInfoVo.technologyImg = technologyInfo.technologyImg;
					technologyInfoVo.technologyLevel = technologyInfo.technologyLevel;
					technologyInfoVo.technologyName = technologyInfo.technologyName;
					technologyInfoVo.defaultDonate = technologyInfo.defaultDonate;
					arr.addItem(technologyInfoVo);
				}
				SystemDataModel.mainCorpsInfo.corpsTechnologyList.source = arr.toArray();
			}
		}
	}
}