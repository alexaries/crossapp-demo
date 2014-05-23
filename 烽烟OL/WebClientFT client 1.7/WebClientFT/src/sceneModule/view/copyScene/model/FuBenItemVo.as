package sceneModule.view.copyScene.model 
{
	/**
	 * ...
	 * @author hao
	 */
	public class FuBenItemVo 
	{
		private var _id:int;
		private var _bg_img_path:String;
		private var _level_stage:int;
		private var _chose_items:Array;
		public function FuBenItemVo() 
		{
			_chose_items = [];
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function get bg_img_path():String 
		{
			return _bg_img_path;
		}
		
		public function set bg_img_path(value:String):void 
		{
			_bg_img_path = value;
		}
		
		public function get chose_items():Array 
		{
			return _chose_items;
		}
		
		public function set chose_items(value:Array):void 
		{
			_chose_items = value;
		}
		
		public function get level_stage():int 
		{
			return _level_stage;
		}
		
		public function set level_stage(value:int):void 
		{
			_level_stage = value;
		}
		
	}

}