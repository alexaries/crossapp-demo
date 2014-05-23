package sceneModule.view.ui.mediator
{
	import org.robotlegs.mvcs.Mediator;
	import util.xtrace;
	
	public class NUIProgressBarMediator extends Mediator
	{
		
		
		public function NUIProgressBarMediator()
		{
			super();
		}
		override public function onRegister():void{
			xtrace("init progress bar");
		}
		
		override public function preRemove():void {
			
		}
		
	}
}