package managers 
{
	import mx.core.UIComponent;
	/**
	 * ...
	 * @author hao
	 */
	public class UILayerManager 
	{
		private static var _instance:UILayerManager;
		public static function getInstance():UILayerManager {
			if (null == _instance) {
				_instance = new UILayerManager();
			}
			return _instance;
		}
		
		public function UILayerManager() 
		{
			if (null != _instance) {
				throw new Error("UILayerManager should be instance");
			}
		}
		
		/////////////////////////////////////////////////////////////////
		//弹出层
		private var _alert_layer:UIComponent;
		
		public function get alert_layer():UIComponent 
		{
			return _alert_layer;
		}
		
		public function set alert_layer(value:UIComponent):void 
		{
			_alert_layer = value;
		}
		
	}

}