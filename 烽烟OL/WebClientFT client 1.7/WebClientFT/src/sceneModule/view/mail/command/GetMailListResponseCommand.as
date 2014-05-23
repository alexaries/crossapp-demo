package sceneModule.view.mail.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.mail.mail501.MailInfo;
	import proto.mail.mail501.dataPacket;
	import proto.mail.mail501.getMailListResponse;
	
	import sceneModule.model.vo.mailVo.MailBasicInfoVo;
	import sceneModule.view.mail.event.GetMailListResponseEvent;
	
	import util.CommonTools;

	/**
	 * 获取邮件列表Response Command 
	 * @author Yaolx
	 * 
	 */	
	public class GetMailListResponseCommand extends Command
	{
		[Inject]
		public var evt:GetMailListResponseEvent;
		public function GetMailListResponseCommand()
		{
			super();
		}
		override public function execute():void{
			var byteArray:ByteArray = evt.result as ByteArray;
			var getMailListRes:getMailListResponse = new getMailListResponse();
			getMailListRes.readExternal(byteArray);
			if(getMailListRes.result){
				var dataPackage:dataPacket = getMailListRes.data;
				SystemDataModel.mailListInfo.curPage = dataPackage.curPage;
				SystemDataModel.mailListInfo.maxPage = dataPackage.maxPage;
				SystemDataModel.mailListInfo.responseMailType = dataPackage.responseMailType;
				var l:int = dataPackage.mailinfo.length;
				var mailArr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var mailInfo:MailInfo = dataPackage.mailinfo[i];
					var mailInfoVo:MailBasicInfoVo = new MailBasicInfoVo();
					mailInfoVo.mailId = mailInfo.mailId;
					mailInfoVo.mailState = mailInfo.mailState;
					mailInfoVo.mailFromType = mailInfo.mailFromType;
					mailInfoVo.mailTitle = mailInfo.mailTitle;
					mailInfoVo.mialSendTime = mailInfo.mialSendTime;
					mailInfoVo.outline = mailInfo.outline;
					mailArr.addItem(mailInfoVo);
				}
				SystemDataModel.mailListInfo.mailinfo.source = mailArr.toArray();
			}
		}
	}
}