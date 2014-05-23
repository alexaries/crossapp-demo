package sceneModule.view.pray.command
{
	import flash.utils.ByteArray;
	import model.SystemDataModel;
	import org.robotlegs.mvcs.Command;
	import proto.qidao.qidao4100.GetPrayInfoResponse;
	import sceneModule.view.pray.event.PrayEvent;

	public class GetPrayInfoCommand extends Command
	{
		[Inject]
		public var evt:PrayEvent;


		public function GetPrayInfoCommand()
		{
			super();
		}

		override public function execute():void
		{
			var byteArray:ByteArray=evt._obj as ByteArray;
			var responseData:GetPrayInfoResponse=new GetPrayInfoResponse();
			responseData.readExternal(byteArray);

			if (responseData.result)
			{

				SystemDataModel.prayInfoVo.needDiamond=responseData.needDiamond;
				SystemDataModel.prayInfoVo.prayDes=responseData.prayDes;
				SystemDataModel.prayInfoVo.remainTimes=responseData.remainTimes;
				
				var otherPrayStrNum:int=responseData.otherPrayMsg.length;
				//其他玩家祈祷信息
				var str:String
				for (var m:int=0; m < otherPrayStrNum; m++)
				{
					SystemDataModel.prayInfoVo.tempStr+= "\n\n"+responseData.otherPrayMsg[m]+"\n\n";
				}
				
//				if(SystemDataModel.prayInfoVo.otherPrayMsg.length>1)
//				{
//					SystemDataModel.prayInfoVo.tempStr="";
//				}
			}
		}
	}
}
