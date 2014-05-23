package sceneModule.view.pet.event
{
	import flash.events.Event;

	public class MediatorRegisterPetEvent extends Event
	{
		public static const MR_PET_COMP:String = "mr_pet_comp";
		public static const MR_PET_INFO:String = "mr_pet_info";
		public static const MR_PET_MATRIX:String = "mr_pet_matirx";
		public static const MR_PET_ITEMRENDER:String = "mr_pet_itemRender";
		public static const MR_PET_MATRIXITEMRENDER:String = "mr_pet_matrixitemRender";
		public static const MR_PET_SKILLITEMRENDER:String = "mr_pet_skillItemRender";
		
		public var view:Object;
		public function MediatorRegisterPetEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterPetEvent(type, view, bubbles, cancelable);
		}
	}
}