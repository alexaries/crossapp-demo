package sceneModule.view.group.command
{
	import event.GuidEventCenter;
	import event.SwitchMaskEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import loader.ProgressBarControl;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.core.IMediatorMap;
	
	import proto.zudui.zudui4300.DuiWuInfo;
	import proto.zudui.zudui4300.ZuDuiListInfoRequest;
	import proto.zudui.zudui4300.ZuDuiListInfoResponse;
	import proto.zudui.zudui4301.CreateZuDuiRequest;
	import proto.zudui.zudui4301.CreateZuDuiResponse;
	import proto.zudui.zudui4302.GetDuiWuInfoRequest;
	import proto.zudui.zudui4302.GetDuiWuInfoResponse;
	import proto.zudui.zudui4302.PosRoleInfo;
	import proto.zudui.zudui4303.JoinDuiWuRequest;
	import proto.zudui.zudui4303.JoinDuiWuResponse;
	import proto.zudui.zudui4304.DWMemberInfo;
	import proto.zudui.zudui4304.GetGroupInfoRequest;
	import proto.zudui.zudui4304.GetGroupInfoResponse;
	import proto.zudui.zudui4305.LeaveDuiWuRequest;
	import proto.zudui.zudui4305.LeaveDuiWuResponse;
	import proto.zudui.zudui4306.TiRenRequest;
	import proto.zudui.zudui4306.TiRenResponse;
	import proto.zudui.zudui4308.BuffInfo;
	import proto.zudui.zudui4308.EnemyArray;
	import proto.zudui.zudui4308.FightData;
	import proto.zudui.zudui4308.FightRequest;
	import proto.zudui.zudui4308.FightResponse;
	import proto.zudui.zudui4308.initBattleData;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.model.rvo.RBattleAllRoundVo;
	import sceneModule.model.rvo.RBattleBuffVo;
	import sceneModule.model.rvo.RBattleEnemyVo;
	import sceneModule.model.rvo.RBattleInitChaVo;
	import sceneModule.model.rvo.RBattleInitVo;
	import sceneModule.model.rvo.RBattleRoundVo;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.group.view.CreateOrJoinWindow;
	import sceneModule.view.group.vo.DWMemberInfoVO;
	import sceneModule.view.group.vo.DuiWuInfoVO;
	
	import service.ISocketServer;
	
	import util.PackageIitemInfoSettingUtil;

	public class GroupMessage extends EventDispatcher
	{
		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var progressBar:ProgressBarControl;
		
		private static var _instance:GroupMessage;
		
		private var _event_dispatcher:IEventDispatcher;
		private  var _mediatorMap:IMediatorMap;
		
		public function GroupMessage()
		{
			
		}
		
		public static function getInstance():GroupMessage{
			if(_instance == null){
				_instance = new GroupMessage();
			}
			return _instance;
		}
		
		public function addBattleEventListener():void{
			socket.send(new mx.rpc.Responder(battleHandler,faultHandler),URLConst.GROUP_BATTLE_COMMANDID,null,false);
		}
		
		public function removeBattleEventListener():void{
			
		}
		
		public function set curMediatorMap(value:IMediatorMap):void{
			_mediatorMap = value;
		}
		
		public function set event_dispatcher(value:IEventDispatcher):void 
		{
			_event_dispatcher = value;
		}
		
		public function get event_dispatcher():IEventDispatcher{
			return _event_dispatcher;
		}
		
		public function onPopUpCreateOrJoinWindow(funType:String,dType:int):void{
			var obj:Object = new Object();
			obj.funType = funType;
			obj.dType = dType;
			WindowManager.createWindow(CreateOrJoinWindow.NAME,obj,null,false,false,false,null,_mediatorMap,popUpWindowLayer,true);
		}
		
		public function getMatrixRoleInfo(dId:int):void{
			var dwReq:GetDuiWuInfoRequest = new GetDuiWuInfoRequest();
			dwReq.id = SystemDataModel.roleId;
			dwReq.dwId = dId;
			var byteArray:ByteArray = new ByteArray();
			dwReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(matrixHandler,faultHandler),URLConst.GROUP_MAINFO_COMMANDID,byteArray);
		}
		
		public function changeServerToClient(index:int):int{
			switch(index){
				case 1:
					return 2;
					break;
				case 2:
					return 5;
					break;
				case 3:
					return 8;
					break;
				case 4:
					return 1;
					break;
				case 5:
					return 4;
					break;
				case 6:
					return 7;
					break;
				case 7:
					return 0;
					break;
				case 8:
					return 3;
					break;
				case 9:
					return 6;
					break;
			}
			return 0;
		}
		
		public function changeClientToServer(index:int):int{
			switch(index){
				case 0:
					return 7;
					break;
				case 1:
					return 4;
					break;
				case 2:
					return 1;
					break;
				case 3:
					return 8;
					break;
				case 4:
					return 5;
					break;
				case 5:
					return 2;
					break;
				case 6:
					return 9;
					break;
				case 7:
					return 6;
					break;
				case 8:
					return 3;
					break;
			}
			return 1;
		}
		
		public function createOrJoin(funType:String,pos:int,dType:int):void{
			if(funType == 'Create'){
				createDuiWu(dType,GroupMessage.getInstance().changeClientToServer(pos));
			}else{
				joinDuiWu(dType,GroupMessage.getInstance().changeClientToServer(pos));
			}
			WindowManager.closeWindow(CreateOrJoinWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,_mediatorMap);
		}
		
		private function matrixHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetDuiWuInfoResponse = new GetDuiWuInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.posRoleInfo.length;
				for(var i:int=0;i<l;i++){
					var posInfo:PosRoleInfo = responseData.posRoleInfo[i];
					var index:int = GroupMessage.getInstance().changeServerToClient(posInfo.pos);
					var cPosInfo:DWMemberInfoVO = SystemDataModel.mainGroupInfo.dwmemberInfo[index] as DWMemberInfoVO;
					cPosInfo.level = posInfo.level;
					cPosInfo.proType = posInfo.roleType;
					cPosInfo.roleId = posInfo.roleId;
					cPosInfo.roleName = posInfo.roleName;
				}
			}
		}
		
		public function jiaDuWuList():void{
			SystemDataModel.mainGroupInfo.curPage = 1;
			SystemDataModel.mainGroupInfo.maxPage = 1;
			var l:int = 7;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var dwInfoVo:DuiWuInfoVO = new DuiWuInfoVO();
				dwInfoVo.curNum = i+1;
				dwInfoVo.dwId = 2;
				dwInfoVo.dwType = 2;
				dwInfoVo.leaderName = 'aaa';
				arr.addItem(dwInfoVo);
			}
			SystemDataModel.mainGroupInfo.duiWuInfo.source = arr.toArray();
		}
		
		private var intervalTime:int;
		public function setTimeDuWuList():void{
			intervalTime = setInterval(getDuWuList,2000);
		}
		
		public function getDuWuList():void{
			var getDWreq:ZuDuiListInfoRequest = new ZuDuiListInfoRequest();
			getDWreq.id = SystemDataModel.roleId;
			getDWreq.curPage = SystemDataModel.mainGroupInfo.curPage;
			var byteArray:ByteArray = new ByteArray();
			getDWreq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(dwHandler,faultHandler),URLConst.GROUP_LISTINFO_COMMANDID,byteArray);
		}
		
		private function dwHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ZuDuiListInfoResponse = new ZuDuiListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainGroupInfo.curPage = responseData.zuDuiInfo.curPage;
				SystemDataModel.mainGroupInfo.maxPage = responseData.zuDuiInfo.maxPage;
				var l:int = responseData.zuDuiInfo.duiWuInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var dwInfo:DuiWuInfo = responseData.zuDuiInfo.duiWuInfo[i];
					var dwInfoVo:DuiWuInfoVO = new DuiWuInfoVO();
					dwInfoVo.curNum = dwInfo.curNum;
					dwInfoVo.dwId = dwInfo.dwId;
					dwInfoVo.dwType = dwInfo.dwType;
					dwInfoVo.leaderName = dwInfo.leaderName;
					arr.addItem(dwInfoVo);
				}
				SystemDataModel.mainGroupInfo.duiWuInfo.source = arr.toArray();
			}
		}
		
		public function createDuiWu(gkType:int=1,pos:int=0):void{
			var createDWreq:CreateZuDuiRequest = new CreateZuDuiRequest();
			createDWreq.id = SystemDataModel.roleId;
			createDWreq.gkType = gkType;
			createDWreq.pos = pos;
			var byteArray:ByteArray = new ByteArray();
			createDWreq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(createHandler,faultHandler),URLConst.GROUP_CREATE_COMMANDID,byteArray);
		}
		
		public function closeWindowHandler():void{
			SystemDataModel.mainGroupInfo.inGroupFlag = false;
			clearInterval(intervalTime);
			leaveGroup();
		}
		
		public function leaveGroup():void{
			var leaveReq:LeaveDuiWuRequest = new LeaveDuiWuRequest();
			leaveReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			leaveReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(leaveHandler,faultHandler),URLConst.GROUP_LEAVE_COMMANDID,byteArray);
		}
		
		private function leaveHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:LeaveDuiWuResponse = new LeaveDuiWuResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainGroupInfo.inGroupFlag = false;
				if(SystemDataModel.mainGroupInfo.isLeader){
					SystemDataModel.mainGroupInfo.isLeader = false;
				}
			}
		}
		
		private function createHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:CreateZuDuiResponse = new CreateZuDuiResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainGroupInfo.inGroupFlag = true;
				SystemDataModel.mainGroupInfo.isLeader = true;
				getGroupInfo(responseData.dwId);
			}
		}
		
		public function tiRen(rId:int):void{
			var tiReq:TiRenRequest = new TiRenRequest();
			tiReq.id = SystemDataModel.roleId;
			tiReq.roleId = rId;
			var byteArray:ByteArray = new ByteArray();
			tiReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(tiHandler,faultHandler),URLConst.GROUP_TIREN_COMMANDID,byteArray);
		}
		
		private function tiHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:TiRenResponse = new TiRenResponse();
			responseData.readExternal(byteArray);
		}
		
		public function joinDuiWu(dwId:int,pos:int=0):void{
			var joinReq:JoinDuiWuRequest = new JoinDuiWuRequest();
			joinReq.dwId = dwId;
			joinReq.id = SystemDataModel.roleId;
			joinReq.pos = pos;
			var byteArray:ByteArray = new ByteArray();
			joinReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(joinHandler,faultHandler),URLConst.GROUP_JOIN_COMMANDID,byteArray);
		}
		
		private function joinHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:JoinDuiWuResponse = new JoinDuiWuResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainGroupInfo.inGroupFlag = true;
				SystemDataModel.mainGroupInfo.isLeader = false;
				getGroupInfo(responseData.rdwId);
			}
		}
		
		public function getJiaInfo():void{
			var l:int = 5;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var dwmInfoVo:DWMemberInfoVO = new DWMemberInfoVO();
				dwmInfoVo.level = 1;
				dwmInfoVo.pos = i+1;
				dwmInfoVo.proType = 2;
				dwmInfoVo.roleId = 4;
				dwmInfoVo.roleName = 'sdaf';
				arr.addItem(dwmInfoVo);
			}
			SystemDataModel.mainGroupInfo.memberInfo.source = arr.toArray();
		}
		
		public function getGroupInfo(dwId:int):void{
			var getGroupReq:GetGroupInfoRequest = new GetGroupInfoRequest();
			getGroupReq.dwId = dwId;
			getGroupReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getGroupReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(groupHandler,faultHandler),URLConst.GROUP_INFO_COMMANDID,byteArray);
		}
		
		private function groupHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetGroupInfoResponse = new GetGroupInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.dwMemberInfo.length;
				if(l==0){
					SystemDataModel.mainGroupInfo.inGroupFlag = false;
				}else{
					var arr:ArrayCollection = new ArrayCollection();
					for(var i:int=0;i<l;i++){
						var dwmInfo:DWMemberInfo = responseData.dwMemberInfo[i];
						var dwmInfoVo:DWMemberInfoVO = new DWMemberInfoVO();
						dwmInfoVo.level = dwmInfo.level;
						dwmInfoVo.pos = dwmInfo.pos;
						dwmInfoVo.proType = dwmInfo.proType;
						dwmInfoVo.roleId = dwmInfo.roleId;
						dwmInfoVo.roleName = dwmInfo.roleName;
						arr.addItem(dwmInfoVo);
					}
					SystemDataModel.mainGroupInfo.memberInfo.source = arr.toArray();
				}
			}
		}
		
		public function onBattle():void{
			var battleReq:FightRequest = new FightRequest();
			battleReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			battleReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(battleHandler,faultHandler),URLConst.GROUP_BATTLE_COMMANDID,byteArray);
		}
		
		private function battleHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:FightResponse = new FightResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				//初始化战场
				var initBattleVo:RBattleInitVo = new RBattleInitVo();
				if(responseData.data.startData){
					var bl:int = responseData.data.startData.length;
					var battleInitChaArr:Array = new Array();
					for(var bi:int=0;bi<bl;bi++){
						var initData:initBattleData = responseData.data.startData[bi]
						var initBattleChaVo:RBattleInitChaVo = new RBattleInitChaVo();
						
						initBattleChaVo.chaId=initData.chaId;//角色的ID
						initBattleChaVo.chaBattleId=initData.chaBattleId;//角色的战场ID
						initBattleChaVo.chaName=initData.chaName;//角色的名称
						initBattleChaVo.chaLevel=initData.chaLevel;//角色的等级
						initBattleChaVo.chaProfessionType=initData.chaProfessionType;//角色的职业
						initBattleChaVo.chaDirection=initData.chaDirection;//1--玩家朝向右，朝向右。2--玩家朝向左
						initBattleChaVo.chaCurrentHp=initData.chaCurrentHp;//角色当前的血量
						initBattleChaVo.chaCurrentPower=initData.chaCurrentPower;//角色的当前能量
						initBattleChaVo.chaTotalHp=initData.chaTotalHp;//角色的总HP
						initBattleChaVo.chaTotalPower=initData.chaTotalPower;//角色的总Power
						initBattleChaVo.chaPos =new Point(initData.chaPos[0],initData.chaPos[1]);//角色动画的坐标
						battleInitChaArr.push(initBattleChaVo);
					}
					initBattleVo.rBattleInitChaVoArr = battleInitChaArr;
					initBattleVo.rBattleCenterPoint = new Point(responseData.data.centerX,responseData.data.centerY);
					initBattleVo.rResArr = responseData.data.rResArr;
				}
				//战斗结果
				SystemDataModel.battleInfoVo.battleResult = responseData.data.battleResult;
				SystemDataModel.battleInfoVo.jingjiResult = responseData.data.fightmsg;
				
				var battleAllRoundVo:RBattleAllRoundVo = new RBattleAllRoundVo();
				if(responseData.data.stepData){
					var sl:int = responseData.data.stepData.length;
					var battleRoundArray:Array = new Array();
					for( var ii:int=0;ii<sl;ii++){
						var fightData:FightData = responseData.data.stepData[ii];
						var rBattleRoundVo:RBattleRoundVo = new RBattleRoundVo();
						rBattleRoundVo.chaId = fightData.chaId;//角色的id
						rBattleRoundVo.chaBattleId = fightData.chaBattleId;//角色的战场ID
						rBattleRoundVo.chaProfessionType = fightData.chaProfessionType;//角色的职业
						rBattleRoundVo.actionId = fightData.actionId;//角色的攻击动作id
						rBattleRoundVo.counterHitActionId = fightData.counterHitActionId;//角色受反击时的动作
						
						rBattleRoundVo.isDeathOfCounterHit = fightData.isDeathOfCounterHit;//角色是否受反击致死0:否，1：是
						rBattleRoundVo.txtEffectId = fightData.txtEffectId;//角色的文字特效
						rBattleRoundVo.chaEffectId = fightData.chaEffectId;//角色特效ID
						rBattleRoundVo.chaEnemyEffectId = fightData.chaEnemyEffectId;//角色技能承受特效
						rBattleRoundVo.chaThrowEffectId = fightData.chaThrowEffectId;//角色技能投射特效
						rBattleRoundVo.chaAoeEffectId = fightData.chaAoeEffectId;//技能的全屏特效
						rBattleRoundVo.chaName = fightData.chaName;//角色名字
						rBattleRoundVo.chaLevel = fightData.chaLevel;//角色等级
						
						//buff
						var rl:int = fightData.chaBuffArr.length;
						var r_arr:Array = new Array();
						for(var ri:int=0;ri<rl;ri++){
							r_arr.push(fightData.chaBuffArr[ri]);
						}
						rBattleRoundVo.chaBuffArr = r_arr;
						//buffinfo
						var b_l:int = fightData.chaBuffShowList.length;
						var buff_arr:Array = new Array();
						for(var b_i:int=0;b_i<b_l;b_i++){
							var buffInfo:BuffInfo = fightData.chaBuffShowList[b_i];
							var rBattleBuffVo:RBattleBuffVo = new RBattleBuffVo();
							rBattleBuffVo.buffId = buffInfo.buffId;
							rBattleBuffVo.buffLayerCount = buffInfo.buffLayerCount;
							rBattleBuffVo.buffRemainRoundCount = buffInfo.buffRemainRoundCount;
							buff_arr.push(rBattleBuffVo);
						}
						rBattleRoundVo.chaBuffShowList = buff_arr;
						
						
						
						rBattleRoundVo.chaPowerUp = fightData.chaPowerUp;//power增加
						rBattleRoundVo.chaPowerDown = fightData.chaPowerDown;//power减少(能量消耗)
						rBattleRoundVo.chaCurrentPower = fightData.chaCurrentPower;//当前的能量
						rBattleRoundVo.chaChangeHp = fightData.chaChangeHp;//角色血量变化(受治疗或攻击后)
						rBattleRoundVo.chaCurrentHp = fightData.chaCurrentHp;//角色当前的血量
						rBattleRoundVo.chaExpendHp = fightData.chaExpendHp;//角色血量消耗(技能消耗反弹等)
						
						rBattleRoundVo.chaStartPos = new Point(fightData.chaStartPos[0],fightData.chaStartPos[1]);//角色的起始坐标
						rBattleRoundVo.chaTargetPos = new Point(fightData.chaTargetPos[0],fightData.chaTargetPos[1]);//角色的目标坐标
						rBattleRoundVo.chaAttackType = fightData.chaAttackType;//角色的攻击方式 1:进程，2：远程
						rBattleRoundVo.chaDirection = fightData.chaDirection;//1玩家朝向右 2--玩家朝向左
						rBattleRoundVo.isCriticalBlow = fightData.isCriticalBlow;//是否暴击
						rBattleRoundVo.chaTotalHp = fightData.chaTotalHp;
						//							repeated EnemyArray enemyChaArr = 25;//被攻击方数据
						var el:int = fightData.enemyChaArr.length;
						var eArr:Array = new Array();
						for(var ei:int=0;ei<el;ei++){
							var enemyInfo:EnemyArray = fightData.enemyChaArr[ei];
							var rBattleEnemyVo:RBattleEnemyVo = new RBattleEnemyVo();
							rBattleEnemyVo.enemyChaId = enemyInfo.enemyChaId;// ID
							rBattleEnemyVo.enemyBattleId = enemyInfo.enemyBattleId;// 战斗ID
							rBattleEnemyVo.enemyActionId = enemyInfo.enemyActionId;// 动作ID
							rBattleEnemyVo.enemyCounterHitActionId = enemyInfo.enemyCounterHitActionId;//反击时的动作ID
							rBattleEnemyVo.enemyTxtEffectId = enemyInfo.enemyTxtEffectId;// 文字效果ID，暴击，闪避，冰冻等
							
							rBattleEnemyVo.chaEffectId = enemyInfo.chaEffectId;//角色特效ID
							rBattleEnemyVo.chaEnemyEffectId = enemyInfo.chaEnemyEffectId;//被打角色特效ID
							rBattleEnemyVo.chaThrowEffectId = enemyInfo.chaThrowEffectId;//角色投射特效ID
							rBattleEnemyVo.chaEnemyAoeEffectId = enemyInfo.chaEnemyAoeEffectId;//受攻击者反击技能的全屏特效
							rBattleEnemyVo.enemyTotalHp = enemyInfo.enemyTotalHp;
							rBattleEnemyVo.enemyName = enemyInfo.enemyChaName;//敌人名称
							rBattleEnemyVo.enemyLevel = enemyInfo.enemychaLevel;//敌人等级
							//buff
							var rl1:int = enemyInfo.enemyBuffArr.length;
							var r_arr1:Array = new Array();
							for(var ri1:int=0;ri1<rl1;ri1++){
								r_arr1.push(enemyInfo.enemyBuffArr[ri1]);
							}
							rBattleEnemyVo.enemyBuffArr = r_arr1;
							//buffinfo
							var b_l1:int = enemyInfo.enemyBuffShowList.length;
							var buff_arr1:Array = new Array();
							for(var b_i1:int=0;b_i1<b_l1;b_i1++){
								var buffInfo1:BuffInfo = enemyInfo.enemyBuffShowList[b_i1];
								var rBattleBuffVo1:RBattleBuffVo = new RBattleBuffVo();
								rBattleBuffVo1.buffId = buffInfo1.buffId;
								rBattleBuffVo1.buffEffectId = buffInfo1.buffEffectId;
								rBattleBuffVo1.buffIconId = buffInfo1.buffIconId;
								rBattleBuffVo1.buffName = buffInfo1.buffName;
								rBattleBuffVo1.buffLayerCount = buffInfo1.buffLayerCount;
								rBattleBuffVo1.buffRemainRoundCount = buffInfo1.buffRemainRoundCount;
								buff_arr1.push(rBattleBuffVo1);
							}
							rBattleEnemyVo.enemyBuffShowList = buff_arr1;
							
							rBattleEnemyVo.enemyPowerUp = enemyInfo.enemyPowerUp;// +20 power增加
							rBattleEnemyVo.enemyCurrentPower = enemyInfo.enemyCurrentPower;//当前能量
							rBattleEnemyVo.enemyChangeHp = enemyInfo.enemyChangeHp;//角色血量变化
							rBattleEnemyVo.enemyCurrentHp = enemyInfo.enemyCurrentHp;//角色的当前血量
							rBattleEnemyVo.enemyCounterHit = enemyInfo.enemyCounterHit;// 是否反击：0-否，1-是
							rBattleEnemyVo.enemyStartPos = new Point(enemyInfo.enemyStartPos[0],enemyInfo.enemyStartPos[1]);// 起始坐标 
							rBattleEnemyVo.enemyTargetPos = new Point(enemyInfo.enemyTargetPos[0],enemyInfo.enemyTargetPos[1]);// 目标坐标
							rBattleEnemyVo.enemyDirection = enemyInfo.enemyDirection;//1--玩家朝向右，朝向右。2--玩家朝向左
							rBattleEnemyVo.enemyProfessionType = enemyInfo.enemyProfessionType;//1--玩家朝向右，朝向右。2--玩家朝向左
							eArr.push(rBattleEnemyVo);
						}
						rBattleRoundVo.enemyChaArr = eArr;
						battleRoundArray.push(rBattleRoundVo);
						battleAllRoundVo.rBattleAllRoundArr = battleRoundArray;
						//							battleAllRoundVo.rSceneId = responseData.data.
					}
				}
				SystemDataModel.battleInfoVo._battleAllRoundVo = battleAllRoundVo;
				SystemDataModel.battleInfoVo._initBattleVo = initBattleVo;
				//把标志位设为不可传入 此时以后不更新玩家信息，直到新场景加载完毕
				SystemDataModel.sceneIsLoaded = false;
				
				GuidEventCenter.getInstance().dispatchEvent(
					new SwitchMaskEvent(
						SwitchMaskEvent.SwitchMaskEvent_SHOW
					)
				);
				//显示加载条
				progressBar.visible = true;
				
				
				SystemDataModel.groupBattleFlag = true;
				
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}