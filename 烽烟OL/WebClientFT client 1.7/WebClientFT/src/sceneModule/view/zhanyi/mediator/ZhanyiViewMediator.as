package sceneModule.view.zhanyi.mediator
{
	import adobe.utils.CustomActions;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import managers.WindowManager;
	import model.SystemDataModel;
	import model.URLConst;
	import mx.core.UIComponent;
	import mx.rpc.Responder;
	import org.robotlegs.mvcs.Mediator;
	import proto.zhanyi.GetNowZhanYiInfo4500.GetNowZhanYiInfoRequest;
	import proto.zhanyi.GetNowZhanYiInfo4500.GetNowZhanYiInfoResponse;
	import proto.zhanyi.GetNowZhanYiInfo4500.ZhangJieInfo;
	import proto.zhanyi.ZhangJieFight4501.ZhangJieFightRequest;
	import proto.zhanyi.ZhangJieFight4501.ZhangJieFightResponse;
	import resource.AssetCenter;
	import sceneModule.view.copyScene.view.SpBitmapButton;
	import sceneModule.view.zhanyi.model.ZhanyiItemVo;
	import sceneModule.view.zhanyi.model.ZhanyiModel;
	import sceneModule.view.zhanyi.view.JianTouSprite;
	import sceneModule.view.zhanyi.view.ZhanyiItemView;
	import sceneModule.view.zhanyi.view.ZhanyiView;
	import service.ISocketServer;
	import util.Logging;
	import wordscene.config.SConfigCenter;
	import wordscene.event.PlusEvent;
	public class ZhanyiViewMediator extends Mediator
	{
		[Inject]
		public var socket:ISocketServer;
		
		private var _downBgBitmap:Bitmap;
		private var _midContain:Sprite;
		private var _midMask:Sprite;
		private var _topBgBitmap:Bitmap;
		private var _leftbtn:SpBitmapButton;
		private var _rightbtn:SpBitmapButton;
		private var _closeBtn:SpBitmapButton;
		private var _jiantouSp:JianTouSprite;
		
		private var _lastLevelDises:Vector.<DisplayObject>;
		private var _ismoveing:Boolean;
		
		public function ZhanyiViewMediator()
		{
			Logging.log("初始化战役mediator");
			_lastLevelDises = new Vector.<DisplayObject>();
			super();
		}
		
		override public function onRegister():void {
			Logging.log("注册战役mediator");
			view.addEventListener(Event.REMOVED_FROM_STAGE, remove_from_stage);
			
			initView();
		}
		
		private function remove_from_stage(e:Event):void {
			if (view) {
				view.removeEventListener(Event.REMOVED_FROM_STAGE, remove_from_stage);
				preRemove();
			}
			
		}
		
		override public function preRemove():void {
			if(!view){
				return;
			}
			Logging.log("移出mediator");
		}
		
		private function initView():void {
			_downBgBitmap = new Bitmap();
			contain.addChild(_downBgBitmap);
			
			_midContain = new Sprite();
			contain.addChild(_midContain);
			
			_midMask = new Sprite();
			_midMask.graphics.beginFill(0xFFFF00, 0.5);
			_midMask.graphics.drawRect(0, 0, 1024, 650);
			_midMask.graphics.endFill();
			contain.addChild(_midMask);
			_midContain.mask = _midMask;
			
			_topBgBitmap = new Bitmap();
			contain.addChild(_topBgBitmap);
			
			_leftbtn = new SpBitmapButton('zhanyi', 'left_up', 'left_over', 'left_down', 'left_dis');
			_leftbtn.x = 26;
			_leftbtn.y = 463;
			_leftbtn.addEventListener(MouseEvent.CLICK, onLeftClick);
			contain.addChild(_leftbtn);
			
			_rightbtn = new SpBitmapButton('zhanyi', 'right_up', 'right_over', 'right_down', 'right_dis');
			_rightbtn.x = 981;
			_rightbtn.y = 463;
			_rightbtn.addEventListener(MouseEvent.CLICK, onRightClick);
			contain.addChild(_rightbtn);
			
			_closeBtn = new SpBitmapButton('zhanyi', 'close_up', 'close_over', 'close_down');
			_closeBtn.x = 985;
			_closeBtn.y = 10;
			_closeBtn.addEventListener(MouseEvent.CLICK, onClose);
			contain.addChild(_closeBtn);
			
			_jiantouSp = new JianTouSprite();
			
			_downBgBitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('zhanyi', 'zhanyi_down_bg');
			_topBgBitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('zhanyi', 'zhanyi_top_bg');
			
			if (null == ZhanyiModel.getInstance().sdata) {
				
			}
			else{
				addLevel(ZhanyiModel.getInstance().sdata.index);
				_midContain.x = -ZhanyiModel.getInstance().sdata.index * 1024;
			}
		}
		
		private function onClose(e:MouseEvent = null):void 
		{
			WindowManager.closeWindow(ZhanyiView.NAME);
		}
		
		private function onLeftClick(e:MouseEvent):void {
			if (_leftbtn.is_disable || _ismoveing) {
				return;
			}
			requestPageInfo(ZhanyiModel.getInstance().curindex - 1);
		}
		
		private function onRightClick(e:MouseEvent):void {
			if (_rightbtn.is_disable || _ismoveing) {
				return;
			}
			requestPageInfo(ZhanyiModel.getInstance().curindex + 1);
		}
		
		private function toRight():void 
		{
			addLevel(ZhanyiModel.getInstance().curindex + 1);
			_ismoveing = true;
			TweenLite.to(_midContain, 1, { x:_midContain.x - 1024, onComplete:moveOver } );
		}
		
		private function toLeft():void 
		{
			addLevel(ZhanyiModel.getInstance().curindex - 1);
			_ismoveing = true;
			TweenLite.to(_midContain, 1, { x:_midContain.x + 1024, onComplete:moveOver } );
		}
		
		private function moveOver():void {
			_ismoveing = false;
			clearLast();
		}
		
		
		private function addLevel(index:int):void {
			ZhanyiModel.getInstance().curindex = index;
			var len:int = _midContain.numChildren;
			for (var j:int = 0; j < len; j++) 
			{
				_lastLevelDises.push(_midContain.getChildAt(j));
			}
			
			if (_jiantouSp.parent) {
				_jiantouSp.parent.removeChild(_jiantouSp);
			}
			
			var levelbgBitmap:Bitmap = new Bitmap();
			levelbgBitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('zhanyi', 'level_bg_' + (index + 1));
			levelbgBitmap.x = levelbgBitmap.width * index;
			levelbgBitmap.y = 60;
			_midContain.addChild(levelbgBitmap);
			
			len = ZhanyiModel.getInstance().sdata.zhangjielist.length;
			for (var i:int = 0; i < len; i++) 
			{
				var siteminfo:ZhangJieInfo = ZhanyiModel.getInstance().sdata.zhangjielist[i] as ZhangJieInfo;
				
				var iteminfo:ZhanyiItemVo = SConfigCenter.getInstance().getZhanyiItemInfo(siteminfo.zhangjieid);
				if (null == iteminfo) {
					Logging.log("no 战役 item", siteminfo.zhangjieid);
				}
				else {
					var itemview:ZhanyiItemView = new ZhanyiItemView(iteminfo.img, iteminfo.id, siteminfo);
					itemview.x = iteminfo.posx + levelbgBitmap.x;
					itemview.y = iteminfo.posy;
					itemview.addEventListener(PlusEvent.PlusEvent_ZhanyiItemClick, onItemClick);
					_midContain.addChild(itemview);
					if (!_jiantouSp.parent) {
						if (2 == siteminfo.state) {
							_jiantouSp.x = itemview.x;
							_jiantouSp.y = itemview.y;
							_midContain.addChild(_jiantouSp);
						}
					}
				}
			}
			
			if (index <= 0) {
				_leftbtn.set_disable(true);
			}
			else {
				_leftbtn.set_disable(false);
			}
			if (index >= ZhanyiModel.getInstance().maxindex) {
				_rightbtn.set_disable(true);
			}
			else {
				_rightbtn.set_disable(false);
			}
		}
		
		private function onItemClick(e:PlusEvent):void 
		{
			reqestFight(e.obj.id);
		}
		
		//显示战役
		public function requestPageInfo(index:int):void {
			var req:GetNowZhanYiInfoRequest = new GetNowZhanYiInfoRequest();
			req.id = SystemDataModel.roleId;
			req.index = index;
			var bytes:ByteArray = new ByteArray();
			req.writeExternal(bytes);
			socket.send(new Responder(responsePageInfo, faultHandler), URLConst.ZHANYI_REQUEST_LIST, bytes);
			Logging.log("请求战役数据");
		}
		
		//返回战役数据
		public function responsePageInfo(data:Object):void {
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetNowZhanYiInfoResponse = new GetNowZhanYiInfoResponse();
			responseData.readExternal(byteArray);
			Logging.log("战役数据返回", Logging.o2s(responseData));
			if (responseData.result) {
				if (responseData.data.index == ZhanyiModel.getInstance().curindex + 1) {
					if (1 == responseData.data.state) {
						//未激活
						return;
					}
					ZhanyiModel.getInstance().sdata = responseData.data;
					toRight();
				}
				else if (responseData.data.index == ZhanyiModel.getInstance().curindex - 1) {
					ZhanyiModel.getInstance().sdata = responseData.data;
					toLeft();
				}
			}
		}
		
		//申请战斗
		public function reqestFight(id:int):void {
			var req:ZhangJieFightRequest = new ZhangJieFightRequest();
			req.id = SystemDataModel.roleId;
			req.zhangjieid = id;
			var bytes:ByteArray = new ByteArray();
			req.writeExternal(bytes);
			socket.send(new Responder(responseFight, faultHandler), URLConst.ZHANYI_FIGHT, bytes);
			Logging.log("请求战役数据", Logging.o2s(req));
		}
		public function responseFight(data:Object):void {
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ZhangJieFightResponse = new ZhangJieFightResponse();
			responseData.readExternal(byteArray);
			Logging.log("战役请求战斗返回", Logging.o2s(responseData));
			if (responseData.result) {
				onClose();
			}
		}
		
		public function faultHandler(data:Object):void {
			
		}
		
		private function clearLast():void {
			while (_lastLevelDises.length > 0) {
				var dis:DisplayObject = _lastLevelDises.pop();
				if (dis.parent) {
					dis.parent.removeChild(dis);
				}
			}
		}
		
		public function get view():ZhanyiView {
			return viewComponent as ZhanyiView;
		}
		
		public function get contain():UIComponent {
			return view.contain;
		}
		
	}
}