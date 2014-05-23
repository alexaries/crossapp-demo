package Animation
{
	import flash.events.Event;

	public class CreateRoleMovieNextStopEvent extends Event
	{
		public static const CREATEROLEMOVIENEXTSTOP:String="createRoleMovieNextStop";
		public function CreateRoleMovieNextStopEvent(typeEvent:String)
		{
			super(typeEvent);
		}
	}
}