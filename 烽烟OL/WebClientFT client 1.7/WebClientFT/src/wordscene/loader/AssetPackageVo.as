package wordscene.loader 
{
	/**
	 * ...
	 * @author hao
	 */
	public class AssetPackageVo 
	{
		private var _id:String;
		private var _path:String;
		private var _assetItems:Array;
		
		public function AssetPackageVo() 
		{
			
		}
		
		public function addItems(xml:*, ids:Array):void {
			_assetItems = [];
			
			_id = xml.@id;
			_path = xml.@path;
			
			for each (var item:String in ids) 
			{
				var itemXML:* = xml.asset.(@id == item);
				
				var i:AssetItemVo = new AssetItemVo();
				i.readXML(itemXML);
				
				i.id = _id + SAssetManager.GAP_CHAR + i.id;
				i.path = _path + i.path;
				
				_assetItems.push(i);
			}
		}
		
		
		public function readXML(xml:*):void {
			_assetItems = [];
			
			_id = xml.@id;
			_path = xml.@path;
			
			for each (var item:XML in xml.asset) 
			{
				var i:AssetItemVo = new AssetItemVo();
				i.readXML(item);
				
				i.id = _id + SAssetManager.GAP_CHAR + i.id;
				i.path = _path + i.path;
				
				_assetItems.push(i);
			}
		}
		
		public function get assetItems():Array 
		{
			return _assetItems;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set path(value:String):void 
		{
			_path = value;
		}
		
	}

}