package sceneModule.view.zhanxing.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
//	import proto.zhanxing.jifenginfo3609.ExchangeInfo;
	import proto.zhanxing.jifenginfo3609.GetJiFengListInfoResponse;
	
	import sceneModule.view.zhanxing.event.JiFengEvent;
	import sceneModule.view.zhanxing.vo.ExchangeInfo;

	public class GetJiFengInfoCommand extends Command
	{
		[Inject]
		public var evt:JiFengEvent;

		private static var _instance:GetJiFengInfoCommand;
		
		
		public static function getInstance():GetJiFengInfoCommand{
			if(null == _instance){
				_instance = new GetJiFengInfoCommand();
			}
			return _instance;
		}
		
		public function GetJiFengInfoCommand()
		{
			super();
		}

		override public function execute():void
		{
			var byteArray:ByteArray=evt.view as ByteArray;
			var responseData:GetJiFengListInfoResponse=new GetJiFengListInfoResponse();
			responseData.readExternal(byteArray);

			if (responseData.result && responseData.data)
			{
				var jiFengExcNUm:int=responseData.data.exchInfo.length;
				var jiFengArr:ArrayCollection=new ArrayCollection();

				for (var i:int=0; i <jiFengExcNUm ; i++)
				{
					var exC:ExchangeInfo=new ExchangeInfo();
					exC.xingYun.icon=responseData.data.exchInfo[i].xingYun.icon;
					exC.xingYun.type=responseData.data.exchInfo[i].xingYun.type;
					exC.xingYun.xyName=responseData.data.exchInfo[i].xingYun.xyName;
					exC.xingYun.xyDes=responseData.data.exchInfo[i].xingYun.xyDes;
					exC.jifengValue=responseData.data.exchInfo[i].jifengValue;
					exC.xingYun.quality=responseData.data.exchInfo[i].xingYun.quality;
					exC.xingYun.xyId=responseData.data.exchInfo[i].xingYun.xyId;
					exC.xingYun.xytemId=responseData.data.exchInfo[i].xingYun.xytemId;
					jiFengArr.addItem(exC);
				}
				SystemDataModel.jifengInfo.exchInfo.source=jiFengArr.toArray();
				SystemDataModel.jifengInfo.curpage=responseData.data.curpage;
				SystemDataModel.jifengInfo.totalpage=responseData.data.totalpage;
				SystemDataModel.jifengInfo.jiFengTotal=responseData.data.jiFengTotal;
			}
		}
		
		
	}
}
