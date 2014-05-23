package sceneModule.view.GameTopUI.mediator
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.reward.reward2400.AnouInfo;
	import proto.reward.reward2400.GameTopTitleResponse;
	
	import sceneModule.view.GameTopUI.view.GameTopUI;
	import sceneModule.view.GameTopUI.vo.GameTopUIVO;
	
	import service.ISocketServer;

	public class GameTopUImediator extends Mediator
	{
		[Inject]
		public var comp:GameTopUI;
		
		[Inject]
		public var socketService:ISocketServer;
		public function GameTopUImediator()
		{
			super();
		}
		
		override public function onRegister():void{
			socketService.send(new mx.rpc.Responder(gameTopUiHandler,faultHandler),URLConst.REWARD_GAMETOP_COMMANDID,null,false);
			
//			onShift();
		}
		
		private function gameTopUiHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GameTopTitleResponse = new GameTopTitleResponse();
			responseData.readExternal(byteArray);
			var l:int = responseData.anouInfo.length;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var annouInfo:AnouInfo = responseData.anouInfo[i];
				var gameTopUIVO:GameTopUIVO = new GameTopUIVO();
				gameTopUIVO.anouType = annouInfo.anouType;
				gameTopUIVO.surplusTimes = annouInfo.surplusTimes;
				if(gameTopUIVO.anouType == 5){
					arr.addItemAt(gameTopUIVO,0);
				}else{
					arr.addItem(gameTopUIVO);
				}
				
			}
			SystemDataModel.gameTopList.source = arr.toArray();
		}
		
		private function onShift():void{
			var arr:ArrayCollection = new ArrayCollection();
			
			var gameTopUIVO1:GameTopUIVO = new GameTopUIVO();
			gameTopUIVO1.anouType = 1;
			arr.addItem(gameTopUIVO1);
			SystemDataModel.gameTopList.source = arr.toArray();
			var gameTopUIVO2:GameTopUIVO = new GameTopUIVO();
			gameTopUIVO2.anouType = 2;
			arr.addItem(gameTopUIVO2);
			SystemDataModel.gameTopList.source = arr.toArray();
			var gameTopUIVO3:GameTopUIVO = new GameTopUIVO();
			gameTopUIVO3.anouType = 3;
			arr.addItem(gameTopUIVO3);
			SystemDataModel.gameTopList.source = arr.toArray();
			var gameTopUIVO4:GameTopUIVO = new GameTopUIVO();
			gameTopUIVO4.anouType = 4;
			gameTopUIVO4.surplusTimes = 20;
			arr.addItem(gameTopUIVO4);
			SystemDataModel.gameTopList.source = arr.toArray();
			var gameTopUIVO5:GameTopUIVO = new GameTopUIVO();
			gameTopUIVO5.anouType = 5;
			gameTopUIVO5.surplusTimes = 20;
			arr.addItem(gameTopUIVO5);
			SystemDataModel.gameTopList.source = arr.toArray();
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}