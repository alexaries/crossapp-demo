package sceneModule.view.buff.mediator
{
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.buff.view.BuffComponentItemRender;
	
	import service.ISocketServer;

	public class BuffComponentItemRenderMeidator extends Mediator
	{
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var comp:BuffComponentItemRender;
		public function BuffComponentItemRenderMeidator()
		{
			super();
		}
		
		override public function onRegister():void{
			
		}
	}
}