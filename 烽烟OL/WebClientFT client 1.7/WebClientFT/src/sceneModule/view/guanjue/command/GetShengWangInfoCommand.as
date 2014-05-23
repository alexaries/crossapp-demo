package sceneModule.view.guanjue.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.guanjue.guanjue3303.GetWeiWangInfoResponse;
	import proto.guanjue.guanjue3303.Wupin;
	
	import sceneModule.view.guanjue.event.ShengWangEvent;
	import sceneModule.view.guanjue.event.ShengWangItemRenderEvent;



	public class GetShengWangInfoCommand extends Command
	{
		[Inject]
		public var evt:ShengWangEvent;

		public function GetShengWangInfoCommand()
		{
			super();
		}

		override public function execute():void
		{
			var byteArray:ByteArray=evt.view as ByteArray;
			var responseData:GetWeiWangInfoResponse=new GetWeiWangInfoResponse();
			responseData.readExternal(byteArray);

			if (responseData.result && responseData.data)
			{
				var weiWangWpNUm:int=responseData.data.wp.length;
				var weiWangWpArr:ArrayCollection=new ArrayCollection();

				for (var i:int=0; i < weiWangWpNUm; i++)
				{
					var wpinfo:Wupin=responseData.data.wp[i];
					var wp:Wupin=new Wupin();
					wp.wy=wpinfo.wy;
					wp.id=wpinfo.id;
					wp.name=wpinfo.name;
					wp.count=wpinfo.count;
					wp.weiwang=wpinfo.weiwang;
					wp.adddq=wpinfo.adddq;
					wp.addzuan=wpinfo.addzuan;
					weiWangWpArr.addItem(wp);
				}
				SystemDataModel.shengWangInfo.wp.source=weiWangWpArr.toArray();

			}
		}
	}
}
