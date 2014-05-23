package resource 
{
	import util.HashMap;
	/**
	 * ...
	 * @author hao
	 */
	public class AssetPackage 
	{
		private var _id:String;
		private var _imgs:HashMap;
		public function AssetPackage() 
		{
			_imgs = new HashMap();
		}
		
		public function get imgs():HashMap 
		{
			return _imgs;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
	}

}