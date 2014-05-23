package sceneModule.view.corps.mediator
{
	import event.GuidClearEvent;
	import event.GuidEventCenter;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.AssetCenter;
	
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.corps.view.ChoseCorpsComponent;
	import sceneModule.view.corps.view.NCropEmblemView;
	import sceneModule.view.corps.view.NCropKejiView;
	import sceneModule.view.corps.view.NCropMemberView;
	import sceneModule.view.corps.view.NCropRequestView;
	import sceneModule.view.corps.view.NCropsInView;
	import sceneModule.view.corps.view.NCropsOutView;
	import sceneModule.view.corps.view.NCropsRootView;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.xtrace;

	public class NCorpsRootMediator extends Mediator
	{
		[Inject]
		public var socketService:ISocketServer;
		[Inject]
		public var comp:NCropsRootView;
		[Inject]
		public var out_view:NCropsOutView;
		[Inject]
		public var in_view:NCropsInView;
		[Inject]
		public var request_view:NCropRequestView;
		[Inject]
		public var member_view:NCropMemberView;
		[Inject]
		public var emblem_view:NCropEmblemView;
		[Inject]
		public var keji_view:NCropKejiView;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		
		public static const CAR_TYPE_UNION_LIST:String = "0";
		public static const CAR_TYPE_MEMBER_LIST:String = "1";
		public static const CAR_TYPE_Emblem:String = "2";
		public static const CAR_TYPE_Keji:String = "3";
		public static const CAR_TYPE_REQUEST_LIST:String = "5";
		
		private var _car_type:String;
		
		
		public function NCorpsRootMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			this.eventDispatcher.addEventListener(NCropsEvent.EVENT_Crops_REFRESH, refresh);
			this.addContextListener(NCropsEvent.EVENT_Crops_TAB_BAR, on_refresh_tab, NCropsEvent);
			comp.cardtype.addEventListener(flash.events.Event.CHANGE,on_change_car);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			
			refresh();
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(NCropsRootView.NAME,false,false,null,popUpWindowLayer);
		}
		
		override public function preRemove():void {
			this.eventDispatcher.removeEventListener(NCropsEvent.EVENT_Crops_REFRESH, refresh);
			comp.cardtype.removeEventListener(flash.events.Event.CHANGE,on_change_car);
		}
		
		private function refresh(e:NCropsEvent = null):void {
			AssetCenter.getInstance().load_package('ui_union', real_show, null, true);
		}
		
		private function real_show():void {
			xtrace("refresh crop");
//			CommonTools.make_bitmap(view.img_bg).bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_union', 'union_bg');
			
			var is_in:Boolean = SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag;
			if (is_in) {
				comp.to_in();
			}
			else {
				comp.to_not_in();
			}
			_car_type = CAR_TYPE_UNION_LIST;
			change_car();
		}
		
		private function on_change_car(e:Event):void{
			_car_type = String(comp.cardtype.selectedValue);
			change_car();
		}
		
		private function on_refresh_tab(e:NCropsEvent):void {
			var is_in:Boolean = SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag;
			if (is_in) {
				comp.to_in();
			}
			else {
				comp.to_not_in();
			}
		}
		
		
		private function change_car():void {
			if (WindowManager.isPopedUp(ChoseCorpsComponent.NAME)) {
				WindowManager.closeWindow(ChoseCorpsComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
				GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.CLOSE_UNION_ZHENYING));
			}
			comp.car_contain.removeAllElements();
			comp.cardtype.selectedValue = _car_type;
			switch (_car_type) 
			{
				case CAR_TYPE_UNION_LIST:
					this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_VIEW_OUT_REFRESH));
					comp.car_contain.addElement(out_view);
					mediatorMap.createMediator(out_view);
					break;
				case CAR_TYPE_MEMBER_LIST:
					this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_REFRESH_MEMBER_VIEW));
					comp.car_contain.addElement(member_view);
					mediatorMap.createMediator(member_view);
					break;
				case CAR_TYPE_Emblem:
					this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_REFRESH_Emblem_VIEW));
					comp.car_contain.addElement(emblem_view);
					mediatorMap.createMediator(emblem_view);
					break;
				case CAR_TYPE_Keji:
					this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_REFRESH_Keji_VIEW));
					comp.car_contain.addElement(keji_view);
					mediatorMap.createMediator(keji_view);
					break;
				case CAR_TYPE_REQUEST_LIST:
					this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_REFRESH_REQUEST_VIEW));
					comp.car_contain.addElement(request_view);
					mediatorMap.createMediator(request_view);
					break;
				default:
					break;
			}
		}
		
		private function remove_view():void {
			comp.removeAllElements();
		}
		
		public function get view():NCropsRootView {
			return viewComponent as NCropsRootView;
		}
	}
}