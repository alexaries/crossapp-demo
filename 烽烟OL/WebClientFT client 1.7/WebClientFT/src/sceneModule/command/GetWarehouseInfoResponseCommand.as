package sceneModule.command
{
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import sceneModule.event.GetWarehouseInfoResponseEvent;
	
	import model.SystemDataModel;

	/**
	 * 获取仓库信息返回Response Command 
	 * @author Yaolx
	 * 
	 */	
	public class GetWarehouseInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:GetWarehouseInfoResponseEvent;
		public function GetWarehouseInfoResponseCommand()
		{
		}
		override public function execute():void{
		      var arr:ArrayCollection = new ArrayCollection();
			  arr.source = evt.result;
			  SystemDataModel.warehouseInfo.source = arr.toArray();
		}
	}
}