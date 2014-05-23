package sceneModule.view.zhanyi.model 
{
	import proto.zhanyi.GetNowZhanYiInfo4500.ZhangJieInfo;
	import proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiResponseData;
	/**
	 * ...
	 * @author hao
	 */
	public class ZhanyiModel 
	{
		private static var _instance:ZhanyiModel;
		public static function getInstance():ZhanyiModel {
			if (null == _instance) {
				_instance = new ZhanyiModel();
			}
			return _instance;
		}
		public function ZhanyiModel() 
		{
			
		}
		
		private var _curindex:int;
		private var _maxindex:int;
		private var _sdata:ZhanyiResponseData;
		
		public function getZhangejieInfo(id:int):ZhangJieInfo {
			var len:int = _sdata.zhangjielist.length;
			for (var i:int = 0; i < len; i++) 
			{
				var cur:ZhangJieInfo = _sdata.zhangjielist[i] as ZhangJieInfo;
				if (cur.zhangjieid == id) {
					return cur;
				}
			}
			return null;
		}
		
		public function get curindex():int 
		{
			return _curindex;
		}
		
		public function set curindex(value:int):void 
		{
			_curindex = value;
		}
		
		public function get maxindex():int 
		{
			return _maxindex;
		}
		
		public function set maxindex(value:int):void 
		{
			_maxindex = value;
		}
		
		public function get sdata():ZhanyiResponseData 
		{
			return _sdata;
		}
		
		public function set sdata(value:ZhanyiResponseData):void 
		{
			_sdata = value;
			_maxindex = value.maxpage;
		}
		
	}

}