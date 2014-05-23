package sceneModule.view.territory.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.territory.territory2800.GetWaJueInfoRequest;
	import proto.territory.territory2800.GetWaJueInfoResponse;
	import proto.territory.territory2805.GetAramListInfoRequest;
	import proto.territory.territory2805.GetAramListInfoResponse;
	import proto.territory.territory2805.PetAramInfo;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.guanjue.view.GuanjueWindow;
	import sceneModule.view.sg.view.ShenDiWindow;
	import sceneModule.view.territory.model.TerritoryConfig;
	import sceneModule.view.territory.model.TerritoryPetInfoVO;
	import sceneModule.view.territory.view.AramWindow;
	import sceneModule.view.territory.view.BaseSprite;
	import sceneModule.view.territory.view.LianjinWindow;
	import sceneModule.view.territory.view.TerritoryWindow;
	import sceneModule.view.zhanxing.view.ZhanXingWindow;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.DelayExcuter;

	public class TerritoryWindowMediator extends Mediator
	{
		[Inject]
		public var comp:TerritoryWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		
		public function TerritoryWindowMediator()
		{
			
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.clokeBtn,MouseEvent.CLICK,onCloseWindow);
			initView();
		}
		
		private function initView():void{
			for each(var item:XML in TerritoryConfig.getInstance().territory_xml.territory){
				var terSprite:BaseSprite = new BaseSprite();
				terSprite.fun_type = item.@id;
				terSprite.name_ = item.@name;
				terSprite.x = item.@posx;
				terSprite.y = item.@posy;
				var des:String = '<font color="'+item.@textColor+'">'+item.@name + CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','tWM_sxdj')+ item.@reLevel + '</font>';
				terSprite.textInfo = des;
				terSprite.bitMap_sou = AssetCenter.getInstance().get_img_form_pacakge('ui_territory','terBuild_'+item.@icon);
				comp.ico_contain.addChild(terSprite);
				terSprite.settextPos(item.@textPosx,item.@textPosy);
				var reqLev:int = item.@reLevel;
				if(reqLev > SystemDataModel.roleInfo.level){
					terSprite.filters = new Array(CommonTools.changeColorFilter());
					terSprite.mouseEnabled = false;
					terSprite.mouseChildren = false;
				}else{
					terSprite.buttonMode = true;
					terSprite.useHandCursor = true;
					terSprite.addEventListener(MouseEvent.CLICK,onMouseClick);
				}
				
			}
		}
		
		private function onMouseClick(evt:MouseEvent):void{
			var targetObj:BaseSprite = evt.currentTarget as BaseSprite;
//			xtrace("targetObj.fun_type:=="+targetObj.fun_type);
			switch(targetObj.fun_type){
				case 1:
					getAramListInfo();
					break;
				case 2:
					onZhanXing();
					break;
				case 3:
					AssetCenter.getInstance().load_package("ui_shengdi",to_shengge,null,true,null,null,null);
					break;
				case 4:
					AssetCenter.getInstance().load_package("ui_guanjue",to_guanjue,null,true,null,null,null);
					break;
				case 5:
					AssetCenter.getInstance().load_package("ui_lianjin",to_lianjin,null,true,null,null,null);
					break;
			}

		}
		
		private function to_shengge():void{
			WindowManager.createWindow(ShenDiWindow.NAME,null,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer,true);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_UNION_ZHENYING_CHOSE)]);
		}
		
		
		private function onZhanXing():void{
			if(SystemDataModel.roleInfo.level<16){
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','tWM_bz16'));
				return;
			}
			AssetCenter.getInstance().load_package("ui_zhanxing",to_zhanxing,null,true,null,null,null);
			
		}
		
		private function to_zhanxing():void{
			WindowManager.createWindow(ZhanXingWindow.NAME,null,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer,true);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.UI_TANBAO)]);

		}
		
		private function to_lianjin():void{
			WindowManager.createWindow(LianjinWindow.NAME,null,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer,true);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TIEKUANGDONG)]);
		}
		
		private function to_guanjue():void{
			WindowManager.createWindow(GuanjueWindow.NAME,null,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer,true);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_FENGLU)]);
		}
		
//		private function getGuanJueInfo():void{
//			WindowManager.createWindow(GuanjueWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
//		}
		
		private function getAramListInfo():void{
			var getAramListReq:GetAramListInfoRequest = new GetAramListInfoRequest();
			getAramListReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getAramListReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(getAramHandler,faultHandler),URLConst.TERRITORY_ARAM_GETLIST_COMMANDID,byteArray);
		}
		
		private function getAramHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetAramListInfoResponse = new GetAramListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.aramInfoVo.roleRunningFlag = responseData.roleRunningFlag;
				SystemDataModel.aramInfoVo.roleRunTime = responseData.roleRunTime;
				SystemDataModel.aramInfoVo.sptimes = responseData.sptimes;
				SystemDataModel.aramInfoVo.expbound = responseData.expbound;
				SystemDataModel.aramInfoVo.goldreq = responseData.goldreq;
				var l:int = responseData.petAramInfo.length;
				var petArr:ArrayCollection = new ArrayCollection();
				for(var i:int = 0;i<l;i++){
					var petInfo:PetAramInfo = responseData.petAramInfo[i];
					var terPetInfoVo:TerritoryPetInfoVO = new TerritoryPetInfoVO();
					terPetInfoVo.icon = petInfo.icon;
					terPetInfoVo.petId = petInfo.petId;
					terPetInfoVo.petLevel = petInfo.petLevel;
					terPetInfoVo.petName = petInfo.petName;
					terPetInfoVo.remainTime = petInfo.remainTime;
					terPetInfoVo.resPetId = petInfo.resPetId;
					terPetInfoVo.runningFlag = petInfo.runningFlag;
					terPetInfoVo.type = petInfo.type;
					petArr.addItem(terPetInfoVo);
				}
				SystemDataModel.aramInfoVo.petAramInfo.source = petArr.toArray();
				AssetCenter.getInstance().load_package("ui_aram",to_aram,null,true,null,null,null);
			}
			
		}
		
		private function to_aram():void{
			WindowManager.createWindow(AramWindow.NAME,null,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer,true);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ZHUNBEI_QIANGHUA)]);

		}
		
		private function getLianjinInfo():void{
			var getWaJueReq:GetWaJueInfoRequest = new GetWaJueInfoRequest();
			getWaJueReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getWaJueReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(wajueHandler,faultHandler),URLConst.TERRITORY_GETLIANJININFO_COMMANDID,byteArray);
		}
		
		private function wajueHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetWaJueInfoResponse = new GetWaJueInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.lianjinInfoVo.runningFlag = responseData.runningTask;
				SystemDataModel.lianjinInfoVo.remainTime = responseData.remainTime;
				WindowManager.createWindow(LianjinWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER)]);
			}
		}
		
		private function onCloseWindow(evt:MouseEvent = null):void{
//			WindowManager.closeWindow(TerritoryWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
//			comp.img_bg.source = null;
//			comp.img_bg = null;
			WindowManager.closeAllWindows();
//			var l:int = comp.ico_contain.numElements;
//			for(var i:int=0;i<l;i++){
//				var sprite:BaseSprite = comp.ico_contain.getElementAt(i) as BaseSprite;
//				if(sprite){
//					sprite.clear();
//				}
//			}
//			comp.ico_contain.removeAllElements();
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}