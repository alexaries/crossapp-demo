package sceneModule.view.skill.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.skill.skill801.GetSkillInfoRequest;
	import proto.skill.skill806.UnLoadSkillRequest;
	import proto.skill.skill806.UnLoadSkillResponse;
	
	import sceneModule.event.ChangeWindowStateEvent;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.skill.event.GetBattleSkillInfoResponseEvent;
	import sceneModule.view.skill.event.GetSkillInfoResponseEvent;
	import sceneModule.view.skill.event.MediatorRegisterSkillEvent;
	import sceneModule.view.skill.view.MainMenuBattleSkillComponent;
	import sceneModule.view.skill.view.MainMenuSkillComponent;
	
	import service.ISocketServer;

	public class MainMenuSkillComponentMediator extends Mediator
	{
		[Inject]
		public var comp:MainMenuSkillComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function MainMenuSkillComponentMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.learnSkill,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.mapListener(comp.learnSkill,DragEvent.DRAG_DROP,onDragDrop);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWin);
			this.eventMap.mapListener(comp,MediatorRegisterSkillEvent.MEDIATORREGISTER_SKILLITEMRENDER,onRegisterSkillComp);
			this.eventMap.mapListener(comp,MediatorRegisterSkillEvent.MEDIATORREGISTER_SKILLCOMP,onRegisterSkillComp);
			this.eventMap.mapListener(comp,MediatorRegisterSkillEvent.MEDIATORREGISTER_BATTLESKILL,onRegisterSkillComp);
		}
		
		private function onRegisterSkillComp(evt:MediatorRegisterSkillEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		override public function onRemove():void{
			this.eventMap.unmapListener(comp.learnSkill,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.unmapListener(comp.learnSkill,DragEvent.DRAG_DROP,onDragDrop);
			this.eventMap.unmapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWin);
		}
		
		private function onCloseWin(evt:MouseEvent):void{
			WindowManager.closeWindow(MainMenuSkillComponent.NAME,false,false,null,popUpWindowLayer);
		}
		
		private function onDragEnter(evt:DragEvent):void{
			if (evt.dragSource.hasFormat(MainMenuBattleSkillComponent.FROMROLESKILL)) //如果标号为format则接受拖来的物体
			{
				DragManager.acceptDragDrop(IUIComponent(evt.target)); // 接受被拖进来的物体       
			}
		}
		private function onDragDrop(evt:DragEvent):void{
			var batSkillData:Object = evt.dragSource.dataForFormat(MainMenuBattleSkillComponent.FROMROLESKILL);
			if(batSkillData){
				//卸载技能TODO
				onUnLoadSkill(batSkillData.skillId,batSkillData.pos);
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
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}