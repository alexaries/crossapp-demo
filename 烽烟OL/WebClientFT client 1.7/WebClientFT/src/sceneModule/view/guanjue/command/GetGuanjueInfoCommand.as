package sceneModule.view.guanjue.command
{
	import flash.utils.ByteArray;

	import model.SystemDataModel;

	import mx.collections.ArrayCollection;

	import org.robotlegs.mvcs.Command;

	import proto.guanjue.guanjue3300.GetGuanJueInfoResponse;
	import proto.guanjue.guanjue3300.GuanJueInfo;

	import sceneModule.view.guanjue.event.GuanjueEvent;

	import util.xtrace;



	public class GetGuanjueInfoCommand extends Command
	{
		[Inject]
		public var evt:GuanjueEvent;


		public function GetGuanjueInfoCommand()
		{
			super();
		}

		override public function execute():void
		{
			var byteArray:ByteArray=evt._obj as ByteArray;
			var responseData:GetGuanJueInfoResponse=new GetGuanJueInfoResponse();
			responseData.readExternal(byteArray);

			if (responseData.result && responseData.data)
			{
				var currShuxingNum:int=responseData.data.adddq.length;
				var xiajiShuxingNum:int=responseData.data.addxj.length;
				var fengjueshiTimeNum:int=responseData.data.ftime.length;
				var fengjueshiContentNum:int=responseData.data.fcontext.length;

				var currShuxingArr:ArrayCollection=new ArrayCollection();
				var xiajiShuxingArr:ArrayCollection=new ArrayCollection();
				var fengjueshiTimeArr:ArrayCollection=new ArrayCollection();
				var fengjueshiContentArr:ArrayCollection=new ArrayCollection();

				SystemDataModel.guanJueInfo.currentJuewei=responseData.data.currentJuewei;
				SystemDataModel.guanJueInfo.weiwang=responseData.data.weiwang;
				SystemDataModel.guanJueInfo.currentJinbi=responseData.data.currentJinbi;
				SystemDataModel.guanJueInfo.currentDouqi=responseData.data.currentDouqi;
				SystemDataModel.guanJueInfo.nextJuewei=responseData.data.nextJuewei;
				SystemDataModel.guanJueInfo.nextWeiwang=responseData.data.nextWeiwang;
				SystemDataModel.guanJueInfo.nextJinbi=responseData.data.nextJinbi;
				SystemDataModel.guanJueInfo.nextDouqi=responseData.data.nextDouqi;
				SystemDataModel.guanJueInfo.isjw=responseData.data.isjw;
				SystemDataModel.guanJueInfo.hasGetSalary=responseData.data.hasGetSalary;
				SystemDataModel.guanJueInfo.level=responseData.data.level;
				SystemDataModel.guanJueInfo.curpage=responseData.data.curpage;
				SystemDataModel.guanJueInfo.totalpage=responseData.data.totalpage;

				//当前属性增加列表

				for (var i:int=0; i < currShuxingNum; i++)
				{
					currShuxingArr.addItem(responseData.data.adddq[i]);
				}

				//下级属性增加列表
				for (var j:int=0; j < xiajiShuxingNum; j++)
				{
					xiajiShuxingArr.addItem(responseData.data.addxj[j]);
				}

				//封爵史时间
				var str:String
				for (var m:int=0; m < fengjueshiTimeNum; m++)
				{
					SystemDataModel.guanJueInfo.tempStr+=responseData.data.ftime[m].toString() + "\n\t" + responseData.data.fcontext[m]+"\n\n\n\n";
				}
//				trace("SystemDataModel.guanJueInfo.tempStr:" + SystemDataModel.guanJueInfo.tempStr);

				SystemDataModel.guanJueInfo.adddq.source=currShuxingArr.toArray(); //当前属性
				SystemDataModel.guanJueInfo.addxj.source=xiajiShuxingArr.toArray(); //下级属性
			}
		}
	}
}
