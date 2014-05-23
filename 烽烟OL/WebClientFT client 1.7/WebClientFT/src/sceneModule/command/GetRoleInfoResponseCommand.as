package sceneModule.command
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.scene.Appellation;
	import proto.scene.scene201.GetPlayerInfoResponse;
	
	import sceneModule.event.GetRoleInfoResponseEvent;
	import sceneModule.model.vo.AppellationInfoVo;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.nmall.model.MallMessage;
	import sceneModule.view.role.event.NRoleEvent;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.event.NTaskEvent;

	/**
	 *获取角色信息成功处理Command 
	 * @author Yaolx
	 * 
	 */	
	public class GetRoleInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:GetRoleInfoResponseEvent;
		public function GetRoleInfoResponseCommand()
		{
			super();
		}
		override public function execute():void{
			var byteArray:ByteArray = evt.result as ByteArray;
			var responseData:GetPlayerInfoResponse = new GetPlayerInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){				
				SystemDataModel.roleInfo.id=responseData.data.id;     //角色id
				SystemDataModel.roleInfo.nickname=responseData.data.nickname;  //用户名
				SystemDataModel.roleInfo.roletype=responseData.data.roletype; //角色类型（vip）
				SystemDataModel.roleInfo.level=responseData.data.level;//角色等级
				if(!SystemDataModel.openFunFlag){
					SystemDataModel.openFunLevel = responseData.data.level;
				}
				SystemDataModel.roleInfo.profession=responseData.data.profession;//角色职业
				SystemDataModel.roleInfo.energy=responseData.data.energy;//角色的活力
				SystemDataModel.roleInfo.rank=responseData.data.rank;//角色的军衔
				SystemDataModel.roleInfo.guildname=responseData.data.guildname;// 角色行会的名称
				SystemDataModel.roleInfo.manualStr=responseData.data.manualStr; //玩家自定义加的力量点数
				SystemDataModel.roleInfo.manualVit=responseData.data.manualVit;//玩家自定义加的体质(耐力)点数
				SystemDataModel.roleInfo.manualDex=responseData.data.manualDex;//玩家自定义加的灵巧(敏捷)点数
				SystemDataModel.roleInfo.manualWis=responseData.data.manualWis;//自定义加上的智力
				SystemDataModel.roleInfo.maxHp=responseData.data.maxHp;//最大血量
				SystemDataModel.roleInfo.hp=responseData.data.hp;//当前血量
				SystemDataModel.roleInfo.exp=responseData.data.exp;//当前经验值
				SystemDataModel.roleInfo.maxExp=responseData.data.maxExp;//升级所需经验值
				SystemDataModel.roleInfo.physicalAttack=responseData.data.physicalAttack;//物理攻击
				SystemDataModel.roleInfo.magicAttack=responseData.data.magicAttack;//魔法攻击
				SystemDataModel.roleInfo.physicalDefense=responseData.data.physicalDefense;//物理防御
				SystemDataModel.roleInfo.magicDefense=responseData.data.magicDefense;//魔法防御
				SystemDataModel.roleInfo.speed=responseData.data.speed;//速度
				SystemDataModel.roleInfo.critRate=responseData.data.critRate;//暴击
				SystemDataModel.roleInfo.hitRate=responseData.data.hitRate;//命中
				SystemDataModel.roleInfo.dodgeRate=responseData.data.dodgeRate;//闪避
				SystemDataModel.roleInfo.gold=responseData.data.gold;//魔钻(金币)
				SystemDataModel.roleInfo.coin=responseData.data.coin;//游戏币
				SystemDataModel.roleInfo.deposit = responseData.data.deposit;//存款
				SystemDataModel.roleInfo.block = responseData.data.block;//存款
				
				//军团加成数据
				SystemDataModel.roleInfo.exULiliang = responseData.data.exULiliang;
				SystemDataModel.roleInfo.exUMinjie = responseData.data.exUMinjie;
				SystemDataModel.roleInfo.exUZhili = responseData.data.exUZhili;
				SystemDataModel.roleInfo.exUNaili = responseData.data.exUNaili;
				SystemDataModel.roleInfo.exUWugong = responseData.data.exUWugong;
				SystemDataModel.roleInfo.exUMogong = responseData.data.exUMonggong;
				
				SystemDataModel.roleInfo.unionType = responseData.data.unionType;
				
				SystemDataModel.roleInfo.appellation.name = responseData.data.appellation.name;
				SystemDataModel.roleInfo.appellation.idInDB = responseData.data.appellation.idInDB;
				SystemDataModel.roleInfo.appellation.modID = responseData.data.appellation.modID;
				//------------------------军团信息----------------------------
				var old_flag:Boolean = SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag;
				SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag = responseData.data.corpsInfo.joinCorpsFlag;
				SystemDataModel.roleInfo.roleCorpsInfo.corpsLevel = responseData.data.corpsInfo.corpsLevel;
				SystemDataModel.roleInfo.roleCorpsInfo.corpsName = responseData.data.corpsInfo.corpsName;
				var oldpos:int = SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition;
				SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition = responseData.data.corpsInfo.corpsPosition;
				
				SystemDataModel.roleInfo.buyHLcount = responseData.buyCount;
				
//				SystemDataModel.roleInfo.appellationInfoVo:ArrayCollection = new ArrayCollection();//称号 AppellationInfoVo
				var l:int = responseData.data.appellationList.length;
				var appelArr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var appellationInfo:Appellation = responseData.data.appellationList[i];
					var appellationInfoVo:AppellationInfoVo = new AppellationInfoVo();
					appellationInfoVo.idInDB = appellationInfo.idInDB;
					appellationInfoVo.modID = appellationInfo.modID;
					appellationInfoVo.name = appellationInfo.name;
					appelArr.addItem(appellationInfoVo);
				}
				SystemDataModel.roleInfo.appellationArr.source = appelArr.toArray();
				if(old_flag != SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag){
					this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_REFRESH));
				}
				if(oldpos != SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition){
					this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_TAB_BAR));
				}
				this.dispatch(new NRoleEvent(NRoleEvent.NRoleEvent_INFO_CHANGE));
				
				TaskMessage.getInstance().dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_TRAC));
				MallMessage.getInstance().dispatchEvent(new Event(MallMessage.MallMessage_REFRESH_MONEY));
			}		    
		}
	}
}