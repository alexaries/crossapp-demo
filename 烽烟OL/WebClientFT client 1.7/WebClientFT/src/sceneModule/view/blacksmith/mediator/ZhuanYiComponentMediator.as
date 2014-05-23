package sceneModule.view.blacksmith.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.events.IndexChangedEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.blacksmith.blacksmith2119.StrengthenItemRequest;
	import proto.blacksmith.blacksmith2119.StrengthenItemResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.blacksmith.view.MainEquipmentZhuanYiComponent;
	import sceneModule.view.blacksmith.view.ZhuanYiComponent;
	import sceneModule.view.blacksmith.view.ZhuanYiItemRender;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.shop.command.ShopMessage;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;
	
	import util.DelayExcuter;

	public class ZhuanYiComponentMediator extends Mediator
	{
		[Inject]
		public var comp:ZhuanYiComponent;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		[Inject]
		public var socket:ISocketServer;

		[Inject]
		public var popUpShow:IPopUpShow;

		public function ZhuanYiComponentMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			ShopMessage.getInstance().getStrengthenPackageInfo();
			this.eventMap.mapListener(comp.pre_btn, MouseEvent.CLICK, onPrePage);
			this.eventMap.mapListener(comp.next_btn, MouseEvent.CLICK, onNextPage);
			
			this.eventMap.mapListener(comp.changePropBtn, MouseEvent.CLICK, onChangProp);
			this.eventMap.mapListener(comp.s1, DragEvent.DRAG_ENTER, onDragEnter);
			this.eventMap.mapListener(comp.s1, DragEvent.DRAG_DROP, onDrag1Drop);

			this.eventMap.mapListener(comp.s2, DragEvent.DRAG_ENTER, onDragEnter);
			this.eventMap.mapListener(comp.s2, DragEvent.DRAG_DROP, onDrag2Drop);
			
			this.eventMap.mapListener(comp.equipmentChangeProp, DragEvent.DRAG_ENTER, onListDragEnter);
			this.eventMap.mapListener(comp.equipmentChangeProp, DragEvent.DRAG_DROP, onListDragDrop);
		}
		
		private function onListDragEnter(evt:DragEvent):void
		{
			if (evt.dragSource.dataForFormat(MainEquipmentZhuanYiComponent.FROMPACKAGE))
			{
				DragManager.acceptDragDrop(IUIComponent(evt.target));
			}
		}
		
		private function onListDragDrop(evt:DragEvent):void
		{
			if(comp.s1.data)
			{
				comp.s1.data=null;
			}else if(comp.s2.data)
			{
				comp.s2.data=null;
			}
		}
		
		
		private function onPrePage(evt:MouseEvent):void
		{
			ShopMessage.getInstance().getStrengthenPackageInfo(SystemDataModel.strPackageInfo.curPage - 1);
		}
		
		private function onNextPage(evt:MouseEvent):void
		{
			ShopMessage.getInstance().getStrengthenPackageInfo(SystemDataModel.strPackageInfo.curPage + 1);
		}
		
		private function onChangProp(evt:MouseEvent):void
		{
			var strengthenreq:StrengthenItemRequest=new StrengthenItemRequest();
			strengthenreq.id=SystemDataModel.roleId;


			strengthenreq.itemId1=comp.s1.data.id;
			strengthenreq.itemId2=comp.s2.data.id;

			var byteArray:ByteArray=new ByteArray();
			strengthenreq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(strengThenHandler, faultHandler), URLConst.QUEREN_CHANGEPROP_COMMANDID, byteArray);
		}

		private function onDragEnter(evt:DragEvent):void
		{
			if (evt.dragSource.dataForFormat(ZhuanYiItemRender.DRAGNAME))
			{
				DragManager.acceptDragDrop(IUIComponent(evt.target));
			}
		}


		private function onDrag1Drop(evt:DragEvent):void
		{
			var itemObj:Object=evt.dragSource.dataForFormat(ZhuanYiItemRender.DRAGNAME);
			comp.s1.data=itemObj;
			if(comp.s2.data)
			{
				if(comp.s1.data.id==comp.s2.data.id)
				{
					comp.s2.data=null;
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','zyCM_xtzy'));
				}
			}
			
			if(comp.s2.data)
			{
				if(comp.s1.data.bodyType!=comp.s2.data.bodyType)
				{
					comp.s1.data=null;
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','zyCM_lxzy'));
				}
			}
			
			acctep();
		}

		private function onDrag2Drop(evt:DragEvent):void
		{
			var itemObj:Object=evt.dragSource.dataForFormat(ZhuanYiItemRender.DRAGNAME);
			comp.s2.data=itemObj;
			if(comp.s1.data)
			{
				if(comp.s1.data.id==comp.s2.data.id)
				{
					comp.s1.data=null;
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','zyCM_xtzy'));
				}
			}
			
			if(comp.s1.data)
			{
				if(comp.s1.data.bodyType!=comp.s2.data.bodyType)
				{
					comp.s2.data=null;
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','zyCM_lxzy'));
				}
			}
			acctep();
		}

		private function acctep():void
		{
			if (comp.s1.data && comp.s2.data)
			{
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ZHUNBEI_QIANGHUA)]);

				var oneReq:StrengthenItemRequest=new StrengthenItemRequest();
				oneReq.id=SystemDataModel.roleId;
				oneReq.itemId1=comp.s1.data.id;
				oneReq.itemId2=comp.s2.data.id;
				var byteArray:ByteArray=new ByteArray();
				oneReq.writeExternal(byteArray);
				socket.send(new mx.rpc.Responder(nextHandler, faultHandler), URLConst.BLACKSMITH_CHANGEPROP_COMMANDID, byteArray);
			}
		}

		private function strengThenHandler(data:Object):void
		{
			var byteArray:ByteArray=data as ByteArray;
			var responseData:StrengthenItemResponse=new StrengthenItemResponse();
			responseData.readExternal(byteArray);
			if (responseData.result)
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','zyCM_zycg'));
				resetInfo();
				ShopMessage.getInstance().getStrengthenPackageInfo(SystemDataModel.strPackageInfo.curPage);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ZHUNBEI_QIANGHUA)]);
			}
			else
			{
				popUpShow.show(responseData.message);
			}
		}

		private function faultHandler(evt:FaultEvent):void
		{

		}

		private function nextHandler(data:Object):void
		{
			var byteArray:ByteArray=data as ByteArray;
			var responseData:StrengthenItemResponse=new StrengthenItemResponse();
			responseData.readExternal(byteArray);
			if (responseData.result)
			{
				comp.equip1.text=comp.s1.data.name;
				comp.equip2.text=comp.s2.data.name;
				comp.equipA.text=comp.s1.data.name;
				comp.equipB.text=comp.s2.data.name;
				comp.xiaohaoLabel.text=responseData.qh.toString();
				comp.jinbiLabel.text=responseData.coin.toString();
				if (SystemDataModel.roleInfo.coin >= responseData.coin)
				{
					comp.changePropBtn.enabled=true;
				}
				else
				{
					comp.changePropBtn.enabled=false;
					comp.needCoin.visible=true;
				}
			}
		}

		private function resetInfo():void
		{
			comp.s1.data=null;
			comp.s2.data=null;
			comp.equip1.text='';
			comp.equip2.text='';
			comp.equipA.text='';
			comp.equipB.text='';
			comp.xiaohaoLabel.text='';
			comp.jinbiLabel.text='';
			comp.changePropBtn.enabled=false;
		}
	}
}
