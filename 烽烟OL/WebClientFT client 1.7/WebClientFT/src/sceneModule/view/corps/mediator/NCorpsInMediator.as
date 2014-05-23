package sceneModule.view.corps.mediator
{
	import model.SystemDataModel;
	import org.robotlegs.mvcs.Mediator;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.corps.view.NCropsInView;
	import service.ISocketServer;
	import util.xtrace;
	public class NCorpsInMediator extends Mediator
	{
		[Inject]
		public var socketService:ISocketServer;
		[Inject]
		public var comp:NCropsInView;
		
		
		
		public function NCorpsInMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventDispatcher.addEventListener(NCropsEvent.EVENT_Crops_VIEW_IN_REFRESH, refresh);
			init_view();
		}
		
		private function init_view():void {
			
		}
		
		private function refresh(e:NCropsEvent):void {
			
		}
	}
}