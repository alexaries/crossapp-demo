package sceneModule.view.tavern.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.tavern.tavern3500.GetTavernTaskInfoResponse;
	import proto.tavern.tavern3500.Schedule;
	
	import sceneModule.view.tavern.event.WOWEvent;
	import sceneModule.view.tavern.vo.TavernWoWInfo;

	public class GetWowInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:WOWEvent;

		public function GetWowInfoResponseCommand()
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
				var l:int=responseData.data.wowInfo.length;
				var fslen:int=responseData.data.fashiPet.length;
				var zslen:int=responseData.data.zhanshiPet.length;
				var yxlen:int=responseData.data.youxiaPet.length;

				var fsArr:ArrayCollection=new ArrayCollection();
				var zsArr:ArrayCollection=new ArrayCollection();
				var yxArr:ArrayCollection=new ArrayCollection();

				var arr:ArrayCollection=new ArrayCollection();
				
				for (var i:int=0; i < l; i++)
				{
					var taverWowinfo:TavernWoWInfo=new TavernWoWInfo();
					
					taverWowinfo.wSkill=responseData.data.wowInfo[i].wSkill;
					taverWowinfo.wTexing=responseData.data.wowInfo[i].wTexing;
					taverWowinfo.wLiliang=responseData.data.wowInfo[i].wLiliang;
					taverWowinfo.wZhili=responseData.data.wowInfo[i].wZhili;
					taverWowinfo.wNaili=responseData.data.wowInfo[i].wNaili;
					taverWowinfo.wMinjie=responseData.data.wowInfo[i].wMinjie;
					taverWowinfo.wWugong=responseData.data.wowInfo[i].wWugong;
					taverWowinfo.wMogong=responseData.data.wowInfo[i].wMogong;
					taverWowinfo.wGongsu=responseData.data.wowInfo[i].wGongsu;
					taverWowinfo.wBaoji=responseData.data.wowInfo[i].wBaoji;
					taverWowinfo.wWufang=responseData.data.wowInfo[i].wWufang;
					taverWowinfo.wMofang=responseData.data.wowInfo[i].wMofang;
					taverWowinfo.wMingzhong=responseData.data.wowInfo[i].wMingzhong;
					taverWowinfo.wShanbi=responseData.data.wowInfo[i].wShanbi;
					taverWowinfo.wKaobao=responseData.data.wowInfo[i].wKaobao;
					taverWowinfo.wGuyongzhi=responseData.data.wowInfo[i].wGuyongzhi;
					taverWowinfo.wName=responseData.data.wowInfo[i].wName;
					taverWowinfo.wGuYongJinBi=responseData.data.wowInfo[i].wGuYongJinBi;
					taverWowinfo.id=responseData.data.wowInfo[i].id;
					taverWowinfo.icon=responseData.data.wowInfo[i].icon;
					taverWowinfo.type=responseData.data.wowInfo[i].type;
					taverWowinfo.color=responseData.data.wowInfo[i].color;
					taverWowinfo.level=responseData.data.wowInfo[i].level;
					taverWowinfo.wGuYongXingYunZhi=responseData.data.wowInfo[i].wGuYongXingYunZhi;
					arr.addItem(taverWowinfo);
				}

				for (var j:int=0; j < fslen; j++)
				{
					var fsInfo:Schedule=responseData.data.fashiPet[j];
					var fs:Schedule=new Schedule();
					fs.type=fsInfo.type;
					fs.icon=fsInfo.icon;
					fs.Skill=fsInfo.Skill;
					fs.Texing=fsInfo.Texing;
					fs.Liliang=fsInfo.Liliang;
					fs.Naili=fsInfo.Naili;
					fs.Zhili=fsInfo.Zhili;
					fs.Minjie=fsInfo.Minjie;
					fs.Dengji=fsInfo.Dengji;
					fs.Hp=fsInfo.Hp;
					fs.Name=fsInfo.Name;
					fsArr.addItem(fs);
				}

				for (var m:int=0; m < zslen; m++)
				{
					var zsInfo:Schedule=responseData.data.zhanshiPet[m];
					var zs:Schedule=new Schedule();
					zs.type=zsInfo.type;
					zs.icon=zsInfo.icon;
					zs.Skill=zsInfo.Skill;
					zs.Texing=zsInfo.Texing;
					zs.Liliang=zsInfo.Liliang;
					zs.Naili=zsInfo.Naili;
					zs.Zhili=zsInfo.Zhili;
					zs.Minjie=zsInfo.Minjie;
					zs.Dengji=zsInfo.Dengji;
					zs.Hp=zsInfo.Hp;
					zs.Name=zsInfo.Name;
					zsArr.addItem(zs);
				}

				for (var n:int=0; n < yxlen; n++)
				{
					var yxInfo:Schedule=responseData.data.youxiaPet[n];
					var yx:Schedule=new Schedule();
					yx.type=yxInfo.type;
					yx.icon=yxInfo.icon;
					yx.Skill=yxInfo.Skill;
					yx.Texing=yxInfo.Texing;
					yx.Liliang=yxInfo.Liliang;
					yx.Naili=yxInfo.Naili;
					yx.Zhili=yxInfo.Zhili;
					yx.Minjie=yxInfo.Minjie;
					yx.Dengji=yxInfo.Dengji;
					yx.Hp=yxInfo.Hp;
					yx.Name=yxInfo.Name;
					yxArr.addItem(yx);
				}
				SystemDataModel.wow.refreshTime=responseData.data.refreshTime
				SystemDataModel.wow.xingyunzhi=responseData.data.xingyunzhi
				SystemDataModel.wow.shengYuCiShu=responseData.data.shengYuCiShu

				SystemDataModel.wow.wowInfo.source=arr.toArray();
				SystemDataModel.wow.fashiPet.source=fsArr.toArray();
				SystemDataModel.wow.zhanshiPet.source=zsArr.toArray();
				SystemDataModel.wow.youxiaPet.source=yxArr.toArray();

			}
		}
	}
}
