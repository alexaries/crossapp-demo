package sceneModule.view.pet.command
{
	
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.pet.PetInfo;
	import proto.pet.pet2300.GetPetListInfoRequest;
	import proto.pet.pet2300.GetPetListInfoResponse;
	import proto.pet.pet2300.PetInfo;
	import proto.pet.pet2306.GetPetMatrixListRequest;
	import proto.pet.pet2306.GetPetMatrixListResponse;
	import proto.pet.pet2306.MatrixTitleInfo;
	import proto.pet.pet2307.SettingMatrixRequest;
	import proto.pet.pet2307.SettingMatrixResponse;
	import proto.pet.pet2311.GetOnePetInfoRequest;
	import proto.pet.pet2311.GetOnePetInfoResponse;
	import proto.pet.pet2311.PetSkillInfo;
	import proto.pet.pet2313.GetBeiJiChengListRequest;
	import proto.pet.pet2313.GetBeiJiChengListResponse;
	import proto.pet.pet2313.PetInfoList;
	import proto.pet.pet2315.GetTuJianPetListRequest;
	import proto.pet.pet2315.GetTuJianPetListResponse;
	import proto.pet.pet2315.sjPetInfo;
	import proto.pet.pet2316.GetOnePetTuJianInfoRequest;
	import proto.pet.pet2316.GetOnePetTuJianInfoResponse;
	
	import sceneModule.view.pet.event.GetPetListInfoResponseEvent;
	import sceneModule.view.pet.view.MainPetViewInfoComponent;
	import sceneModule.view.pet.vo.PetInfoVO;
	import sceneModule.view.pet.vo.PetJianInfoVO;
	import sceneModule.view.pet.vo.PetMatrixInfoVO;
	import sceneModule.view.pet.vo.PetMatrixTitleInfoVO;
	import sceneModule.view.pet.vo.PetSkillInfoVO;
	import sceneModule.view.pet.vo.PetTuJianInfoVO;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;
	import util.PackageIitemInfoSettingUtil;

	/**
	 * 宠物系统指令信息 
	 * @author Dream-Y
	 * 
	 */	
	public class PetMessage extends EventDispatcher
	{
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var _event_dispatcher:IEventDispatcher;
		
		private static var _instance:PetMessage;
		public function PetMessage()
		{
		}
		
		public static function getInstance():PetMessage{
			if(null == _instance){
				_instance = new PetMessage();
			}
			return _instance;
		}
		
		public function getOneTuJianInfo(pId:int):void{
			var gtjReq:GetOnePetTuJianInfoRequest = new GetOnePetTuJianInfoRequest();
			gtjReq.id = SystemDataModel.roleId;
			gtjReq.petId = pId;
			var byteArray:ByteArray = new ByteArray();
			gtjReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(gtjHandler,faultHandler),URLConst.PET_ONE_TUJIAN_INFO_COMMANDID,byteArray);
		}
		
		private function gtjHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetOnePetTuJianInfoResponse = new GetOnePetTuJianInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.otherPetInfoVo.curHun = responseData.curHun;
				SystemDataModel.otherPetInfoVo.maxHun = responseData.maxHun;
				SystemDataModel.otherPetInfoVo.reqCoin = responseData.reqCoin;
				PackageIitemInfoSettingUtil.setPetInfo(SystemDataModel.otherPetInfoVo,responseData.info);
			}
		}
		
		public function getTuJianListInfo(page:int=1,type:int=1):void{
			var tjReq:GetTuJianPetListRequest = new GetTuJianPetListRequest();
			tjReq.id = SystemDataModel.roleId;
			tjReq.page = page;
			tjReq.type = type;
			var byteArray:ByteArray = new ByteArray();
			tjReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(tjHandler,faultHandler),URLConst.PET_TUJIAN_PET_COMMANDID,byteArray);
		}
		
		private function tjHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetTuJianPetListResponse = new GetTuJianPetListResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.ptjListInfo.curPage = responseData.slInfo.curPage;
				SystemDataModel.ptjListInfo.maxPage = responseData.slInfo.maxPage;
				SystemDataModel.ptjListInfo.sjPro = responseData.slInfo.sjPro;
				var l:int = responseData.slInfo.sjListPet.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var ptjInfoVo:PetTuJianInfoVO = new PetTuJianInfoVO();
					var pInfoVo:sjPetInfo = responseData.slInfo.sjListPet[i];
					ptjInfoVo.petId = pInfoVo.petId;
					ptjInfoVo.petLevel = pInfoVo.petLevel;
					ptjInfoVo.petName = pInfoVo.petName;
					ptjInfoVo.viewFlag = pInfoVo.viewFlag;
					ptjInfoVo.quality = pInfoVo.quality;
					arr.addItem(ptjInfoVo);
				}
				SystemDataModel.ptjListInfo.sjListPet.source = arr.toArray();
			}
		}
		
		public function getBeiChuanChengList(petId:int):void{
			var bjcReq:GetBeiJiChengListRequest = new GetBeiJiChengListRequest();
			bjcReq.id = SystemDataModel.roleId;
			bjcReq.petId = petId;
			var byteArray:ByteArray = new ByteArray();
			bjcReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(bjcHandler,faultHandler),URLConst.PET_BEI_CHUAN_COMMANDID,byteArray);
		}
		
		private function bjcHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetBeiJiChengListResponse = new GetBeiJiChengListResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_FENGLU)]);

				var l:int = responseData.petInfoList.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var petInfoVo:PetInfoVO = new PetInfoVO();
					var petList:PetInfoList = responseData.petInfoList[i];
					PackageIitemInfoSettingUtil.setPetInfo(petInfoVo,petList.info);
					petInfoVo.reqCoin = petList.reqCoin;
					arr.addItem(petInfoVo);
				}
				SystemDataModel.bjcList.source = arr.toArray();

			}
		}
		
		public function getMatrixListInfoJia():void{
			SystemDataModel.petMatrixList.curNum = 5;
			SystemDataModel.petMatrixList.maxNum = 10;
			SystemDataModel.petMatrixList.jwDes = 'nima';
			
			var tl:int = 9;
			var tArr:ArrayCollection = new ArrayCollection();
			for(var ti:int=0;ti<tl;ti++){
				var matrixTileInfoVo:PetMatrixTitleInfoVO = new PetMatrixTitleInfoVO();
				matrixTileInfoVo.hasPet = false;
				matrixTileInfoVo.petId = 0;
				matrixTileInfoVo.type = 0;
				matrixTileInfoVo.icon = 0;
				matrixTileInfoVo.titlePos = ti;
				tArr.addItem(matrixTileInfoVo);
			}
			SystemDataModel.petMatrixList.matrixTitleList.source = tArr.toArray();
		}
		
		public function getMatrixListInfo():void{
			var getPetMatrixReq:GetPetMatrixListRequest = new GetPetMatrixListRequest();
			getPetMatrixReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getPetMatrixReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(matrixListHandler,faultHandler),URLConst.PET_GETMATRIX_COMMANDID,byteArray);
		}
		
		private function matrixListHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetPetMatrixListResponse = new GetPetMatrixListResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.petMatrixList.curNum = responseData.matrixInfo.curNum;
				SystemDataModel.petMatrixList.maxNum = responseData.matrixInfo.maxNum;
				SystemDataModel.petMatrixList.jwDes = responseData.matrixInfo.jwDes;
				
					var tl:int = responseData.matrixInfo.matrixTitleInfo.length;
					var tArr:ArrayCollection = new ArrayCollection();
					for(var ti:int=0;ti<tl;ti++){
						var matrixTileInfo:MatrixTitleInfo = responseData.matrixInfo.matrixTitleInfo[ti];
						var matrixTileInfoVo:PetMatrixTitleInfoVO = new PetMatrixTitleInfoVO();
						matrixTileInfoVo.hasPet = matrixTileInfo.hasPet;
						matrixTileInfoVo.petId = matrixTileInfo.petId;
						matrixTileInfoVo.type = matrixTileInfo.type;
						matrixTileInfoVo.icon = matrixTileInfo.icon;
						matrixTileInfoVo.titlePos = matrixTileInfo.titlePos;
						tArr.addItem(matrixTileInfoVo);
					}
					SystemDataModel.petMatrixList.matrixTitleList.source = tArr.toArray();
				}
		}
		
		public function getJiaPetInfo():void{
			var l:int = 5;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var petInfoVo:PetJianInfoVO = new PetJianInfoVO();
				petInfoVo.petId = i;//宠物id
				petInfoVo.resPetId = i;//宠物资源id
				petInfoVo.petName = 'aaaa';//宠物名称
				petInfoVo.petLevel=i;//宠物等级
				petInfoVo.type=220000;//暴击加成
				petInfoVo.icon=5001;//暴击加成
				arr.addItem(petInfoVo);
			}
			SystemDataModel.curPetNum = 5;
			SystemDataModel.maxPetNum = 10;
			SystemDataModel.petList.source = arr.toArray();
		}
		
		public function getPetInfo():void{
			var getPetListReq:GetPetListInfoRequest = new GetPetListInfoRequest();
			getPetListReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getPetListReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(getPetListHandler,faultHandler),URLConst.PET_GETLISTINFO_COMMANDID,byteArray);
		}
		private function getPetListHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetPetListInfoResponse = new GetPetListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.petInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var petInfo:proto.pet.pet2300.PetInfo = responseData.petInfo[i] as proto.pet.pet2300.PetInfo;
					var petInfoVo:PetJianInfoVO = new PetJianInfoVO();
					petInfoVo.petId = petInfo.petId;//宠物id
					petInfoVo.resPetId = petInfo.resPetId;//宠物资源id
					petInfoVo.petName = petInfo.petName;//宠物名称
					petInfoVo.petLevel=petInfo.petLevel;//宠物等级
					petInfoVo.type=petInfo.type;//暴击加成
					petInfoVo.icon=petInfo.icon;//暴击加成
					arr.addItem(petInfoVo);
				}
				SystemDataModel.curPetNum = responseData.curPetNum;
				SystemDataModel.maxPetNum = responseData.maxPetNum;
				SystemDataModel.petList.source = arr.toArray();
			}
		}
		
		/**
		 * 发送阵法站位改变指令
		 */
		private var tempFun:Function;
		public function sendModifyMatrixInfo(oType:int=0,pId:int=0,fPos:int=0,tPos:int=0,reHandler:Function = null):void{
			tempFun = reHandler;
			var settingMatrixReq:SettingMatrixRequest = new SettingMatrixRequest();
			settingMatrixReq.matrixId = SystemDataModel.tempMatrixId;
			settingMatrixReq.id = SystemDataModel.roleId;
			settingMatrixReq.operationType = oType;
			settingMatrixReq.petId = pId;
			settingMatrixReq.fromPos = fPos;
			settingMatrixReq.toPos = tPos;
			var byteArray:ByteArray = new ByteArray();
			settingMatrixReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(settingMatrixHandler,faultHandler),URLConst.PET_SETTINGMATRIX_COMMANDID,byteArray);
		}
		private function settingMatrixHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:SettingMatrixResponse = new SettingMatrixResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getMatrixListInfo();
				if(tempFun != null){
					tempFun();
				}
			}
		}
		
		public function set event_dispatcher(value:IEventDispatcher):void 
		{
			_event_dispatcher = value;
		}
		
		public function get event_dispatcher():IEventDispatcher{
			return _event_dispatcher;
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		
		
		public function getOnePetInfo(petId:int,masterId:int):void{
			var getOnePetInfoReq:GetOnePetInfoRequest = new GetOnePetInfoRequest();
			getOnePetInfoReq.id = SystemDataModel.roleId;
			getOnePetInfoReq.petId = petId;
			getOnePetInfoReq.masterId = masterId;
			var byteArray:ByteArray = new ByteArray();
			getOnePetInfoReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(petInfoHandler,faultHandler),URLConst.PET_VIEWINFO_COMMANDID,byteArray);
		}
		
		private function petInfoHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetOnePetInfoResponse = new GetOnePetInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.info){
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.PET_PEIYANG_ACTION)]);

//				SystemDataModel.otherPetInfoVo.petId = responseData.info.petId;//宠物id
//				SystemDataModel.otherPetInfoVo.resPetId = responseData.info.resPetId;//宠物资源id
//				SystemDataModel.otherPetInfoVo.petName = responseData.info.petName;//宠物名称
//				SystemDataModel.otherPetInfoVo.petLevel=responseData.info.petLevel;//宠物等级
//				SystemDataModel.otherPetInfoVo.inMatrixFlag = responseData.info.inMatrixFlag;//是否在阵法中
//				SystemDataModel.otherPetInfoVo.petDes=responseData.info.petDes;//宠物描述
//				SystemDataModel.otherPetInfoVo.baseHp=responseData.info.baseHp;//基础血量
//				SystemDataModel.otherPetInfoVo.manualHp=responseData.info.manualHp;//血量加成
//				SystemDataModel.otherPetInfoVo.basePhyAttack=responseData.info.basePhyAttack;//基础物理攻击
//				SystemDataModel.otherPetInfoVo.manualPhyAttack=responseData.info.manualPhyAttack;//物理攻击加成
//				SystemDataModel.otherPetInfoVo.baseMagicAttack=responseData.info.baseMagicAttack;//基础魔法攻击
//				SystemDataModel.otherPetInfoVo.manualMagicAttack=responseData.info.manualMagicAttack;//魔法攻击加成
//				SystemDataModel.otherPetInfoVo.basePhyDefense=responseData.info.basePhyDefense;//基础物理防御
//				SystemDataModel.otherPetInfoVo.manualPhyDefense=responseData.info.manualPhyDefense;//物理防御加成
//				SystemDataModel.otherPetInfoVo.baseMagicDefense=responseData.info.baseMagicDefense;//基础魔法防御
//				SystemDataModel.otherPetInfoVo.manualMagicDefense=responseData.info.manualMagicDefense;//魔法防御加成
//				SystemDataModel.otherPetInfoVo.baseHitRate=responseData.info.baseHitRate;//基础命中
//				SystemDataModel.otherPetInfoVo.manualHitRate=responseData.info.manualHitRate;//命中加成
//				SystemDataModel.otherPetInfoVo.baseDodgeRate=responseData.info.baseDodgeRate;//基础闪避
//				SystemDataModel.otherPetInfoVo.manualDodgeRate=responseData.info.manualDodgeRate;//闪避加成
//				SystemDataModel.otherPetInfoVo.baseSpeed=responseData.info.baseSpeed;//基础攻击速度
//				SystemDataModel.otherPetInfoVo.manualSpeed=responseData.info.manualSpeed;//基础速度加成
//				SystemDataModel.otherPetInfoVo.baseCritRate=responseData.info.baseCritRate;//基础暴击
//				SystemDataModel.otherPetInfoVo.manualCritRate=responseData.info.manualCritRate;//暴击加成
//				SystemDataModel.otherPetInfoVo.type=responseData.info.type;//暴击加成
//				SystemDataModel.otherPetInfoVo.icon=responseData.info.icon;//暴击加成
//				SystemDataModel.otherPetInfoVo.flowFlag = responseData.info.flowFlag;
//				SystemDataModel.otherPetInfoVo.baseBlock = responseData.info.baseBlock;//基础抗暴
//				SystemDataModel.otherPetInfoVo.manualBlock = responseData.info.manualBlock;//抗暴加成
//				SystemDataModel.otherPetInfoVo.liliang = responseData.info.liliang;//力量
//				SystemDataModel.otherPetInfoVo.zhili = responseData.info.zhili;//智力
//				SystemDataModel.otherPetInfoVo.naili =  responseData.info.naili;//耐力
//				SystemDataModel.otherPetInfoVo.minjie = responseData.info.minjie;//敏捷
//				SystemDataModel.otherPetInfoVo.maxHp = responseData.info.maxHp;//总血量
//				SystemDataModel.otherPetInfoVo.curExp = responseData.info.curExp;//当前经验
//				SystemDataModel.otherPetInfoVo.maxExp = responseData.info.maxExp;//总经验
//				SystemDataModel.otherPetInfoVo.curQuality = responseData.info.curQuality;//当前品质0普通1优秀2精良3史诗5传说
//				SystemDataModel.otherPetInfoVo.texing = responseData.info.texing;//特性
				PackageIitemInfoSettingUtil.setPetInfo(SystemDataModel.otherPetInfoVo,responseData.info);
				if(responseData.ziZhiInfo){
					SystemDataModel.otherPetInfoVo.cur_zi_li = responseData.ziZhiInfo.curZiLi;
					SystemDataModel.otherPetInfoVo.cur_zi_min = responseData.ziZhiInfo.curZiMin;
					SystemDataModel.otherPetInfoVo.cur_zi_nai = responseData.ziZhiInfo.curZiNai;
					SystemDataModel.otherPetInfoVo.cur_zi_zhi = responseData.ziZhiInfo.curZiZhi;
					SystemDataModel.otherPetInfoVo.max_zi_li = responseData.ziZhiInfo.maxZiLi;
					SystemDataModel.otherPetInfoVo.max_zi_min = responseData.ziZhiInfo.maxZiMin;
					SystemDataModel.otherPetInfoVo.max_zi_nai = responseData.ziZhiInfo.maxZiNai;
					SystemDataModel.otherPetInfoVo.max_zi_zhi = responseData.ziZhiInfo.maxZiZhi;
				}
				SystemDataModel.otherPetInfoVo.extendExp = responseData.extendsExp;
//				var sl:int = responseData.info.petSkillInfo.length;
//				var skilArr:ArrayCollection = new ArrayCollection();
//				for(var si:int=0;si<sl;si++){
//					var petSkillInfo:PetSkillInfo = responseData.info.petSkillInfo[si];
//					var petSkillInfoVo:PetSkillInfoVO = new PetSkillInfoVO();
//					petSkillInfoVo.hasActivationFlag = petSkillInfo.hasActivationFlag;
//					petSkillInfoVo.icon = petSkillInfo.icon;
//					petSkillInfoVo.petSkillDes = petSkillInfo.petSkillDes;
//					petSkillInfoVo.petSkillId = petSkillInfo.petSkillId;
//					petSkillInfoVo.petSkillLevel = petSkillInfo.petSkillLevel;
//					petSkillInfoVo.petSkillMaxLevel = petSkillInfo.petSkillMaxLevel;
//					petSkillInfoVo.petSkillName = petSkillInfo.petSkillName;
//					petSkillInfoVo.type = petSkillInfo.type;
//					skilArr.addItem(petSkillInfoVo);
//				}
//				SystemDataModel.otherPetInfoVo.petSkillInfoList.source = skilArr.toArray();
			}
		}
	}
}