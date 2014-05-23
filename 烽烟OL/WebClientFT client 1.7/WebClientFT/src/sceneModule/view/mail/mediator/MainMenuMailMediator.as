package sceneModule.view.mail.mediator
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.events.ItemClickEvent;
	import mx.events.ListEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.mail.mail501.getMailListRequest;
	import proto.mail.mail502.sendMailRequest;
	import proto.mail.mail502.sendMailResponse;
	import proto.mail.mail503.saveAndDeleteMailRequest;
	import proto.mail.mail503.saveAndDeleteMailResponse;
	import proto.mail.mail505.MailInfo;
	import proto.mail.mail505.getMailInfoRequest;
	import proto.mail.mail505.getMailInfoResponse;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.ChangeWindowStateEvent;
	import sceneModule.model.vo.mailVo.MailBasicInfoVo;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.corps.view.NCorpAlert;
	import sceneModule.view.mail.event.GetMailListResponseEvent;
	import sceneModule.view.mail.event.MainMenuMailComponentCreateCompleteEvent;
	import sceneModule.view.mail.event.MainMenuMailSaveOrDeleteSuccessMessageEvent;
	import sceneModule.view.mail.event.NMailEvent;
	import sceneModule.view.mail.event.SendMailEvent;
	import sceneModule.view.mail.view.MainMailItemRender;
	import sceneModule.view.mail.view.MainMenuMailComponent;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;
	
	import util.CommonTools;

	public class MainMenuMailMediator extends Mediator
	{
		[Inject]
		public var mainMenuMail:MainMenuMailComponent;

		[Inject]
		public var socketService:ISocketServer;

		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		public function MainMenuMailMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			//发送邮件
			this.addViewListener(SendMailEvent.SENDMAIL, sendMail);
			//上一页
			this.eventMap.mapListener(mainMenuMail.preBtn, MouseEvent.CLICK, onPrePage);
			//下一页
			this.eventMap.mapListener(mainMenuMail.nextBtn, MouseEvent.CLICK, onNextPage);
			//删除当页
			this.eventMap.mapListener(mainMenuMail.deleteCurPageBtn, MouseEvent.CLICK, onDeleteCurPageMail);
			//保存邮件
//			this.eventMap.mapListener(mainMenuMail.saveBtn, MouseEvent.CLICK, onSaveMail);
			//删除邮件
			this.eventMap.mapListener(mainMenuMail.deleteBtn, MouseEvent.CLICK, onDeleteMail);
			this.eventMap.mapListener(mainMenuMail.cardtype, ItemClickEvent.ITEM_CLICK, onTabBarChange);
			this.eventMap.mapListener(mainMenuMail.mailList, MouseEvent.CLICK, onMailItemClick);

			//收到新邮件提示
			this.eventDispatcher.addEventListener(NMailEvent.NMailEvent_NEW_MAIL, onTabBarChange);

			//操作成功后的提示
			this.eventDispatcher.addEventListener(MainMenuMailSaveOrDeleteSuccessMessageEvent.MAINMENUMAILSAVEORDELETEMESSAGE, onConfimMessage);

			//派发初始化完成事件
			this.dispatch(new MainMenuMailComponentCreateCompleteEvent(MainMenuMailComponentCreateCompleteEvent.MAINMENUMAILCOMPONENTCREATECOMPLETE));

			//this.eventMap.mapListener(mainMenuMail.closeWinBtn,MouseEvent.CLICK,onCloseWindow);
			
			this.eventMap.mapListener(mainMenuMail.closeBtnWin,MouseEvent.CLICK,onCloseWindow);

			getMailView();
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(MainMenuMailComponent.NAME,false,false,null,popUpWindowLayer);
		}

		override public function preRemove():void
		{
			this.eventDispatcher.removeEventListener(NMailEvent.NMailEvent_NEW_MAIL, onTabBarChange);
			this.eventDispatcher.removeEventListener(MainMenuMailSaveOrDeleteSuccessMessageEvent.MAINMENUMAILSAVEORDELETEMESSAGE, onConfimMessage);
		}

//		private function onCloseWindow(evt:MouseEvent):void
//		{
//			dispatch(new ChangeWindowStateEvent(ChangeWindowStateEvent.CHANGEWINDOWSTATE, ChangeWindowStateEvent.MAINMENU));
//		}

		/**
		 * onConfimMessage
		 * @param evt
		 * 信息提示
		 */
		private function onConfimMessage(evt:MainMenuMailSaveOrDeleteSuccessMessageEvent):void
		{
			//mainMenuMail.infoConfim.text = evt.confimMessage;
		}

		private function getMailView():void
		{
			showMail();
			SystemDataModel.mailListInfo.curPage=1;
		}

		private function showMail():void
		{
			CommonTools.make_bitmap(mainMenuMail.mainMailBg).bitmapData=AssetCenter.getInstance().get_img_form_pacakge("ui_mail", "mainMailBg");
			CommonTools.make_bitmap(mainMenuMail.mailInfoBg).bitmapData=AssetCenter.getInstance().get_img_form_pacakge("ui_mail", "mailInfoBg");
		}

		/**
		 * onSaveMail
		 */
		private function onSaveMail(evt:MouseEvent):void
		{
			//保存邮件 0 为保存
			onSaveOrDeleteMail(0);
			//清空邮件信息
			mainMenuMail.clearMailInfo();
		}

		/**
		 * onDeleteMail
		 */
		private function onDeleteMail(evt:MouseEvent):void
		{
			//删除邮件 1为删除
			onSaveOrDeleteMail(1);
			//清空邮件信息
			mainMenuMail.clearMailInfo();
		}

		/**
		 * 保存或删除邮件
		 * @param setType 操作类型 0为保存1为删除
		 *
		 */
		private function onSaveOrDeleteMail(setType:int):void
		{
			var saveOrDeleteMail:saveAndDeleteMailRequest=new saveAndDeleteMailRequest();
			saveOrDeleteMail.id=SystemDataModel.roleId;
			saveOrDeleteMail.mailType=SystemDataModel.mailListInfo.responseMailType;
			saveOrDeleteMail.requestInfo=tempMailId;
			saveOrDeleteMail.setType=setType;
			var saveOrDeleteByte:ByteArray=new ByteArray();
			saveOrDeleteMail.writeExternal(saveOrDeleteByte);
			socketService.send(new mx.rpc.Responder(saveOrDeleteHandler, faultHandler), URLConst.DELETE_MAIL_COMMANDID, saveOrDeleteByte);
		}

		private function saveOrDeleteHandler(data:Object):void
		{
			var saveOrDelResByte:ByteArray=data as ByteArray;
			var saveOrDelRes:saveAndDeleteMailResponse=new saveAndDeleteMailResponse();
			saveOrDelRes.readExternal(saveOrDelResByte);
			if (saveOrDelRes.result)
			{
				//从新获取邮件信息
				getMailListInfo(SystemDataModel.mailListInfo.curPage, SystemDataModel.mailListInfo.responseMailType);
					//成功后提示信息
					//mainMenuMail.infoConfim.text = saveOrDelRes.message;
			}
			else
			{
				popUpShow.show(saveOrDelRes.message);
			}
		}

		/**
		 * sendMail
		 */
		private function sendMail(evt:SendMailEvent):void
		{
			if (mainMenuMail.userName.text == "")
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('mail','mmm_sjwk'));
//				popUpShow.show("收件者不能为空");
//				WindowManager.createWindow(NCorpAlert.NAME,{msg:"收件者不能为空！"},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
			}
			else
			{
				if (mainMenuMail.writeMailTitle.text == "")
				{
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('mail','mmm_btwk'));
//					popUpShow.show("邮件标题不能为空！");
//					WindowManager.createWindow(NCorpAlert.NAME,{msg:"邮件标题不能为空！"},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
				}
				else
				{
					if (mainMenuMail.writeCailContent.text == "")
					{
//						popUpShow.show("确定发送没有内容的邮件！", null, null, null, null, onSendMail);
//						WindowManager.createWindow(NCorpAlert.NAME,{"确定发送没有内容的邮件！"},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
					}
					else
					{
						onSendCommandWriteMail();
					}

				}
			}


		}

		private function onSendMail(evt:MouseEvent):void
		{
			//发送邮件
			onSendCommandWriteMail();
			//清空写信界面信息
			mainMenuMail.clearWriteMailInfo();
		}

		private function onSendCommandWriteMail():void
		{
			var sendMail:sendMailRequest=new sendMailRequest();
			sendMail.id=SystemDataModel.roleId;
			sendMail.acceptName=mainMenuMail.userName.text;
			sendMail.mailTitle=mainMenuMail.writeMailTitle.text;
			sendMail.mailContent=mainMenuMail.writeCailContent.text;
			var sendMailByte:ByteArray=new ByteArray();
			sendMail.writeExternal(sendMailByte);
			socketService.send(new mx.rpc.Responder(sendMailHandler, faultHandler), URLConst.ADD_MAIL_COMMANDID, sendMailByte);
		}

		private function sendMailHandler(data:Object):void
		{
			var sendMailByteArray:ByteArray=data as ByteArray;
			var sendMailRes:sendMailResponse=new sendMailResponse();
			sendMailRes.readExternal(sendMailByteArray);
			if (sendMailRes.result)
			{
				mainMenuMail.clearWriteMailInfo();
					//mainMenuMail.infoConfim.text = sendMailRes.message;
			}
			else
			{
				//popUpShow.show(sendMailRes.message);
			}
		}

		/**
		 * 上一页
		 * @param evt
		 *
		 */
		private function onPrePage(evt:MouseEvent):void
		{

			getMailListInfo(SystemDataModel.mailListInfo.curPage - 1, getCurSelectedIndex(mainMenuMail.cardtype.selectedValue));
		}

		/**
		 * 获取邮件列表
		 * @param pageCount 获取指定页数的邮件列表
		 * @param mailType 所获取的邮件的类型
		 */
		private function getMailListInfo(pageCount:int, mailType:int):void
		{
			var getMailListReq:getMailListRequest=new getMailListRequest();
			getMailListReq.id=SystemDataModel.roleId;
			getMailListReq.pageCount=pageCount;
			getMailListReq.mailType=mailType;
			var mailListByteArray:ByteArray=new ByteArray();
			getMailListReq.writeExternal(mailListByteArray);
			socketService.send(new mx.rpc.Responder(mailListHandler, faultHandler), URLConst.GET_MAILLIST_COMMANDID, mailListByteArray);
		}

		/**
		 * 邮件类型改变重新获取相应的数据
		 */
		private function onTabBarChange(evt:Event=null):void
		{
			getMailListInfo(1, getCurSelectedIndex(mainMenuMail.cardtype.selectedValue));
			mainMenuMail.clearMailInfo();
		}

		/**
		 * mailListHandler
		 */
		private function mailListHandler(data:Object):void
		{
			dispatch(new GetMailListResponseEvent(GetMailListResponseEvent.GETMAILLISTRESPONSE, data));
		}

		/**
		 * 下一页
		 * @param evt
		 *
		 */
		private function onNextPage(evt:MouseEvent):void
		{
			getMailListInfo(SystemDataModel.mailListInfo.curPage + 1, getCurSelectedIndex(mainMenuMail.cardtype.selectedValue));
		}

		private function getCurSelectedIndex(value:Object):int
		{
			var i:int;
			switch (value)
			{
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('mail','mmm_qb'):
					i=0;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfM_xt'):
					i=1;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('mail','mmm_wj'):
					i=2;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('mail','mmm_bc'):
					i=3;
					break;
			}
			return i;
		}

		/**
		 * 删除一页数据
		 * @param evt
		 *
		 */

		private function onDeleteCurPageMail(evt:MouseEvent):void
		{
			var deleteMail:saveAndDeleteMailRequest=new saveAndDeleteMailRequest();
			deleteMail.id=SystemDataModel.roleId;
			var mailIdArr:Array=new Array();
			var l:int=SystemDataModel.mailListInfo.mailinfo.length;
			for (var i:int=0; i < l; i++)
			{
				mailIdArr.push(SystemDataModel.mailListInfo.mailinfo[i].mailId);
			}
			deleteMail.mailId=mailIdArr;
			deleteMail.setType=2; //2未删除一页数据
			deleteMail.mailType=SystemDataModel.mailListInfo.responseMailType;
			var deleteMailByteArray:ByteArray=new ByteArray();
			deleteMail.writeExternal(deleteMailByteArray);
			socketService.send(new mx.rpc.Responder(deleteMailHandler, faultHandler), URLConst.DELETE_MAIL_COMMANDID, deleteMailByteArray);
		}

		/**
		 * 删除邮件返回处理
		 */
		private function deleteMailHandler(data:Object):void
		{
			var deleteResByte:ByteArray=data as ByteArray;
			var deleteMailResponse:saveAndDeleteMailResponse=new saveAndDeleteMailResponse();
			deleteMailResponse.readExternal(deleteResByte);
			if (deleteMailResponse.result)
			{
				getMailListInfo(SystemDataModel.mailListInfo.curPage, getCurSelectedIndex(mainMenuMail.cardtype.selectedValue));
					//mainMenuMail.infoConfim.text = deleteMailResponse.message;
			}
			else
			{
				popUpShow.show(deleteMailResponse.message);
			}
		}

		/**
		 * 查看邮件详细信息
		 * @param evt
		 *
		 */
		private function onMailItemClick(evt:MouseEvent):void
		{
			if (mainMenuMail.currentState == "writeMailState")
			{
				mainMenuMail.currentState="commonState"
			}
			if (null == mainMenuMail.mailList.selectedItem as MailBasicInfoVo)
			{
				return;
			}
			var mailId:int=(mainMenuMail.mailList.selectedItem as MailBasicInfoVo).mailId;
			//mainMenuMail.infoConfim.text = "";
			var getMailInfo:getMailInfoRequest=new getMailInfoRequest();
			getMailInfo.id=SystemDataModel.roleId;
			getMailInfo.mailId=mailId;
			var mailInfoByte:ByteArray=new ByteArray();
			getMailInfo.writeExternal(mailInfoByte);
			socketService.send(new mx.rpc.Responder(mailInfoHandler, faultHandler), URLConst.MAIL_GETINFO_COMMANDID, mailInfoByte);
		}
		/**
		 * 查看邮件详细信息
		 */
		private var tempMailId:int;

		private function mailInfoHandler(data:Object):void
		{
			var mailInfoByteArray:ByteArray=data as ByteArray;
			var mailInfoResponse:getMailInfoResponse=new getMailInfoResponse();
			mailInfoResponse.readExternal(mailInfoByteArray);
			if (mailInfoResponse.result)
			{
				var mailInfo:MailInfo=mailInfoResponse.data.mailinfo;
				tempMailId=mailInfo.mailIdResponse;
				mainMenuMail.mailFromPos.text=mailInfo.mailFrom;
				mainMenuMail.mailTitle.text=mailInfo.mailTitle;
				mainMenuMail.mailContent.text=mailInfo.mailContent;
				mainMenuMail.mail_data.text=mailInfo.mailDate;
				//回去按钮是否可操作   系统邮件不可恢复
				if (!mainMenuMail.resumeBtn.enabled && mailInfo.mailType != 0)
				{
					mainMenuMail.resumeBtn.enabled=true;
				}
				//保存按钮是否可以操作  处于保存状态下得邮件不可以操作保存按钮
//				if (!mainMenuMail.saveBtn.enabled && SystemDataModel.mailListInfo.responseMailType != 3)
//				{
//					mainMenuMail.saveBtn.enabled=true;
//				}
				//删除按钮是否可以操作
				if (!mainMenuMail.deleteBtn.enabled)
				{
					mainMenuMail.deleteBtn.enabled=true;
				}
				//查看完邮件信息后需要把缓存中的相应邮件状态设为已读，便于显示邮件的状态
				var l:int=SystemDataModel.mailListInfo.mailinfo.length;
				for (var i:int=0; i < l; i++)
				{
					if (SystemDataModel.mailListInfo.mailinfo[i].mailId == mailInfo.mailIdResponse)
					{
						if (SystemDataModel.mailListInfo.mailinfo[i].mailState != 1)
						{
							SystemDataModel.mailListInfo.mailinfo[i].mailState=1;
						}
					}
				}
			}
			else
			{
				popUpShow.show(mailInfoResponse.message);
			}
		}

		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void
		{

		}
	}
}