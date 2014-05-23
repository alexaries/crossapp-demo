package sceneModule.view.skill.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.skill.skill801.GetSkillInfoRequest;
	import proto.skill.skill805.LoadSkillRequest;
	import proto.skill.skill805.LoadSkillResponse;
	import proto.skill.skill806.UnLoadSkillRequest;
	import proto.skill.skill806.UnLoadSkillResponse;
	import proto.skill.skill807.OpenBattleSpaceRequest;
	import proto.skill.skill807.OpenBattleSpaceResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.skillVo.SkillBasicInfoVo;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.skill.event.GetBattleSkillInfoResponseEvent;
	import sceneModule.view.skill.event.GetSkillInfoResponseEvent;
	import sceneModule.view.skill.view.LockedSkillDesTooltip;
	import sceneModule.view.skill.view.MainMenuBattleSkillComponent;
	import sceneModule.view.skill.view.MainMenuSkillItemRender;
	import sceneModule.view.skill.view.MainMenuSkillTooltip;
	
	import service.ISocketServer;

	/**
	 * EquipmentSkillComponentMediator 
	 * @author Yaolx
	 * 
	 */	
	public class MainMenuBattleSkillComponentMediator extends Mediator
	{
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var comp:MainMenuBattleSkillComponent;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var _toolTip:MainMenuSkillTooltip;
		
		private var _lockSkilltips:LockedSkillDesTooltip;
		public function MainMenuBattleSkillComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.comp.doubleClickEnabled = true;
//			this.eventMap.mapListener(comp.skillImg,MouseEvent.MOUSE_MOVE,onMouseMove);
//			this.eventMap.mapListener(comp.skillImg,MouseEvent.MOUSE_OUT,onMouseOut);
			this.eventMap.mapListener(comp.skillImg,MouseEvent.CLICK,onMouseClick);
//			this.eventMap.mapListener(comp.skillImg,MouseEvent.MOUSE_OVER,onMouseOver);
		}
		
		override public function onRemove():void{
//			this.eventMap.unmapListener(comp.skillImg,MouseEvent.MOUSE_MOVE,onMouseMove);
//			this.eventMap.unmapListener(comp.skillImg,MouseEvent.MOUSE_OUT,onMouseOut);
			this.eventMap.unmapListener(comp.skillImg,MouseEvent.CLICK,onMouseClick);
//			this.eventMap.unmapListener(comp.skillImg,MouseEvent.MOUSE_OVER,onMouseOver);
			
			_lockSkilltips = null;
		}
		
		private function onMouseOver(evt:MouseEvent):void{
			if(comp.data.skillStatus == MainMenuBattleSkillComponent.LOCK)
			{
				if(!_lockSkilltips){
					_lockSkilltips = new LockedSkillDesTooltip();
					_lockSkilltips.curDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('shill','mmbsCM_xhwb');
					comp.addElement(_lockSkilltips);
				}
				_lockSkilltips.visible = true;
				settooltipPosition();
			}
			
		}
		
		private function settooltipPosition():void
		{
			if(_lockSkilltips){
				_lockSkilltips.x = comp.mouseX + 10;
				_lockSkilltips.y = comp.mouseY + 10;
			}
		}
		
		//MouseDoubleClick
		private function onMouseClick(evt:MouseEvent):void{
			if(comp.data.skillStatus && comp.data.skillStatus == MainMenuBattleSkillComponent.EQUIP){
				//执行鼠标双击事件
				onUnLoadSkill(comp.data.skillId,comp.skillPos);
			}else if(comp.data.skillStatus == MainMenuBattleSkillComponent.LOCK){
//				popUpShow.show("是否花费500钻开通技能栏！", null, null, null, null, onOpenSkillSpace);
			}
			
		}
		/**
		 * 卸载技能 
		 */		
		private function onUnLoadSkill(skillId:int,pos:int=0):void{
			var unloadSkillReq:UnLoadSkillRequest = new UnLoadSkillRequest();
			unloadSkillReq.id = SystemDataModel.roleId;
			unloadSkillReq.skillId = skillId;
			unloadSkillReq.skillPos = pos;
			var unLoadByteArray:ByteArray = new ByteArray();
			unloadSkillReq.writeExternal(unLoadByteArray);
			socketService.send(new mx.rpc.Responder(unLoadSkillHandler,faultHandler),URLConst.SKILL_UNLOAD_COMMANDID,unLoadByteArray);
		}
		private function unLoadSkillHandler(data:Object):void{
			var resByteArray:ByteArray = data as ByteArray;
			var responseData:UnLoadSkillResponse = new UnLoadSkillResponse();
			responseData.readExternal(resByteArray);
			if(responseData.result){
				onGetSkillData();
				onGetRoleSkillData();
			}else{
				popUpShow.show(responseData.message);
			}
		}
		private function onMouseDownAndDrag(evt:MouseEvent):void{
			if(comp.data.skillStatus && comp.data.skillStatus == MainMenuBattleSkillComponent.EQUIP){
				var iu:IUIComponent=evt.currentTarget as IUIComponent;
				var ds:DragSource=new DragSource();
				var obj:Object = new Object();
				obj.skillId = comp.data.skillId;
				obj.pos = comp._skillPos;
				ds.addData(obj, MainMenuBattleSkillComponent.FROMROLESKILL);
				var dragProxy:Image = new Image();
				dragProxy.width = 42;
				dragProxy.height = 42;
				dragProxy.source = comp.skillImg.source;
				DragManager.doDrag(comp, ds, evt,dragProxy); // 开始拖动这个物体
			}else if(comp.data.skillStatus == MainMenuBattleSkillComponent.LOCK){
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('shill','mmbsCM_sfwb'), null, null, null, null, onOpenSkillSpace);
			}
		}
		
		/**
		 * 解锁未开放的技能栏
		 */
		private function onOpenSkillSpace(evt:MouseEvent):void{
			var openSkillSpaceReq:OpenBattleSpaceRequest = new OpenBattleSpaceRequest();
			openSkillSpaceReq.id = SystemDataModel.roleId;
			openSkillSpaceReq.spacePos = comp.skillPos;
			var byteArray:ByteArray = new ByteArray();
			openSkillSpaceReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(openSkillSpaceHandler,faultHandler),URLConst.SKILL_OPENCLOCK_COMMANDID,byteArray);
		}
		private function openSkillSpaceHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:OpenBattleSpaceResponse = new OpenBattleSpaceResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				onGetRoleSkillData();
			}
		}
		
		private function onMouseMove(evt:MouseEvent):void{
			if(comp.data.skillStatus && comp.data.skillStatus == 2){
				if(!_toolTip){
					_toolTip = new MainMenuSkillTooltip();
					popUpWindowLayer.addElement(_toolTip);
				}
				if(!_toolTip.visible)_toolTip.visible = true;
				_toolTip.curDataInfo = comp.data as SkillBasicInfoVo;
				setToolTipPos();
			}
		}
		private function onMouseOut(evt:MouseEvent):void{
			if(_toolTip && _toolTip.visible)_toolTip.visible = false;
			if(_lockSkilltips){
				_lockSkilltips.visible=false;
			}
		}
		private function setToolTipPos():void{
			if(_toolTip){
				if((FlexGlobals.topLevelApplication.mouseX + _toolTip.width + 5) > FlexGlobals.topLevelApplication.width){
					_toolTip.x = FlexGlobals.topLevelApplication.mouseX - _toolTip.width - 5;
				}else{
					_toolTip.x = FlexGlobals.topLevelApplication.mouseX + 5;
				}
				if((FlexGlobals.topLevelApplication.mouseY + _toolTip.height + 5) > FlexGlobals.topLevelApplication.height){
					_toolTip.y = FlexGlobals.topLevelApplication.height - _toolTip.height;
				}else{
					_toolTip.y = FlexGlobals.topLevelApplication.mouseY + 5;
				}
				
			}
		}
		/**
		 * 装载技能 
		 * @param evt
		 * 
		 */	
		private function onLoadSkill(skillId:int):void{
			var loadSkillReq:LoadSkillRequest = new LoadSkillRequest();
			loadSkillReq.id = SystemDataModel.roleId;
			loadSkillReq.skillId = skillId;
			loadSkillReq.skillPos = comp.skillPos;
			var loadByteArray:ByteArray = new ByteArray();
			loadSkillReq.writeExternal(loadByteArray);
			socketService.send(new mx.rpc.Responder(loadSkillHandler,faultHandler),URLConst.SKILL_LOAD_COMMANDID,loadByteArray);
		}
		private function loadSkillHandler(data:Object):void{
			var resData:ByteArray = data as ByteArray;
			var responseData:LoadSkillResponse = new LoadSkillResponse();
			responseData.readExternal(resData);
			if(responseData.result){
				onGetSkillData();
				onGetRoleSkillData();
				//拖动到技能设置
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_SKILL_ENABLE));
			}else{
				popUpShow.show(responseData.message);
			}
		}
		/**
		 * 获取技能数据 
		 */		
		private function onGetSkillData():void{
			var skillRequest:GetSkillInfoRequest = new GetSkillInfoRequest();
			skillRequest.id = SystemDataModel.roleId;
			var skillByteArray:ByteArray = new ByteArray();
			skillRequest.writeExternal(skillByteArray);
			socketService.send(new mx.rpc.Responder(skillInfoHandler,faultHandler),URLConst.SKILL_GETINFO_COMMANDID,skillByteArray);
		}
		private function skillInfoHandler(data:Object):void{
			dispatch(new GetSkillInfoResponseEvent(GetSkillInfoResponseEvent.GETSKILLINFORESPONSE,data));
		}
		/**
		 * 获取技能数据 
		 */		
		private function onGetRoleSkillData():void{
			var skillRequest:GetSkillInfoRequest = new GetSkillInfoRequest();
			skillRequest.id = SystemDataModel.roleId;
			var skillByteArray:ByteArray = new ByteArray();
			skillRequest.writeExternal(skillByteArray);
			socketService.send(new mx.rpc.Responder(RoleSkillInfoHandler,faultHandler),URLConst.SKILL_ROLESELF_COMMANDID,skillByteArray);
		}
		private function RoleSkillInfoHandler(data:Object):void{
			dispatch(new GetBattleSkillInfoResponseEvent(GetBattleSkillInfoResponseEvent.GETBATTLESKILLINFORESPONSE,data));
		}
		
		/**
		 * faultHandler 
		 */		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}