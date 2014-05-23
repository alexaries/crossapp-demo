package sceneModule.view.prompted.mediator
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.chat.event.ChatToObjectListEvent;
	import sceneModule.view.chat.event.MainOpenWhisperWindowEvent;
	import sceneModule.view.prompted.view.PromptedComponent;
	
	import service.ISocketServer;

	public class PromptedComponentMediator extends Mediator
	{
		[Inject]
		public var comp:PromptedComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var sockectService:ISocketServer;
		public function PromptedComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this._eventDispatcher.addEventListener(ChatToObjectListEvent.CHATTOOBJECTLISTEVENT,onChatListChange);
			
			this.eventMap.mapListener(comp.ppImg,MouseEvent.CLICK,onPpImgClick);
		}
		
		private function onChatListChange(evt:ChatToObjectListEvent):void{
			comp.onSetPromptedInfo();
		}
		
		private function onPpImgClick(evt:MouseEvent):void{
			this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,comp.curPromptedInfo.chatObjectId,comp.curPromptedInfo.name));
		}
	}
}