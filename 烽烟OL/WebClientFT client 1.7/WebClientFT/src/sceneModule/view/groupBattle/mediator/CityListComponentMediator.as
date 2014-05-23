package sceneModule.view.groupBattle.mediator
{
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.groupBattle.view.CityListComponent;

	public class CityListComponentMediator extends Mediator
	{
		[Inject]
		public var comp:CityListComponent;
		public function CityListComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
		}
	}
}