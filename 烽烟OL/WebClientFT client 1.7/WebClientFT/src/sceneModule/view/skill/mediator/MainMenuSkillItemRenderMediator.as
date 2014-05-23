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
	
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.events.ToolTipEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.skill.skill801.GetSkillInfoRequest;
	import proto.skill.skill802.LevelUpSkillRequest;
	import proto.skill.skill802.LevelUpSkillResponse;
	import proto.skill.skill803.ActivationSkillRequest;
	import proto.skill.skill803.ActivationSkillResponse;
	import proto.skill.skill805.LoadSkillRequest;
	import proto.skill.skill805.LoadSkillResponse;
	import proto.skill.skill806.UnLoadSkillRequest;
	import proto.skill.skill806.UnLoadSkillResponse;
	
	import sceneModule.model.vo.skillVo.SkillBasicInfoVo;
	import sceneModule.model.vo.skillVo.SkillInfoVo;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.skill.event.GetBattleSkillInfoResponseEvent;
	import sceneModule.view.skill.event.GetSkillInfoResponseEvent;
	import sceneModule.view.skill.view.MainMenuBattleSkillComponent;
	import sceneModule.view.skill.view.MainMenuSkillItemRender;
	import sceneModule.view.skill.view.MainMenuSkillTooltip;
	
	import service.ISocketServer;

	public class MainMenuSkillItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:MainMenuSkillItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var _toolTip:MainMenuSkillTooltip;
		public function MainMenuSkillItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.comp.skillImg.doubleClickEnabled = true;
			this.eventMap.mapListener(comp.skillImg,MouseEvent.MOUSE_MOVE,onMouseMove);
			this.eventMap.mapListener(comp.skillImg,MouseEvent.MOUSE_OUT,onMouseOut);
//			this.eventMap.mapListener(comp.iBtn,MouseEvent.CLICK,onClickBtn);
			
			this.eventMap.mapListener(comp.skillImg,MouseEvent.CLICK,onMouseClick);
		}
		
		override public function onRemove():void{
			this.eventMap.unmapListener(comp.skillImg,MouseEvent.MOUSE_MOVE,onMouseMove);
			this.eventMap.unmapListener(comp.skillImg,MouseEvent.MOUSE_OUT,onMouseOut);
//			this.eventMap.unmapListener(comp.iBtn,MouseEvent.CLICK,onClickBtn);
			
			this.eventMap.unmapListener(comp.skillImg,MouseEvent.CLICK,onMouseClick);
			
			comp.skillImg.source = null;
			_toolTip = null;
		}
		//MouseDown
		private function onMouseClick(evt:MouseEvent):void{
			//执行鼠标双击事件
			onLoadSkill(comp.data.skillId,-1);
		}
		/**
		 * 装载技能 
		 * @param evt
		 * 
		 */	
		private function onLoadSkill(skillId:int,pos:int):void{
			var loadSkillReq:LoadSkillRequest = new LoadSkillRequest();
			loadSkillReq.id = SystemDataModel.roleId;
			loadSkillReq.skillId = skillId;
			loadSkillReq.skillPos = pos;
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
				//单击到技能设置
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
		private function onMouseMove(evt:MouseEvent):void{
		    if(!_toolTip){
				_toolTip = new MainMenuSkillTooltip();
				popUpWindowLayer.addElement(_toolTip);
			}
			if(!_toolTip.visible)_toolTip.visible = true;
			popUpWindowLayer.setElementIndex(_toolTip,popUpWindowLayer.numElements - 1);
			_toolTip.curDataInfo = comp.data as SkillBasicInfoVo;
			setToolTipPos();
		}
		private function onMouseOut(evt:MouseEvent):void{
			if(_toolTip && _toolTip.visible)_toolTip.visible = false;
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
		 * 升级或激活 
		 */		
		private function onClickBtn(evt:MouseEvent):void{
			if(comp.data.skillStatus == 0){
				onLevelUpSkill();
			}else{
				onActivationSkill();
			}
		}
		/**
		 *激活技能 
		 * 
		 */		
		private function onActivationSkill():void{
			var activationReq:ActivationSkillRequest = new ActivationSkillRequest();
			activationReq.id = SystemDataModel.roleId;
			activationReq.skillId = comp.data.skillId;
			var activationByte:ByteArray = new ByteArray();
			activationReq.writeExternal(activationByte);
			socketService.send(new mx.rpc.Responder(activationHandler,faultHandler),URLConst.SKILL_ACTIVATION_COMMANDID,activationByte);
		}
		private function activationHandler(data:Object):void{
			var resByteArray:ByteArray = data as ByteArray;
			var activationRes:ActivationSkillResponse = new ActivationSkillResponse();
			activationRes.readExternal(resByteArray);
			if(activationRes.result){
				onGetSkillData();
				//成功激活技能
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_SKILL_ACTIVE));
			}else{
				popUpShow.show(activationRes.message);
			}
		}
		/**
		 * 升级 
		 */		
		private function onLevelUpSkill():void{
			var levelUpRequest:LevelUpSkillRequest = new LevelUpSkillRequest();
			levelUpRequest.id = SystemDataModel.roleId;
			levelUpRequest.skillId = comp.data.skillId;
			var levelUpByteArray:ByteArray = new ByteArray();
			levelUpRequest.writeExternal(levelUpByteArray);
			socketService.send(new mx.rpc.Responder(levelUpHandler,faultHandler),URLConst.SKILL_LEVELUP_COMMANDID,levelUpByteArray);
		}
		private function levelUpHandler(data:Object):void{
			var levelUpByte:ByteArray = data as ByteArray;
			var levelUpRes:LevelUpSkillResponse = new LevelUpSkillResponse();
			levelUpRes.readExternal(levelUpByte);
			if(levelUpRes.result){
				onGetSkillData();
				onGetRoleSkillData();
			}else{
				popUpShow.show(levelUpRes.message);
			}
		}
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}