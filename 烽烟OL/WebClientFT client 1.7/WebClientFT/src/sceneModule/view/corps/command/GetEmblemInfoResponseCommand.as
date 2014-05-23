package sceneModule.view.corps.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.corps.corps1310.EmblemInfo;
	import proto.corps.corps1310.GetEmblemInfoResponse;
	
	import sceneModule.view.corps.event.GetEmblemInfoResponseEvent;

	/**
	 * 获取军徽信息返回Command 
	 * @author Dream-Y
	 * 
	 */	
	public class GetEmblemInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:GetEmblemInfoResponseEvent;
		public function GetEmblemInfoResponseCommand()
		{
			super();
		}
		override public function execute():void{
			var byteArray:ByteArray = evt.obj as ByteArray;
			var responseData:GetEmblemInfoResponse = new GetEmblemInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var emblemInfo:EmblemInfo = responseData.data;
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.corpsChief = emblemInfo.corpsChief;
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.corpsFounder = emblemInfo.corpsFounder;
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.corpsId = emblemInfo.corpsId;
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.corpsImg = emblemInfo.corpsImg;
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.corpsLevel = emblemInfo.corpsLevel;
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.createData = emblemInfo.createData;
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.emblemLevel = emblemInfo.emblemLevel;
				var ol:int = emblemInfo.orderInfo.length;
				var arr_ol:ArrayCollection = new ArrayCollection();
				for(var oi:int = 0;oi<ol;oi++){
					arr_ol.addItem(emblemInfo.orderInfo[oi]);
				}
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.orderInfoList.source = arr_ol.toArray();
				var sl:int = emblemInfo.staffInfo.length;
				var arr_sl:ArrayCollection = new ArrayCollection();
				for(var si:int = 0;si<sl;si++){
					arr_sl.addItem(emblemInfo.staffInfo[si]);
				}
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.staffInfoList.source = arr_sl.toArray();
				var vl:int = emblemInfo.veteranList.length;
				var arr_vl:ArrayCollection = new ArrayCollection();
				for(var vi:int = 0;vi<vl;vi++){
					arr_vl.addItem(emblemInfo.veteranList[vi]);
				}
				SystemDataModel.mainCorpsInfo.corpsEmblemInfo.veteranList.source = arr_vl.toArray();
			}
		}
	}
}