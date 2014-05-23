package sceneModule.view.corps.mediator
{
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1302.CreateCorpsRequest;
	import proto.corps.corps1302.CreateCorpsResponse;
	
	import sceneModule.view.corps.view.CreateCorpsComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.systemInfo.event.SystemInfoEvent;
	
	import service.ISocketServer;

	/**
	 * 创建军团mediator 
	 * @author Dream-Y
	 * 
	 */	
	public class CreateCorpsComponentMediator extends Mediator
	{
		[Inject]
		public var comp:CreateCorpsComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function CreateCorpsComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.createBtn,MouseEvent.CLICK,onCreateCorps);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.mapListener(comp.clokeBtn,MouseEvent.CLICK,onCancel);
		}
		
		/**
		 * 创建军团 
		 */		
		private function onCreateCorps(evt:MouseEvent):void{
			var createCorpsRequest:CreateCorpsRequest = new CreateCorpsRequest();
			createCorpsRequest.id = SystemDataModel.roleId;
			createCorpsRequest.corpsName = comp.corpsName.text;
			var byteArray:ByteArray = new ByteArray();
			createCorpsRequest.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(createCorpsHandler,faultHandler),URLConst.CORPS_CREATE_COMMANDID,byteArray);
			closeWinAndRemoveListener();
		}
		private function createCorpsHandler(data:Object):void{
			var resByteArray:ByteArray = data as ByteArray;
			var responseData:CreateCorpsResponse = new CreateCorpsResponse();
			responseData.readExternal(resByteArray);
			if(!responseData.result){
				popUpShow.show(responseData.message);
			}
			if(responseData.message){
				this.dispatch(new SystemInfoEvent(SystemInfoEvent.SYSTEMINFOEVENT,responseData.message));
			}
//			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE,GuideInfo.ACTION_CREATE_UNION_OK));
		}
		/**
		 * 取消创建军团和关闭
		 */
		private function onCancel(evt:MouseEvent):void{
			closeWinAndRemoveListener();
		}
		/**
		 * 关闭窗口移除事件监听 
		 */		
		private function closeWinAndRemoveListener():void{
			this.eventMap.unmapListener(comp.createBtn,MouseEvent.CLICK,onCreateCorps);
			this.eventMap.unmapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.unmapListener(comp.clokeBtn,MouseEvent.CLICK,onCancel);
			WindowManager.closeWindow(CreateCorpsComponent.NAME,false,false,null,popUpWindowLayer);
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}