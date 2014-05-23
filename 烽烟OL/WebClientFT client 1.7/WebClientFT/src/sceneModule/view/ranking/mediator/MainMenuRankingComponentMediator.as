package sceneModule.view.ranking.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Menu;
	import mx.controls.Tree;
	import mx.core.FlexGlobals;
	import mx.events.ItemClickEvent;
	import mx.events.ListEvent;
	import mx.events.MenuEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.Suite;
	import proto.ranking.ranking2001.GetRankingListInfoRequest;
	import proto.ranking.ranking2002.GetMyScoreInfoRequest;
	import proto.ranking.ranking2002.GetMyScoreInfoResponse;
	import proto.ranking.ranking2002.MyScoreListInfo;
	import proto.scene.scene221.GetOtherRoleInfoRequest;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.ChangeWindowStateEvent;
	import sceneModule.model.vo.itemsVo.PackageSuite;
	import sceneModule.model.vo.rankingVO.MainRankingInfoVo;
	import sceneModule.model.vo.rankingVO.RankingScoreInfoVO;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.ranking.event.GetRankingListInfoResponseEvent;
	import sceneModule.view.ranking.view.MainMenuRankingComponent;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;

	/**
	 * 排行榜MainMenuRankingComponentMediator 
	 * @author Dream-Y
	 * 
	 */	
	public class MainMenuRankingComponentMediator extends Mediator
	{
		[Inject]
		public var comp:MainMenuRankingComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function MainMenuRankingComponentMediator()
		{
			super();
		}
		override public function onRegister():void{
			this.eventMap.mapListener(comp.cardtype,ItemClickEvent.ITEM_CLICK,onItemClick);
			this.eventMap.mapListener(comp.rankList,IndexChangeEvent.CHANGE,onRankListChange);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			onGetRankingListInfo(1);
		}
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(MainMenuRankingComponent.NAME,false,false,null,popUpWindowLayer);
		}
		
		private var myMenu:Menu;
		private function onRankListChange(evt:IndexChangeEvent):void{
			var arr:Array;
			arr = new Array([CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','clIRC_ck')]);
			
			myMenu = Menu.createMenu(null,getItemMenuData(arr), false);
			myMenu.labelField = 'label';
			myMenu.width = 100;
			myMenu.height = 100;
			myMenu.addEventListener(MenuEvent.ITEM_CLICK,onMenuItemClick);
			var menuX:int;
			var menuY:int = FlexGlobals.topLevelApplication.mouseY + 10;
			if(FlexGlobals.topLevelApplication.mouseX+10+myMenu.width > 1000){
				menuX = FlexGlobals.topLevelApplication.mouseX-10-myMenu.width
			}else{
				menuX = FlexGlobals.topLevelApplication.mouseX+10;
			}
			myMenu.show(500,500);
		}
		private function onMenuItemClick(evt:MenuEvent):void{
				switch(evt.index){
					case 0:
						//查看
						onLookOtherRoleInfo(1);
						break;
				}
		}
		/**
		 * 查看其他玩家信息
		 */
		private function onLookOtherRoleInfo(roleId:int):void{
			if(!SystemDataModel.curShowInfoIsOtherRoleFlag){
				SystemDataModel.curShowInfoIsOtherRoleFlag = true;
			}
			
			var getOtherRoleInfo:GetOtherRoleInfoRequest = new GetOtherRoleInfoRequest();
			getOtherRoleInfo.id = SystemDataModel.roleId;
			getOtherRoleInfo.roleId = roleId;
			var otherRoleByte:ByteArray = new ByteArray();
			getOtherRoleInfo.writeExternal(otherRoleByte);
		}
		private function getItemMenuData(itemArr:Array):Array {
			var l:int = itemArr.length;
			var itemMenuData:Array = new Array();
			for(var i:int=0;i<l;i++){
				var menuItem:Object = new Object();
				menuItem.label = itemArr[i];
				itemMenuData.push(menuItem);
			}
			return itemMenuData;
		}
		
		private function onItemClick(evt:ItemClickEvent):void{
			onGetRankingListInfo(MainRankingInfoVo.getRankingTypeOnSelected(comp.cardtype.selectedValue));
		}
		
		/**
		 * 获取排行榜信息
		 */
		private function onGetRankingListInfo(rankType:int):void{
			var getRankingRequest:GetRankingListInfoRequest = new GetRankingListInfoRequest();
			getRankingRequest.id = SystemDataModel.roleId;
			getRankingRequest.rankingType = rankType;
			var byteArray:ByteArray = new ByteArray();
			getRankingRequest.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(rankingHandler,faultHandler),URLConst.RANKING_GETLISTINFO_COMMANDID,byteArray);
		}
		private function rankingHandler(data:Object):void{
			this.dispatch(new GetRankingListInfoResponseEvent(GetRankingListInfoResponseEvent.GETRANKINGLISTINFORESPONSE,data));
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}