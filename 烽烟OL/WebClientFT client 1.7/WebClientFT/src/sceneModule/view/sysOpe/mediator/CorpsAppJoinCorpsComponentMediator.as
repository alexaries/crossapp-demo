package sceneModule.view.sysOpe.mediator
{
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1304.AcceptOrRefuseAppliRequest;
	
	import sceneModule.view.sysOpe.view.CorpsAppJoinCorpsComponent;
	
	import service.ISocketServer;

	public class CorpsAppJoinCorpsComponentMediator extends Mediator
	{
		[Inject]
		public var comp:CorpsAppJoinCorpsComponent;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function CorpsAppJoinCorpsComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.canBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.mapListener(comp.subBtn,MouseEvent.CLICK,onSubClick);
			this.eventMap.mapListener(comp.iTextArea,TextEvent.LINK,onTextLink);
		}
		
		private var linkType:int;//临时超链接类型
		private var sendId:int;//临时相应的超链接所需的id
		private var tempName:String;//临时的超链接名称
		private var tempItemId:int;
		private function onTextLink(evt:TextEvent):void{
			var tempP:Array;
			if(evt.text.indexOf("?")>=0){
				tempP = evt.text.split("?");
				if(tempP.length == 3){
					sendId = tempP[0];
					linkType = tempP[1];
					tempName = tempP[2];
					switch(linkType){
						case 1:
							//弹出装备menu
//							trace("超链接----------------");
							break;
					}
				}else{
//					popUpShow.show("参数个数报错!!!");
				}
			}else{
//				popUpShow.show("Error chatLink");
			}
		}
		
		private function onSubClick(evt:MouseEvent):void{
			onAcceptAndRe(0,comp.curObj.roleId);
			onCloseWindow();
			
		}
		
		private function onCancel(evt:MouseEvent = null):void{
			onAcceptAndRe(1,comp.curObj.roleId);
			onCloseWindow();
		}
		
		/**
		 *  
		 * @param type 0接受1拒绝
		 * @param roleId 申请者id
		 * 
		 */		
		private function onAcceptAndRe(type:int,roleId:int):void{
			var arReq:AcceptOrRefuseAppliRequest = new AcceptOrRefuseAppliRequest();
			arReq.id = SystemDataModel.roleId;
			arReq.appliId = roleId;
			arReq.operType = type;
			var byteArray:ByteArray = new ByteArray();
			arReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(canHandler,faultHandler),URLConst.CORPS_ACCEPTORREFUSE_COMMANDID,byteArray);
		
		}
		
		private function canHandler(data:Object):void{
			
		}
		
		private function onCloseWindow():void{
			comp.parent.removeChild(comp);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}