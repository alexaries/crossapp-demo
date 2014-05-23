package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 存款和取款事件 
	 * @author Yaolx
	 * 
	 */	
	public class DepositAndGetMoneyEvent extends Event
	{
		public static const DEPOSITANDGETMONEYEVENT:String = "depositAndGetMoneyEvent";
		public var typeChange:int;//1存款 2取款
		public var count:int;
		public function DepositAndGetMoneyEvent(typeEvent:String,t:int,c:int)
		{
			this.typeChange = t;
			this.count = c;
			super(typeEvent);
		}
	}
}