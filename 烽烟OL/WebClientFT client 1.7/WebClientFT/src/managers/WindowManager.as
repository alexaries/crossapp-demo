package managers
{
	
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import loader.UILoaderProgressBarView;
	
	import managers.BaseWindow;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import mx.core.FlexGlobals;
	import mx.core.FlexSprite;
	import mx.core.IUIComponent;
	import mx.core.IVisualElementContainer;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.core.IMediatorMap;
	
	import sceneModule.view.announ.AddWindowEvent;
	import sceneModule.view.announ.AddWindowEventDispatcher;
	import sceneModule.view.corps.view.ChoseCorpsComponent;
	import sceneModule.view.groupBattle.command.GroupBattleMessage;
	import sceneModule.view.groupBattle.view.GroupBattleInfoComponent;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.ui.LayerEnableMouseComponent;
	import sceneModule.view.wordmap.view.SceneMapView;
	
	import spark.components.Group;
	import spark.effects.Fade;
	
	import util.DelayExcuter;

	public class WindowManager
	{
		/**
		 * 关闭后的缓存策略，关闭后保持缓存。
		 */ 
		public static const CACHE_POLICY_CACHE:String='cache';
		/**
		 * 关闭后的缓存策略，关闭后从缓存中清除。
		 */ 
		public static const CACHE_POLICY_NOT_CACHE:String='not_cache';
		
		/**
		 * 弹出堆栈，保存弹出窗口的类名。按照弹出顺序排列，新弹出的窗口压在数组尾部。
		 */ 
		private static var popUpStack:Array;
		/**
		 * 窗口缓存，<windowClassName, window>。以窗口的类名为key，保存已创建的窗口。
		 */ 
		private static var windowsCache:Dictionary;
		
		/**
		 * 模态层缓存 
		 * 
		 */		
		private static var modalSpriteCache:Dictionary;
		
		/**
		 * 模态堆栈 
		 * 
		 */		
		private static var modalStack:Array;
		
		public function WindowManager()
		{
			throw new Error('This class is a static class.');
			
		}
		
		public static function  onResize():void{
			if(popUpStack){
				var l:int = popUpStack.length;
				for(var i:int=0;i<l;i++){
					var window:BaseWindow = getWindow(popUpStack[i]);
					if(window){
						window.x = FlexGlobals.topLevelApplication.width/2 - window.width/2;
						if(FlexGlobals.topLevelApplication.height > 650){
							window.y = 325 - window.height/2;
						}else{
							window.y = FlexGlobals.topLevelApplication.height/2 - window.height/2;
						}
						
					}
					
				}
			}
		}
		
		/**
		 * 根据指定的类名和初始数据，创建并弹出一个窗口。
		 * 
		 * 通过窗口类的名称来创建窗口，创建后的窗口会放入缓存，在后续的请求中，将复用缓存中的窗口对象。
		 * 尝试创建一个已经弹出的窗口，会将此窗口放到最前端，并不会创建和弹出一个新的窗口实例。
		 * 
		 * @param windowClassName 窗口的类名，用于通过getDefinitionByName方法来获得窗口的Class，这个Class必须是BaseWindow的子类。
		 * @param initData 窗口的初始化数据，传递给窗口的<code>data</code>变量，窗口负责在创建时根据data初始化，并监听dataChange事件。
		 * @param parentClassName 父窗口的类名，传递给弹出窗口的parentName变量，用于记录弹出窗口由哪一个窗口弹出。父窗口也必须是一个BaseWindow的子类。null代表顶级。
		 * @param docked 是否允许通过鼠标拖动。
		 * @param modal 是否是模态化窗口。
		 * @param position 显示位置，null代表居中显示。
		 */ 
		private static var showFlag:Boolean = true;
		public static function createWindow(windowClassName:String, initData:Object=null, parentClassName:String=null, disableParent:Boolean = false, modal:Boolean=false, docked:Boolean=false, position:Point=null,mediatorMapInstance:IMediatorMap=null,parentDisplayObject:PopUpWindowLayer = null,sameShow:Boolean = false):BaseWindow
		{
			if(!showFlag)return null;
			showFlag = false;
			// init properties.
//			trace('创建窗口...'+windowClassName);
			if (!windowsCache)
			{
				windowsCache = new Dictionary();
			}
			if (!popUpStack)
			{
				popUpStack = new Array();
			}
			
			if(!modalSpriteCache){
				modalSpriteCache = new Dictionary();
			}
			
			if(!modalStack){
				modalStack = new Array();
			}
//			 trace('sameShow'+sameShow);
			if(!sameShow){
				var l:int = popUpStack.length;
//				trace('-----------'+popUpStack.length);
				for(var i:int=0;i<l;i++){
					var oldWindow:BaseWindow = getWindow(popUpStack[i]);
					if(oldWindow){
						//关闭旧窗口
//						trace('关闭窗口...' + popUpStack[i]);
						if (WindowManager.isPopedUp(ChoseCorpsComponent.NAME)) {
							WindowManager.closeWindow(ChoseCorpsComponent.NAME);
							GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.CLOSE_UNION_ZHENYING));
						}
						WindowManager.closeWindow(popUpStack[i],false,false,WindowManager.CACHE_POLICY_NOT_CACHE,parentDisplayObject);
					}
				}
			}
			
			// 从缓存中获得窗口，或者创建新的窗口并放入缓存
			var window:BaseWindow = getWindow(windowClassName);
			if (window == null)
			{
				var windowClass:Class = getDefinitionByName(windowClassName) as Class;
				// 检查是否成功获得windowClass
				if (windowClass == null)
				{
					throw new ArgumentError(windowClassName + " is not a Class!");
				}
				window = new windowClass() as BaseWindow;
				// 检查window是否BaseWindow子类
				if (window == null)
				{
					throw new ArgumentError(windowClassName + " is not sub class of BaseWindow!");
				}
				
				// window创建成功，放入窗口缓存
				windowsCache[windowClassName] = window;
			}
			
			// 设置窗口状态和初始化数据
			window.docked = docked;
			window.data = initData;
			window.windowClassName = windowClassName;
			
			window.parentName = null;
			window.enabled = true;
			
//			var parentWindow:BaseWindow = getWindow(parentClassName);
//			if (parentWindow != null)
//			{
//				window.parentName = parentClassName;
//				parentWindow.hasChildren = true;
//				parentWindow.enabled = !disableParent;
//			}
			
			window.addEventListener(MouseEvent.MOUSE_DOWN, windowMouseDown, false, 0, true);
						
			// 设置位置
			if (position)
			{
				window.x = position.x;
				window.y = position.y;
			}
			// 监测窗口是否在已弹出清单中，以及在什么位置
			var popedIndex:int = popUpStack.indexOf(windowClassName);
			if(modal && popedIndex <0){
//				var modalSprite:LayerEnableMouseComponent = new LayerEnableMouseComponent();
//				modalSprite.width = FlexGlobals.topLevelApplication.width;
//				modalSprite.height = FlexGlobals.topLevelApplication.height;
//				modalSpriteCache[windowClassName] = modalSprite;
//				modalStack.push(windowClassName);
//				parentDisplayObject.addElement(modalSprite);
			}
			
			
//			trace('窗口清单index'+popedIndex);
			if (popedIndex >= 0)
			{
				// 如果在已弹出列表中，提到最前端，并从弹出堆栈中的原位置移除
//				PopUpManager.bringToFront(window);
				popUpStack.splice(popedIndex, 1);
			}
			else
			{
				// 如果不再已弹出列表中，弹出窗口
//				PopUpManager.addPopUp(window, parentDisplayObject == null ? FlexGlobals.topLevelApplication as DisplayObject : parentDisplayObject, modal);
//				if(parentWindow == null){
					if(parentDisplayObject){
						parentDisplayObject.addElement(window);
//						onShowWindowFade(window,0.4,1);
					}else{
						FlexGlobals.topLevelApplication.addElement(window);
//						onShowWindowFade(window,0.4,1);
					}
//				}else{
//					parentWindow.addElement(window);
//					onShowWindowFade(window,0.4,1);
//				}
				
				if(mediatorMapInstance){
					mediatorMapInstance.createMediator(window);
				}
				if(windowClassName!= 'loader.UILoaderProgressBarView'){
					SystemDataModel.curOpenWindowName = windowClassName;
					SystemDataModel.curWindowParentName = parentClassName;
				}
				
			}
			showFlag = true;
			// 将窗口压入堆栈顶部
			popUpStack.push(windowClassName);
			
			// 如果未设置位置，让窗口居中
			if (!position)
			{
//				PopUpManager.centerPopUp(window);
				window.x = FlexGlobals.topLevelApplication.width/2 - window.width/2;
				//if(FlexGlobals.topLevelApplication.height>650){
				//	window.y = 325 - window.height/2;
				//}else{
					window.y = FlexGlobals.topLevelApplication.height/2 - window.height/2;
				//}
				
			}
//			trace('x' + window.x + 'y' + window.y);
			
			if (SceneMapView.NAME == windowClassName) {
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_SCENE_MAP));
			}
			
			return window;
		}
		
		public static function onShowWindowFade(window:BaseWindow,fromAlpha:Number,toAlpha:Number):void{
			var fade:Fade = new Fade();
			fade.alphaFrom = fromAlpha;
			fade.alphaTo = toAlpha;
			fade.duration = 300;
			fade.target = window;
			fade.play();
		}
		public static function onHideWindowFade(window:BaseWindow,fromAlpha:Number,toAlpha:Number):void{
			var fade:Fade = new Fade();
			fade.alphaFrom = fromAlpha;
			fade.alphaTo = toAlpha;
			fade.duration = 300;
			fade.target = window;
			fade.play();
		}
		
		protected static function windowMouseDown(e:MouseEvent):void
		{
			var currentWindow:BaseWindow = e.currentTarget as BaseWindow;
			if (currentWindow == null || (!currentWindow.hasChildren && currentWindow.parentName == null))
				return;
			
			
			var sm:SystemManager = currentWindow.systemManager as SystemManager;
			var currIndex:int = sm.getChildIndex(currentWindow);
			if (currIndex < 0)
				return;

			while(currentWindow.parentName != null && isPopedUp(currentWindow.parentName))
			{
				currentWindow = getWindow(currentWindow.parentName);
				sm.setChildIndex(currentWindow, currIndex);
			}
			
			bringChildrenChainToFront(currentWindow, currentWindow, currIndex, sm);
		}
		
		private static function bringChildrenChainToFront(frontWindow:BaseWindow, currentWindow:BaseWindow, currentWindowIndex:int, sm:SystemManager):void
		{
			for (var j:int =0;j<sm.numChildren;j++)
			{
				var window:BaseWindow = sm.getChildAt(j) as BaseWindow;
				if (window == null)
				{
					continue;
				}
				if (window.windowClassName == currentWindow.windowClassName || window.windowClassName == frontWindow.windowClassName)
				{
					break;
				}
				if (window.parentName == currentWindow.windowClassName)
				{
					sm.setChildIndex(window, currentWindowIndex);
					bringChildrenChainToFront(frontWindow, window, currentWindowIndex, sm);
					j = 0;
				}
			}
		}
		
		
		/**
		 * 根据窗口类名关闭一个窗口。
		 * 
		 * @param windowClassName 窗口类的类名。
		 * @param closeAllChildren 关闭策略，决定是否同时关闭父窗口或子窗口。null等同于CLOSE_POLITY_SINGLE；CLOSE_POLITY_SINGLE，只关闭自身；CLOSE_POLITY_PARENT，同时关闭父窗口；CLOSE_POLITY_CHIDREN，同时关闭所有子窗口。
		 * @param closeParent 缓存策略，决定关闭后是否缓存窗口对象。null将使用窗口的cachePolicy变量来决定。CACHE_POLITY_CACHE，代表关闭后缓存；CACHE_POLITY_NOT_CACHE，代表关闭后清空缓存。
		 *
		 */
		public static function closeWindow(windowClassName:String, closeAllChildren:Boolean=false, closeParent:Boolean=false, cachePolicy:String=WindowManager.CACHE_POLICY_NOT_CACHE,parentDisplayObject:IVisualElementContainer = null, mediamap:IMediatorMap = null):void
		{		
//			trace('onCloseWindow...'+windowClassName);
			if(windowClassName != UILoaderProgressBarView.NAME){
				GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.UI_CHANGE));
			}
			if(windowClassName == GroupBattleInfoComponent.NAME){
				GroupBattleMessage.getInstance().cancelGroupBattle();
			}
			if (windowClassName == MainMenuComponent.NAME) {
				GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.MAIN_MENU));
			}else {
				if (windowClassName != "sceneModule.view.corps.view.NCorpAlert") {
					if ("loader.UILoaderProgressBarView" != windowClassName) {
						GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_CHECH_TASK));
					}
				}
			}
			// 从缓存中获得窗口
			var window:BaseWindow = getWindow(windowClassName);	
			if(window==null) return;	
			var popedIndex:int = popUpStack.indexOf(windowClassName);
			// 如果在缓存和弹出堆栈中都找不到指定窗口，忽略本次请求
			if (window == null && popedIndex < 0) 
			{
				return;
			}
			
			// close
//			PopUpManager.removePopUp(window);
			parentDisplayObject = window.parent as IVisualElementContainer;
			if(parentDisplayObject){
				
//				onHideWindowFade(window,1,0);
//				new DelayExcuter(700,function():void{
					if(parentDisplayObject.getElementIndex(window)>=0){
						try{
							parentDisplayObject.removeElement(window);
						}catch(e:Error){
							
						}
					}
//					var modelLayer:LayerEnableMouseComponent = WindowManager.getModelLayer(windowClassName);
//					if(modelLayer){
//						try{
//							parentDisplayObject.removeElement(modelLayer);
//						}catch(e:Error){
//							
//						}
//						var modalIndex:int = modalStack.indexOf(windowClassName);
//						modalStack.splice(modalIndex, 1);
//					}
					if (mediamap) {
						mediamap.removeMediatorByView(window);
					}
//				},null);
			}
//			window.parent.removeChild(window);
			window.onClose();
			window.removeEventListener(MouseEvent.MOUSE_DOWN, windowMouseDown);
			// remove from popupStack
			if (popedIndex >= 0)
			{
				popUpStack.splice(popedIndex, 1);
			}		
			
			if (closeParent)
			{
				closeWindow(window.parentName, true, false); // 嵌套调用，single方式确认只会嵌套一次
			}
			else
			{
				var parentWindow:BaseWindow = getWindow(window.parentName);
				if (parentWindow != null)
				{
					parentWindow.enabled = true;
				}
			}
			
			if (closeAllChildren)
			{
				for (var i:int = popUpStack.length - 1; i >= 0; i --)
				{
					var name:String = popUpStack[i];
					var win:BaseWindow = getWindow(name);
					if (win != null && win.parentName == windowClassName)
					{
						closeWindow(name, true, false);      // 嵌套调用，single方式确认只会嵌套一次
					}
				}
				window.hasChildren = false;
			}
			
			window.parentName = null;
			
			if (cachePolicy == null)
			{
				cachePolicy = window.windowCachePolicy;
			}
			switch (cachePolicy)
			{
				case CACHE_POLICY_CACHE:
					break;
				case CACHE_POLICY_NOT_CACHE:
					delete windowsCache[windowClassName];
					break;
			}	
			if(windowClassName!= 'loader.UILoaderProgressBarView'){
				SystemDataModel.curOpenWindowName = null;
			}
			
		}	
		private function onRemoveWindowByEffectAfter():void{
			
		}
		
		/**
		 * 通过类名从缓存中获取窗口对象。
		 *
		 */
		public static function getWindow(windowClassName:String):BaseWindow
		{
			return windowsCache == null ? null : windowsCache[windowClassName] as BaseWindow;
		}
		
		public static function getModelLayer(windowClassName:String):LayerEnableMouseComponent{
			return modalSpriteCache == null ? null : modalSpriteCache[windowClassName] as LayerEnableMouseComponent;
		}
			
		/**
		 * 关闭所有已经打开的窗口。
		 *
		 */
		public static function closeAllWindows():void
		{
			if (!popUpStack)
				return
				
			for (var i:int = popUpStack.length - 1; i >= 0; i --)
			{
				var name:String = popUpStack[i];
				closeWindow(name);
			}
			SystemDataModel.curOpenWindowName = null;
			SystemDataModel.curWindowParentName = null;
		}
		
		/**
		 * 清空缓存。这个方法同时会导致所有窗口关闭。
		 */ 
		public static function clearCache():void
		{
			closeAllWindows();
			if (windowsCache != null)
			{
				// 直接用for in循环遍历删除会有问题，先列举，再删除
				var cachedNames:Array = new Array();
				for (var cachedname:String in windowsCache)
				{
					cachedNames.push(cachedname);
				}
				for each (var name:String in cachedNames)
				{
					delete windowsCache[name];
				}
				cachedNames = null;
			}
		}
		
		/**
		 * 将窗口对象注册到缓存中。
		 */ 
		public static function registerWindowToCache(windowClassName:String, window:BaseWindow):void
		{
			if (!windowsCache)
			{
				windowsCache = new Dictionary();
			}
			windowsCache[windowClassName] = window;
		}
		
		/**
		 * 通过窗口类名判断窗口是否处于最上层。
		 * 
		 * TODO 这个目前只能判断窗口是否最后一个被弹出，不能判断是否显示在最上层，鼠标点击事件可能会改变显示次序，这个要再研究一下。
		 */ 
		public static function isTopLevel(windowClassName:String):Boolean
		{
			return popUpStack == null ? false : popUpStack.indexOf(windowClassName) == popUpStack.length - 1;
		}
		
		/**
		 * 通过窗口类名判断窗口是否已经被弹出。
		 */ 
		public static function isPopedUp(windowClassName:String):Boolean
		{
			return popUpStack == null ? false : popUpStack.indexOf(windowClassName) >= 0;
		}
		
		public static function getModalStr():String{
			var str:String='';
			var l:int = modalStack.length;
			for(var i:int=0;i<l;i++){
				str+=modalStack[i];
			}
			return str;
		}
	}
}