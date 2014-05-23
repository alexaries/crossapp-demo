package sceneModule.view.corps.event 
{
	import com.greensock.TweenLite;
	
	import flash.accessibility.Accessibility;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	import managers.UILayerManager;
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.UIComponent;
	import mx.rpc.Responder;
	
	import org.robotlegs.core.IMediatorMap;
	
	import proto.ItemsInfo;
	import proto.corps.corps1322.GetSingleUnionInfoRequest;
	import proto.corps.corps1322.GetSingleUnionInfoResponse;
	import proto.corps.corps1323.CorpsLevelUpNotify;
	import proto.corps.corps1323.CorpsLevelUpRequest;
	import proto.scene.scene221.GetOtherRoleInfoRequest;
	import proto.scene.scene221.GetOtherRoleInfoResponse;
	
	import resource.AssetCenter;
	
	import sceneModule.model.vo.RoleInfoVo;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.corps.view.CorpsInfoComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.roleInfo.view.MainLookRoleInfoComponent;
	import sceneModule.view.roleInfo.view.MainRoleInfoComponent;
	
	import service.ISocketServer;
	
	import util.PackageIitemInfoSettingUtil;
	import util.xtrace;

	/**
	 * ...
	 * @author hao
	 */
	public class NCropMessage extends EventDispatcher
	{
		[Inject]
		public var socketServer:ISocketServer;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public var map_mediarot:IMediatorMap;
		
		private var _price_mask:Sprite;
		/////////////////////////////////////////////////////////////////////////////////////
		private static var _instance:NCropMessage;
		public static function getInstance():NCropMessage {
			if (null == _instance) {
				_instance = new NCropMessage();
			}
			return _instance;
		}
		public function NCropMessage() 
		{
			super(this);
		}
		/////////////////////////////////////////////////////////////////////////////////////
		public function init_events():void {
			request_union_lvup(false);
		}
		
		
		//申请查看他人的信息
		public function request_see_other(id:int):void{
			var msg:GetOtherRoleInfoRequest = new GetOtherRoleInfoRequest();
			msg.id = SystemDataModel.roleId;
			msg.roleId = id;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			socketServer.send(new Responder(response_see_other,faultHandler),URLConst.GET_OTHERROLEINFO_COMMANDID,bytes);
		}
		
		private var info:RoleInfoVo = new RoleInfoVo();
		private function response_see_other(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetOtherRoleInfoResponse = new GetOtherRoleInfoResponse();
			responseData.readExternal(byteArray);
			
			if(responseData.result && responseData.data){
				info.id=responseData.data.otherRoleInfo.id;     //角色id
				info.nickname=responseData.data.otherRoleInfo.nickname;  //用户名
				info.roletype=responseData.data.otherRoleInfo.roletype; //角色类型（vip）
				info.level=responseData.data.otherRoleInfo.level;//角色等级
				info.profession=responseData.data.otherRoleInfo.profession;//角色职业
				info.energy=responseData.data.otherRoleInfo.energy;//角色的活力
				info.rank=responseData.data.otherRoleInfo.rank;//角色的军衔
				info.guildname=responseData.data.otherRoleInfo.guildname;// 角色行会的名称
//				info.roleCorpsInfo=responseData.data.otherRoleInfo.corpsInfo;//角色军团信息
				info.roleCorpsInfo.joinCorpsFlag=responseData.data.otherRoleInfo.corpsInfo.joinCorpsFlag;//角色是否加入军团
				info.roleCorpsInfo.corpsName=responseData.data.otherRoleInfo.corpsInfo.corpsName;//角色军团名称
				info.roleCorpsInfo.corpsPosition=responseData.data.otherRoleInfo.corpsInfo.corpsPosition;//角色军团职位
				info.roleCorpsInfo.corpsLevel=responseData.data.otherRoleInfo.corpsInfo.corpsLevel;//角色军团等级
				
				info.manualStr=responseData.data.otherRoleInfo.manualStr; //玩家自定义加的力量点数
				info.manualVit=responseData.data.otherRoleInfo.manualVit;//玩家自定义加的体质(耐力)点数
				info.manualDex=responseData.data.otherRoleInfo.manualDex;//玩家自定义加的灵巧(敏捷)点数
				info.manualWis=responseData.data.otherRoleInfo.manualWis;//自定义加上的智力
				info.maxHp=responseData.data.otherRoleInfo.maxHp;//最大血量
				info.hp=responseData.data.otherRoleInfo.hp;//当前血量
				info.exp=responseData.data.otherRoleInfo.exp;//当前经验值
				info.maxExp=responseData.data.otherRoleInfo.maxExp;//升级所需经验值
				info.physicalAttack=responseData.data.otherRoleInfo.physicalAttack;//物理攻击
				info.magicAttack=responseData.data.otherRoleInfo.magicAttack;//魔法攻击
				info.physicalDefense=responseData.data.otherRoleInfo.physicalDefense;//物理防御
				info.magicDefense=responseData.data.otherRoleInfo.magicDefense;//魔法防御
				info.speed=responseData.data.otherRoleInfo.speed;//速度
				info.critRate=responseData.data.otherRoleInfo.critRate;//暴击
				info.hitRate=responseData.data.otherRoleInfo.hitRate;//命中
				info.dodgeRate=responseData.data.otherRoleInfo.dodgeRate;//闪避
				info.gold=responseData.data.otherRoleInfo.gold;//魔钻(金币)
				info.coin=responseData.data.otherRoleInfo.coin;//游戏币
				info.deposit = responseData.data.otherRoleInfo.deposit;//存款
				info.block = responseData.data.otherRoleInfo.block;//抗爆
				
				//军团加成数据
				info.exULiliang = responseData.data.otherRoleInfo.exULiliang;
				info.exUMinjie = responseData.data.otherRoleInfo.exUMinjie;
				info.exUZhili = responseData.data.otherRoleInfo.exUZhili;
				info.exUNaili = responseData.data.otherRoleInfo.exUNaili;
				info.exUWugong = responseData.data.otherRoleInfo.exUWugong;
				info.exUMogong = responseData.data.otherRoleInfo.exUMonggong;
				
				info.unionType = responseData.data.otherRoleInfo.unionType;
				
				
				info.appellation.name = responseData.data.otherRoleInfo.appellation.name;
				info.appellation.idInDB = responseData.data.otherRoleInfo.appellation.idInDB;
				info.appellation.modID = responseData.data.otherRoleInfo.appellation.modID;
				
				var l:int = responseData.data.otherRoleItem.length;
				var arr:Array = [];
				for(var i:int=0;i<l;i++){
					if(responseData.data.otherRoleItem[i].itemInfo){
						arr.push(PackageIitemInfoSettingUtil.PackageItemSetting(responseData.data.otherRoleItem[i].itemInfo as ItemsInfo));
					}else{
						arr.push(new PackageItem());
					}
					
				}
				info.otherRoleItemsInfo.source = arr;
				AssetCenter.getInstance().load_package("ui_bg_role",to_roleinfo,null,true);
			}
		}
		private function to_roleinfo():void{
			WindowManager.createWindow(MainLookRoleInfoComponent.NAME,info,null,false,true,false,null, map_mediarot, popUpWindowLayer,true);
		}
		//查看军团信息
		public function request_single_union_info(id:int):void {
			var msg:GetSingleUnionInfoRequest = new GetSingleUnionInfoRequest();
			msg.id = SystemDataModel.roleId;
			msg.unionId = id;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("获取军团信息",msg);
			socketServer.send(new Responder(response_single_union_info,faultHandler),URLConst.CORPS_REQUEST_UNION_INFO,bytes);
		}
		private function response_single_union_info(bytes:ByteArray):void {
			var msg:GetSingleUnionInfoResponse = new GetSingleUnionInfoResponse();
			msg.readExternal(bytes);
			xtrace("获取军团信息回复", msg);
			if (msg.result) {
				var obj:Object = { };
				obj.corpsId = msg.corpsId;
				obj.corpsImg = msg.corpsImg;
				obj.corpsChief = msg.corpsChief;
				obj.corpsLevel = msg.corpsLevel;
				obj.curNum = msg.curNum;
				obj.maxNum = msg.maxNum;
				obj.onApplication = msg.onApplication;
				obj.corpsTitle = msg.corpsTitle;
				obj.corpsAnnouncement = msg.corpsAnnouncement;
				obj.corpsName = msg.corpsName;
				obj.leaderId = msg.leaderId;
				obj.is_in_union = SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag;
				obj.self_corp_pos = SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition;
				WindowManager.createWindow(CorpsInfoComponent.NAME,obj,null,false,false,false,null,map_mediarot,popUpWindowLayer);
			}
		}
		
		
		//申请军团升级信息
		public function request_union_lvup(issend:Boolean = true):void{
			var msg:CorpsLevelUpRequest = new CorpsLevelUpRequest();
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("申请军团升级信息");
			socketServer.send(new Responder(notify_union_lvup,faultHandler),URLConst.CORPS_LEVELUP,bytes,issend);
		}
		//军团升级信息广播
		private function notify_union_lvup(bytes:ByteArray):void {
			var msg:CorpsLevelUpNotify = new CorpsLevelUpNotify();
			msg.readExternal(bytes);
			xtrace("军团升级信息广播", msg);
			
			var tf_contain:Sprite = new Sprite();
			var layer:UIComponent = UILayerManager.getInstance().alert_layer;
			var t_w:int = 400;
			var t_h:int = 160;
			if (null == _price_mask) {
				_price_mask = new Sprite();
				
				var sptop:Sprite = new Sprite();
				sptop.graphics.beginGradientFill(GradientType.LINEAR, [0x000000, 0x000000], [0, 1], [100, 0xFF]);
				sptop.graphics.drawRect(0, 0, t_h, t_w);
				sptop.rotation = 90;
				sptop.x = t_w;
				_price_mask.addChild(sptop);
				
				var spdown:Sprite = new Sprite();
				spdown.graphics.beginGradientFill(GradientType.LINEAR, [0x000000, 0x000000], [0, 1], [100, 0xFF]);
				spdown.graphics.drawRect(0, 0, t_h, t_w);
				spdown.rotation = -90;
				spdown.y = t_h * 2;
				_price_mask.addChild(spdown);
				_price_mask.cacheAsBitmap = true;
				
				_price_mask.x = (layer.stage.stageWidth - _price_mask.width)/2;
				_price_mask.y = 105;
			}
			
			
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			var f:TextFormat = new TextFormat();
			f.size = 22;
			f.bold = true;
			f.color = 0xffff00;
			tf.defaultTextFormat = f;
			tf.cacheAsBitmap = true;
			var fi:GlowFilter = new  GlowFilter(0x333333, 1, 2, 2, 8);
			tf.filters = [fi];
			tf.text = "恭喜，您军团等级提升为" + msg.level + "级";
			tf.x = (layer.stage.stageWidth - tf.width)/2;
			tf.y = _price_mask.y + 2 * t_h;

			tf.mask = _price_mask;
			
			
			layer.addChild(tf);
			layer.addChild(_price_mask);
			
			TweenLite.to(tf, 5, {y:_price_mask.y - tf.height, onComplete:tfmove_over, onCompleteParams:[tf, _price_mask]} );
			
		}
		
		private function tfmove_over(tf:TextField, mask:DisplayObject):void {
			tf.parent && tf.parent.removeChild(tf);
			mask.parent && mask.parent.removeChild(mask);
		}
		
		
		
		private function faultHandler(e:Object):void {
			
		}
		
	}

}