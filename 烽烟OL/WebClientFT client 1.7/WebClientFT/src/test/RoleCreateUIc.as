package zhushen.ui.roleCreate
{
	import mx.controls.Alert;
	
	import t4game.common.*;
	import t4game.data.GameAvatarData;
	import t4game.net.ITcpMessageListener;
	import t4game.net.TcpMessage;
	
	import zhushen.ui.UIcFather;
	import zhushen.vcm.roleCreate.RoleCreatevcm;
	import zhushen.zhushengame.Game;
	import zhushen.zhushengame.common.lang.LangLoad;
	import zhushen.zhushengame.rolelist.GameRoleInfo;
	import zhushen.zhushengame.utils.GameAlert;

	/**
	 * 创建人物模块的UIc部分 
	 * @author t4game
	 * 
	 */
	public class RoleCreateUIc extends UIcFather implements ITcpMessageListener
	{
		private var _game:Game;
		private var _vcm:RoleCreatevcm;
		private var _alert:Alert;
		private var _roleInfo:GameRoleInfo=new GameRoleInfo();
		public var occu:int;
		/**
		 * 声明一个存储角色信息的数组 
		 */
		public var roleInfoList:Array=[];

		/**
		 * 构造函数 
		 * @param main Game类
		 * @param _vcm 对应的VCM
		 * 
		 */
		public function RoleCreateUIc(main:Game, _vcm:RoleCreatevcm)
		{
			_game=main;
			_game.addMessageListener(this);
			this._vcm=_vcm;
			sendRoleListMessage();
		}
		/**
		 * 移除UIc中所涉及到的引用及侦听器
		 * 
		 */
        public override function release():void
		{
			_game.removeMessageListener(this);
			_game=null;
			_vcm=null;
			roleInfoList=[];
		}
		
		/**
		 * 创建角色消息判断 
		 * @param message 包括消息类型
		 * @return 
		 * 
		 */
		public function onTcpMessage(message:TcpMessage):Boolean
		{
			var commandId:int=message.commandId;
			if (commandId == MessageCommands.GET_ROLEORIGINAL_MESSAGE)
			{
				processGetRoleMessage(message);
				return true;
			}
			if (commandId == MessageCommands.CREATE_ROLE_MESSAGE)
			{
				processCreateRoleMessage(message);
				return true;
			}
			if (commandId == MessageCommands.ROLE_RANDOM_NAME_MESSAGE)
			{
				processRoleRandomNameMessage(message);
				return true;
			}
			return false;
		}
		/**
		 * 发送获取角色信息的消息 
		 * 
		 */
		private function sendRoleListMessage():void
		{
			var message:TcpMessage=_game.newTcpMessage();
			message.commandId=MessageCommands.GET_ROLEORIGINAL_MESSAGE;
			_game.sendTcpMessage(message);
		}
		private function processRoleRandomNameMessage(message:TcpMessage):void
		{
			var name:String = message.readUTF();
			_vcm.roleCreateUI.NameText.text = name;
		}
		/**
		 * 处理角色信息消息 
		 * @param message 服务器返回的角色信息，包括图形资源等
		 * 
		 */
		private function processGetRoleMessage(message:TcpMessage):void
		{
			var equipNum:int=0;
			var countryid:int;
			
			if (message.readByte() == true)
			{
				var size:int=message.readByte();
				for (var i:int=0; i < size; i++)
				{
					var supportChangeImage:Boolean=message.readBoolean();
					for (var j:int=0; j < 2; j++)
					{
						_roleInfo=new GameRoleInfo();
						_roleInfo.occupationId=i;
						_roleInfo.avatarData=new GameAvatarData();
						_roleInfo.avatarData.setObjectDataId(message.readShort());
						_roleInfo.avatarData.supportChangeImage=supportChangeImage;
						
						equipNum=message.readByte();
						_roleInfo.avatarData.initImageDataList(equipNum);
						for (var k:int=0; k < equipNum; k++)
						{
							_roleInfo.avatarData.setImageData(message.readShort(), k);
						}
//						1.05升级修改 start
						message.readInt();
//						1.05升级修改 end
						roleInfoList.push(_roleInfo);
					}
				}
				countryid=message.readByte();//默认国家
				occu=message.readByte();//默认职业
				_vcm.createRoleList();
				if(occu!=-1&&countryid!=-1)
				{
					_vcm.roleCreateUI.setSexIndex=CommonConstants.SEX_WOMAN;
					_vcm.roleCreateUI.setCountryIndex=countryid;
					_vcm.roleCreateUI.setCareerIndex=occu;
//					_vcm.drawActionRole(occu*2+1);//职业为0,1,2,3,默认画女性
					_vcm.setCountryData(countryid);
					_vcm.setCareer(occu);
//					_vcm.roleCreateUI.onClickHead();
				}
				
				_vcm.drawRole();
				_vcm.roleCreateUI.setSelectRoleEffect(occu);
				_vcm.roleCreateUI.headSelected(_vcm.roleCreateUI.randomArr[occu]);//服务器下发的人物对应出现黄框
				_vcm.roleCreateUI.showDuoBianXing(occu);//服务器下发的人物的职业对应红色多边形
			}
		}
		
		private function processCreateRoleMessage(message:TcpMessage):void
		{
			_vcm.roleCreateUI.hasSend = false;
			_vcm.roleCreateUI.SendRoleInfo.mouseEnabled = true;
			var state:int=message.readByte();
			if (state == 1)
			{
				GameAlert.hide();
				_roleInfo.roleId=message.readInt();
				_roleInfo.sceneName=message.readUTF();
				_roleInfo.countryId=_vcm.getCountryvcm();
				_roleInfo.roleName=_vcm.getTextBox();
				_roleInfo.sex=_vcm.getSexvcm();
				_roleInfo.occupationId=_vcm.getJobvcm();
				_game.gameWorld.isLoginAgain=false;
				_vcm.gotoRoleList(_roleInfo);
			}
			else if (state == 4)
			{
				GameAlert.target = _vcm;
				GameAlert.show(LangLoad.TIP11,null,yesFun);
			}
			else if (state == 2)
			{
				GameAlert.target = _vcm;
				GameAlert.show(LangLoad.TIP12,null,yesFun);
			}
			else if (state == 5)
			{
				GameAlert.target = _vcm;
				GameAlert.show(LangLoad.TIP13,null,yesFun);
			}
			else
			{
				GameAlert.target = _vcm;
				GameAlert.show(LangLoad.TIP14,null,yesFun);
			}
		}
		public function sendRandomNameMessage():void
		{
			var message:TcpMessage=_game.newTcpMessage();
			message.commandId=MessageCommands.ROLE_RANDOM_NAME_MESSAGE;
			message.writeByte(_vcm.getSexvcm());
			_game.sendTcpMessage(message);
		}
		/**
		 * 发送角色信息消息
		 *
		 */
		public function sendRoleInfoMessage():void
		{
			if(_vcm.getTextBox()=="-1")
			{
				GameAlert.show(LangLoad.FEIFA,null,yesFun);
				return;
			}
			if(_vcm.getTextBox().length == 0)
			{
				GameAlert.show(LangLoad.QINGSHURU,null,yesFun);
				return;
			}
			if(_vcm.getTextBox()!=""&&_vcm.getTextBox()!=_vcm.roleCreateUI.defaultString)
			{
				_vcm.roleCreateUI.hasSend = true;
				var message:TcpMessage=_game.newTcpMessage();
				message.commandId=MessageCommands.CREATE_ROLE_MESSAGE;
				message.writeInt(_game.gameUser.userId);
				message.writeUTF(_vcm.getTextBox());
				message.writeByte(_vcm.getJobvcm());
				message.writeByte(_vcm.getSexvcm());
				message.writeByte(_vcm.getCountryvcm());
				_game.sendTcpMessage(message);
				_vcm.roleCreateUI.SendRoleInfo.mouseEnabled = false;
			}else{
				GameAlert.target = _vcm;
				GameAlert.show(LangLoad.QINGSHURU,null,yesFun);
			}
		}
			
		/**
		 * 返回到角色选择 
		 * 
		 */		
		public function backSelectRole():void
		{
			_vcm.backSelect();
		}
		public function get roleInfo():GameRoleInfo
		{
			return _roleInfo;
		}
		public function get vcm():RoleCreatevcm
		{
			return _vcm;
		}
	}
}