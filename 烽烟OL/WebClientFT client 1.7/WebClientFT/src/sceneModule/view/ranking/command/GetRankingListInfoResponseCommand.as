package sceneModule.view.ranking.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.ranking.ranking2001.GetRankingListInfoResponse;
	import proto.ranking.ranking2001.RankingInfo;
	
	import sceneModule.model.vo.rankingVO.RankingInfoVO;
	import sceneModule.view.ranking.event.GetRankingListInfoResponseEvent;

	/**
	 * 排行榜返回Command 
	 * @author Dream-Y
	 * 
	 */	
	public class GetRankingListInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:GetRankingListInfoResponseEvent;
		public function GetRankingListInfoResponseCommand()
		{
			super();
		}
		override public function execute():void{
			var byteArray:ByteArray = evt.obj as ByteArray;
			var responseData:GetRankingListInfoResponse = new GetRankingListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainRankingInfo.myRanking = responseData.data.myRanking;
				SystemDataModel.mainRankingInfo.refreshTime = responseData.data.refreshTime;
				var l:int = responseData.data.rankingInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				
				for(var i:int=0;i<l;i++){
					var rankingInfo:RankingInfo = responseData.data.rankingInfo[i];
					var rankingInfoVo:RankingInfoVO = new RankingInfoVO();
					rankingInfoVo.id = rankingInfo.id;
					rankingInfoVo.param1 = rankingInfo.param1;
					rankingInfoVo.param2 = rankingInfo.param2;
					rankingInfoVo.param3 = rankingInfo.param3;
					rankingInfoVo.param4 = rankingInfo.param4;
					rankingInfoVo.param5 = rankingInfo.param5;
					arr.addItem(rankingInfoVo);
				}
				SystemDataModel.mainRankingInfo.rankingInfoList.source = arr.toArray();
			}
		}
	}
}