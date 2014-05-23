package sceneModule.view.sysOpe.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.sysOpe.sysOpe2900.SysOpeCorpsResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.sysOpe.view.CorpsAppJoinCorpsComponent;
	import sceneModule.view.sysOpe.view.SysOpeCommonWindow;
	import sceneModule.view.sysOpe.view.SysOpeEquipmentWindow;
	import sceneModule.view.sysOpe.view.SysOpeGuaJiComponent;
	import sceneModule.view.sysOpe.view.SysOpeWindow;
	
	import service.ISocketServer;
	
	import spark.effects.Move;

	public class SysOpeWindowMediator extends Mediator
	{
		[Inject]
		public var comp:SysOpeWindow;
		
		[Inject]
		public var socketServer:ISocketServer;
		public function SysOpeWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.createBtn,MouseEvent.CLICK,onCreate);
			
			socketServer.send(new mx.rpc.Responder(corpsSysOpeHandler,faultHandler),URLConst.SYSOPE_SHOW_COMMANDID,null,false);
		}
		
		private function corpsSysOpeHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:SysOpeCorpsResponse = new SysOpeCorpsResponse();
			responseData.readExternal(byteArray);
			if(responseData.sysOpeType == 0){
				var str:String = "<u><a href='event:"+responseData.roleId+"?"+1+"?"+""+responseData.roleName+"'><font color='#92d050'>"+responseData.roleName+"</font></a></u>";
				var corpStr:String=str+CrotaResourceConfig.getInstance().getTextByModuleAndId('sysOpe','soWM_sqjr')
				var obj:Object = new Object();
				obj.type = 1;
				obj.roleId = responseData.roleId;
				obj.roleName = responseData.roleName;
				onCreateItemRender(corpStr,obj);
			}else if(responseData.sysOpeType == 1){
				var objE:Object = new Object();
				objE.icon = responseData.icon;//1安装装备2强化装备3升级技能4更换技能5升级宠物
				objE.iconType = responseData.type;
				objE.pos = responseData.pos;
				objE.page = responseData.curPage;
				objE.toPos = responseData.toposition;
				objE.type = responseData.sysOpeType;
				objE.tishiStr = responseData.tishiStr;
				objE.contentStr = responseData.contentStr;
				objE.caozuoStr = responseData.caozuoStr;//血量不足5%
				onCreateEquipment(objE);
			}else if(responseData.sysOpeType == 8){
				var gjComp:SysOpeGuaJiComponent = new SysOpeGuaJiComponent();
				gjComp.y = gjComp.height;
				gjComp.right = 50;
				comp.iContaner.addChild(gjComp);
				gjComp.setCurGuaJiInfo(responseData.guaJiInfo.exp,responseData.guaJiInfo.time);
				showCompEffect(gjComp);
			}
			else{
				var obj1:Object = new Object();
				obj1.type = responseData.sysOpeType;
				obj1.tishiStr = responseData.tishiStr;
				obj1.contentStr = responseData.contentStr;
				obj1.caozuoStr = responseData.caozuoStr;//血量不足5%
				
				if(SystemDataModel.sysOpeDictionary[responseData.sysOpeType] == null){
					onCreateCommon(obj1);
					SystemDataModel.sysOpeDictionary[responseData.sysOpeType] = obj1;
				}
			}
		}
		
		private function onCreate(evt:MouseEvent):void{
			onCreateItemRender('尼玛，坑爹的策划！');
		}
		
		private function onCreateCommon(obj:Object):void{
			var commonSys:SysOpeCommonWindow = new SysOpeCommonWindow();
			commonSys.y = commonSys.height;
			comp.iContaner.addChild(commonSys);
			commonSys._curObj = obj;
			showCompEffect(commonSys);
		}
		
		private function onCreateEquipment(obj:Object):void{
			var equipComp:SysOpeEquipmentWindow = new SysOpeEquipmentWindow();
			equipComp.y = equipComp.height;
			equipComp.curObj = obj;
			comp.iContaner.addChild(equipComp);
			showCompEffect(equipComp);
		}
		
		private function onCreateItemRender(msg:String,obj:Object = null):void{
			var sysItemRender:CorpsAppJoinCorpsComponent = new CorpsAppJoinCorpsComponent();
			sysItemRender.y = sysItemRender.height;
			sysItemRender.curObj = obj;
			comp.iContaner.addChild(sysItemRender);
			sysItemRender.iTextArea.htmlText = msg;
			showCompEffect(sysItemRender);
		}
		
		private function showCompEffect(_target:Object):void{
			var move:Move = new Move();
			move.target = _target;
			move.duration = 1000;
			move.yFrom = 83;
			move.yTo = -95;
			move.play();
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}