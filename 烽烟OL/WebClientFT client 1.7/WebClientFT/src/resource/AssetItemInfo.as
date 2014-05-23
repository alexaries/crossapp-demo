package resource 
{
	/**
	 * ...
	 * @author hao
	 */
	public class AssetItemInfo 
	{
		public static const AssetItemInfo_TYPE_IMG:int = 0;
		public static const AssetItemInfo_TYPE_SWF:int = 1;
		
		private var _id:String;
		private var _path:String;
		private var _package_id:String;
		private var _type:int;
		public function AssetItemInfo() 
		{
			_type = 0;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function get path():String 
		{
			return _path;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function set path(value:String):void 
		{
			_path = value;
		}
		
		public function get package_id():String 
		{
			return _package_id;
		}
		
		public function set package_id(value:String):void 
		{
			_package_id = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
	}

}