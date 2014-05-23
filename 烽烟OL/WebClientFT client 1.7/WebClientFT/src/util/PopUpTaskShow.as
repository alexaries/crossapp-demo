package util
{
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexMouseEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	public class PopUpTaskShow extends Actor implements IPopUpTaskShow
	{
		private static var _instance:PopUpTaskShow;
		private var popUpWin:PopUpTaskWindow;
		private var _submitHandler:Function;
		private var _cancelHandler:Function;
		private var _randomClickHandler:Function;
		[Embed(source='/embed/role/npcChatRoleImage.png')]
		[Bindable]
		private var npcImg:Class;
		public function PopUpTaskShow()
		{
			popUpWin = new PopUpTaskWindow();
		}
		//		public static function instance():PopUpShow{
		//			if(!_instance){
		//				_instance = new PopUpShow();
		//			}
		//			return _instance;
		//		}
		public function show(content:String,titleStr:String=null,ImageUrl:String=null,submitStr:String=null,cancelStr:String=null,submitHandler:Function=null,cancelHandler:Function=null,randomClickHandler:Function=null,submitBtnVisible:Boolean=false,cancelBtnVisible:Boolean = false,swfVisible:Boolean=true):void{
			FlexGlobals.topLevelApplication.addElement(popUpWin);
//			popUpWin.x = FlexGlobals.topLevelApplication.width/2 - popUpWin.width/2;
//			popUpWin.y = FlexGlobals.topLevelApplication.height/2-popUpWin.height/2 -80;
//			FlexGlobals.topLevelApplication.addEventListener(MouseEvent.CLICK,onMouseDownOutSide);
//			popUpWin.addEventListener(MouseEvent.CLICK,onClickThisWindow);
			popUpWin.taskContent.htmlText = content;
			if(ImageUrl !=null){
				popUpWin.roleImage.source=ImageUrl;
				popUpWin.roleImage.width = 303;
				popUpWin.roleImage.height = 322;
				popUpWin.roleImage.x = -49;
				popUpWin.roleImage.y = -83;
			}else{
				popUpWin.roleImage.source = npcImg;
				popUpWin.roleImage.width = 503;
				popUpWin.roleImage.height = 385;
				popUpWin.roleImage.x = -216;
				popUpWin.roleImage.y = -148;
			}
//			if(titleStr == null){
//				popUpWin.titleLabel.text="信息提示";
//			}else{
//				popUpWin.titleLabel.text=titleStr;
//			}
			if(submitBtnVisible){
				popUpWin.submitBtn.visible = true;
				if(submitStr == null){
					popUpWin.submitBtn.label=null;
				}else{
					popUpWin.submitBtn.label=submitStr;
				}
				popUpWin.submitBtn.addEventListener(MouseEvent.CLICK,onSubmitClick);
			}else{
				popUpWin.submitBtn.visible = false;
			}
			if(cancelBtnVisible){
				popUpWin.cancelBtn.visible = true;
				if(cancelStr == null){
					popUpWin.cancelBtn.label="取消";
				}else{
					popUpWin.cancelBtn.label=cancelStr;
				}
				popUpWin.cancelBtn.addEventListener(MouseEvent.CLICK,onCancelClick);
			}else{
				popUpWin.cancelBtn.visible = false;
			}
			popUpWin.pointSwf.visible = swfVisible;
			
			_submitHandler=submitHandler;
			_cancelHandler=cancelHandler;
			_randomClickHandler = randomClickHandler;	
			popUpWin.pointSwf.addEventListener(MouseEvent.CLICK,onRandomClickHandler);
			
		}
		private function onRandomClickHandler(evt:MouseEvent):void{
			FlexGlobals.topLevelApplication.removeElement(popUpWin);
			if(_randomClickHandler != null){
				_randomClickHandler(evt);
			}
		}
		
		public function onSubmitClick(evt:MouseEvent):void{
			evt.stopImmediatePropagation();
			removeThisWindow();
			if(_submitHandler !=null){
				_submitHandler(evt);
			}
			
		}
		public function onCancelClick(evt:MouseEvent):void{
			evt.stopImmediatePropagation();
			removeThisWindow();
			if(_cancelHandler !=null){
				_cancelHandler(evt);
			}
			
		}
		private function onClickThisWindow(evt:MouseEvent):void{
			evt.stopPropagation();
		}
		//移除窗口
		private function removeThisWindow():void{
//			popUpWin.removeEventListener(MouseEvent.CLICK,onClickThisWindow);
//			FlexGlobals.topLevelApplication.removeEventListener(MouseEvent.CLICK,onMouseDownOutSide);
			FlexGlobals.topLevelApplication.removeElement(popUpWin);
		}
		
		private function onMouseDownOutSide(evt:MouseEvent):void{
			removeThisWindow();
		}
	}
}