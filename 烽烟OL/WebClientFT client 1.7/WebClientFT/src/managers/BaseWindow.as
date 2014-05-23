package managers
{
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	
	import spark.components.TitleWindow;
	import style.Skin_CrotaBaseTitleWindow;
	
	
	/**
	 * Base window for all popup window.
	 * 配合WindowManager使用。
	 * 
	 * BaseWindow默认添加了CreationComplete和Close事件的监听。
	 * init方法监听CreationComplete事件。
	 * onClose方法监听Close事件。
	 * 
	 * BaseWindow使用data变量作为显示初始化参数。
	 * onShow方法监听DataChange事件。
	 * 在BaseWindow每次被显示时，onShow方法都保证会被调用。
	 * 可以在onShow做每次被显示时的初始化操作，data用于传递初始化参数。
	 * 
	 */
	public class BaseWindow extends spark.components.TitleWindow
	{
		/**
		 * BaseWindow的类名，必须包含完整的包名。
		 * 用于获取Class对象，再由Class对象创建窗口实例。
		 * 每个子类都必须定义这个常量。
		 */ 
		public static const NAME:String = "managers.BaseWindow";
		
		/**
		 * 窗口被创建后，会将NAME传递给此变量。
		 * 请不要在除WindowManager以外的地方对此变量赋值。
		 */ 
		public var windowClassName:String;
		
		/**
		 * 窗口缓存类型，决定窗口被关闭后是否在系统中缓存窗口的实例。
		 * WindowManager的closeWindow方法的cachePolicy参数比此参数优先。
		 */ 
		public var windowCachePolicy:String = WindowManager.CACHE_POLICY_CACHE;
		
		/**
		 * 是否存在子窗口。
		 * 此参数用于优化WindowManager的部分运算，并不能真正作为是否有子窗口的依据。
		 */ 
		public var hasChildren:Boolean = false;
		
		/**
		 * 窗口是否固定位置（固定位置的意思是不可拖动）。
		 * 窗口的不可拖动，通过修改isPopUp参数来实现。
		 */ 
		private var _docked:Boolean = false;
		
		/**
		 * 父窗口的类名。null或""表示无父窗口。
		 */ 
		public var parentName:String = "";
		
		/**
		 * Constructor.
		 * 添加了creationComplete和close时间的监听。
		 */
		
		private var _data:Object;
		
		public function BaseWindow()
		{
			addEventListener(FlexEvent.CREATION_COMPLETE, onInitHandler, false, 0, true);
			addEventListener(CloseEvent.CLOSE, onCloseHandler, false, 0, true);
			
//			var filter:BitmapFilter = getBitmapFilter();
//			var myFilters:Array = new Array();
//			myFilters.push(filter);
//			filters = myFilters;
			
			this.setStyle('skinClass',Class(Skin_CrotaBaseTitleWindow));
			
		}
		
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var angle:Number = 45;
			var alpha:Number = 0.8;
			var blurX:Number = 8;
			var blurY:Number = 8;
			var distance:Number = 8;
			var strength:Number = 0.65;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.LOW;
			return new DropShadowFilter(distance,
				angle,
				color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
		}

		
		/**
		 * 窗口的初始化方法。监听窗口的creationComplete事件。
		 * 此方法中添加了dataChange事件的监听，并模拟了一次dataChange事件。
		 * 
		 * @param event 事件引用，实现中不建议使用此实例。
		 */
		private function onInitHandler(event:FlexEvent):void
		{
			addEventListener(FlexEvent.DATA_CHANGE, onDataChangeHandler, false, 0, true);
			onInit();
			onShow();
		}
		
		/**
		 * 此方法作为dataChange事件的监听器。
		 * 
		 * 在CreateComplete事件的响应中，添加了这个方法的监听。
		 * 所以在CreateComplete事件派发之前，对data进行赋值不会调用到这个方法。
		 * 
		 * @param event 事件引用，实现中不建议使用此实例。
		 */ 
		private function onDataChangeHandler(event:FlexEvent):void
		{
			onShow();
		}
		
		private function onCloseHandler(event:CloseEvent):void
		{
			close();
		}
		
		/**
		 * 窗口的初始化方法。监听窗口的creationComplete事件。
		 * 此方法中添加了dataChange事件的监听，并模拟了一次dataChange事件。
		 * 
		 * 子类如果override此方法，必须在方法中调用super.init(event);
		 * 
		 * @param event 事件引用，实现中不建议使用此实例。
		 */
		protected function onInit():void
		{
			
		}
		
		/**
		 * 窗口每次被WindowManager弹出时会被调用。
		 * 
		 * 在窗口第一次被实例化并显示时，此方法被createComplete事件的监听方法调用。
		 * 之后，此方法被dataChange事件的监听方法调用。
		 * 
		 * 子类如果需要在窗口每次被显示时，做初始化，请override此方法。
		 * 
		 * data变量用于传递初始化变量。
		 * WindowManager的createWindow方法中，initData参数会在每次onShow被调用前传递给data变量。
		 * 可以在此方法中检测data变量获取初始化参数。
		 * data变量的具体使用方式，由子类自行决定。
		 * 
		 */ 
		protected function onShow():void
		{
			
		}
		
		
		/**
		 * 窗口关闭时，此方法会被调用。
		 * 
		 * 在此方法中释放占资源较大的内容，去除数据监听等。
		 * 
		 */
		public function onClose():void 
		{
			
		}
		
		/**
		 * 调用此方法关闭当前窗口。
		 */
		final public function close():void 
		{
			WindowManager.closeWindow(windowClassName);
		}
		
		/**
		 * @get
		 * 
		 */
		public function get docked():Boolean 
		{
			return _docked;
		}
		
		
		/**
		 * @set
		 * 
		 */
		public function set docked(value:Boolean):void 
		{
			// 窗口的不可拖动，通过修改isPopUp参数来实现。
			isPopUp = !(_docked = value);
		}
		
		public function set data(value:Object):void{
			this._data = value;
		}
		
		public function get data():Object{
			return this._data;
		}
		
	}
}