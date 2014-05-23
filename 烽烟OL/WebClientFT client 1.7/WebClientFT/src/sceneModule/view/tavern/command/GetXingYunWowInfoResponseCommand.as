package sceneModule.view.tavern.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.tavern.tavern3503.GetTavernTaskInfoResponse;
	
	import sceneModule.view.tavern.event.XingYunWOWEvent;
	import sceneModule.view.tavern.vo.XingYunTavernWoWInfo;
	import sceneModule.view.tavern.vo.XingYunTravernInfo;

	public class GetXingYunWowInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:XingYunWOWEvent;

		public function GetXingYunWowInfoResponseCommand()
		{
			super();
		}

		override public function execute():void
		{
			var byteArray:ByteArray=evt.view as ByteArray;
			var responseData:GetTavernTaskInfoResponse=new GetTavernTaskInfoResponse();
			responseData.readExternal(byteArray);
			if (responseData.result && responseData.data)
			{
				var l:int=responseData.data.xingYunwowInfo.length;

				var xingYunArr:ArrayCollection=new ArrayCollection();

				var arr:ArrayCollection=new ArrayCollection();

				for (var i:int=0; i < l; i++)
				{
					var xytavernOfWoWInfoVo:XingYunTavernWoWInfo=new XingYunTavernWoWInfo();
					
					var xytaverinfo:XingYunTravernInfo=new XingYunTravernInfo();
					
					xytavernOfWoWInfoVo.wSkill=responseData.data.xingYunwowInfo[i].wSkill;
					xytavernOfWoWInfoVo.wTexing=responseData.data.xingYunwowInfo[i].wTexing;
					xytavernOfWoWInfoVo.wLiliang=responseData.data.xingYunwowInfo[i].wLiliang;
					xytavernOfWoWInfoVo.wZhili=responseData.data.xingYunwowInfo[i].wZhili;
					xytavernOfWoWInfoVo.wNaili=responseData.data.xingYunwowInfo[i].wNaili;
					xytavernOfWoWInfoVo.wMinjie=responseData.data.xingYunwowInfo[i].wMinjie;
					xytavernOfWoWInfoVo.wWugong=responseData.data.xingYunwowInfo[i].wWugong;
					xytavernOfWoWInfoVo.wMogong=responseData.data.xingYunwowInfo[i].wMogong;
					xytavernOfWoWInfoVo.wGongsu=responseData.data.xingYunwowInfo[i].wGongsu;
					xytavernOfWoWInfoVo.wBaoji=responseData.data.xingYunwowInfo[i].wBaoji;
					xytavernOfWoWInfoVo.wWufang=responseData.data.xingYunwowInfo[i].wWufang;
					xytavernOfWoWInfoVo.wMofang=responseData.data.xingYunwowInfo[i].wMofang;
					xytavernOfWoWInfoVo.wMingzhong=responseData.data.xingYunwowInfo[i].wMingzhong;
					xytavernOfWoWInfoVo.wShanbi=responseData.data.xingYunwowInfo[i].wShanbi;
					xytavernOfWoWInfoVo.wKaobao=responseData.data.xingYunwowInfo[i].wKaobao;
					xytavernOfWoWInfoVo.wGuyongzhi=responseData.data.xingYunwowInfo[i].wGuyongzhi;
					xytavernOfWoWInfoVo.wName=responseData.data.xingYunwowInfo[i].wName;
					xytavernOfWoWInfoVo.wGuYongXingYunZhi=responseData.data.xingYunwowInfo[i].wGuYongXingYunZhi;
					xytavernOfWoWInfoVo.id=responseData.data.xingYunwowInfo[i].id;
					xytavernOfWoWInfoVo.icon=responseData.data.xingYunwowInfo[i].icon;
					xytavernOfWoWInfoVo.type=responseData.data.xingYunwowInfo[i].type;
					xytavernOfWoWInfoVo.color=responseData.data.xingYunwowInfo[i].color;
					xytavernOfWoWInfoVo.level=responseData.data.xingYunwowInfo[i].level;
					
					arr.addItem(xytavernOfWoWInfoVo);
				}
				SystemDataModel.xingYunTravernInfo.page=responseData.data.page;
				SystemDataModel.xingYunTravernInfo.zong=responseData.data.zong;
				SystemDataModel.xingYunTravernInfo.xingYunwowInfo.source=arr.toArray();
			}
		}
	}
}
