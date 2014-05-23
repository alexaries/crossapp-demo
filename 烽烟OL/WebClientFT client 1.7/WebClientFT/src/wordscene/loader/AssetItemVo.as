package wordscene.loader 
{
	/**
	 * ...
	 * @author hao
	 */
	public class AssetItemVo 
	{
		private var _id:String;
		private var _path:String;
		private var _type:int;
		private var _ver:String;
		
		public function AssetItemVo() 
		{
			
		}
		
		public function readXML(xml:*):void {
			_id = xml.@id;
			_path = xml.@path;
			_type = xml.@type;
			_ver = xml.@ver;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get path():String 
		{
			return _path;
		}
		
		public function set path(value:String):void 
		{
			_path = value;
		}
		
		public function get ver():String 
		{
			return _ver;
		}
		
		public function set ver(value:String):void 
		{
			_ver = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		
		
	}

}