package sceneModule.view.groupBattle.mediator
{
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.groupBattle.view.XuYuanComponent;

	public class XuYuanComponentMediator extends Mediator
	{
		[Inject]
		public var comp:XuYuanComponent;
		public function XuYuanComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
		}
	}
}