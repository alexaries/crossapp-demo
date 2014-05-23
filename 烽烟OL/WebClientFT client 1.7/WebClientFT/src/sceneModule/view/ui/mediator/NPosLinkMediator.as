package sceneModule.view.ui.mediator
{
	import flash.events.MouseEvent;
	import wordscene.WordSceneSprite;
	
	import managers.ToolTipManager;
	import managers.WindowManager;
	
	import model.SystemDataModel;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.rvo.RSwitchVo;
	import sceneModule.view.gaAndsd.view.GuaJiConfimComponent;
	import sceneModule.view.roleInfo.view.RoleInfoShowTooltip;
	import sceneModule.view.ui.PosLinkItem;
	import sceneModule.view.ui.PosLinkView;
	import sceneModule.view.ui.event.NMainUIEvent;
	
	import util.xtrace;

	/**
	 * PlayerFriendsWindowMediator
	 * @author Yoalx
	 *
	 */
	public class NPosLinkMediator extends Mediator
	{
		public static const LINE_SIZE:int=2;

		[Inject]
		public var comp:PosLinkView;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		private var _items:Array;

		private var _base_x:int=18;
		private var _base_y:int=25;

		public var roleInfoShowTooltip:RoleInfoShowTooltip;

		public function NPosLinkMediator()
		{
			_items=[];
			super();
		}

		override public function onRegister():void
		{
			init_view();

			this.eventDispatcher.addEventListener(NMainUIEvent.NMainUIEvent_REFRESH_TRIPS_INFO, init_view);
		}

		override public function preRemove():void
		{
			this.eventDispatcher.removeEventListener(NMainUIEvent.NMainUIEvent_REFRESH_TRIPS_INFO, init_view);
		}


		private function init_view(e:NMainUIEvent=null):void
		{
			/*var item:PosLinkItem = new PosLinkItem();
			item.l_name.text = "hello word";
			comp.addElement(item);*/
			if (null == SystemDataModel.switchInfoArr)
			{
				return;
			}
			if (null == comp)
			{
				return;
			}

			var d_arr:Array=SystemDataModel.switchInfoArr;
			var d_len:int=d_arr.length;

			var v_len:int=_items.length;

			var index:int=0;
			for (; index < d_len; index++)
			{
				var info:RSwitchVo=d_arr[index] as RSwitchVo;
				if (v_len <= index)
				{
					//添加视图
					add_item(index, info);
				}
				else
				{
					//刷新视图
					var view_item:PosLinkItem=_items[index] as PosLinkItem;
					refresh_item(view_item, info);
				}
			}
			remove_item(index);
		}

		private function in_goto(e:MouseEvent):void
		{
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				var tag:PosLinkItem=e.currentTarget as PosLinkItem;
				var index:int=_items.indexOf(tag);
				if (-1 != index)
				{
					var info:RSwitchVo=SystemDataModel.switchInfoArr[index] as RSwitchVo;
					xtrace("自动寻路到传送门");
					//char.findPath(SystemDataModel.roleId, info.id);
					WordSceneSprite.getInstance().gotoTrip(info.id);
				}
			}
			
		}

		private function add_item(index:int, info:RSwitchVo):void
		{
			var item:PosLinkItem=new PosLinkItem();
			item.x = 70;
			item.y = 50 + index * 20;
			item.addEventListener(MouseEvent.CLICK, in_goto);

			item.addEventListener(MouseEvent.MOUSE_OVER, onPosMouseOver);
			item.addEventListener(MouseEvent.MOUSE_MOVE, onPosMouseMove);
			item.addEventListener(MouseEvent.MOUSE_OUT, onPosMouseOut);
			refresh_item(item, info);
			_items.push(item);
			comp.addElement(item);
		}

		private function refresh_item(view_item:PosLinkItem, info:RSwitchVo):void
		{
			view_item.l_name.text=info.name;
		}

		private function remove_item(index:int):void
		{
			while (_items.length > index)
			{
				var item:PosLinkItem=_items.pop();
				item.removeEventListener(MouseEvent.CLICK, in_goto);
				comp.removeElement(item);
			}
		}

		private function onPosMouseOver(evt:MouseEvent):void
		{
			if (!roleInfoShowTooltip)
			{
				roleInfoShowTooltip=ToolTipManager.showToolTip(RoleInfoShowTooltip.NAME) as RoleInfoShowTooltip;
			}
//			roleInfoShowTooltip.btDes="标题：副本寻路";
			roleInfoShowTooltip.msDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('ui','nplM_djxl');
			(evt.currentTarget as PosLinkItem).addElement(roleInfoShowTooltip);
		}

		private function onPosMouseOut(evt:MouseEvent):void
		{
			if (roleInfoShowTooltip)
			{
				(evt.currentTarget as PosLinkItem).removeElement(roleInfoShowTooltip);
			}
		}

		private function onPosMouseMove(evt:MouseEvent):void
		{
			if (roleInfoShowTooltip)
			{
//				if(((evt.currentTarget as PosLinkItem).mouseX+roleInfoShowTooltip.width)>FlexGlobals.topLevelApplication.width)
//				{
					roleInfoShowTooltip.x=(evt.currentTarget as PosLinkItem).mouseX - roleInfoShowTooltip.width;
					roleInfoShowTooltip.y=(evt.currentTarget as PosLinkItem).mouseY + 10;
//				}
				
			}
			
		}
	}
}
