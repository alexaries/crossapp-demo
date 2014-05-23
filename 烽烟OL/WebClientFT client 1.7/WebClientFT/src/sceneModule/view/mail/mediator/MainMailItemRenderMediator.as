package sceneModule.view.mail.mediator
{
	/**
	 * MainMailItemRenderMediator
	 * @auther Yaolx
	 */
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.mail.mail501.getMailListRequest;
	import proto.mail.mail503.saveAndDeleteMailRequest;
	import proto.mail.mail503.saveAndDeleteMailResponse;
	
	import resource.AssetCenter;
	
	import sceneModule.view.mail.event.GetMailListResponseEvent;
	import sceneModule.view.mail.event.MainMenuMailSaveOrDeleteSuccessMessageEvent;
	import sceneModule.view.mail.view.MainMailItemRender;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.CommonTools;

	public class MainMailItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:MainMailItemRender;

		[Inject]
		public var socketServer:ISocketServer;

		[Inject]
		public var popUpShow:IPopUpShow;

		public function MainMailItemRenderMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			//保存
			//this.eventMap.mapListener(comp.saveBtn,MouseEvent.CLICK,onSaveMail);
			//删除
			//this.eventMap.mapListener(comp.deleteBtn,MouseEvent.CLICK,onDeleteMail);
			showMailItem();
		}

		/**
		 * 保存邮件
		 */
		public function onSaveMail(evt:MouseEvent):void
		{
			evt.stopImmediatePropagation();
			onSaveOrDeleteMail(0, comp.data.mailId);
		}

		private function showMailItem():void
		{
			CommonTools.make_bitmap(comp.imgTopLayer).bitmapData=AssetCenter.getInstance().get_img_form_pacakge("ui_mail", "imgTopLayer");
		}

		/**
		 * 保存或删除邮件
		 * @param setType 操作类型 0保存1删除
		 * @param mailId 邮件id
		 */
		private function onSaveOrDeleteMail(setType:int, mailId:int):void
		{
			var saveMail:saveAndDeleteMailRequest=new saveAndDeleteMailRequest();
			saveMail.id=SystemDataModel.roleId;
			saveMail.setType=setType;
			saveMail.requestInfo=mailId;
			saveMail.mailType=SystemDataModel.mailListInfo.responseMailType;
			var byteArray:ByteArray=new ByteArray();
			saveMail.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(saveMailHandler, faultHandler), URLConst.DELETE_MAIL_COMMANDID, byteArray);
		}

		private function saveMailHandler(data:Object):void
		{
			var saveMailByte:ByteArray=data as ByteArray;
			var saveMailRes:saveAndDeleteMailResponse=new saveAndDeleteMailResponse();
			saveMailRes.readExternal(saveMailByte);
			if (saveMailRes.result)
			{
				//从新获取邮件列表信息
				getMailListInfo(SystemDataModel.mailListInfo.curPage, SystemDataModel.mailListInfo.responseMailType);
				//派发操作成功信息提示
				dispatch(new MainMenuMailSaveOrDeleteSuccessMessageEvent(MainMenuMailSaveOrDeleteSuccessMessageEvent.MAINMENUMAILSAVEORDELETEMESSAGE, saveMailRes.message));
			}
			else
			{
				popUpShow.show(saveMailRes.message);
			}
		}

		/**
		 * 获取邮件列表
		 * @param pageCount 所获取邮件的信息的页数
		 * @param mailType 所获取邮件的类型
		 */
		private function getMailListInfo(pageCount:int, mailType:int):void
		{
			var getMailListReq:getMailListRequest=new getMailListRequest();
			getMailListReq.id=SystemDataModel.roleId;
			getMailListReq.pageCount=pageCount;
			getMailListReq.mailType=mailType;
			var mailListByteArray:ByteArray=new ByteArray();
			getMailListReq.writeExternal(mailListByteArray);
			socketServer.send(new mx.rpc.Responder(mailListHandler, faultHandler), URLConst.GET_MAILLIST_COMMANDID, mailListByteArray);
		}

		/**
		 * mailListHandler
		 */
		private function mailListHandler(data:Object):void
		{
			dispatch(new GetMailListResponseEvent(GetMailListResponseEvent.GETMAILLISTRESPONSE, data));
		}

		/**
		 *删除邮件
		 */
		public function onDeleteMail(evt:MouseEvent):void
		{
			evt.stopImmediatePropagation();
			onSaveOrDeleteMail(1, comp.data.mailId);
		}

		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void
		{

		}
	}
}