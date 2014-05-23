package sceneModule.view.skill.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.skill.skill801.GetSkillInfoResponse;
	import proto.skill.skill801.SkillInfoList;
	
	import sceneModule.model.vo.skillVo.SkillBasicInfoVo;
	import sceneModule.view.skill.event.GetSkillInfoResponseEvent;

	public class GetSkillInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:GetSkillInfoResponseEvent;
		public function GetSkillInfoResponseCommand()
		{
			super();
		}
		override public function execute():void{
			var byteArray:ByteArray = evt._obj as ByteArray;
			var responseData:GetSkillInfoResponse = new GetSkillInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result && responseData.data){
				var l:int = responseData.data.skillInfoList.length;
				var arr:ArrayCollection = new ArrayCollection();
				var pasArr:ArrayCollection = new ArrayCollection();
				var appArr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var skillInfo:SkillInfoList = responseData.data.skillInfoList[i];
					var skillBaseInfo:SkillBasicInfoVo = new SkillBasicInfoVo();
					skillBaseInfo.icon = skillInfo.icon;
					skillBaseInfo.levelUpEffect = skillInfo.levelUpEffect;
					skillBaseInfo.levelUpMoney = skillInfo.levelUpMoney;
					skillBaseInfo.levelUpProps = skillInfo.levelUpProps;
					skillBaseInfo.levelUpRoleLevel = skillInfo.levelUpRoleLevel;
					skillBaseInfo.releasePreEnergy = skillInfo.releasePreEnergy;
					skillBaseInfo.remainRoleLevel = skillInfo.remainRoleLevel;
					skillBaseInfo.skillDes = skillInfo.skillDes;
					skillBaseInfo.skillId = skillInfo.skillId;
					skillBaseInfo.skillLevel = skillInfo.skillLevel;
					skillBaseInfo.skillName = skillInfo.skillName;
					skillBaseInfo.skillStatus = skillInfo.skillStatus;
					skillBaseInfo.type = skillInfo.type;
					skillBaseInfo.skillType = skillInfo.skillType;
					if(skillInfo.skillType == 0){
						arr.addItem(skillBaseInfo);
					}else if(skillInfo.skillType == 1){
						pasArr.addItem(skillBaseInfo);
					}else if(skillInfo.skillType == 2){
						appArr.addItem(skillBaseInfo);
					}else{
						trace("技能类型出错.....");
					}
					
				}
				SystemDataModel.mainSkillInfo.skillList.source = arr.toArray();
				SystemDataModel.mainSkillInfo.pasSkillList.source = pasArr.toArray();
				SystemDataModel.mainSkillInfo.appSkillList.source = appArr.toArray();
			}
		}
	}
}