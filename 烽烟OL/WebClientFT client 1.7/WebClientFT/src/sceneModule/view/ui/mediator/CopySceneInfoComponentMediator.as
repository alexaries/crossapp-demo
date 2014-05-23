package sceneModule.view.ui.mediator
{
	import flash.events.TextEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.friend.event.NFriendEvent;
	import sceneModule.view.ui.CopySceneInfoComponent;
	
	import service.ISocketServer;

	public class CopySceneInfoComponentMediator extends Mediator
	{
		[Inject]
		public var comp:CopySceneInfoComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		public function CopySceneInfoComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
		    this.eventMap.mapListener(comp.profession,TextEvent.LINK,onTextLink);
			this.eventMap.mapListener(comp.profession0,TextEvent.LINK,onTextLink);
		}
		
		
		private function onTextLink(evt:TextEvent):void{
			var tempP:Array;
			if(evt.text.indexOf("?")>=0){
				tempP = evt.text.split("?");
				if(tempP.length == 2){
					viewInfo(tempP[0],tempP[1]);
				}
			}
		}
		private function viewInfo(i_d:int,type:int):void{
			if(i_d == 0)return;
			if(type == 1){
				//查看资料
				this.dispatch(new NFriendEvent(NFriendEvent.NFriendEvent_LOOK_INFO,i_d,true));
				NCropMessage.getInstance().request_see_other(i_d);
			}else{
				NCropMessage.getInstance().request_single_union_info(i_d);
			}
		}
	}
}