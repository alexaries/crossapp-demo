package sceneModule.view.colonMan.command
{
	import flash.events.EventDispatcher;
	import flash.media.Video;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.ItemsInfo;
	import proto.Suite;
	import proto.colo.colo2901.ColonizationInfo;
	import proto.colo.colo2901.GetColonizationListRequest;
	import proto.colo.colo2901.GetColonizationListResponse;
	import proto.colo.colo2902.ColoFuBenInfo;
	import proto.colo.colo2902.GetColonFuBenListRequest;
	import proto.colo.colo2902.GetColonFuBenListResponse;
	import proto.reward.reward2405.CopyInfo;
	import proto.reward.reward2405.GetColonizationSceneInfoRequest;
	import proto.reward.reward2405.GetColonizationSceneInfoResponse;
	import proto.reward.reward2408.ObtainItemRequest;
	import proto.reward.reward2408.ObtainItemResponse;
	import proto.reward.reward2409.OpenCangkuRequest;
	import proto.reward.reward2409.OpenCangkuResponse;
	import proto.scene.scene204.PackageInfo;
	import proto.scene.scene204.getItemsInPackageRequest;
	import proto.scene.scene204.getItemsInPackageResponse;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.model.vo.packageVo.PackageSuite;
	import sceneModule.view.colonMan.vo.ColonaztionFuBenGroupVO;
	import sceneModule.view.colonMan.vo.ColonaztionFuBenInfoVO;
	import sceneModule.view.colonMan.vo.CopyColoInfoVO;
	import sceneModule.view.pack.event.PackageInfoChangeEvent;
	
	import service.ISocketServer;
	
	import util.PackageIitemInfoSettingUtil;

	public class ColonManMessage extends EventDispatcher 
	{
		[Inject]
		public var socketService:ISocketServer;
		
		private static var _instance:ColonManMessage;
		public function ColonManMessage()
		{
		}
		
		public static function getInstance():ColonManMessage{
			if(null == _instance){
				_instance = new ColonManMessage();
			}
			return _instance;
		}
		
		public function getSetColoManInfo():void{
			SystemDataModel.colonizationInfo.curPage = 1;
			SystemDataModel.colonizationInfo.maxPage = 1;
			var l:int = 5;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var copyColoInfoVo:CopyColoInfoVO = new CopyColoInfoVO();
				copyColoInfoVo.c_id=i;//副本id
				copyColoInfoVo.c_name=i+'AAABBBCCC';//副本名称
				copyColoInfoVo.li_liang=100;//基础力量
				copyColoInfoVo.add_li_liang=100;//力量加成
				copyColoInfoVo.min_jie=100;//敏捷
				copyColoInfoVo.add_min_jie=100;//敏捷加成
				copyColoInfoVo.zhi_li=100;//智力
				copyColoInfoVo.add_zhi_li=100;//智力加成
				copyColoInfoVo.nai_li=100;//耐力
				copyColoInfoVo.add_nai_li=100;//耐力加成
				copyColoInfoVo.ji_shen=100;//精神
				copyColoInfoVo.add_ji_shen=100;//精神加成
				copyColoInfoVo.wu_gong=100;//物攻
				copyColoInfoVo.add_wu_gong=100;//物攻加成
				copyColoInfoVo.wu_fang=100;//物防
				copyColoInfoVo.add_wu_fang=100;//物防加成
				copyColoInfoVo.mo_gong=100;//魔攻
				copyColoInfoVo.add_mo_gong=100;//魔攻加成
				copyColoInfoVo.mo_fang=100;//魔防
				copyColoInfoVo.add_mo_fang=100;//魔防加成
				copyColoInfoVo.gong_su=100;//攻速
				copyColoInfoVo.add_gong_su=100;//攻速加成
				copyColoInfoVo.ming_zhong=100;//命中
				copyColoInfoVo.add_ming_zhong=100;//命中加成
				copyColoInfoVo.bao_ji=100;//暴击
				copyColoInfoVo.add_bao_ji=100;//暴击加成
				copyColoInfoVo.shan_bi=100;//闪避
				copyColoInfoVo.add_shan_bi=100;//闪避加成
				copyColoInfoVo.liliang_info.remainTime = 10000;//力量药剂信息
				copyColoInfoVo.liliang_info.status = 1;//力量药剂信息
				copyColoInfoVo.minjie_info.remainTime = 10000;//敏捷药剂信息
				copyColoInfoVo.minjie_info.status = 0;//敏捷药剂信息
				copyColoInfoVo.zhili_info.remainTime = 10000;//智力药剂信息
				copyColoInfoVo.zhili_info.status = 1;//智力药剂信息
				copyColoInfoVo.naili_info.remainTime = 10000;//耐力药剂信息
				copyColoInfoVo.naili_info.status = 1;//耐力药剂信息
				copyColoInfoVo.jingshen_info.remainTime = 1000*i;//精神药剂信息
				copyColoInfoVo.jingshen_info.status = 0;//精神药剂信息
				arr.addItem(copyColoInfoVo);
			}
			SystemDataModel.colonizationInfo.copyInfoArr.source = arr.toArray();
		}
		
		public function getColoManInfo(curPage:int):void{
//			getSetColoManInfo();
			var getColoManReq:GetColonizationSceneInfoRequest = new GetColonizationSceneInfoRequest();
			getColoManReq.id = SystemDataModel.roleId;
			getColoManReq.curPage = curPage;
			var byteArray:ByteArray = new ByteArray();
			getColoManReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(colonHandler,faultHandler),URLConst.REWARD_COLONI_COMMANDID,byteArray);
		}
		
		private function colonHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetColonizationSceneInfoResponse = new GetColonizationSceneInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.colonizationInfo.curPage = responseData.data.curPage;
				SystemDataModel.colonizationInfo.maxPage = responseData.data.maxPage;
				var l:int = responseData.data.copyInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var copyInfo:CopyInfo = responseData.data.copyInfo[i];
					var copyColoInfoVo:CopyColoInfoVO = new CopyColoInfoVO();
					copyColoInfoVo.c_id=copyInfo.cId;//副本id
					copyColoInfoVo.c_name=copyInfo.cName;//副本名称
					copyColoInfoVo.li_liang=copyInfo.liLiang;//基础力量
					copyColoInfoVo.add_li_liang=copyInfo.addLiLiang;//力量加成
					copyColoInfoVo.min_jie=copyInfo.minJie;//敏捷
					copyColoInfoVo.add_min_jie=copyInfo.addMinJie;//敏捷加成
					copyColoInfoVo.zhi_li=copyInfo.zhiLi;//智力
					copyColoInfoVo.add_zhi_li=copyInfo.addZhiLi;//智力加成
					copyColoInfoVo.nai_li=copyInfo.naiLi;//耐力
					copyColoInfoVo.add_nai_li=copyInfo.addNaiLi;//耐力加成
					copyColoInfoVo.ji_shen=copyInfo.jiShen;//精神
					copyColoInfoVo.add_ji_shen=copyInfo.addJiShen;//精神加成
					copyColoInfoVo.wu_gong=copyInfo.wuGong;//物攻
					copyColoInfoVo.add_wu_gong=copyInfo.addWuGong;//物攻加成
					copyColoInfoVo.wu_fang=copyInfo.wuFang;//物防
					copyColoInfoVo.add_wu_fang=copyInfo.addWuFang;//物防加成
					copyColoInfoVo.mo_gong=copyInfo.moGong;//魔攻
					copyColoInfoVo.add_mo_gong=copyInfo.addMoGong;//魔攻加成
					copyColoInfoVo.mo_fang=copyInfo.moFang;//魔防
					copyColoInfoVo.add_mo_fang=copyInfo.addMoFang;//魔防加成
					copyColoInfoVo.gong_su=copyInfo.gongSu;//攻速
					copyColoInfoVo.add_gong_su=copyInfo.addGongSu;//攻速加成
					copyColoInfoVo.ming_zhong=copyInfo.mingZhong;//命中
					copyColoInfoVo.add_ming_zhong=copyInfo.addMingZhong;//命中加成
					copyColoInfoVo.bao_ji=copyInfo.baoJi;//暴击
					copyColoInfoVo.add_bao_ji=copyInfo.addBaoJi;//暴击加成
					copyColoInfoVo.shan_bi=copyInfo.shanBi;//闪避
					copyColoInfoVo.add_shan_bi=copyInfo.addShanBi;//闪避加成
					copyColoInfoVo.liliang_info.remainTime = copyInfo.liliangInfo.remainTime;//力量药剂信息
					copyColoInfoVo.liliang_info.status = copyInfo.liliangInfo.status;//力量药剂信息
					copyColoInfoVo.minjie_info.remainTime = copyInfo.minjieInfo.remainTime;//敏捷药剂信息
					copyColoInfoVo.minjie_info.status = copyInfo.minjieInfo.status;//敏捷药剂信息
					copyColoInfoVo.zhili_info.remainTime = copyInfo.zhiliInfo.remainTime;//智力药剂信息
					copyColoInfoVo.zhili_info.status = copyInfo.zhiliInfo.status;//智力药剂信息
					copyColoInfoVo.naili_info.remainTime = copyInfo.nailiInfo.remainTime;//耐力药剂信息
					copyColoInfoVo.naili_info.status = copyInfo.nailiInfo.status;//耐力药剂信息
					copyColoInfoVo.jingshen_info.remainTime = copyInfo.jingshenInfo.remainTime;//精神药剂信息
					copyColoInfoVo.jingshen_info.status = copyInfo.jingshenInfo.status;//精神药剂信息
					arr.addItem(copyColoInfoVo);
				}
				SystemDataModel.colonizationInfo.copyInfoArr.source = arr.toArray();
			}
		}
		
		public function getCangKuInfo():void{
			var requestGetItemInPackage:proto.scene.scene204.getItemsInPackageRequest = new getItemsInPackageRequest();
			requestGetItemInPackage.id = SystemDataModel.roleId;
			var itemInPackageByteArray:ByteArray = new ByteArray();
			requestGetItemInPackage.writeExternal(itemInPackageByteArray);
			socketService.send(new mx.rpc.Responder(itemInPackageResultHandler,faultHandler),URLConst.CANGKU_INFO_COMMANDID,itemInPackageByteArray);
		}
		
		private function itemInPackageResultHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:getItemsInPackageResponse=new getItemsInPackageResponse();
			responseData.readExternal(byteArray);
			if(responseData.result && responseData.data){
				var l:int = responseData.data.packageItemInfo.length;
				SystemDataModel.cangKuInfoVo.canUseTileCount = responseData.data.packageSize;
				SystemDataModel.cangKuInfoVo.curOpenMaxCount = responseData.data.totalsize;
				var packageArr:ArrayCollection = new ArrayCollection();
				for(var i:int = 0;i<l;i++){
					//				   var packageInfoItem:PackageInfo = responseData.data.packageItemInfo[i];
					var packageInfoItem:PackageInfo = responseData.data.packageItemInfo[i];
					var itemInfo:ItemsInfo = packageInfoItem.itemInfo;//生成的
					var packageInfoVo:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(itemInfo.templateId);//VO
					PackageIitemInfoSettingUtil.setItemDefaultInfo2(packageInfoVo,itemInfo);
					packageArr.addItem(packageInfoVo);
				}
				
				SystemDataModel.cangKuInfoVo.packageInfoColl.source = packageArr.toArray();
				
				this.dispatchEvent(new PackageInfoChangeEvent(PackageInfoChangeEvent.CANGKUINFOCHANGEVENT));
			}
		}
		
		public function onObatinItem(pos:int=0,type:int=0):void{
			var obtainItemReq:ObtainItemRequest = new ObtainItemRequest();
			obtainItemReq.id = SystemDataModel.roleId;
			obtainItemReq.type = type;
			obtainItemReq.pos = pos;
			var byteArray:ByteArray = new ByteArray();
			obtainItemReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(obtainHandler,faultHandler),URLConst.OBTAIN_ITEM_COMMANDID,byteArray);
		}
		
		private function obtainHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ObtainItemResponse = new ObtainItemResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getCangKuInfo();
			}
		}
		
		public function onOpenCangku(pos:int):void{
			var openCangKuReq:OpenCangkuRequest = new OpenCangkuRequest();
			openCangKuReq.id = SystemDataModel.roleId;
			openCangKuReq.pos = pos;
			var byteArray:ByteArray = new ByteArray();
			openCangKuReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(openCangHandler,faultHandler),URLConst.OPEN_CANGKU_COMMANDID,byteArray);
		}
		private function openCangHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:OpenCangkuResponse = new OpenCangkuResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getCangKuInfo();
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private var returnFun:Function;
		public function getColoPrivilegeData(page:int=1,fun:Function = null):void{
//			getColoPrivilegeDataJia();
			var coloPriReq:GetColonizationListRequest = new GetColonizationListRequest();
			coloPriReq.id = SystemDataModel.roleId;
			coloPriReq.curPage = page;
			var byteArray:ByteArray = new ByteArray();
			coloPriReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(coloPriHandler,faultHandler),URLConst.COLO_LINGDI_LIST_COMMANDID,byteArray);
			
			returnFun = fun;
		}
		private function coloPriHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetColonizationListResponse = new GetColonizationListResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.colonizationPrivilegeInfo.curPage = responseData.rCurPage;
				SystemDataModel.colonizationPrivilegeInfo.maxPage = responseData.maxPage;
				var l:int = responseData.coloList.length;
				var arr:ArrayCollection = new ArrayCollection();
				
				for(var i:int=0; i<l; i++){
					var coloInfo:ColonizationInfo = responseData.coloList[i];
					var coloGroupInfo:ColonaztionFuBenGroupVO = new ColonaztionFuBenGroupVO();
					coloGroupInfo.coloId = coloInfo.coloId;
					coloGroupInfo.coloName = coloInfo.coloName;
					arr.addItem(coloGroupInfo);
				}
				
				SystemDataModel.colonizationPrivilegeInfo.colonizationList.source = arr.toArray();
				if(returnFun != null){
					returnFun();
				}
			}
		}
		private function getColoPrivilegeDataJia():void{
			SystemDataModel.colonizationPrivilegeInfo.curPage = 1;
			SystemDataModel.colonizationPrivilegeInfo.maxPage = 1;
			var l:int = 10;
			var arr:ArrayCollection = new ArrayCollection();
			
			for(var i:int=0; i<l; i++){
//				var coloInfo:ColonizationInfo = responseData.coloList[i];
				var coloGroupInfo:ColonaztionFuBenGroupVO = new ColonaztionFuBenGroupVO();
				coloGroupInfo.coloId = i+1;
				coloGroupInfo.coloName = '策划坑爹'+i;
				arr.addItem(coloGroupInfo);
			}
			
			SystemDataModel.colonizationPrivilegeInfo.colonizationList.source = arr.toArray();
		}
		
		public function getColoFuBenGroupInfo(coloId:int):void{
//			getColoFuBenGroupInfoJia();
			var fubenGroupReq:GetColonFuBenListRequest = new GetColonFuBenListRequest();
			fubenGroupReq.id = SystemDataModel.roleId;
			fubenGroupReq.coloId = coloId;
			var byteArray:ByteArray = new ByteArray();
			fubenGroupReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(fubenHandler,faultHandler),URLConst.COLO_FUBEN_INFO_COMMANDID,byteArray);
		}
		private function fubenHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetColonFuBenListResponse = new GetColonFuBenListResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.curColonizationFuBenInfo.curColonaztionDes = responseData.coloDes;
			    var l:int = responseData.fuBenlist.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int = 0; i<l; i++){
					var coloFuBenInfo:ColoFuBenInfo = responseData.fuBenlist[i];
					var coloFuBenInfoVo:ColonaztionFuBenInfoVO = new ColonaztionFuBenInfoVO();
					coloFuBenInfoVo.coloCorpsName = coloFuBenInfo.coloCorpsName;
					coloFuBenInfoVo.coloType = coloFuBenInfo.coloType;
					coloFuBenInfoVo.fuBenId = coloFuBenInfo.fuBenId;
					coloFuBenInfoVo.fuBenName = coloFuBenInfo.fuBenName;
					coloFuBenInfoVo.lingzhu = coloFuBenInfo.lingzhu;
					coloFuBenInfoVo._fu_camp = coloFuBenInfo.FuCamp;
					arr.addItem(coloFuBenInfoVo);
				}
				SystemDataModel.curColonizationFuBenInfo.fubenList.source = arr.toArray();
			}
		}
		public function getColoFuBenGroupInfoJia():void{
			SystemDataModel.curColonizationFuBenInfo.curColonaztionDes = '坑爹的策划';
			var l:int = 10;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int = 0; i<l; i++){
//				var coloFuBenInfo:ColoFuBenInfo = responseData.fuBenlist[i];
				var coloFuBenInfoVo:ColonaztionFuBenInfoVO = new ColonaztionFuBenInfoVO();
				coloFuBenInfoVo.coloCorpsName = '坑爹的策划';
				coloFuBenInfoVo.coloType = 1;
				coloFuBenInfoVo.fuBenId = i+1;
				coloFuBenInfoVo.fuBenName = '坑爹的策划'+i;
				coloFuBenInfoVo.lingzhu = '坑爹的策划'+i+1;
				coloFuBenInfoVo._fu_camp = 1;
				arr.addItem(coloFuBenInfoVo);
			}
			SystemDataModel.curColonizationFuBenInfo.fubenList.source = arr.toArray();
		}
	}
}