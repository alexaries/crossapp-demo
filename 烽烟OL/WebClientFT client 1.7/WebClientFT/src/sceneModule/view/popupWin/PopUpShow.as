package sceneModule.view.popupWin
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexMouseEvent;
	import mx.managers.PopUpManager;
	
	import org.robotlegs.mvcs.Actor;
	
	import resource.CrotaResourceConfig;

	public class PopUpShow extends Actor implements IPopUpShow
	{
		private static var _instance:PopUpShow;
		private var popUpWin:PopUpWindow;
		private var _submitHandler:Function;
		private var _sub_args:Array;
		private var _cancal_args:Array;
		private var _cancelHandler:Function;
		private var defaultUrl:String="assets/role/roleImage1.png";	
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function PopUpShow()
		{
			popUpWin = new PopUpWindow();
		}
//		public static function instance():PopUpShow{
//			if(!_instance){
//				_instance = new PopUpShow();
//			}
//			return _instance;
//		}
		public function show(content:String,titleStr:String=null,ImageUrl:String=null,submitStr:String=null,cancelStr:String=null,submitHandler:Function=null,cancelHandler:Function=null,subags:Array = null,cancelargs:Array = null):void{
			popUpWindowLayer.addElement(popUpWin);
			popUpWin.x = FlexGlobals.topLevelApplication.width/2 - popUpWin.width/2;
			popUpWin.y = FlexGlobals.topLevelApplication.height/2 - popUpWin.height/2;
			popUpWin.popInfo.text = content;
			if(ImageUrl !=null){
			//	popUpWin.roleImage.source=ImageUrl;
			}else{
				//popUpWin.roleImage.source=defaultUrl;
			}
			if(titleStr == null){
				popUpWin.titleLabel.text=CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_xxts');
			}else{
				popUpWin.titleLabel.text=titleStr;
			}
			if(submitStr == null){
				popUpWin.submitBtn.label=CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd');
			}else{
				popUpWin.submitBtn.label=submitStr;
			}
			if(cancelStr == null){
				popUpWin.cancelBtn.label=CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx');
			}else{
				popUpWin.cancelBtn.label=cancelStr;
			}
			
			_submitHandler=submitHandler;
			_cancelHandler = cancelHandler;
			
			_sub_args = subags;
			_cancal_args = cancelargs;
			
			popUpWin.submitBtn.addEventListener(MouseEvent.CLICK,onSubmitClick);
			popUpWin.cancelBtn.addEventListener(MouseEvent.CLICK,onCancelClick);
		}
		
		public function onSubmitClick(evt:MouseEvent):void{
			evt.stopPropagation();
			removeThisWindow();
			if (_submitHandler != null) {
				if (null != _sub_args) {
					_submitHandler.apply(null, _sub_args);
				}
				else{
					_submitHandler(evt);
				}
			}
		}
		public function onCancelClick(evt:MouseEvent):void{			
			evt.stopPropagation();
			removeThisWindow();
			if (_cancelHandler != null) {
				if (null != _cancal_args) {
					_cancelHandler.apply(null, _cancal_args);
				}
				else{
					_cancelHandler(evt);
				}
			}
		}
		//移除窗口
		private function removeThisWindow():void{
			if(popUpWindowLayer.contains(popUpWin)){
				popUpWindowLayer.removeElement(popUpWin);
			}
		}
	}
}