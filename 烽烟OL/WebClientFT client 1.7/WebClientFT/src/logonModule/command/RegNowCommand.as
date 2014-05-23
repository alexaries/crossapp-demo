package logonModule.command
{
	import mediator.ApplicationMediator;
	
	import org.robotlegs.mvcs.Command;
	
	import registModule.event.RegPageEvent;
	import registModule.mediator.RegPageMediator;

	/**
	 * 点击 立即注册处理 
	 * @author mutou
	 * 
	 */	
	public class RegNowCommand extends Command
	{
		public function RegNowCommand()
		{
			super();
		}
		[Inject]
		public var applicationMediator:ApplicationMediator;
		[Inject]
		public var regEvent:RegPageEvent;
		
		override public function execute():void{
			applicationMediator.onSwitchToLoginPageView(regEvent);
		}
	}
}