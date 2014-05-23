package sceneModule.view.wordmap.model 
{
	/**
	 * ...
	 * @author hao
	 */
	public class MapIconInfo 
	{
		private var _id:int;
		private var _posx:int;
		private var _posy:int;
		private var _need_lev:int;
		private var _name:String;
		private var _des:String;
		public function MapIconInfo() 
		{
		}
		
		private function setModelData():void {
			
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
			//setModelData();
		}
		
		public function get posx():int 
		{
			return _posx;
		}
		
		public function get posy():int 
		{
			return _posy;
		}
		
		public function set posx(value:int):void 
		{
			_posx = value;
		}
		
		public function set posy(value:int):void 
		{
			_posy = value;
		}
		
		public function get need_lev():int 
		{
			return _need_lev;
		}
		
		public function set need_lev(value:int):void 
		{
			_need_lev = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get des():String 
		{
			return _des;
		}
		
		public function set des(value:String):void 
		{
			_des = value;
		}
		
	}

}