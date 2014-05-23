package sceneModule.view.task.mediator
{
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.task.view.MainTaskComponent;
	
	import service.ISocketServer;
	import service.SocketService;

	public class MainTaskComponentMediator extends Mediator
	{
		[Inject]
		public var comp:MainTaskComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		
		public function MainTaskComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mediatorMap.createMediator(comp.npc_task_view);
		}
	}
}