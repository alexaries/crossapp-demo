package model 
{
	/**
	 * ...
	 * @author hao
	 */
	public class GuideClearItem 
	{
		private var _type:int;
		private var _target_id:int;
		public function GuideClearItem() 
		{
			
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
		public function get target_id():int 
		{
			return _target_id;
		}
		
		public function set target_id(value:int):void 
		{
			_target_id = value;
		}
		
	}

}