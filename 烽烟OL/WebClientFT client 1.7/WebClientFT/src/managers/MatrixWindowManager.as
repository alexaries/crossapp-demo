package managers
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import mediator.TaskGuideMediator;
	import model.GuideInfo;
	import util.DelayExcuter;
	
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import mx.core.IVisualElement;
	
	import org.robotlegs.core.IMediatorMap;
	
	import sceneModule.view.mainMenu.view.MainMenuComponent;

	public class MatrixWindowManager
	{
		/**
		 * 窗口缓存，<windowClassName, window>。以窗口的类名为key，保存已创建的窗口。
		 */ 
		private static var windowsCache:Dictionary;
		
		/**
		 * 当前显示的窗口
		 */
		private static var curShowWindowArr:Array;
		
		/**
		 * 当前显示窗口缓存
		 */
		private static var curWindowCache:Dictionary;
		public function MatrixWindowManager()
		{
			throw new Error("This class is a static class");
		}
		
		public static function createAndCloseMatrixWindow(windowClassName:String,initData:Object=null,mediatorMapInstance:IMediatorMap=null,parentDisplayObject:PopUpWindowLayer = null):Boolean{
			if(!windowsCache){
				windowsCache = new Dictionary();
			}
			
			if(!curShowWindowArr){
				curShowWindowArr = new Array();
			}
			
			if(!curWindowCache){
				curWindowCache = new Dictionary();
			}
			var window:DisplayObject = getWindow(windowClassName);
			if(window == null){
				var windowClass:Class = getDefinitionByName(windowClassName) as Class;
				// 检查是否成功获得windowClass
				if (windowClass == null)
				{
					throw new ArgumentError(windowClassName + " is not a Class!");
				}
				
				window = new windowClass() as DisplayObject;
				// 检查window是否BaseWindow子类
				if (window == null)
				{
					throw new ArgumentError(windowClassName + " is not sub class of BaseWindow!");
				}
				
				// window创建成功，放入窗口缓存
				windowsCache[windowClassName] = window;
			}
			
			if(curShowWindowArr.length == 1){
				//说明当前已经存在窗口 移出窗口
				if(curWindowCache[windowClassName] == null){
					//说明当前打开的和现在存在的不是同一个窗口，需要移出现在存在的窗口
					onCloseWindow((curShowWindowArr[0] as DisplayObject),mediatorMapInstance,parentDisplayObject,true,window,windowClassName);
					return true;
				}else{
					//说明当前打开的和现在存在的是同一个窗口 说明是要隐藏该窗口
					
					onCloseWindow(curWindowCache[windowClassName],mediatorMapInstance,parentDisplayObject);
					
					return false;
				}
			}else if(curShowWindowArr.length > 1){
				trace("窗口管理出错！！！");
			}else{
				//直接添加窗口
				onOpenWindow(window,windowClassName,mediatorMapInstance,parentDisplayObject);
				return true;
			}
			return false;
		}
		/**
		 * 弹出窗口 
		 * @param className
		 * @return 
		 * 
		 */	
		public static function onOpenWindow(window:DisplayObject,windowClassName:String,mediatorMapInstance:IMediatorMap=null,parentDisplayObject:PopUpWindowLayer = null):void{
			mediatorMapInstance.contextView.addChild(window);
			
			curShowWindowArr.push(window);
			curWindowCache[windowClassName] = window;
			mediatorMapInstance.createMediator(window);
			
			window.y = - window.height;
			
			var tYShow:int = -1;
			
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.MAIN_UI_ALERT));
			
			TweenMax.to(window,0.8,{bezier:[{y:tYShow}], orientToBezier:true, ease:Bounce.easeOut, onComplete:open_window_over, onCompleteParams:[windowClassName]});
		}
		
		private static function open_window_over(window_name:String):void {
			if (window_name == MainMenuComponent.NAME) {
				//new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER)]);
				//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER));
			}
		}
		
		/**
		 * 关闭窗口 
		 * @param className
		 * @return 
		 * 
		 */	
		public static var tempParentDisplayObject:PopUpWindowLayer;
		public static var addFlag:Boolean;
		public static var tempWindow:DisplayObject;
		public static var tempMediator:IMediatorMap;
		public static var tempRemoveWindow:DisplayObject;
		public static var tempWindowClassName:String;
		public static function onCloseWindow(window:DisplayObject,mediatorMapInstance:IMediatorMap=null,parentDisplayObject:PopUpWindowLayer = null,isAddFlag:Boolean=false,addWindow:DisplayObject = null,className:String = null):void{
			var class_name:String = getQualifiedClassName(window);
			class_name = class_name.replace("::", ".");
			if (class_name == MainMenuComponent.NAME) {
				GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.MAIN_MENU));
			}
			else {
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_CHECH_TASK));
			}
			tempMediator = mediatorMapInstance;
			addFlag = isAddFlag;
			tempWindow = addWindow;
			tempRemoveWindow = window;
			tempWindowClassName = className;
			tempParentDisplayObject = parentDisplayObject;
			var tYHide:int = - window.height;
			TweenMax.to(window,0.8,{y:tYHide,onComplete:afterCloseToOpen});
		}
		public static function afterCloseToOpen():void{
			if(tempMediator.contextView.hasOwnProperty('tempRemoveWindow')){
				tempMediator.contextView.removeChild(tempRemoveWindow);
			}
			
			curShowWindowArr = new Array();
			curWindowCache = new Dictionary();
			if(addFlag){
				onOpenWindow(tempWindow,tempWindowClassName,tempMediator,tempParentDisplayObject);
			}
		}
		/**
		 * 从缓存中获取窗口的实例
		 */
		public static function getWindow(className:String):DisplayObject{
			return windowsCache == null ? null : windowsCache[className] as DisplayObject;
		}
	}
}